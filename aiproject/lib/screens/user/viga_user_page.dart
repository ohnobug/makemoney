// 文件路径: /lib/screens/user/viga_user.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/user/widgets/viga_user_function_button.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_page_loading.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/screens/user/photo_viewer/viga_photo_viewer_page.dart';
import 'package:vigaviga/screens/discovery/search/viga_user_search_results_page.dart';

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

  final List<String> _works = List.generate(
      100, (i) => 'https://picsum.photos/400/400?random=${i + 500}');

  final List<String> _collections = [];

  final List<String> _praised = List.generate(
      30, (i) => 'https://picsum.photos/400/400?random=${i + 5000}');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();

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
          ? BlocBuilder<VigaUserCubit, UserState>(builder: (context, userState) {
              return _buildPage(systemState, userState);
            })
          : const VigaPageLoading();
    });
  }

  double customkToolbarHeight = 95.w;
  double expandedHeight = 680.w;

  Widget _buildPage(SystemState systemState, UserState userState) {
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

  // [已有方法] 已登录状态的UI
  Widget _buildUserInfoSection(
    SystemState systemState,
    UserState userState,
    ThemeData theme,
  ) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    String cdnBase = systemState.cdnBase;
    String accountId = userState.userinfoName!;

    final List<VigaUserFunctionButton> serviceButtons = [
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon11.png",
        title: "钱包",
        onPressed: () => Navigator.pushNamed(context, '/user/services'),
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon12.png",
        title: "交易",
        onPressed: () {
          Navigator.pushNamed(context, '/test');
        },
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon13.png",
        title: "创作中心",
        onPressed: () {
          Navigator.pushNamed(context, '/user/photo_viewer');
        },
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon16.png",
        title: "浏览历史",
        onPressed: () {
          Navigator.pushNamed(context, '/payment_demo');
        },
      ),
      VigaUserFunctionButton(
        icon: "$cdnBase/icon/server_icon14.png",
        title: "学院",
        onPressed: () {
          Navigator.pushNamed(context, '/user/course_list');
        },
      ),
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
                  icon: const IconData(
                    0xe63d,
                    fontFamily: 'Iconfont',
                  ),
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
                _buildFloatingIconButton(
                  icon: const IconData(
                    0xe635,
                    fontFamily: 'Iconfont',
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/discovery/qrcode_scanner',
                  ),
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
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/user/info'),
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
                              Row(
                                children: [
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
                                      Navigator.pushNamed(context,
                                          '/user/collection_and_payment');
                                    },
                                    child: Icon(
                                      Icons.qr_code_2_outlined,
                                      size: 50.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.w),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(text: accountId),
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
                          "25",
                          "关注",
                          () => Navigator.pushNamed(
                              context, '/user/follow_and_fans'),
                        ),
                        SizedBox(width: 60.w),
                        _buildStatsItem(
                          "1.2M",
                          "粉丝",
                          () => Navigator.pushNamed(
                              context, '/user/follow_and_fans'),
                        ),
                        SizedBox(width: 60.w),
                        _buildStatsItem(
                          "8.9M",
                          "获赞",
                          () => Navigator.pushNamed(context, '/user/like'),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/user/info'),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: theme.dividerColor,
                            foregroundColor: theme.textTheme.bodyLarge?.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                            ),
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
                      ],
                    ),
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
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => serviceButtons[index],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // [新方法] 为未登录用户设计的用户信息区域
  Widget _buildUnauthenticatedUserInfoSection(
      SystemState systemState, ThemeData theme) {
    return SizedBox(
      height: expandedHeight,
      child: Stack(
        children: [
          // --- 背景图和遮罩 (与登录状态完全相同，保持一致性) ---
          Positioned.fill(
            child: VigaAppNetworkImage(
              imageUrl: "https://picsum.photos/750/750?random=497",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
              ),
            ),
          ),
          // --- 设置 与 扫码按钮 (保留通用功能) ---
          Positioned(
            top: systemState.statusHeight,
            right: 15.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFloatingIconButton(
                  icon: const IconData(
                    0xe63d,
                    fontFamily: 'Iconfont',
                  ),
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
                _buildFloatingIconButton(
                  icon: const IconData(
                    0xe635,
                    fontFamily: 'Iconfont',
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/discovery/qrcode_scanner',
                  ),
                ),
              ],
            ),
          ),

          // --- 核心内容：引导登录 ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 可以使用一个通用头像或图标
                Icon(
                  Icons.account_circle_outlined,
                  size: 140.w,
                  color: Colors.white.withAlpha(204),
                ),
                SizedBox(height: 30.w),
                // 引导文案
                Text(
                  "登录后体验更多精彩",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.w),
                // 登录/注册按钮
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user/auth/login');
                    logger.info("跳转到登录注册页");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentRedVibrant1, // 使用醒目的颜色
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.w),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 100.w,
                      vertical: 20.w,
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "登录 / 注册",
                    style: TextStyle(
                      fontSize: 30.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
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

  // 导航到搜索结果页面
  void _navigateToSearchPage(BuildContext context) {
    String searchType;
    switch (_tabController.index) {
      case 0:
        searchType = 'works';
        break;
      case 1:
        searchType = 'collections';
        break;
      case 2:
        searchType = 'praised';
        break;
      default:
        searchType = 'works';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VigaSearchResultsPage(
          initialSearchType: searchType,
          works: _works,
          collections: _collections,
          praised: _praised,
        ),
      ),
    );
  }
}

