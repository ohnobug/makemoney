// 文件路径: /lib/screens/author/viga_author_detail_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_page_loading.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/tools/viewer/viga_viewer_service.dart';

// 作品数据模型
class WorkItem {
  final String imageUrl;
  final int viewCount;

  WorkItem({
    required this.imageUrl,
    required this.viewCount,
  });
}

class VigaAuthorDetailPage extends StatefulWidget {
  final String authorId;
  final String authorName;
  final String authorAvatar;

  const VigaAuthorDetailPage({
    super.key,
    required this.authorId,
    this.authorName = '',
    this.authorAvatar = '',
  });

  @override
  State<VigaAuthorDetailPage> createState() => _VigaAuthorDetailPageState();
}

class _VigaAuthorDetailPageState extends State<VigaAuthorDetailPage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<VigaAuthorDetailPage> {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  late PageController _pageController;

  // 作者作品数据
  final List<WorkItem> _works = [];

  // 作者信息
  late String _authorName;
  late String _authorAvatar;
  late int _followersCount;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _pageController = PageController();

    // 初始化作者信息
    _authorName =
        widget.authorName.isEmpty ? '作者${widget.authorId}' : widget.authorName;
    _authorAvatar = widget.authorAvatar.isEmpty
        ? 'https://picsum.photos/200/200?random=${widget.authorId}'
        : widget.authorAvatar;
    _followersCount = Random().nextInt(10000) + 1000;
    _likesCount = Random().nextInt(1000000) + 10000;

