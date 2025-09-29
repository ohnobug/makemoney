// ./lib/widgets/ljn_custom_tabbar.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher.dart';
import 'package:vigaviga/screens/shortvideos/ljn_arts.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';
import 'package:vigaviga/screens/discovery/ljn_discovery.dart';
import 'package:vigaviga/screens/contract/ljn_recent_chats_list.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/screens/user/ljn_user.dart';
import 'package:vigaviga/widgets/ljn_popup_menu.dart';

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

  int _tabbarIndex = 0;
  int _appbarNameIndex = 0;
  double _appbarLeft = 0;
  bool _hiddenAppbar = true;
  bool _showPopup = false;

  Color? _tabBarBackgroundColor;
  Color? _selectedItemColor;
  Color? _unselectedItemColor;
  Color? _borderColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();

    _pageController.addListener(_handlePageScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LJNSystemCubit>().updateVideoProgress(show: true);
        context.read<LJNSystemCubit>().updateMainTabIndex(_tabController.index);
      }
    });
  }

  void _handlePageScroll() {
    if (_tabController.indexIsChanging) return;
    if (!_pageController.hasClients) return;

    final double page = _pageController.page!;
    final int newIndex = page.round();

    if (_tabController.index != newIndex) {
      setState(() {
        _tabController.index = newIndex;
      });
    }

    _tabController.offset = page - newIndex;

    // 延迟到下一帧更新UI，避免 build 期间调用 setState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateUIColors(page);
        _handleAppBarAnimation(page);
      }
    });

    if (page == newIndex.toDouble()) {
      if (_tabbarIndex != newIndex) {
        setState(() {
          _tabbarIndex = newIndex;
          _appbarNameIndex = newIndex;
        });
        context.read<LJNSystemCubit>().updateMainTabIndex(newIndex);
        context.read<LJNSystemCubit>().updateVideoProgress(show: newIndex == 0);
      }
    }
  }

  void _updateUIColors(double pageValue) {
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

    Color newTabBarBackgroundColor;
    Color newSelectedItemColor;
    Color newUnselectedItemColor;
    Color newBorderColor;

    if (pageValue >= 0 && pageValue <= 1) {
      newTabBarBackgroundColor = Color.lerp(
          videoTabBackgroundColor, otherTabBackgroundColor, pageValue)!;
      newSelectedItemColor = Color.lerp(
          videoTabForegroundColor, otherTabForegroundColor, pageValue)!;
      newUnselectedItemColor = Color.lerp(
          videoTabUnselectedColor, otherTabUnselectedColor, pageValue)!;
      newBorderColor =
          Color.lerp(videoTabBorderColor, otherTabBorderColor, pageValue)!;
    } else {
      newTabBarBackgroundColor = otherTabBackgroundColor;
      newSelectedItemColor = otherTabForegroundColor;
      newUnselectedItemColor = otherTabUnselectedColor;
      newBorderColor = otherTabBorderColor;
    }

    if (newTabBarBackgroundColor != _tabBarBackgroundColor ||
        newSelectedItemColor != _selectedItemColor ||
        newUnselectedItemColor != _unselectedItemColor ||
        newBorderColor != _borderColor) {
      setState(() {
        _tabBarBackgroundColor = newTabBarBackgroundColor;
        _selectedItemColor = newSelectedItemColor;
        _unselectedItemColor = newUnselectedItemColor;
        _borderColor = newBorderColor;
      });
    }
  }

  void _handleAppBarAnimation(double animationValue) {
    // 页面在 0 和 1 之间滑动时
    if (animationValue >= 0 && animationValue < 1) {
      setState(() {
        _appbarLeft = (1 - animationValue) * 750.w;
        // 当 value 接近 0 时，我们希望 AppBar 隐藏
        // 当 value 接近 1 时，我们希望 AppBar 完全显示
        // 所以 _hiddenAppbar 的状态应该在滑动过程中改变
        _hiddenAppbar = animationValue < 0.5; // 例如，可以简单以 0.5 为界
        _appbarNameIndex = 1;
      });
    }
    // 页面在 3 和 4 之间滑动时
    else if (animationValue > 3 && animationValue <= 4) {
      setState(() {
        _appbarLeft = (animationValue.floor() - animationValue) * 750.w;
        _hiddenAppbar = animationValue > 3.5; // 同样以 3.5 为界
        _appbarNameIndex = 3;
      });
    }
    // 页面完全停在 0 或 4
    else if (animationValue == 0 || animationValue == 4) {
      setState(() => _hiddenAppbar = true);
    }
    // 其他页面（1, 2, 3）
    else {
      setState(() {
        _appbarLeft = 0;
        _hiddenAppbar = false;
      });
    }
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

    _tabBarBackgroundColor ??= Colors.black.withAlpha(64);
    _selectedItemColor ??= Colors.white;
    _unselectedItemColor ??= Colors.white.withAlpha(153);
    _borderColor ??= Colors.white.withAlpha(38);

    return BlocListener<LJNSystemCubit, SystemState>(
      listenWhen: (prev, current) =>
          prev.parentDragState != current.parentDragState ||
          (current.parentDragState == ParentDragState.dragging &&
              prev.parentDragOffset != current.parentDragOffset),
      listener: (context, state) {
        if (state.parentDragState == ParentDragState.dragging) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              final currentPagePixels = (_tabController.index * screenWidth);
              _pageController
                  .jumpTo(currentPagePixels - state.parentDragOffset);
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
            backgroundColor: _tabbarIndex == 0
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
                      color: _borderColor!,
                      width: 1.0.w,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    if (_tabbarIndex != index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
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
              physics: systemCubit.state.showMiniProgramDrawer
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
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
                          if (_tabbarIndex == 3)
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
                        leading: _tabbarIndex == 3
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
              visible: systemCubit.state.showVideoProgress && _tabbarIndex == 0,
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
