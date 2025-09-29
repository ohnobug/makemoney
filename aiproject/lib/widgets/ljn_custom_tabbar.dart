// ./lib/widgets/ljn_custom_tabbar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_popup_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher.dart';
import 'package:vigaviga/screens/shortvideos/ljn_arts.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';
import 'package:vigaviga/screens/discovery/ljn_discovery.dart';
import 'package:vigaviga/screens/contract/ljn_recent_chats_list.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/screens/user/ljn_user.dart';

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
        icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
        iconSize: 90.0.w),
    _TabInfo(
        icon: const IconData(0xe61c, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe638, fontFamily: "Iconfont"),
        iconSize: 86.0.w),
    _TabInfo(
        icon: const IconData(0xe67c, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe642, fontFamily: "Iconfont"),
        iconSize: 96.0.w),
    _TabInfo(
        icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
        iconSize: 90.0.w),
    _TabInfo(
        icon: const IconData(0xe63f, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe62b, fontFamily: "Iconfont"),
        iconSize: 96.0.w),
  ];

  int _appbarNameIndex = 0;
  double _appbarLeft = 0;
  bool _hiddenAppbar = true;
  bool _showPopup = false;

  Color _tabBarBackgroundColor = Colors.black.withAlpha(64);
  Color _selectedItemColor = Colors.white;
  Color _unselectedItemColor = Colors.white.withAlpha(153);
  Color _borderColor = Colors.white.withAlpha(38);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _pageController.addListener(_handlePageScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateUiForPage(0.0);
        context.read<LJNSystemCubit>().updateVideoProgress(show: true);
        context.read<LJNSystemCubit>().updateMainTabIndex(_tabController.index);
      }
    });
  }

  void _updateUiForPage(double page) {
    if (!mounted) return;
    if (_tabController.indexIsChanging) return;

    _tabController.offset = (page - _tabController.index).clamp(-1.0, 1.0);

    final theme = Theme.of(context);

    // 定义两种状态的颜色
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

    // 计算渐变进度 t
    final double t = page.clamp(0.0, 1.0);

    // 使用 lerp 计算当前帧的颜色
    final newTabBarBackgroundColor =
        Color.lerp(videoTabBackgroundColor, otherTabBackgroundColor, t)!;
    final newSelectedItemColor =
        Color.lerp(videoTabForegroundColor, otherTabForegroundColor, t)!;
    final newUnselectedItemColor =
        Color.lerp(videoTabUnselectedColor, otherTabUnselectedColor, t)!;
    final newBorderColor =
        Color.lerp(videoTabBorderColor, otherTabBorderColor, t)!;

    // AppBar 滑动动画逻辑
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

    // 通过 setState 应用所有计算出的新状态
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
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<LJNSystemCubit, SystemState>(
      listenWhen: (prev, current) =>
          prev.parentDragState != current.parentDragState ||
          (current.parentDragState == ParentDragState.dragging &&
              prev.parentDragDelta != current.parentDragDelta),
      listener: (context, state) {
        if (state.parentDragState == ParentDragState.dragging) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              _pageController.position.jumpTo(
                  _pageController.position.pixels - state.parentDragDelta);
            }
          });
        } else if (state.parentDragState == ParentDragState.animating) {
          final velocity = state.parentDragEndVelocity!;
          final offset = state.parentDragOffset;

          if (offset > screenWidth / 3 || velocity > 800) {
            _pageController.animateToPage(_tabController.index - 1,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut);
          } else {
            _pageController.animateToPage(_tabController.index,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut);
          }

          systemCubit.onParentDragHandled();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            primary: false,
            backgroundColor: _tabController.index == 0
                ? Colors.black
                : theme.scaffoldBackgroundColor,
            bottomNavigationBar: Visibility(
              visible: !systemCubit.state.showMiniProgramDrawer,
              child: Container(
                height: 106.w,
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
                    // [MODIFIED] 最终的、最稳健的 onTap 逻辑
                    // 1. 立即将 UI "跃迁" 到目标页面的最终状态
                    _updateUiForPage(index.toDouble());

                    // 2. 启动 PageView 的内容滚动动画
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
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
                        height: 105.w,
                        iconMargin: EdgeInsets.only(bottom: 8.w),
                        icon: SizedBox(
                          height: 50.w,
                          width: 50.w,
                          child: Center(
                              child: Icon(icon, size: tabInfo.iconSize.w)),
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
              physics: systemCubit.state.parentDragState != ParentDragState.idle
                  ? const NeverScrollableScrollPhysics()
                  : (systemCubit.state.showMiniProgramDrawer
                      ? const NeverScrollableScrollPhysics()
                      : const ClampingScrollPhysics()),
              children: const <Widget>[
                LJNArts(),
                LJNDiscovery(),
                LJNPublisher(),
                LJNRecentChatsList(),
                LJNUser(),
              ],
            ),
          ),
          Visibility(
            visible: !_hiddenAppbar &&
                ((systemCubit.state.homescrollpixels +
                        systemCubit.state.statusHeight) <=
                    (MediaQuery.of(context).size.height * 0.25)),
            child: Positioned(
              top: systemCubit.state.homescrollpixels,
              left: _appbarLeft,
              child: Container(
                width: 750.0.w,
                height: systemCubit.state.statusHeight + 90.w,
                color: systemCubit.state.homescrollpixels == 0
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
                                  color:
                                      theme.appBarTheme.titleTextStyle!.color,
                                  const IconData(0xe608,
                                      fontFamily: 'Iconfont'),
                                  size: 42.w,
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              if (systemCubit.state.homescrollpixels == 0) {
                                setState(() => _showPopup = !_showPopup);
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: 90.w,
                              padding: EdgeInsets.only(right: 33.w),
                              alignment: Alignment.center,
                              child: Icon(
                                color: theme.appBarTheme.titleTextStyle!.color,
                                const IconData(0xe726, fontFamily: 'Iconfont'),
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
                                    color:
                                        theme.appBarTheme.titleTextStyle!.color,
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
              top: systemCubit.state.statusHeight + 80.w,
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
          Positioned(
            bottom: 106.w,
            left: 0,
            right: 0,
            child: Visibility(
              visible: systemCubit.state.showVideoProgress &&
                  _tabController.index == 0,
              child: LinearProgressIndicator(
                value: systemCubit.state.videoProgress,
                minHeight: 1.5,
                backgroundColor: Colors.grey.withAlpha(77),
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.grey.withAlpha(179)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
