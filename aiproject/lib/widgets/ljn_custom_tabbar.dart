// ./lib/widgets/ljn_custom_tabbar.dart

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
      iconSize: 80.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe61c, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe638, fontFamily: "Iconfont"),
      iconSize: 76.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe67c, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe642, fontFamily: "Iconfont"),
      iconSize: 82.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
      iconSize: 80.0.w,
    ),
    _TabInfo(
      icon: const IconData(0xe63f, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe62b, fontFamily: "Iconfont"),
      iconSize: 86.0.w,
    ),
  ];

  int _appbarNameIndex = 0;
  double _appbarLeft = 0;
  bool _hiddenAppbar = true;
  bool _showPopup = false;

  Color _tabBarBackgroundColor = Colors.black.withAlpha(64);
  Color _selectedItemColor = Colors.white;
  Color _unselectedItemColor = Colors.white.withAlpha(153);
  Color _borderColor = Colors.white.withAlpha(38);

  bool _isTapAnimating = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _pageController.addListener(_handlePageScroll);

    var systemCubit = context.read<LJNSystemCubit>();

    systemCubit.updateTabbarHeight(100.w);
    systemCubit.updateAppbarHeight(90.w);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateUiForPage(0.0);

        if (kIsWeb) {
          systemCubit.updateStatusHeight(0);
        } else {
          systemCubit.updateStatusHeight(MediaQuery.of(context).padding.top);
        }
      }
    });
  }

  void _updateUiForPage(double page) {
    if (!mounted) return;
    if (_tabController.indexIsChanging && !_isTapAnimating) return;

    if (!_isTapAnimating) {
      _tabController.offset = (page - _tabController.index).clamp(-1.0, 1.0);
    }

    final theme = Theme.of(context);
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

    final double t = page.clamp(0.0, 1.0);
    final newTabBarBackgroundColor =
        Color.lerp(videoTabBackgroundColor, otherTabBackgroundColor, t)!;
    final newSelectedItemColor =
        Color.lerp(videoTabForegroundColor, otherTabForegroundColor, t)!;
    final newUnselectedItemColor =
        Color.lerp(videoTabUnselectedColor, otherTabUnselectedColor, t)!;
    final newBorderColor =
        Color.lerp(videoTabBorderColor, otherTabBorderColor, t)!;

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
      _tabBarBackgroundColor = newTabBarBackgroundColor;
      _selectedItemColor = newSelectedItemColor;
      _unselectedItemColor = newUnselectedItemColor;
      _borderColor = newBorderColor;
      _appbarLeft = newAppbarLeft;
      _appbarNameIndex = newAppbarNameIndex;
      _hiddenAppbar = newHiddenAppbar;
    });
  }

  void _handlePageScroll() {
    if (!_pageController.hasClients) return;
    if (_isTapAnimating) return;
    _updateUiForPage(_pageController.page!);
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
              // 页面内容
              Scaffold(
                primary: false,
                backgroundColor: _tabController.index == 0
                    ? Colors.black
                    : theme.scaffoldBackgroundColor,
                bottomNavigationBar: Visibility(
                  visible: !systemState.showMiniProgramDrawer,
                  child: Container(
                    height: systemState.tabbarHeight + 1.0.w,
                    decoration: BoxDecoration(
                      color: _tabBarBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          color: _borderColor,
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

                        _updateUiForPage(index.toDouble());
                        _tabController.index = index;

                        _pageController
                            .animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                            .then((_) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() {
                                _isTapAnimating = false;
                              });
                            }
                          });
                        });
                      },
                      dividerColor: Colors.transparent,
                      labelColor: _selectedItemColor,
                      labelStyle: theme.tabBarTheme.labelStyle,
                      unselectedLabelColor: _unselectedItemColor,
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
                            // height: systemState.tabbarHeight,
                            iconMargin: EdgeInsets.only(bottom: 6.w),
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
                  // [MODIFIED] 这是唯一的修改。
                  // 将 physics 设置为 NeverScrollableScrollPhysics，
                  // 这会禁止用户通过手势滑动页面，但依然允许通过点击 TabBar 来切换。
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
                bottom: systemState.tabbarHeight + 0.w,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: systemState.showVideoProgress,
                  child: LinearProgressIndicator(
                    value: systemState.videoProgress,
                    minHeight: 2,
                    backgroundColor: theme.colorScheme.primary.withAlpha(77),
                    // minHeight: 5,
                    // backgroundColor: theme.colorScheme.primary,
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
