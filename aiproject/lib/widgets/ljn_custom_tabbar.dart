import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_custom_physics.dart';
import 'package:vigaviga/screens/contract/ljn_contact.dart';
import 'package:vigaviga/screens/discovery/ljn_discovery.dart';
import 'package:vigaviga/screens/home/ljn_home.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/screens/user/ljn_user.dart';

// 关键改动 1: _TabInfo 不再需要 title 属性。它只存储不依赖 context 的静态信息。
class _TabInfo {
  final int icon;
  final int selectedIcon;
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

  // 关键改动 2: _tabs 列表现在是 final，并且只包含静态的图标信息。
  final List<_TabInfo> _tabs = const [
    _TabInfo(icon: 0xe7b3, selectedIcon: 0xe676, iconSize: 45.0),
    _TabInfo(icon: 0xe608, selectedIcon: 0xe609, iconSize: 48.0),
    _TabInfo(icon: 0xe61c, selectedIcon: 0xe638, iconSize: 43.0),
    _TabInfo(icon: 0xe63f, selectedIcon: 0xe62b, iconSize: 48.0),
  ];

  int _currentIndex = 0;
  double _appbarLeft = 0;
  bool _setStatusHeight = false;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    // 关键改动 3: TabController 可以在 initState 中安全地初始化，因为它不再依赖 context。
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      animationDuration: Duration.zero,
    );
    _tabController.addListener(_handleTabSelection);
  }

  // 关键改动 4: didChangeDependencies 不再需要了，可以安全删除。

  void _handleTabSelection() {
    if (_tabController.index != _currentIndex) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }

    if (_tabController.animation!.value >= 2 &&
        _tabController.animation!.value <= 3) {
      setState(() {
        _appbarLeft = 750.w * (2 - _tabController.animation!.value);
      });
    } else if (_appbarLeft != 0) {
      setState(() {
        _appbarLeft = 0;
      });
    }

    if ((_tabController.animation!.value - 1).abs() < 0.2) {
      context.read<LJNSystemCubit>().updateContactazshow(true);
    } else {
      context.read<LJNSystemCubit>().updateContactazshow(false);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  // 辅助方法，用于在 build 方法中获取动态标题列表
  List<String> _getTabTitles(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.tabbar_label_chat,
      l10n.tabbar_label_contacts,
      l10n.tabbar_label_discover,
      l10n.tabbar_label_me,
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 关键改动 5: 在 build 方法中获取最新的标题。
    // 这样每次语言切换导致重建时，标题都会被刷新。
    final tabTitles = _getTabTitles(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        if (!_setStatusHeight) {
          final topPadding = kIsWeb ? 0.0 : MediaQuery.of(context).padding.top;
          context.read<LJNSystemCubit>().updateStatusHeight(topPadding);
          _setStatusHeight = true;
        }

        // 使用从 build 方法中动态获取的标题
        final appBarTitle = Text(tabTitles[_currentIndex]);
        final percent75Position = MediaQuery.of(context).size.height * 0.25;

        return Stack(
          children: [
            Scaffold(
              primary: false,
              bottomNavigationBar: Visibility(
                visible: !systemState.showMiniProgramDrawer,
                child: Container(
                  height: 106.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).tabBarTheme.dividerColor!,
                        width: 1.5.w,
                      ),
                      bottom: BorderSide(width: 0),
                    ),
                  ),
                  child: TabBar(
                    dividerColor: Theme.of(context).tabBarTheme.dividerColor,
                    labelColor: Theme.of(context).tabBarTheme.labelColor,
                    labelStyle: Theme.of(context).tabBarTheme.labelStyle,
                    unselectedLabelColor:
                        Theme.of(context).tabBarTheme.unselectedLabelColor,
                    indicator: const BoxDecoration(),
                    controller: _tabController,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabs: List.generate(
                      _tabs.length,
                      (index) {
                        final tabInfo = _tabs[index];
                        final isSelected = index == _currentIndex;
                        return Tab(
                          height: 105.w,
                          iconMargin: EdgeInsets.only(bottom: 8.w),
                          icon: SizedBox(
                            height: 50.w,
                            width: 50.w,
                            child: Center(
                              child: Icon(
                                IconData(
                                  isSelected
                                      ? tabInfo.selectedIcon
                                      : tabInfo.icon,
                                  fontFamily: 'Iconfont',
                                ),
                                size: tabInfo.iconSize.w,
                              ),
                            ),
                          ),
                          // 关键改动 6: 直接从动态标题列表中获取 text
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
                        // 这里使用了自定义的 LJNCustomTabBarViewScrollPhysics
                        parent: const ClampingScrollPhysics(),
                      ),
                controller: _tabController,
                children: const <Widget>[
                  LJNHome(),
                  LJNContact(),
                  LJNDiscovery(),
                  LJNUser(),
                ],
              ),
            ),
            Visibility(
              visible:
                  (systemState.homescrollpixels + systemState.statusHeight) <=
                      percent75Position,
              child: Positioned(
                top: systemState.homescrollpixels,
                left: _appbarLeft,
                child: Container(
                  width: 750.0.w,
                  height: systemState.statusHeight + 90.w,
                  color: systemState.homescrollpixels == 0
                      ? Theme.of(context).colorScheme.surface
                      : AppColors.transparent,
                  child: Listener(
                    onPointerUp: (_) => context
                        .read<LJNSystemCubit>()
                        .updateShowMiniProgramDrawer(false),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppBar(
                          primary: false,
                          title: appBarTitle,
                          centerTitle: true,
                          titleTextStyle: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.w),
                            color: Theme.of(context).colorScheme.onSurface,
                            fontFamily: "AlibabaPuHuiTi-Medium",
                          ),
                          toolbarHeight: 90.w,
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          foregroundColor:
                              Theme.of(context).colorScheme.surface,
                          actions: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                color: AppColors.transparent,
                                height: 90.w,
                                padding: EdgeInsets.only(right: 33.w),
                                child: Icon(
                                  const IconData(0xe612,
                                      fontFamily: 'Iconfont'),
                                  size: 40.w,
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
                                color: AppColors.transparent,
                                height: 90.w,
                                padding: EdgeInsets.only(right: 40.w),
                                alignment: Alignment.center,
                                child: Icon(
                                  const IconData(
                                    0xe726,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 42.w,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.transparent,
                ),
              ),
              Positioned(
                right: 15.w,
                top: systemState.statusHeight + 80.w,
                child: SizedBox(
                  width: 320.w,
                  child: Column(
                    children: [
                      Container(
                        width: 320.w,
                        padding: EdgeInsets.only(right: 32.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 36.w,
                              height: 20.w,
                              child: const Icon(
                                IconData(0xe62c, fontFamily: 'Iconfont'),
                                color: AppColors.neutralDarkGrey12,
                                size: 42.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0).w,
                          color: AppColors.neutralDarkGrey12,
                        ),
                        width: 320.w,
                        height: 425.w,
                        child: Column(
                          children: [
                            // 发起群聊
                            LJNPopupMenuItem(
                              title:
                                  AppLocalizations.of(context)!.startGroupChat,
                              icon: 0xe676,
                              onTap: () => setState(
                                () => _showPopup = false,
                              ),
                            ),
                            // 添加好友
                            LJNPopupMenuItem(
                              title: AppLocalizations.of(context)!.addFriend,
                              icon: 0xe61f,
                              onTap: () {
                                setState(() => _showPopup = false);
                                Navigator.pushNamed(context, '/add_friends');
                              },
                            ),
                            // 扫一扫
                            LJNPopupMenuItem(
                              title: AppLocalizations.of(context)!.scan,
                              icon: 0xe69a,
                              onTap: () {
                                setState(() => _showPopup = false);
                                Navigator.pushNamed(context, '/qrcode_scanner');
                              },
                            ),
                            // 收付款
                            LJNPopupMenuItem(
                              title: AppLocalizations.of(context)!.payment,
                              icon: 0xe611,
                              onTap: () {
                                setState(() => _showPopup = false);
                                Navigator.pushNamed(
                                  context,
                                  '/collection_and_payment',
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ],
        );
      },
    );
  }
}

class LJNPopupMenuItem extends StatefulWidget {
  final String title;
  final int icon;
  final Function()? onTap;

  const LJNPopupMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  State<LJNPopupMenuItem> createState() => _LJNPopupMenuItemState();
}

class _LJNPopupMenuItemState extends State<LJNPopupMenuItem> {
  Color _bgColor = AppColors.neutralDarkGrey12;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _bgColor = AppColors.neutralDarkGrey15),
      onTapCancel: () => setState(() => _bgColor = AppColors.neutralDarkGrey12),
      onTapUp: (_) {
        setState(() => _bgColor = AppColors.neutralDarkGrey12);
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onTap?.call();
        });
      },
      child: Container(
        height: 105.w,
        color: _bgColor,
        child: Row(
          children: [
            SizedBox(
              height: 105.w,
              width: 105.w,
              child: Center(
                child: Icon(
                  IconData(widget.icon, fontFamily: 'Iconfont'),
                  color: AppColors.neutralWhite,
                  size: 41.w,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.neutralDarkGrey6,
                      width: 1.5.w,
                    ),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(33.w),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: AppColors.neutralWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
