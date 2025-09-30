// /lib/screens/user/ljn_user.dart

import 'package:flutter/gestures.dart';
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

  VelocityTracker? _velocityTracker;

  bool _isDragging = false;
  bool? _isDraggingParent;

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

    _tabController.addListener(() {
      if (mounted &&
          (_tabController.indexIsChanging || !_tabController.indexIsChanging)) {
        setState(() {});
      }
    });

    _pageController.addListener(() {
      if (!_pageController.hasClients || _tabController.indexIsChanging) return;

      final double page = _pageController.page!;
      final int newIndex = page.round();

      if (_tabController.index != newIndex) {
        setState(() {
          _tabController.index = newIndex;
        });
      }
      _tabController.offset = page - newIndex;
    });

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
    final systemCubit = context.read<LJNSystemCubit>();
    if (systemCubit.state.isParentPageViewLocked) {
      systemCubit.lockParentPageView(false);
    }
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

  // --- 手势处理方法 (最终正确版) ---
  void _handleDragDown(PointerDownEvent details) {
    _isDragging = true;
    _isDraggingParent = null;
    _velocityTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
    _velocityTracker?.addPosition(details.timeStamp, details.position);
  }

  void _handleDragUpdate(PointerMoveEvent details) {
    if (!_isDragging) return;

    _velocityTracker?.addPosition(details.timeStamp, details.position);

    // --- 仲裁阶段 (只在做出决定前运行一次) ---
    if (_isDraggingParent == null) {
      final double dx = details.delta.dx;
      // 仅当手势主要是水平方向时才进行仲裁
      if (dx.abs() > details.delta.dy.abs()) {
        final systemCubit = context.read<LJNSystemCubit>();

        if (_tabController.index == 0 && dx > 0) {
          // 决策：父级处理。
          // 我们通知父级开始，然后就撒手不管，让父级自己的 physics 接管。
          _isDraggingParent = true;
          systemCubit.onParentDragStart();
        } else {
          // 决策：子级处理。
          _isDraggingParent = false;
          systemCubit.lockParentPageView(true);
        }
      }
    }

    // --- 执行阶段 ---
    // 如果决策是让子级处理，我们就手动滚动子 PageView。
    if (_isDraggingParent == false) {
      _pageController.position
          .jumpTo(_pageController.position.pixels - details.delta.dx);
    }
    // 如果 _isDraggingParent 是 true，我们在这里什么都不做，让父级的 physics 自己处理拖动。
  }

  void _onDragEndOrCancel() {
    if (!_isDragging) return;

    final systemCubit = context.read<LJNSystemCubit>();
    final velocity = _velocityTracker?.getVelocity().pixelsPerSecond.dx ?? 0.0;

    if (_isDraggingParent == true) {
      // 通知父级手势结束了，让它可以处理收尾动画和状态重置
      systemCubit.onParentDragEnd(velocity);
    } else if (_isDraggingParent == false) {
      // 如果是子级在处理，解锁父级并动画子级
      systemCubit.lockParentPageView(false);

      final page = _pageController.page!;
      int targetPage;
      const double flingVelocityThreshold = 800.0;
      const double dragOffsetThreshold = 0.25;

      if (velocity.abs() > flingVelocityThreshold) {
        targetPage = (velocity < 0) ? page.ceil() : page.floor();
      } else {
        final offset = page - page.floor();
        if (offset > dragOffsetThreshold &&
            _pageController.page! > page.floor()) {
          targetPage = page.ceil();
        } else if (offset < (1 - dragOffsetThreshold) &&
            _pageController.page! < page.ceil()) {
          targetPage = page.floor();
        } else {
          targetPage = page.round();
        }
      }

      _pageController.animateToPage(
        targetPage.clamp(0, 2),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    // 重置所有状态
    _isDragging = false;
    _isDraggingParent = null;
    _velocityTracker = null;
  }

  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                  child: _buildUserInfoSection(systemState, theme)),
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {});
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
          body: Listener(
            onPointerDown: _handleDragDown,
            onPointerMove: _handleDragUpdate,
            onPointerUp: (_) => _onDragEndOrCancel(),
            onPointerCancel: (_) => _onDragEndOrCancel(),
            behavior: HitTestBehavior.opaque,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
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
        title: "充值",
        onPressed: () {},
      ),
      LJNFunctionButton(
        icon: "images/icon/server_icon12.png",
        title: "提现",
        onPressed: () {},
      ),
      LJNFunctionButton(
        icon: "images/icon/server_icon13.png",
        title: "账单明细",
        onPressed: () {},
      ),
      LJNFunctionButton(
        icon: "images/icon/server_icon14.png",
        title: "创作报表",
        onPressed: () {},
      ),
    ];
    return Container(
      color: theme.cardColor,
      margin: EdgeInsets.only(bottom: 20.w),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              32.w,
              20.w + systemState.statusHeight,
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
                      onTap: () => setState(
                          () => _isBalanceVisible = !_isBalanceVisible),
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
                  padding: EdgeInsets.symmetric(vertical: 30.w),
                  child: Divider(
                    height: 1.w,
                    color: theme.dividerColor,
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: serviceButtons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.1),
                  itemBuilder: (context, index) => serviceButtons[index],
                ),
              ],
            ),
          ),
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
      ),
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(0.w),
            child: Image.network(
              items[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(color: Colors.grey.shade200);
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
