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

  final List<String> _works =
      List.generate(25, (i) => 'https://picsum.photos/300/400?random=$i');
  final List<String> _collections = [];
  final List<String> _praised = List.generate(
      3, (i) => 'https://picsum.photos/300/400?random=${i + 100}');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LJNSystemCubit>().updateHomescrollpixels(0);
        context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
        context.read<LJNSystemCubit>().updateMainpage4isload(true);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage4isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
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
                child: _buildUserInfoSection(systemState, theme),
              ),
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
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
                      Tab(
                        child: Text("笔记 ${_works.length}"),
                      ),
                      Tab(
                        child: Text("收藏 ${_collections.length}"),
                      ),
                      Tab(
                        child: Text("赞过 ${_praised.length}"),
                      ),
                    ],
                  ),
                  color: theme.cardColor,
                ),
                pinned: true,
              ),
            ];
          },
          // ===================================================================
          // [最终改动]
          // ===================================================================
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragEnd: (details) {
              double velocity = details.primaryVelocity ?? 0;

              // 向左滑动 (切换到下一个内部 Tab)
              if (velocity < -100 &&
                  _tabController.index < _tabController.length - 1) {
                _tabController.animateTo(_tabController.index + 1);
              }
              // 向右滑动
              else if (velocity > 100) {
                // 如果在内部 Tab 中可以向右切换，则切换
                if (_tabController.index > 0) {
                  _tabController.animateTo(_tabController.index - 1);
                }
                // [核心逻辑] 如果已经是第一个内部 Tab，则触发外部主 TabBar 的切换
                else {
                  context.read<LJNSystemCubit>().switchToPreviousMainTab();
                }
              }
            },
            child: Container(
              color: theme.cardColor,
              child: TabBarView(
                controller: _tabController,
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
      ),
    );
  }

  // 构建浮动按钮的辅助方法
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

  // 构建用户信息区的 Widget (包含功能按钮)
  Widget _buildUserInfoSection(SystemState systemState, ThemeData theme) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 功能按钮列表数据
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
      padding: EdgeInsets.fromLTRB(
        32.w,
        20.w + systemState.statusHeight,
        32.w,
        40.w,
      ),
      margin: EdgeInsets.only(bottom: 20.w),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部：头像、昵称
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
                        BlocBuilder<LJNUserCubit, LJNUserState>(
                          builder: (context, state) => Text(
                            state.userinfoName ?? '用户名',
                            style: TextStyle(
                              fontSize: 42.w,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.w),
                        // [修复] ID 和二维码图标的 Row
                        GestureDetector(
                          onTap: () {/* 跳转到二维码页面 */},
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // 让Row包裹内容
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
              // 社交数据
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
              // 余额
              Row(
                children: [
                  Text(
                    "余额：",
                    style: TextStyle(
                        fontSize: 30.w,
                        color: theme.colorScheme.onSurface.withOpacity(0.8)),
                  ),
                  Text(
                    _isBalanceVisible ? "\$1,234.56" : "****",
                    style: TextStyle(
                        fontSize: 30.w,
                        color: theme.colorScheme.onSurface,
                        fontFamily: 'DMMono',
                        fontWeight: FontWeight.w600),
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
              // 分割线
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.w,
                ),
                child: Divider(
                  height: 1.w,
                  color: theme.dividerColor,
                ),
              ),
              // [关键改动] 功能按钮 GridView
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  return serviceButtons[index];
                },
              ),
            ],
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
                  onTap: () {
                    logger.info("分享按钮被点击");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 构建社交数据项的小组件
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

// =======================================================================
// [辅助类] 用于创建固定在顶部的 TabBar
// =======================================================================
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
    return Container(
      color: color,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return color != oldDelegate.color;
  }
}

// =======================================================================
// [辅助 Widget] 用于显示作品网格或空状态 (已修复溢出问题)
// =======================================================================
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
    if (items.isEmpty) {
      return _buildEmptyState(context);
    } else {
      return _buildGridContent(context);
    }
  }

  // [关键修改] 在这里修复布局溢出问题
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      alignment: Alignment.topCenter,
      // 👇 [改动] 使用 SingleChildScrollView 包裹 Column
      // 这样当内容超出可用高度时，就会自动启用滚动，从而避免溢出错误。
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
            // 可以额外加一个底部的 padding，防止滚动到底部时按钮紧贴边缘
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
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 4.w,
          childAspectRatio: 9 / 16,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
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
