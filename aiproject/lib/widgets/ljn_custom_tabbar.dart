// ./lib/widgets/ljn_custom_tabbar.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher.dart';
import 'package:vigaviga/screens/shortvideos/ljn_arts.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';
import 'package:vigaviga/widgets/ljn_custom_physics.dart';
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

/// 自定义Tabbar
class LJNCustomTabbar extends StatefulWidget {
  const LJNCustomTabbar({super.key});

  @override
  State<LJNCustomTabbar> createState() => _LJNCustomTabbarState();
}

class _LJNCustomTabbarState extends State<LJNCustomTabbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<_TabInfo> _tabs = [
    _TabInfo(
      icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
      selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
      iconSize: 90.0.w,
    ),
    _TabInfo(
      icon: const IconData(
        0xe61c,
        fontFamily: "Iconfont",
      ),
      selectedIcon: const IconData(
        0xe638,
        fontFamily: "Iconfont",
      ),
      iconSize: 86.0.w,
    ),
    _TabInfo(
      icon: const IconData(
        0xe67c,
        fontFamily: "Iconfont",
      ),
      selectedIcon: const IconData(
        0xe642,
        fontFamily: "Iconfont",
      ),
      iconSize: 96.0.w,
    ),
    _TabInfo(
      icon: const IconData(
        0xe7b3,
        fontFamily: "Iconfont",
      ),
      selectedIcon: const IconData(
        0xe676,
        fontFamily: "Iconfont",
      ),
      iconSize: 90.0.w,
    ),
    _TabInfo(
      icon: const IconData(
        0xe63f,
        fontFamily: "Iconfont",
      ),
      selectedIcon: const IconData(
        0xe62b,
        fontFamily: "Iconfont",
      ),
      iconSize: 96.0.w,
    ),
  ];

  int _tabbarIndex = 0;
  int _appbarNameIndex = 0;
  double _appbarLeft = 0;
  bool _hiddenAppbar = true;
  bool _setStatusHeight = false;
  bool _showPopup = false;

  // 用于存储动态计算的颜色
  Color? _tabBarBackgroundColor;
  Color? _selectedItemColor;
  Color? _unselectedItemColor;
  Color? _borderColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );

    _tabController.addListener(_handleTabSelection);
    _tabController.animation?.addListener(_handleTabAnimation);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateVideoProgress(show: true);
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;

    if (_tabbarIndex != _tabController.index) {
      setState(() {
        _tabbarIndex = _tabController.index;
        _appbarNameIndex = _tabController.index;
      });

      if (_tabController.index != 0) {
        context.read<LJNSystemCubit>().updateVideoProgress(show: false);
      } else {
        context.read<LJNSystemCubit>().updateVideoProgress(show: true);
      }
    }
  }

  void _handleTabAnimation() {
    final theme = Theme.of(context);
    final animationValue = _tabController.animation!.value;

    // 定义视频页(index=0)的颜色
    final Color videoTabBackgroundColor =
        Colors.black.withAlpha(64); // 约等于 withOpacity(0.25)
    const Color videoTabForegroundColor = Colors.white;
    final Color videoTabUnselectedColor =
        Colors.white.withAlpha(153); // 约等于 withOpacity(0.6)
    final Color videoTabBorderColor =
        Colors.white.withAlpha(38); // 约等于 withOpacity(0.15)

    // 定义其他页的颜色
    final Color otherTabBackgroundColor =
        theme.bottomAppBarTheme.color ?? theme.scaffoldBackgroundColor;
    final Color otherTabForegroundColor =
        theme.tabBarTheme.labelColor ?? theme.colorScheme.primary;
    final Color otherTabUnselectedColor =
        theme.tabBarTheme.unselectedLabelColor ?? Colors.grey;
    final Color otherTabBorderColor = theme.dividerColor;

    if (animationValue >= 0 && animationValue <= 1) {
      setState(() {
        _tabBarBackgroundColor = Color.lerp(
          videoTabBackgroundColor,
          otherTabBackgroundColor,
          animationValue,
        );
        _selectedItemColor = Color.lerp(
          videoTabForegroundColor,
          otherTabForegroundColor,
          animationValue,
        );
        _unselectedItemColor = Color.lerp(
          videoTabUnselectedColor,
          otherTabUnselectedColor,
          animationValue,
        );
        _borderColor = Color.lerp(
          videoTabBorderColor,
          otherTabBorderColor,
          animationValue,
        );
      });
    } else {
      if (_tabBarBackgroundColor != otherTabBackgroundColor) {
        setState(() {
          _tabBarBackgroundColor = otherTabBackgroundColor;
          _selectedItemColor = otherTabForegroundColor;
          _unselectedItemColor = otherTabUnselectedColor;
          _borderColor = otherTabBorderColor;
        });
      }
    }

    _handleAppBarAnimation();
  }

  void _handleAppBarAnimation() {
    if (_tabController.animation == null) return;
    final animationValue = _tabController.animation!.value;

    if (animationValue < 1) {
      setState(() {
        _appbarLeft = (1 - animationValue) * 750.w;
        _hiddenAppbar = false;
        _appbarNameIndex = 1;
      });
    } else if (animationValue > 3 && animationValue < 4) {
      setState(() {
        _appbarLeft = (animationValue.floor() - animationValue) * 750.w;
        _hiddenAppbar = false;
        _appbarNameIndex = 3;
      });
    } else if (animationValue == 0 || animationValue == 4) {
      setState(() {
        _hiddenAppbar = true;
      });
    } else {
      setState(() {
        _appbarLeft = 0;
        _hiddenAppbar = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.animation?.removeListener(_handleTabAnimation);
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
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

    // 初始化颜色状态变量
    _tabBarBackgroundColor ??= Colors.black.withAlpha(64);
    _selectedItemColor ??= Colors.white;
    _unselectedItemColor ??= Colors.white.withAlpha(153);
    _borderColor ??= Colors.white.withAlpha(38);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        if (!_setStatusHeight) {
          final topPadding = kIsWeb ? 0.0 : MediaQuery.of(context).padding.top;
          context.read<LJNSystemCubit>().updateStatusHeight(topPadding);
          _setStatusHeight = true;
        }

        final appBarTitle = tabTitles[_appbarNameIndex];
        final percent75Position = MediaQuery.of(context).size.height * 0.25;

        return Stack(
          children: [
            Scaffold(
              primary: false,
              backgroundColor: _tabbarIndex == 0
                  ? Colors.black
                  : theme.scaffoldBackgroundColor,
              bottomNavigationBar: Visibility(
                visible: !systemState.showMiniProgramDrawer,
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
                    dividerColor: Colors.transparent,
                    labelColor: _selectedItemColor,
                    labelStyle: theme.tabBarTheme.labelStyle,
                    unselectedLabelColor: _unselectedItemColor,
                    indicator: const BoxDecoration(),
                    controller: _tabController,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabs: List.generate(
                      _tabs.length,
                      (index) {
                        final tabInfo = _tabs[index];
                        final icon = index == _tabbarIndex
                            ? tabInfo.selectedIcon
                            : tabInfo.icon;
                        return Tab(
                          height: 105.w,
                          iconMargin: EdgeInsets.only(bottom: 8.w),
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
                physics: systemState.showMiniProgramDrawer
                    ? const NeverScrollableScrollPhysics()
                    : CustomTabBarViewScrollPhysics(
                        parent: const ClampingScrollPhysics(),
                      ),
                controller: _tabController,
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
                  ((systemState.homescrollpixels + systemState.statusHeight) <=
                      percent75Position),
              child: Positioned(
                top: systemState.homescrollpixels,
                left: _appbarLeft,
                child: Container(
                  width: 750.0.w,
                  height: systemState.statusHeight + 90.w,
                  color: systemState.homescrollpixels == 0
                      ? theme.appBarTheme.backgroundColor
                      : Colors.transparent,
                  child: Listener(
                    onPointerUp: (_) => context
                        .read<LJNSystemCubit>()
                        .updateShowMiniProgramDrawer(false),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LJNAppBarInner(
                          context: context,
                          title: appBarTitle,
                          actions: [
                            if (_tabbarIndex == 3)
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/contact',
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 90.w,
                                  padding: EdgeInsets.only(right: 33.w),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    color:
                                        theme.appBarTheme.titleTextStyle!.color,
                                    const IconData(
                                      0xe608,
                                      fontFamily: 'Iconfont',
                                    ),
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
                                  const IconData(
                                    0xe726,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 42.w,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.w,
                            )
                          ],
                          leading: _tabbarIndex == 3
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
                    setShowPopup: (bool value) {
                      setState(() => _showPopup = value);
                    },
                  ),
                ),
              )
            ],

            // 播放进度条
            Positioned(
              bottom: 106.w, // TabBar Height
              left: 0,
              right: 0,
              child: Visibility(
                visible: systemState.showVideoProgress &&
                    _tabController.animation!.value == 0,
                child: LinearProgressIndicator(
                  value: systemState.videoProgress,
                  minHeight: 1.5,
                  backgroundColor: Colors.grey.withAlpha(77), // ~30%
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.withAlpha(179), // ~70%
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
