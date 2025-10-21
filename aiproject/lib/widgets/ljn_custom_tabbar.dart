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
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

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

class LJNCustomTabbar extends StatefulWidget {
  const LJNCustomTabbar({super.key});

  @override
  State<LJNCustomTabbar> createState() => _LJNCustomTabbarState();
}

class _LJNCustomTabbarState extends State<LJNCustomTabbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

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

  int _appbarNameIndex = 0;
  double _appbarLeft = 0;
  bool _hiddenAppbar = true;
  bool _showPopup = false;
  bool _isTapAnimating = false;

  // [主要改动 1] 移除所有颜色相关的状态变量
  // Color _tabBarBackgroundColor = ... (移除)
  // Color _selectedItemColor = ... (移除)
  // Color _unselectedItemColor = ... (移除)
  // Color _borderColor = ... (移除)

  @override
  void initState() {
    super.initState();

    var systemCubit = context.read<LJNSystemCubit>();
    systemCubit.updateTabbarHeight(95.w);
    systemCubit.updateAppbarHeight(90.w);

    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    // [主要改动 2] 现在页面滚动时只更新非颜色相关的UI状态
    _pageController.addListener(_handlePageScroll);
    // 同时，我们需要监听 TabController 的动画，以便在 build 方法中获取精确的滚动值
    _tabController.animation?.addListener(() {
      // 仅在手动滑动时触发UI重绘，避免与点击动画冲突
      if (!_isTapAnimating && !_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // [主要改动 3] initState 中不再需要调用 _updateUiForPage 来设置颜色
        _updateNonColorUI(0.0);

        if (kIsWeb) {
          systemCubit.updateStatusHeight(0);
        } else {
          systemCubit.updateStatusHeight(MediaQuery.of(context).padding.top);
        }
      }
    });
  }

  // [主要改动 4] 将 _updateUiForPage 重命名并简化，只处理非颜色的UI状态
  void _updateNonColorUI(double page) {
    if (!mounted) return;

    double newAppbarLeft = 0;
    int newAppbarNameIndex = page.round();
    if (page >= 0 && page < 1) {
      newAppbarLeft = (1 - page) * 750.w;
      newAppbarNameIndex = 1;
    } else if (page > 3 && page <= 4) {
      newAppbarLeft = ((page - 3) * 750.w) * -1;
      newAppbarNameIndex = 3;
    }
    final bool newHiddenAppbar = (page.round() == 0 || page >= 4);

    setState(() {
      _appbarLeft = newAppbarLeft;
      _appbarNameIndex = newAppbarNameIndex;
      _hiddenAppbar = newHiddenAppbar;
    });
  }

  void _handlePageScroll() {
    if (!_pageController.hasClients) return;
    if (_isTapAnimating) return;
    // 页面滚动时，同时触发颜色重计算（通过setState）和非颜色UI更新
    setState(() {});
    _updateNonColorUI(_pageController.page!);
  }

  void _onPageChanged(int index) {
    if (_tabController.index != index) {
      setState(() {
        _tabController.index = index;
      });
    }

    context.read<LJNSystemCubit>().updateMainTabIndex(index);
    context.read<LJNSystemCubit>().updateVideoProgress(show: index == 0);
    context.read<LJNSystemCubit>().updateHomescrollpixels(0);
  }

  @override
  void dispose() {
    _pageController.removeListener(_handlePageScroll);
    _tabController.animation?.removeListener(() {});
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final tabTitles = _getTabTitles(context);
    final systemCubit = context.read<LJNSystemCubit>();

    // [主要改动 5] 在 build 方法中动态计算所有颜色
    // 这样，每当主题变化或页面滚动时，颜色都会被重新正确计算

    // 1. 定义两种状态的颜色
    // 视频页（第0页）的样式
    final Color videoTabBackgroundColor = Colors.black.withAlpha(64);
    const Color videoTabForegroundColor = Colors.white;
    final Color videoTabUnselectedColor = Colors.white.withAlpha(153);
    final Color videoTabBorderColor = Colors.white.withAlpha(38);

    // 其他页面的样式，直接从当前主题获取
    final Color otherTabBackgroundColor =
        theme.bottomAppBarTheme.color ?? theme.scaffoldBackgroundColor;
    final Color otherTabForegroundColor =
        theme.tabBarTheme.labelColor ?? theme.colorScheme.primary;
    final Color otherTabUnselectedColor =
        theme.tabBarTheme.unselectedLabelColor ?? Colors.grey;
    final Color otherTabBorderColor = theme.dividerColor;

    // 2. 计算插值因子 t
    // 获取当前精确的页面位置，优先使用 PageController
    double page =
        _pageController.hasClients && _pageController.position.haveDimensions
            ? _pageController.page!
            : _tabController.index.toDouble();

    // t 只在 0.0 到 1.0 之间有效，用于实现第一页到第二页的过渡动画
    final double t = page.clamp(0.0, 1.0);

    // 3. 使用 Color.lerp 计算出最终的颜色
    final Color finalTabBarBackgroundColor =
        Color.lerp(videoTabBackgroundColor, otherTabBackgroundColor, t)!;
    final Color finalSelectedItemColor =
        Color.lerp(videoTabForegroundColor, otherTabForegroundColor, t)!;
    final Color finalUnselectedItemColor =
        Color.lerp(videoTabUnselectedColor, otherTabUnselectedColor, t)!;
    final Color finalBorderColor =
        Color.lerp(videoTabBorderColor, otherTabBorderColor, t)!;

    // 不再需要 BlocListener 来更新颜色，BlocBuilder 会在主题变化时自动触发重建
    return BlocListener<LJNSystemCubit, SystemState>(
      listenWhen: (prev, current) =>
          prev.parentDragState != current.parentDragState,
      listener: (context, state) {
        if (state.parentDragState == ParentDragState.animating) {
          final velocity = state.parentDragEndVelocity ?? 0.0;

          if (velocity > 800) {
            _pageController.animateToPage(
              _tabController.index - 1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          } else if (_pageController.page! > (_tabController.index - 0.5)) {
            _pageController.animateToPage(
              _tabController.index - 1,
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
                backgroundColor: t < 0.5 // 背景色也需要动态计算
                    ? Colors.black
                    : theme.scaffoldBackgroundColor,
                bottomNavigationBar: Visibility(
                  visible: !systemState.showMiniProgramDrawer && !systemState.showCommentsPanel,
                  child: Container(
                    height: systemState.tabbarHeight + 1.0.w,
                    decoration: BoxDecoration(
                      // [主要改动 6] 使用在 build 方法中计算好的最终颜色
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
                      onTap: (index) {
                        setState(() {
                          _isTapAnimating = true;
                        });

                        _updateNonColorUI(index.toDouble());

                        _pageController
                            .animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                            .then((_) {
                          if (mounted) {
                            setState(() {
                              _isTapAnimating = false;
                            });
                          }
                        });
                      },
                      dividerColor: Colors.transparent,
                      // [主要改动 6] 使用在 build 方法中计算好的最终颜色
                      labelColor: finalSelectedItemColor,
                      labelStyle: theme.tabBarTheme.labelStyle,
                      unselectedLabelColor: finalUnselectedItemColor,
                      indicator: const BoxDecoration(),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      tabs: List.generate(
                        _tabs.length,
                        (index) {
                          final tabInfo = _tabs[index];
                          // 图标的选择逻辑保持不变
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
                body: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
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

              // Appbar
              Visibility(
                visible: !_hiddenAppbar &&
                    ((systemState.homescrollpixels +
                            systemState.statusHeight) <=
                        (MediaQuery.of(context).size.height * 0.25)),
                child: Positioned(
                  top: systemState.homescrollpixels,
                  left: _appbarLeft,
                  child: Container(
                    width: 750.0.w,
                    height: systemState.statusHeight + systemState.appbarHeight,
                    color: systemState.homescrollpixels == 0
                        ? theme.appBarTheme.backgroundColor
                        : Colors.transparent,
                    child: Listener(
                      onPointerUp: (_) =>
                          systemCubit.updateShowMiniProgramDrawer(false),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LJNAppBarInner(
                            context: context,
                            title: tabTitles[_appbarNameIndex],
                            actions: [
                              if (_tabController.index == 3)
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/contact'),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 90.w,
                                    padding: EdgeInsets.only(right: 33.w),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      color: theme
                                          .appBarTheme.titleTextStyle!.color,
                                      const IconData(0xe608,
                                          fontFamily: 'Iconfont'),
                                      size: 42.w,
                                    ),
                                  ),
                                ),
                              GestureDetector(
                                onTap: () {
                                  if (systemState.homescrollpixels == 0) {
                                    setState(() => _showPopup = !_showPopup);
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 90.w,
                                  padding: EdgeInsets.only(right: 33.w),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    color:
                                        theme.appBarTheme.titleTextStyle!.color,
                                    const IconData(0xe726,
                                        fontFamily: 'Iconfont'),
                                    size: 42.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 7.w)
                            ],
                            leading: _tabController.index == 3
                                ? GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 90.w,
                                      padding: EdgeInsets.only(left: 33.w),
                                      child: Icon(
                                        color: theme
                                            .appBarTheme.titleTextStyle!.color,
                                        const IconData(
                                          0xe612,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 40.w,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // 弹出窗口
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
                bottom: systemState.tabbarHeight + systemState.videoProgressBottomOffset,
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
