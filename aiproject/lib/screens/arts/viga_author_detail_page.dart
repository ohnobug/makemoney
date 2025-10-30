// 文件路径: /lib/screens/author/viga_author_detail_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_page_loading.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/screens/discovery/search/viga_home_search_results_page.dart';

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
                  onTap: () => Navigator.pop(context),
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
    final workUrls = _works.map((workItem) => workItem.imageUrl).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VigaHomeSearchResultsPage(
          initialSearchType: 'author_search',
          works: workUrls,
          collections: [],
          praised: [],
        ),
      ),
    );
  }
}

class _AuthorWorksGrid extends StatelessWidget {
  final List<WorkItem> items;
  final bool isActive;

  const _AuthorWorksGrid({
    super.key,
    required this.items,
    required this.isActive,
  });

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
        primary: isActive,
        key: PageStorageKey<String>('author_works'),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) {
          final workItem = items[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              VigaAppNetworkImage(
                imageUrl: workItem.imageUrl,
                fit: BoxFit.cover,
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
                        '${workItem.viewCount}',
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
          );
        },
      ),
    );
  }
}
