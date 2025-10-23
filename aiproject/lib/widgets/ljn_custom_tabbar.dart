import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/arts/ljn_arts_page.dart';
import 'package:vigaviga/screens/contract/ljn_recent_chats_list_page.dart';
import 'package:vigaviga/screens/discovery/ljn_discovery_page.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher_page.dart';
import 'package:vigaviga/screens/user/ljn_user_page.dart';
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

class LJNCustomTabbar extends StatefulWidget {
  const LJNCustomTabbar({super.key});

  @override
  State<LJNCustomTabbar> createState() => _LJNCustomTabbarState();
}

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

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    var systemCubit = context.read<LJNSystemCubit>();
    systemCubit.updateTabbarHeight(95.w);
    systemCubit.updateAppbarHeight(90.w);

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: systemCubit.state.mainTabIndex,
    );
    _tabController.addListener(_onTabChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (kIsWeb) {
          systemCubit.updateStatusHeight(0);
        } else {
          systemCubit.updateStatusHeight(MediaQuery.of(context).padding.top);
          systemCubit
              .updateTabbarHeight(95.w + MediaQuery.of(context).padding.bottom);
        }
      }
    });
  }

  void _onTabChanged() {
    // setState is needed to trigger a rebuild so the Theme widget can update
    setState(() {});
    if (_tabController.indexIsChanging == false) {
      final index = _tabController.index;

      if (index == 0 && index == 4) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
      }

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

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Stack(
          children: [
            Theme(
              data: _tabController.index == 0
                  ? theme.copyWith(
                      bottomAppBarTheme: theme.bottomAppBarTheme.copyWith(
                        color: Colors.black,
                      ),
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
                        height: systemState.tabbarHeight + 1.0.w,
                        decoration: BoxDecoration(
                          // 3. 使用 'newContext' 来获取颜色，这样就能正确读到黑色背景
                          color: Theme.of(newContext).bottomAppBarTheme.color,
                          border: Border(
                            top: BorderSide(
                              color: Theme.of(newContext).dividerColor,
                              width: 1.0.w,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            TabBar(
                              controller: _tabController,
                              dividerColor: Colors.transparent,
                              // 4. TabBar 的颜色也必须从 'newContext' 获取，以确保同步更新
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
                          ],
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
                  );
                },
              ),
            ),

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
    );
  }
}
