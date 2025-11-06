// 文件路径: VigaCustomTabbar.dart (此版本正确，无需修改)

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/arts/viga_arts_page.dart';
import 'package:vigaviga/screens/contract/viga_recent_chats_list_page.dart';
import 'package:vigaviga/screens/discovery/viga_discovery_page.dart';
import 'package:vigaviga/screens/publisher/viga_publisher_page.dart';
import 'package:vigaviga/screens/user/viga_user_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

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

class VigaCustomTabbar extends StatefulWidget {
  const VigaCustomTabbar({super.key});
  @override
  State<VigaCustomTabbar> createState() => _VigaCustomTabbarState();
}

class _VigaCustomTabbarState extends State<VigaCustomTabbar>
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
        iconSize: 75.0.w),
    _TabInfo(
        icon: const IconData(0xe61c, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe638, fontFamily: "Iconfont"),
        iconSize: 71.0.w),
    _TabInfo(
        icon: const IconData(0xe67c, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe642, fontFamily: "Iconfont"),
        iconSize: 77.0.w),
    _TabInfo(
        icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
        iconSize: 75.0.w),
    _TabInfo(
        icon: const IconData(0xe63f, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe62b, fontFamily: "Iconfont"),
        iconSize: 81.0.w),
  ];

  @override
  void initState() {
    super.initState();
    var systemCubit = context.read<VigaSystemCubit>();
    systemCubit.updateBottomNavigationBarHeight(95.w);
    systemCubit.updateAppbarHeight(90.w);
    _tabController = TabController(
        length: _tabs.length,
        vsync: this,
        initialIndex: systemCubit.state.mainTabIndex);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _onTabChanged(isInitialCall: true);
        if (kIsWeb) {
          systemCubit.updateStatusHeight(0);
        } else {
          systemCubit.updateStatusHeight(MediaQuery.of(context).padding.top);
          systemCubit.updateBottomNavigationBarHeight(
              95.w + MediaQuery.of(context).padding.bottom);
        }
      }
    });
  }

  void _onTabChanged({bool isInitialCall = false}) {
    if (!isInitialCall && _tabController.indexIsChanging) {
      setState(() {});
    }
    if (!_tabController.indexIsChanging || isInitialCall) {
      final index = _tabController.index;

      if (!isInitialCall) {
        context.read<VigaSystemCubit>().updateMainTabIndex(index);
        context.read<VigaSystemCubit>().updateVideoProgress(show: index == 0);
      }
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
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Stack(
          children: [
            Theme(
              data: _tabController.index == 0
                  ? theme.copyWith(
                      bottomAppBarTheme:
                          theme.bottomAppBarTheme.copyWith(color: Colors.black),
                      tabBarTheme: theme.tabBarTheme.copyWith(
                        unselectedLabelColor: Colors.white.withAlpha(128),
                        labelColor: Colors.white,
                      ),
                    )
                  : theme,
              child: Builder(
                builder: (BuildContext newContext) {
                  return Scaffold(
                    primary: false,
                    backgroundColor:
                        Theme.of(newContext).scaffoldBackgroundColor,
                    bottomNavigationBar: Visibility(
                      visible: systemState.showHomeTabbar,
                      child: Container(
                        height: systemState.bottomNavigationBarHeight + 1.0.w,
                        decoration: BoxDecoration(
                          color: Theme.of(newContext).bottomAppBarTheme.color,
                          border: Border(
                            top: BorderSide(
                                color: Theme.of(newContext).dividerColor,
                                width: 1.0.w),
                          ),
                        ),
                        child: TabBar(
                          padding: EdgeInsets.only(bottom: 5.w),
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          labelColor:
                              Theme.of(newContext).tabBarTheme.labelColor,
                          labelStyle:
                              Theme.of(newContext).tabBarTheme.labelStyle,
                          unselectedLabelColor: Theme.of(newContext)
                              .tabBarTheme
                              .unselectedLabelColor,
                          indicator: const BoxDecoration(),
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
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
                                    child: Icon(icon, size: tabInfo.iconSize.w),
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
                        VigaArtsPage(),
                        VigaDiscoveryPage(),
                        VigaPublisherPage(),
                        VigaRecentChatsListPage(),
                        VigaUserPage()
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: systemState.bottomNavigationBarHeight +
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
            )
          ],
        );
      },
    );
  }
}
