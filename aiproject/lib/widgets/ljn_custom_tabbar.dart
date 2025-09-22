import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/publisher/ljn_publisher.dart';
import 'package:vigaviga/screens/shortvideos/ljn_arts.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
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
    // 短视频
    _TabInfo(
        icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
        iconSize: 90.0.w),
    // 发现
    _TabInfo(
        icon: const IconData(0xe61c, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe638, fontFamily: "Iconfont"),
        iconSize: 86.0.w),
    // 发布
    _TabInfo(
        icon: const IconData(0xe67c, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe642, fontFamily: "Iconfont"),
        iconSize: 96.0.w),
    // 聊天
    _TabInfo(
        icon: const IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe676, fontFamily: "Iconfont"),
        iconSize: 90.0.w),
    // 我的
    _TabInfo(
        icon: const IconData(0xe63f, fontFamily: "Iconfont"),
        selectedIcon: const IconData(0xe62b, fontFamily: "Iconfont"),
        iconSize: 96.0.w),
  ];

  int _tabbarIndex = 0;
  int _appbarNameIndex = 0;
  double _appbarLeft = 0;
  bool _hiddenAppbar = true;
  bool _setStatusHeight = false;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      animationDuration: Duration.zero,
    );

    _tabController.addListener(() {
      final newIndex = _tabController.index;
      if (_tabbarIndex != newIndex) {
        setState(() {
          _tabbarIndex = newIndex;
          _appbarNameIndex = newIndex;
        });

        // 当切换到非视频 Tab 时，主动隐藏进度条
        if (newIndex != 0) {
          context.read<LJNSystemCubit>().updateVideoProgress(show: false);
        } else {
          // 当切换回视频 Tab 时，让 LJNArts 自己决定是否显示
          // 为了确保切换回来时能立即看到进度条，可以主动调用 show: true
          context.read<LJNSystemCubit>().updateVideoProgress(show: true);
        }
      }
    });

    _tabController.animation?.addListener(_handleAnimation);
  }

  void _handleAnimation() {
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
    _tabController.animation?.removeListener(_handleAnimation);
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

    return BlocBuilder<LJNSystemCubit, SystemState>(
      // 优化：仅在关心的状态变化时才重建此 Widget
      buildWhen: (previous, current) {
        return previous.showMiniProgramDrawer !=
                current.showMiniProgramDrawer ||
            previous.homescrollpixels != current.homescrollpixels ||
            previous.statusHeight != current.statusHeight ||
            previous.showVideoProgress != current.showVideoProgress ||
            previous.videoProgress != current.videoProgress;
      },
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
              bottomNavigationBar: Visibility(
                visible: !systemState.showMiniProgramDrawer,
                child: Container(
                  height: 106.w,
                  decoration: BoxDecoration(
                    color: theme.appBarTheme.backgroundColor,
                    border: Border(
                      top: BorderSide(
                        color: theme.dividerColor,
                        width: 1.0.w,
                      ),
                    ),
                  ),
                  child: TabBar(
                    dividerColor: theme.appBarTheme.backgroundColor,
                    labelColor: theme.tabBarTheme.labelColor,
                    labelStyle: theme.tabBarTheme.labelStyle,
                    unselectedLabelColor:
                        theme.tabBarTheme.unselectedLabelColor,
                    indicator: const BoxDecoration(),
                    controller: _tabController,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
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
              body: TabBarView(
                physics: systemState.showMiniProgramDrawer
                    ? const NeverScrollableScrollPhysics()
                    : CustomTabBarViewScrollPhysics(
                        parent: const ClampingScrollPhysics()),
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
                      : AppColors.transparent,
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
                                onTap: () =>
                                    Navigator.pushNamed(context, '/contact'),
                                child: Container(
                                  color: AppColors.transparent,
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
                                if (systemState.homescrollpixels == 0) {
                                  setState(() => _showPopup = !_showPopup);
                                }
                              },
                              child: Container(
                                color: AppColors.transparent,
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
                          leading: _tabbarIndex == 3
                              ? GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    color: AppColors.transparent,
                                    height: 90.w,
                                    padding: EdgeInsets.only(left: 33.w),
                                    child: Icon(
                                      color: theme
                                          .appBarTheme.titleTextStyle!.color,
                                      const IconData(0xe612,
                                          fontFamily: 'Iconfont'),
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
                  color: AppColors.transparent,
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

            // [最终代码] 添加全局视频进度条
            Positioned(
              bottom: 105.w, // TabBar 的高度
              left: 0,
              right: 0,
              child: Visibility(
                // 只有当 Cubit 说要显示，并且当前 Tab 是视频 Tab (index 0) 时才可见
                visible: systemState.showVideoProgress && _tabbarIndex == 0,
                child: LinearProgressIndicator(
                  value: systemState.videoProgress,
                  minHeight: 3.w, // 细
                  backgroundColor: Colors.black.withAlpha(200), // 灰色背景
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.withAlpha(100), // 灰色进度
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
