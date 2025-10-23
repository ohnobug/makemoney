import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/arts/ljn_arts_page.dart';
import 'package:vigaviga/screens/contract/ljn_recent_chats_list_page.dart';
import 'package:vigaviga/screens/discovery/ljn_discovery_page.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher_page.dart';
import 'package:vigaviga/screens/user/ljn_user_page.dart';
import 'package:vigaviga/widgets/ljn_popup_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

// _TabInfo 类保持不变
class _TabInfo {
  final IconData icon;
  final IconData selectedIcon;
  final double iconSize;

  const _TabInfo({
    required this.icon,
    required this.selectedIcon,
    required this.iconSize,
  });
}

// LJNCustomTabbar 类保持不变
class LJNCustomTabbar extends StatefulWidget {
  const LJNCustomTabbar({super.key});

  @override
  State<LJNCustomTabbar> createState() => _LJNCustomTabbarState();
}

// ------------------- 主要修改区域 -------------------
class _LJNCustomTabbarState extends State<LJNCustomTabbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  List<String> _getTabTitles(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    return [
      l10n.tabbar_label_arts,
      l10n.tabbar_label_discover,
      l10n.tabbar_label_publisher,
      l10n.tabbar_label_chat,
      l10n.tabbar_label_me,
    ];
  }

  final List<_TabInfo> _tabs = [
    _TabInfo(
      icon: const IconData(0xe63c, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe63b, fontFamily: "Iconfont"),
      iconSize: 75.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe61c, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe638, fontFamily: "Iconfont"),
      iconSize: 71.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe67c, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe642, fontFamily: "Iconfont"),
      iconSize: 77.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
      iconSize: 75.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe63f, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe62b, fontFamily: "Iconfont"),
      iconSize: 81.0.w,
    ),
  ];

  bool _showPopup = false;

  @override
  void initState() {
    super.initState();

    var systemCubit = context.read<LJNSystemCubit>();
    systemCubit.updateTabbarHeight(95.w);
    systemCubit.updateAppbarHeight(90.w);

    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (kIsWeb) {
          systemCubit.updateStatusHeight(0);
        } else {
          systemCubit.updateStatusHeight(MediaQuery.of(context).padding.top);
        }
      }
    });
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging == false) {
      final index = _tabController.index;
      context.read<LJNSystemCubit>().updateMainTabIndex(index);
      context.read<LJNSystemCubit>().updateVideoProgress(show: index == 0);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final tabTitles = _getTabTitles(context);
    final systemCubit = context.read<LJNSystemCubit>();

    // 颜色计算逻辑保持不变，但现在依赖于 _tabController 的动画值
    final Color videoTabBackgroundColor = Colors.black.withAlpha(64);
    const Color videoTabForegroundColor = Colors.white;
    final Color videoTabUnselectedColor = Colors.white.withAlpha(153);
    final Color videoTabBorderColor = Colors.white.withAlpha(38);

    final Color otherTabBackgroundColor =
        theme.bottomAppBarTheme.color ?? theme.scaffoldBackgroundColor;
    final Color otherTabForegroundColor =
        theme.tabBarTheme.labelColor ?? theme.colorScheme.primary;
    final Color otherTabUnselectedColor =
        theme.tabBarTheme.unselectedLabelColor ?? Colors.grey;
    final Color otherTabBorderColor = theme.dividerColor;

    double page =
        _tabController.animation?.value ?? _tabController.index.toDouble();

    final double t = page.clamp(0.0, 1.0);

    final Color finalTabBarBackgroundColor =
        Color.lerp(videoTabBackgroundColor, otherTabBackgroundColor, t)!;
    final Color finalSelectedItemColor =
        Color.lerp(videoTabForegroundColor, otherTabForegroundColor, t)!;
    final Color finalUnselectedItemColor =
        Color.lerp(videoTabUnselectedColor, otherTabUnselectedColor, t)!;
    final Color finalBorderColor =
        Color.lerp(videoTabBorderColor, otherTabBorderColor, t)!;

    return BlocListener<LJNSystemCubit, SystemState>(
      listenWhen: (prev, current) =>
          prev.parentDragState != current.parentDragState,
      listener: (context, state) {
        if (state.parentDragState == ParentDragState.animating) {
          final velocity = state.parentDragEndVelocity ?? 0.0;
          // Bloc 监听器中的页面切换逻辑改为使用 _tabController
          final targetPage = _tabController.index - 1;

          if (velocity > 800) {
            _tabController.animateTo(
              targetPage,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          } else if (page > (targetPage + 0.5)) {
            _tabController.animateTo(
              targetPage,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          }
          systemCubit.onParentDragHandled();
        }
      },
      child: BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Stack(
            children: [
              Scaffold(
                primary: false,
                backgroundColor:
                    t < 0.5 ? Colors.black : theme.scaffoldBackgroundColor,
                bottomNavigationBar: Visibility(
                  visible: systemState.showHomeTabbar &&
                      !systemState.showCommentsPanel,
                  child: Container(
                    height: systemState.tabbarHeight + 1.0.w,
                    decoration: BoxDecoration(
                      color: finalTabBarBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          color: finalBorderColor,
                          width: 1.0.w,
                        ),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      labelColor: finalSelectedItemColor,
                      labelStyle: theme.tabBarTheme.labelStyle,
                      unselectedLabelColor: finalUnselectedItemColor,
                      indicator: const BoxDecoration(),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      tabs: List.generate(
                        _tabs.length,
                        (index) {
                          final tabInfo = _tabs[index];
                          final icon = _tabController.index == index
                              ? tabInfo.selectedIcon
                              : tabInfo.icon;
                          return Tab(
                            iconMargin: EdgeInsets.only(bottom: 3.w),
                            icon: SizedBox(
                              height: 50.w,
                              width: 50.w,
                              child: Center(
                                child: Icon(
                                  icon,
                                  size: tabInfo.iconSize.w,
                                ),
                              ),
                            ),
                            text: tabTitles[index],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                appBar: null,
                body: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const <Widget>[
                    LJNArtsPage(),
                    LJNDiscoveryPage(),
                    LJNPublisherPage(),
                    LJNRecentChatsListPage(),
                    LJNUserPage(),
                  ],
                ),
              ),

              // 弹窗
              if (_showPopup) ...[
                GestureDetector(
                  onTapDown: (_) => setState(() => _showPopup = false),
                  child: Container(
                    width: 750.w,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                  ),
                ),
                Positioned(
                  right: 15.w,
                  top: systemState.statusHeight + 80.w,
                  child: SizedBox(
                    width: 320.w,
                    child: LJNPopupMenu(
                      showPopup: _showPopup,
                      setShowPopup: (bool value) =>
                          setState(() => _showPopup = value),
                    ),
                  ),
                )
              ],

              // 视频进度条
              Positioned(
                bottom: systemState.tabbarHeight +
                    systemState.videoProgressBottomOffset,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: systemState.showVideoProgress,
                  child: LinearProgressIndicator(
                    value: systemState.videoProgress,
                    minHeight: 2,
                    backgroundColor: theme.colorScheme.primary.withAlpha(77),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary.withAlpha(179),
                    ),
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
