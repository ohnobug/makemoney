// 文件路径: /lib/screens/user/ljn_user.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 用于剪贴板功能
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart'; // 用于Toast提示
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/user/widgets/ljn_user_function_button.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LJNUser extends StatefulWidget {
  const LJNUser({super.key});
  @override
  State<LJNUser> createState() => _LJNUserState();
}

class _LJNUserState extends State<LJNUser>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<LJNUser> {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  late PageController _pageController;

  final List<String> _works = List.generate(
      500, (i) => 'https://picsum.photos/300/400?random=${i + 500}');

  final List<String> _collections = [];

  final List<String> _praised = List.generate(
      3, (i) => 'https://picsum.photos/300/400?random=${i + 100}');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LJNSystemCubit>().updateHomescrollpixels(0);
        context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
        context.read<LJNSystemCubit>().updateMainpage5isload(true);
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
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage5isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
  }

  // [核心修改] 使用 SliverAppBar 重构页面布局
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    double customkToolbarHeight = 95.w;
    double expandedHeight = 700.w;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // 使用 SliverAppBar 来实现折叠头部的效果
            SliverAppBar(
              // primary: true 会自动处理状态栏的高度和间距
              primary: true,
              // 不显示标题
              title: null,
              // 自动隐藏返回按钮
              automaticallyImplyLeading: false,
              // 将 TabBar 固定在顶部
              pinned: true,
              // 当用户开始向下滚动时，SliverAppBar 是否立即出现
              floating: false,
              toolbarHeight: 0,
              // SliverAppBar 完全展开时的高度
              expandedHeight: expandedHeight,
              // 设置背景为透明，以便 flexibleSpace 的内容能够显示
              backgroundColor: theme.cardColor,

              // 可折叠的区域，通常放置背景图、用户信息等
              flexibleSpace: FlexibleSpaceBar(
                // 折叠模式设置为 parallax，可以产生视差滚动效果
                collapseMode: CollapseMode.parallax,
                // 背景内容就是你的用户信息部分
                background: _buildUserInfoSection(systemState, theme),
              ),

              // SliverAppBar 的底部区域，通常放置 TabBar
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(customkToolbarHeight + 2.5.w),
                child: Container(
                  // 背景色确保 TabBar 在固定时有不透明的背景
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
                          onPressed: () => logger.info("搜索按钮被点击"),
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

  Widget _buildUserInfoSection(SystemState systemState, ThemeData theme) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<LJNUserFunctionButton> serviceButtons = [
      LJNUserFunctionButton(
        icon: "images/icon/server_icon11.png",
        title: "钱包",
        onPressed: () => Navigator.pushNamed(context, '/services'),
      ),
      LJNUserFunctionButton(
        icon: "images/icon/server_icon12.png",
        title: "交易",
        onPressed: () {},
      ),
      LJNUserFunctionButton(
        icon: "images/icon/server_icon13.png",
        title: "创作中心",
        onPressed: () {},
      ),
      LJNUserFunctionButton(
        icon: "images/icon/server_icon13.png",
        title: "浏览历史",
        onPressed: () {},
      ),
      LJNUserFunctionButton(
        icon: "images/icon/server_icon14.png",
        title: "学院",
        onPressed: () {
          Navigator.pushNamed(context, '/course_list');
        },
      ),
    ];
    const String accountId = 'TheMonsterClub';

    return SizedBox(
      height: 700.w,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: "https://picsum.photos/750/750?random=497",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade300),
              errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade300, child: Icon(Icons.error)),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
              ),
            ),
          ),
          // 设置 与 扫码按钮
          Positioned(
            // 使用 SafeArea 来确保按钮不会与状态栏或刘海屏重叠
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
                  onTap: () => Navigator.pushNamed(context, '/setting'),
                ),
                _buildFloatingIconButton(
                  icon: const IconData(
                    0xe635,
                    fontFamily: 'Iconfont',
                  ),
                  onTap: () => Navigator.pushNamed(context, '/qrcode_scanner'),
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
                              Navigator.pushNamed(context, '/userinfo'),
                          child: ClipOval(
                            child: BlocBuilder<LJNUserCubit, LJNUserState>(
                              builder: (context, state) {
                                final avatar = state.userinfoAvatar;
                                return Image.asset(
                                  (avatar == null || avatar.isEmpty)
                                      ? assetPath('images/avatar/default.png')
                                      : assetPath(avatar),
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
                                  BlocBuilder<LJNUserCubit, LJNUserState>(
                                    builder: (context, state) => Text(
                                      state.userinfoName ?? '用户名',
                                      style: TextStyle(
                                          fontSize: 42.w,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.qr_code_2_outlined,
                                    size: 50.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.w),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: accountId),
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
                                        fontSize: 28.w,
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
                          () =>
                              Navigator.pushNamed(context, '/follow_and_fans'),
                        ),
                        SizedBox(width: 60.w),
                        _buildStatsItem(
                          "1.2M",
                          "粉丝",
                          () =>
                              Navigator.pushNamed(context, '/follow_and_fans'),
                        ),
                        SizedBox(width: 60.w),
                        _buildStatsItem(
                          "8.9M",
                          "获赞",
                          () => Navigator.pushNamed(context, '/ljn_like'),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/userinfo'),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: theme.dividerColor,
                            foregroundColor: theme.textTheme.bodyLarge?.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              // vertical: 10.w,
                            ),
                            minimumSize: Size(0, 60.w),
                          ),
                          child: Text(
                            "个人资料",
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
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 32,
                  right: 32,
                ).w,
                child: Divider(
                  height: 1.w,
                  color: theme.dividerColor.withAlpha(80),
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
}

class _UserWorksGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return items.isEmpty
        ? _buildEmptyState(context)
        : _buildGridContent(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    if (buttonText == '发布作品') {
      return Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          primary: isActive,
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
                onPressed: onButtonPressed,
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
                  buttonText,
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
        primary: isActive,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 120.w),
            Image.asset(
              assetPath('images/imgs/no-content.webp'),
              width: 200.w,
              height: 200.w,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 30.w),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 28.w,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 40.w),
            ElevatedButton(
              onPressed: onButtonPressed,
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
                buttonText,
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

  Widget _buildGridContent(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: GridView.builder(
        primary: isActive,
        key: PageStorageKey<String>(emptyMessage),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: items[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey.shade400,
                  ),
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
                      colors: [Colors.black.withAlpha(156), Colors.transparent],
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
          );
        },
      ),
    );
  }
}
