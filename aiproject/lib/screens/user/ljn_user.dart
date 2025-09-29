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

  // 用于手势仲裁的状态
  bool? _isDraggingParent; // null: 待定, true: 拖动父级, false: 拖动自己
  double _initialDragDelta = 0.0;

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
    final systemCubit = context.read<LJNSystemCubit>();

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
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (details) {
              _initialDragDelta = 0.0;
              // 意图预测：使用整数索引进行最可靠的判断
              final bool isAtFirstPage = _tabController.index == 0;

              if (isAtFirstPage) {
                // 只有在第一页时，才需要进入复杂的仲裁流程
                _isDraggingParent = null;
              } else {
                // 如果不在第一页，那么 100% 是拖动自己，无需仲裁
                _isDraggingParent = false;
              }
            },
            onHorizontalDragUpdate: (details) {
              // 如果已确定是拖动自己
              if (_isDraggingParent == false) {
                _pageController.position
                    .jumpTo(_pageController.position.pixels - details.delta.dx);
                return;
              }

              // 如果已确定是拖动父级
              if (_isDraggingParent == true) {
                systemCubit.onParentDragUpdate(details.delta.dx);
                return;
              }

              // --- 仲裁阶段 (仅当 _isDraggingParent is null 时) ---
              _initialDragDelta += details.delta.dx;
              const double decisionThreshold = 8.0;

              // 为保证手感，向左滑时让内部PageView先动
              if (_initialDragDelta < 0) {
                _pageController.position
                    .jumpTo(_pageController.position.pixels - details.delta.dx);
              }

              // 检查是否达到决策阈值
              if (_initialDragDelta.abs() > decisionThreshold) {
                // 如果是向右滑，则判定为拖动父级
                if (_initialDragDelta > 0) {
                  _isDraggingParent = true;
                  systemCubit.onParentDragStart();
                  // 把累计的错误位移交给父级
                  systemCubit.onParentDragUpdate(_initialDragDelta);
                  // 重置内部PageView的位置
                  _pageController.position.jumpTo(0);
                } else {
                  // 如果是向左滑，则判定为拖动自己
                  _isDraggingParent = false;
                }
              }
            },
            onHorizontalDragEnd: (details) {
              if (_isDraggingParent == true) {
                systemCubit.onParentDragEnd(details.primaryVelocity ?? 0);
              } else if (_isDraggingParent == false) {
                final velocity = details.primaryVelocity ?? 0;
                final currentPage = _pageController.page!;
                int targetPage;

                if (velocity.abs() > 600) {
                  targetPage =
                      velocity < 0 ? currentPage.ceil() : currentPage.floor();
                } else {
                  targetPage = currentPage.round();
                }

                _pageController.animateToPage(
                  targetPage.clamp(0, 2),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              }
              // 重置所有状态，为下一次手势做准备
              _isDraggingParent = null;
              _initialDragDelta = 0.0;
            },
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
                ),
                _UserWorksGrid(
                  key: const PageStorageKey('collections_grid'),
                  items: _collections,
                  emptyMessage: '还没有收藏',
                  buttonText: '去看看',
                  onButtonPressed: () {},
                ),
                _UserWorksGrid(
                  key: const PageStorageKey('praised_grid'),
                  items: _praised,
                  emptyMessage: '还没有赞过',
                  buttonText: '去看看',
                  onButtonPressed: () {},
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

  const _UserWorksGrid({
    super.key,
    required this.items,
    required this.emptyMessage,
    required this.buttonText,
    required this.onButtonPressed,
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