class _UserWorksGrid extends StatefulWidget {
  final List<String> items;
  final String emptyMessage;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isActive;

  const _UserWorksGrid({
    super.key,
    required this.items,
    required this.emptyMessage,
    required this.buttonText,
    required this.onButtonPressed,
    required this.isActive,
  });

  @override
  State<_UserWorksGrid> createState() => __UserWorksGridState();
}

class __UserWorksGridState extends State<_UserWorksGrid> {
  // 使用 GlobalKey 来更精确地获取每个图片的位置和大小
  final Map<int, GlobalKey> _imageKeys = {};

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 120.w),
              Icon(
                Icons.camera_roll_outlined,
                size: 150.w,
                color: Colors.grey.shade400,
              ),
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
                  elevation: 0,
                ),
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 28.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40.w),
            ],
          ),
        ),
      );
    }

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        primary: widget.isActive,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                  borderRadius: BorderRadius.circular(
                    40.w,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 60.w,
                  vertical: 20.w,
                ),
                elevation: 0,
              ),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: 28.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40.w),
          ],
        ),
      ),
    );
  }

  Widget _buildGridContent(BuildContext context, SystemState systemState) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: GridView.builder(
        primary: widget.isActive,
        key: PageStorageKey<String>(widget.emptyMessage),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        itemCount: widget.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) {
          // 为每个图片生成一个唯一的 key
          _imageKeys.putIfAbsent(index, () => GlobalKey());
          final imageUrl = widget.items[index];

          return GestureDetector(
            onTap: () {
              // 通过 key 获取图片在屏幕中的精确位置和大小
              final RenderBox? renderBox = _imageKeys[index]
                  ?.currentContext
                  ?.findRenderObject() as RenderBox?;
              if (renderBox == null) return;
              final position = renderBox.localToGlobal(Offset.zero);
              final size = renderBox.size;
              final initialRect = Rect.fromLTWH(
                  position.dx, position.dy, size.width, size.height);

              Navigator.push(
                context,
                PageRouteBuilder(
                  // 核心：页面本身不绘制背景，让路由的过渡动画处理
                  opaque: false,
                  barrierColor: Colors.transparent,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return VigaPhotoViewerPage(
                      imageSources: widget.items,
                      initialIndex: index,
                      initialRect: initialRect, // 传递精确的初始位置
                    );
                  },
                  // 使用路由自带的动画来实现背景的淡入淡出，这是最稳定可靠的方式
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // animation 由路由管理, push时 0->1, pop时 1->0
                    // 我们用它来包裹整个查看器页面，实现完美的淡入淡出
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: imageUrl,
                  child: VigaAppNetworkImage(
                    // 将 key 绑定到 Image 组件上
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
                        '${(Random().nextInt(10) * 1.2 * 1000).toInt()}',
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
}