    // 初始化作品数据，包含固定的观看数量
    _works.addAll(List.generate(
        50,
        (i) => WorkItem(
              imageUrl: 'https://picsum.photos/300/400?random=${i + 1000}',
              viewCount: (Random().nextInt(10) * 1.2 * 1000).toInt(),
            )));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VigaSystemCubit>().updateShowHomeTabbar(true);
        context.read<VigaSystemCubit>().updateMainpage5isload(true);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage5isload!
          ? _buildPage(systemState)
          : const VigaPageLoading();
    });
  }

  double customkToolbarHeight = 95.w;
  double expandedHeight = 550.w;

  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              primary: true,
              title: null,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              toolbarHeight: 0,
              expandedHeight: expandedHeight,
              backgroundColor: theme.cardColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: _buildAuthorInfoSection(systemState, theme),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(customkToolbarHeight + 2.5.w),
                child: Container(
                  color: theme.cardColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          onTap: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          labelColor: theme.colorScheme.onSurface,
                          unselectedLabelColor: theme.colorScheme.onSurface,
                          dividerHeight: 1.w,
                          dividerColor: theme.tabBarTheme.dividerColor,
                          indicatorColor: theme.colorScheme.primary,
                          indicatorWeight: 2.5.w,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelPadding: EdgeInsets.only(
                            left: 20.w,
                            right: 40.w,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 30.w,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 30.w,
                            fontWeight: FontWeight.normal,
                          ),
                          tabs: [
                            Tab(
                              height: customkToolbarHeight,
                              child: Text("作品 ${_works.length}"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: customkToolbarHeight,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0.w,
                              color: theme.tabBarTheme.dividerColor!,
                            ),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => _navigateToAuthorSearchPage(context),
                          icon: Icon(
                            Icons.search,
                            size: 44.w,
                            color: theme.hintColor,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: PageView(
          controller: _pageController,
          physics: const ClampingScrollPhysics(),
          onPageChanged: (index) {
            if (_tabController.index != index) {
              _tabController.animateTo(index);
            }
          },
          children: [
            _AuthorWorksGrid(
              key: const PageStorageKey('author_works_grid'),
              items: _works,
              isActive: _tabController.index == 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingIconButton(
      {required IconData icon, required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 44.w,
      ),
    );
  }

  Widget _buildAuthorInfoSection(SystemState systemState, ThemeData theme) {
    return SizedBox(
      height: expandedHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: VigaAppNetworkImage(
              imageUrl:
                  "https://picsum.photos/750/750?random=${widget.authorId}",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(200),
              ),
            ),
          ),
          Positioned(
            top: systemState.statusHeight,
            right: 15.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFloatingIconButton(
                  icon: const IconData(
                    0xe628,
                    fontFamily: 'Iconfont',
                  ),
                  onTap: () => context.pop(),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: systemState.statusHeight + 100.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: VigaAppNetworkImage(
                            imageUrl: _authorAvatar,
                            width: 140.w,
                            height: 140.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 400.w,
                                    child: Text(
                                      _authorName,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 35.w,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              SizedBox(height: 12.w),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(text: widget.authorId),
                                  );
                                  Fluttertoast.showToast(
                                    msg: "复制成功",
                                    gravity: ToastGravity.CENTER,
                                    webBgColor: "black",
                                    webPosition: "center",
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "ID: ${widget.authorId}",
                                      style: TextStyle(
                                        fontSize: 24.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(
                                      Icons.copy_all_outlined,
                                      size: 28.w,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.w),
                    Row(
                      children: [
                        _buildStatsItem(
                          _followersCount.toString(),
                          "粉丝",
                          () {},
                        ),
                        SizedBox(width: 60.w),
                        _buildStatsItem(
                          _likesCount.toString(),
                          "获赞",
                          () {},
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            logger.info("关注作者: ${widget.authorId}");
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.accentRedVibrant1,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.w,
                            ),
                            minimumSize: Size(0, 70.w),
                          ),
                          child: Text(
                            "关注",
                            style: TextStyle(
                              fontSize: 26.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsItem(String count, String label, VoidCallback? onPress) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 32.w,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 26.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // 导航到作者作品搜索页面
  void _navigateToAuthorSearchPage(BuildContext context) {
    context.push('/search', extra: {
      'initialTab': 0, // 作品tab
      'searchMode': 'author_search',
      'authorId': widget.authorId,
      'authorName': _authorName,
    });
  }
}

class _AuthorWorksGrid extends StatefulWidget {
  final List<WorkItem> items;
  final bool isActive;

  const _AuthorWorksGrid({
    super.key,
    required this.items,
    required this.isActive,
  });

  @override
  State<_AuthorWorksGrid> createState() => __AuthorWorksGridState();
}

class __AuthorWorksGridState extends State<_AuthorWorksGrid> {
  late Map<int, GlobalKey> _imageKeys;

  @override
  void initState() {
    super.initState();
    _imageKeys = {};
  }

  @override
  void didUpdateWidget(covariant _AuthorWorksGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _imageKeys = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildGridContent(context, systemState);
    });
  }

  Widget _buildGridContent(BuildContext context, SystemState systemState) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: GridView.builder(
        primary: widget.isActive,
        key: PageStorageKey<String>('author_works'),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        itemCount: widget.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) {
          if (!_imageKeys.containsKey(index)) {
            _imageKeys[index] = GlobalKey();
          }
          final workItem = widget.items[index];
          final imageUrl = workItem.imageUrl;
          return GestureDetector(
            onTap: () {
              final RenderBox? renderBox = _imageKeys[index]
                  ?.currentContext
                  ?.findRenderObject() as RenderBox?;
              if (renderBox == null) return;
              final position = renderBox.localToGlobal(Offset.zero);
              final size = renderBox.size;
              final initialRect = Rect.fromLTWH(
                position.dx,
                position.dy,
                size.width,
                size.height,
              );
              VigaViewerService.openMultiplePhotos(
                context: context,
                imageUrls: widget.items.map((item) => item.imageUrl).toList(),
                initialIndex: index,
                initialRect: initialRect,
                heroTagPrefix: 'author_page',
              );
            },
            onLongPress: () {
              _showSharePanel(context, workItem);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'author_page_$imageUrl',
                  child: VigaAppNetworkImage(
                    key: _imageKeys[index],
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withAlpha(156),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      10.w,
                      20.w,
                      10.w,
                      8.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          const IconData(
                            0xe643,
                            fontFamily: 'Iconfont',
                          ),
                          color: Colors.white,
                          size: 32.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatViewCount(workItem.viewCount),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.w,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: Colors.black.withAlpha(128),
                                  offset: const Offset(0, 1),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatViewCount(int viewCount) {
    if (viewCount >= 10000) {
      return '${(viewCount / 10000).toStringAsFixed(1)}万';
    } else if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}千';
    } else {
      return viewCount.toString();
    }
  }

  void _showSharePanel(BuildContext context, WorkItem workItem) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AuthorWorksSharePanel(
        workItem: workItem,
      ),
    );
  }
}

// =========================================================================
// 作者作品分享面板组件
// =========================================================================

class _AuthorWorksSharePanel extends StatelessWidget {
  final WorkItem workItem;

  const _AuthorWorksSharePanel({
    required this.workItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 顶部标题栏
          Container(
            height: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '分享作品',
                  style: TextStyle(
                    fontSize: 32.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    size: 40.w,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // 分享选项网格
          Padding(
            padding: EdgeInsets.all(20.w),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
              children: [
                _buildShareOption(
                  icon: const IconData(0xe60f, fontFamily: 'Iconfont'),
                  label: '微信',
                  onTap: () => _handleShareAction(context, '微信'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe610, fontFamily: 'Iconfont'),
                  label: '朋友圈',
                  onTap: () => _handleShareAction(context, '朋友圈'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe611, fontFamily: 'Iconfont'),
                  label: 'QQ',
                  onTap: () => _handleShareAction(context, 'QQ'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe612, fontFamily: 'Iconfont'),
                  label: 'QQ空间',
                  onTap: () => _handleShareAction(context, 'QQ空间'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe613, fontFamily: 'Iconfont'),
                  label: '微博',
                  onTap: () => _handleShareAction(context, '微博'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe614, fontFamily: 'Iconfont'),
                  label: '抖音',
                  onTap: () => _handleShareAction(context, '抖音'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe615, fontFamily: 'Iconfont'),
                  label: '快手',
                  onTap: () => _handleShareAction(context, '快手'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe616, fontFamily: 'Iconfont'),
                  label: '复制链接',
                  onTap: () => _handleShareAction(context, '复制链接'),
                ),
              ],
            ),
          ),

          // 底部操作按钮
          Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Divider(
                  height: 1.w,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 20.w),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: const IconData(0xe617, fontFamily: 'Iconfont'),
                        label: '保存到相册',
                        onTap: () => _handleAction(context, '保存到相册'),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: _buildActionButton(
                        icon: const IconData(0xe618, fontFamily: 'Iconfont'),
                        label: '举报',
                        onTap: () => _handleAction(context, '举报'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(45.w),
            ),
            child: Icon(
              icon,
              size: 45.w,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 24.w,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32.w,
              color: Colors.black87,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleShareAction(BuildContext context, String platform) {
    logger.info('分享到 $platform: ${workItem.imageUrl}');
    Navigator.of(context).pop();
    // 这里可以添加实际的分享逻辑
  }

  void _handleAction(BuildContext context, String action) {
    logger.info('执行操作: $action - ${workItem.imageUrl}');
    Navigator.of(context).pop();
    // 这里可以添加实际的操作逻辑
  }
}
