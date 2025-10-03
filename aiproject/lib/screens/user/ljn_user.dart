// /lib/screens/user/ljn_user.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_button.dart';
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

  bool _isBalanceVisible = true;
  late TabController _tabController;
  late PageController _pageController;

  final List<String> _works =
      List.generate(25, (i) => 'https://picsum.photos/300/400?random=$i');
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

  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      primary: false,
      appBar: PreferredSize(
          preferredSize: Size(750.w, systemState.statusHeight),
          child: Container(
            color: theme.cardColor,
          )),
      backgroundColor: theme.colorScheme.surfaceContainer,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                // 用户信息
                child: _buildUserInfoSection(systemState, theme),
              ),
              // Tabbar标题
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    // [FIXED] 移除了错误的 if 判断
                    onTap: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    labelColor: theme.textTheme.bodyLarge?.color,
                    unselectedLabelColor: theme.hintColor,
                    indicatorColor: theme.colorScheme.primary,
                    indicatorWeight: 2.5,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(horizontal: 40.w),
                    labelStyle: TextStyle(
                      fontSize: 30.w,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 30.w,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: [
                      Tab(child: Text("作品 ${_works.length}")),
                      Tab(child: Text("收藏 ${_collections.length}")),
                      Tab(child: Text("赞过 ${_praised.length}")),
                    ],
                  ),
                  color: theme.cardColor,
                ),
                pinned: true,
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
                emptyMessage: '保持热爱奔赴山河',
                buttonText: '去发布',
                onButtonPressed: () {},
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
      ),
    );
  }

  Widget _buildFloatingIconButton(
      {required IconData icon, required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyLarge?.color,
        size: 44.w,
      ),
      padding: EdgeInsets.all(24.w),
    );
  }

  Widget _buildUserInfoSection(SystemState systemState, ThemeData theme) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<LJNFunctionButton> serviceButtons = [
      LJNFunctionButton(
        icon: "images/icon/server_icon11.png",
        title: "钱包",
        onPressed: () {},
      ),
      LJNFunctionButton(
        icon: "images/icon/server_icon12.png",
        title: "交易",
        onPressed: () {},
      ),
      LJNFunctionButton(
        icon: "images/icon/server_icon13.png",
        title: "创作",
        onPressed: () {},
      ),
      LJNFunctionButton(
        icon: "images/icon/server_icon14.png",
        title: "报表",
        onPressed: () {},
      ),
    ];
    return Stack(
      children: [
        Container(
          color: theme.cardColor,
          margin: EdgeInsets.only(bottom: 20.w),
          padding: EdgeInsets.fromLTRB(
            32.w,
            40.w,
            32.w,
            20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/userinfo'),
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
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/userinfo'),
                          child: BlocBuilder<LJNUserCubit, LJNUserState>(
                            builder: (context, state) => Text(
                              state.userinfoName ?? '用户名',
                              style: TextStyle(
                                fontSize: 42.w,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.w),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/userinfo'),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.vigavigaIdDisplay('TheMonsterClub'),
                                style: TextStyle(
                                  fontSize: 26.w,
                                  color: theme.hintColor,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Icon(
                                Icons.qr_code_2_outlined,
                                size: 28.w,
                                color: theme.hintColor,
                              ),
                              SizedBox(width: 10.w),
                              Icon(
                                Icons.chevron_right,
                                size: 32.w,
                                color: theme.hintColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.w),
              Row(
                children: [
                  _buildStatsItem("25", "关注"),
                  SizedBox(width: 60.w),
                  _buildStatsItem("1.2M", "粉丝"),
                  SizedBox(width: 60.w),
                  _buildStatsItem("8.9M", "获赞"),
                ],
              ),
              SizedBox(height: 30.w),
              Row(
                children: [
                  Text(
                    "余额：",
                    style: TextStyle(
                      fontSize: 30.w,
                      color: theme.colorScheme.onSurface.withAlpha(200),
                    ),
                  ),
                  Text(
                    _isBalanceVisible ? "\$1,234.56" : "****",
                    style: TextStyle(
                      fontSize: 30.w,
                      color: theme.colorScheme.onSurface,
                      fontFamily: 'DMMono',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  InkWell(
                    borderRadius: BorderRadius.circular(20.w),
                    onTap: () =>
                        setState(() => _isBalanceVisible = !_isBalanceVisible),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Icon(
                        _isBalanceVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 32.w,
                        color: theme.hintColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.w, bottom: 20.w),
                child: Divider(
                  height: 1.w,
                  color: theme.dividerColor,
                ),
              ),
              // 功能区域
              GridView.builder(
                padding: EdgeInsets.only(top: 0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) => serviceButtons[index],
              ),
            ],
          ),
        ),
        // 设置
        Positioned(
          top: 0.w,
          right: 0,
          child: Row(
            children: [
              _buildFloatingIconButton(
                icon: Icons.settings_outlined,
                onTap: () => Navigator.pushNamed(context, '/setting'),
              ),
              _buildFloatingIconButton(
                icon: Icons.share_outlined,
                onTap: () => logger.info("分享按钮被点击"),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildStatsItem(String count, String label) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 30.w,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 26.w,
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar, {required this.color});
  final TabBar tabBar;
  final Color color;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: color, child: tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) =>
      color != oldDelegate.color;
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

  Widget _buildGridContent(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: GridView.builder(
        primary: isActive,
        key: PageStorageKey<String>(emptyMessage),
        padding: EdgeInsets.all(4.w),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) {
          return CachedNetworkImage(
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
          );
        },
      ),
    );
  }
}
