// 文件路径: /lib/screens/user/viga_user.dart (最终修正版)

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/user/widgets/viga_user_function_button.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_page_loading.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/tools/viewer/viga_viewer_service.dart';
import 'package:vigaviga/screens/arts/widgets/viga_video_data.dart';
import 'package:vigaviga/widgets/viga_work_share_panel.dart';

class VigaUserPage extends StatefulWidget {
  const VigaUserPage({super.key});
  @override
  State<VigaUserPage> createState() => _VigaUserPageState();
}

class _VigaUserPageState extends State<VigaUserPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<VigaUserPage> {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  late PageController _pageController;
  late List<VideoData> _works;
  late List<VideoData> _collections;
  late List<VideoData> _praised;

  @override
  void initState() {
    super.initState();
    _works = _createMockWorks();
    _collections = _createMockCollections();
    _praised = _createMockPraised();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VigaSystemCubit>().updateShowHomeTabbar(true);
        context.read<VigaSystemCubit>().updateMainpage5isload(true);
      }
    });
  }

  List<VideoData> _createMockWorks() {
    final List<String> descriptions = [
      '记录美好的夏日时光，阳光、沙滩和海浪',
      '城市的夜晚总是充满魅力，灯火辉煌',
      '在大自然中寻找内心的宁静',
      '发现城市中的美食宝藏',
      '和我的小可爱一起度过的快乐时光',
      '旅行中的点点滴滴，都是珍贵的回忆',
      '用画笔记录生活的美好瞬间',
      '分享生活中的小确幸',
      '用镜头捕捉世界的美丽',
      '亲手制作的小物件，充满心意'
    ];

    return List.generate(100, (i) {
      final random = Random(i);

      final descIndex = random.nextInt(descriptions.length);

      return VideoData(
        videoPath: '', // 图片作品，videoPath为空
        avatarPath: 'https://picsum.photos/100/155?random=${i + 1000}',
        userName: '用户${i + 1}',
        description: descriptions[descIndex],
        isLiked: random.nextBool(),
        isCollected: random.nextBool(),
        likeCount: random.nextInt(1000) + 50,
        commentCount: random.nextInt(200) + 10,
        collectionCount: random.nextInt(300) + 20,
        shareCount: random.nextInt(150) + 5,
        viewCount: random.nextInt(5000) + 1000, // 查看次数
      );
    });
  }

  List<VideoData> _createMockCollections() {
    return List.generate(15, (i) {
      final random = Random(i + 100);
      return VideoData(
        videoPath: '', // 图片作品，videoPath为空
        avatarPath: 'https://picsum.photos/100/155?random=${i + 3000}',
        userName: '其他用户${i + 1}',
        description: '这是我收藏的第${i + 1}个作品，非常喜欢！',
        isLiked: true,
        isCollected: true,
        likeCount: random.nextInt(800) + 100,
        commentCount: random.nextInt(150) + 20,
        collectionCount: random.nextInt(200) + 30,
        shareCount: random.nextInt(100) + 10,
        viewCount: random.nextInt(8000) + 2000, // 查看次数
      );
    });
  }

  List<VideoData> _createMockPraised() {
    return List.generate(30, (i) {
      final random = Random(i + 200);
      return VideoData(
        videoPath: '', // 图片作品，videoPath为空
        avatarPath: 'https://picsum.photos/100/155?random=${i + 5000}',
        userName: '创作者${i + 1}',
        description: '这个作品真的很棒，值得点赞！',
        isLiked: true,
        isCollected: false,
        likeCount: random.nextInt(1200) + 200,
        commentCount: random.nextInt(250) + 30,
        collectionCount: random.nextInt(400) + 50,
        shareCount: random.nextInt(180) + 20,
        viewCount: random.nextInt(10000) + 3000, // 查看次数
      );
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
          ? BlocBuilder<VigaUserCubit, UserState>(
              builder: (context, userState) {
              return _buildPage(systemState, userState);
            })
          : const VigaPageLoading();
    });
  }

  double customkToolbarHeight = 95.w;
  double expandedHeight = 680.w;

  Widget _buildPage(SystemState systemState, UserState userState) {
    ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // 默认/收起时为黑色图标
          statusBarBrightness: Brightness.light, // 兼容iOS
        ),
        child: Scaffold(
          backgroundColor: theme.colorScheme.surfaceContainer,
          appBar: null,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  primary: true,
                  title: null,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  toolbarHeight: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness:
                        innerBoxIsScrolled ? Brightness.dark : Brightness.light,
                  ),
                  expandedHeight: expandedHeight,
                  backgroundColor: theme.cardColor,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: BlocBuilder<VigaUserCubit, UserState>(
                      builder: (context, userState) {
                        if (userState.isLoggedIn) {
                          return _buildUserInfoSection(
                              systemState, userState, theme);
                        } else {
                          return _buildUnauthenticatedUserInfoSection(
                            systemState,
                            theme,
                          );
                        }
                      },
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(customkToolbarHeight + 2.5.w),
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
                                Tab(
                                  height: customkToolbarHeight,
                                  child: Text("收藏 ${_collections.length}"),
                                ),
                                Tab(
                                  height: customkToolbarHeight,
                                  child: Text("赞过 ${_praised.length}"),
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
                              onPressed: () => _navigateToSearchPage(context),
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
                _UserWorksGrid(
                  key: const PageStorageKey('works_grid'),
                  items: _works,
                  emptyMessage: '用作品表达自己吧！',
                  buttonText: '发布作品',
                  onButtonPressed: () => logger.info("发布作品按钮被点击"),
                  isActive: _tabController.index == 0,
                ),
                _UserWorksGrid(
                  key: const PageStorageKey('collections_grid'),
                  items: _collections,
                  emptyMessage: '还没有收藏',
                  buttonText: '去看看',
                  onButtonPressed: () {},
                  isActive: _tabController.index == 1,
                ),
                _UserWorksGrid(
                  key: const PageStorageKey('praised_grid'),
                  items: _praised,
                  emptyMessage: '还没有赞过',
                  buttonText: '去看看',
                  onButtonPressed: () {},
                  isActive: _tabController.index == 2,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildFloatingIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 44.w,
      ),
    );
  }

  Widget _buildUserInfoSection(
      SystemState systemState, UserState userState, ThemeData theme) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    String cdnBase = systemState.cdnBase;
    String accountId = userState.userinfoName!;
    final List<VigaUserFunctionButton> serviceButtons = [
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon11.png",
        title: "钱包",
        onPressed: () => context.push('/user/services'),
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon12.png",
        title: "交易",
        onPressed: () {
          context.push('/test');
        },
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon13.png",
        title: "创作中心",
        onPressed: () {
          context.push('/photo_grid');
        },
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon16.png",
        title: "浏览历史",
        onPressed: () {
          context.push('/payment_demo');
        },
      ),
      VigaUserFunctionButton(
          icon: "$cdnBase/icon/server_icon14.png",
          title: "学院",
          onPressed: () {
            context.push(
              '/webview',
              extra: {
                'url': 'https://course.vigaviga.com',
                'title': "学院",
              },
            );
          })
    ];
    return SizedBox(
      height: expandedHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: VigaAppNetworkImage(
              imageUrl: "https://picsum.photos/750/750?random=497",
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
                  icon: const IconData(0xe63d, fontFamily: 'Iconfont'),
                  onTap: () => context.push('/settings'),
                ),
                _buildFloatingIconButton(
                  icon: const IconData(0xe635, fontFamily: 'Iconfont'),
                  onTap: () => context.push('/discovery/qrcode_scanner'),
                )
              ],
            ),
          ),
          Column(children: [
            SizedBox(height: systemState.statusHeight + 100.w),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    GestureDetector(
                      onTap: () => context.push('/user/info'),
                      child: ClipOval(
                        child: BlocBuilder<VigaUserCubit, UserState>(
                          builder: (context, state) {
                            final avatar = state.userinfoAvatar;
                            return VigaAppNetworkImage(
                              imageUrl: (avatar == null || avatar.isEmpty)
                                  ? "${systemState.cdnBase}/avatar/default.png"
                                  : avatar,
                              width: 140.w,
                              height: 140.w,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            BlocBuilder<VigaUserCubit, UserState>(
                              builder: (context, state) => SizedBox(
                                width: 400.w,
                                child: Text(
                                  state.userinfoName ?? '用户名',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 35.w,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.push('/user/user_card');
                              },
                              child: Icon(
                                Icons.qr_code_2_outlined,
                                size: 50.w,
                                color: Colors.white,
                              ),
                            )
                          ]),
                          SizedBox(height: 12.w),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: accountId));
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
                                  l10n.vigavigaIdDisplay(accountId),
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
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                  SizedBox(height: 30.w),
                  Row(children: [
                    _buildStatsItem(
                      "25",
                      "关注",
                      () => context.push('/user/follow_and_fans'),
                    ),
                    SizedBox(width: 60.w),
                    _buildStatsItem(
                      "1.2M",
                      "粉丝",
                      () => context.push('/user/follow_and_fans'),
                    ),
                    SizedBox(width: 60.w),
                    _buildStatsItem(
                      "8.9M",
                      "获赞",
                      () => context.push('/user/like'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => context.push('/user/info'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: theme.dividerColor,
                        foregroundColor: theme.textTheme.bodyLarge?.color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.w)),
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        minimumSize: Size(0, 70.w),
                      ),
                      child: Text(
                        "个人资料",
                        style: TextStyle(
                          fontSize: 26.w,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ])
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                bottom: 25,
                left: 32,
                right: 32,
              ).w,
              child: Divider(
                height: 1.w,
                color: theme.dividerColor.withAlpha(40),
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: serviceButtons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 5,
                  childAspectRatio: 1),
              itemBuilder: (context, index) => serviceButtons[index],
            )
          ])
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedUserInfoSection(
      SystemState systemState, ThemeData theme) {
    return SizedBox(
        height: expandedHeight,
        child: Stack(children: [
          Positioned.fill(
              child: VigaAppNetworkImage(
                  imageUrl: "https://picsum.photos/750/750?random=497",
                  fit: BoxFit.cover)),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
              ),
            ),
          ),
          Positioned(
              top: systemState.statusHeight,
              right: 15.w,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                _buildFloatingIconButton(
                  icon: const IconData(0xe63d, fontFamily: 'Iconfont'),
                  onTap: () => context.push('/settings'),
                ),
                _buildFloatingIconButton(
                  icon: const IconData(0xe635, fontFamily: 'Iconfont'),
                  onTap: () => context.push('/discovery/qrcode_scanner'),
                )
              ])),
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 140.w,
                  color: Colors.white.withAlpha(204),
                ),
                SizedBox(height: 30.w),
                Text("登录后体验更多精彩",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.w,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 50.w),
                ElevatedButton(
                  onPressed: () {
                    context.push('/user/auth/login');
                    logger.info("跳转到登录注册页");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentRedVibrant1,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.w),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.w, vertical: 20.w),
                      elevation: 0),
                  child: Text(
                    "登录 / 注册",
                    style:
                        TextStyle(fontSize: 30.w, fontWeight: FontWeight.bold),
                  ),
                )
              ]))
        ]));
  }

  Widget _buildStatsItem(String count, String label, VoidCallback? onPress) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count,
              style: TextStyle(
                  fontSize: 32.w,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 2.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 26.w,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void _navigateToSearchPage(BuildContext context) {
    context.push('/user_content_search');
  }
}

class _UserWorksGrid extends StatefulWidget {
  final List<VideoData> items;
  final String emptyMessage;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isActive;
  const _UserWorksGrid(
      {super.key,
      required this.items,
      required this.emptyMessage,
      required this.buttonText,
      required this.onButtonPressed,
      required this.isActive});
  @override
  State<_UserWorksGrid> createState() => __UserWorksGridState();
}

class __UserWorksGridState extends State<_UserWorksGrid> {
  late Map<int, GlobalKey> _imageKeys;

  @override
  void initState() {
    super.initState();
    _imageKeys = {};
  }

  @override
  void didUpdateWidget(covariant _UserWorksGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _imageKeys = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return widget.items.isEmpty
          ? _buildEmptyState(context, systemState)
          : _buildGridContent(context, systemState);
    });
  }

  Widget _buildEmptyState(BuildContext context, SystemState systemState) {
    if (widget.buttonText == '发布作品') {
      return Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              primary: widget.isActive,
              physics: widget.isActive
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: 120.w),
                Icon(Icons.camera_roll_outlined,
                    size: 150.w, color: Colors.grey.shade400),
                SizedBox(height: 30.w),
                Text(
                  "你还没有发布过作品",
                  style: TextStyle(
                    fontSize: 28.w,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 40.w),
                ElevatedButton(
                  onPressed: widget.onButtonPressed,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentRedVibrant1,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.w),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.w,
                        vertical: 20.w,
                      ),
                      elevation: 0),
                  child: Text(
                    widget.buttonText,
                    style:
                        TextStyle(fontSize: 28.w, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40.w)
              ])));
    }
    return Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            primary: widget.isActive,
            physics: widget.isActive
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 120.w),
              VigaAppNetworkImage(
                imageUrl: '${systemState.cdnBase}/imgs/no-content.webp',
                width: 200.w,
                height: 200.w,
              ),
              SizedBox(height: 30.w),
              Text(
                widget.emptyMessage,
                style: TextStyle(
                  fontSize: 28.w,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 40.w),
              ElevatedButton(
                onPressed: widget.onButtonPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentRedVibrant1,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.w)),
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.w,
                      vertical: 20.w,
                    ),
                    elevation: 0),
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 28.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40.w)
            ])));
  }

  Widget _buildGridContent(BuildContext context, SystemState systemState) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: GridView.builder(
        primary: widget.isActive,
        key: PageStorageKey<String>(widget.emptyMessage),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        itemCount: widget.items.length,
        physics: widget.isActive
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
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
          final videoData = widget.items[index];
          final imageUrl = videoData.avatarPath; // 使用avatarPath作为封面图片
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
                imageUrls: widget.items.map((item) => item.avatarPath).toList(),
                initialIndex: index,
                initialRect: initialRect,
                heroTagPrefix: 'user_page',
              );
            },
            onLongPress: () {
              _showSharePanel(context, videoData);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'user_page_$imageUrl',
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
                          Colors.transparent
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
                          const IconData(0xe643, fontFamily: 'Iconfont'),
                          color: Colors.white,
                          size: 32.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          _formatViewCount(videoData.viewCount),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.w,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black.withAlpha(128),
                                offset: const Offset(0, 1),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
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

  void _showSharePanel(BuildContext context, VideoData videoData) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => VigaUserWorksSharePanel(
        videoData: videoData,
      ),
    );
  }
}
