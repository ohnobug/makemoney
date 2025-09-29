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

// 关键改动 1: _TabInfo 不再需要 title 属性。它只存储不依赖 context 的静态信息。
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

  // 关键改动 2: _tabs 列表现在是 final，并且只包含静态的图标信息。
  final List<_TabInfo> _tabs = [
    _TabInfo(
        icon: IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: IconData(0xe676, fontFamily: 'Iconfont'),
        iconSize: 90.0.w), // 短视频
    _TabInfo(
        icon: IconData(0xe61c, fontFamily: "Iconfont"),
        selectedIcon: IconData(0xe638, fontFamily: 'Iconfont'),
        iconSize: 86.0.w), // 发现
    _TabInfo(
        icon: IconData(0xe67c, fontFamily: "Iconfont"),
        selectedIcon: IconData(0xe642, fontFamily: 'Iconfont'),
        iconSize: 96.0.w), // 发布
    _TabInfo(
        icon: IconData(0xe7b3, fontFamily: "Iconfont"),
        selectedIcon: IconData(0xe676, fontFamily: 'Iconfont'),
        iconSize: 90.0.w), // 聊天
    _TabInfo(
        icon: IconData(0xe63f, fontFamily: "Iconfont"),
        selectedIcon: IconData(0xe62b, fontFamily: 'Iconfont'),
        iconSize: 96.0.w), // 我的
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
    // 关键改动 3: TabController 可以在 initState 中安全地初始化，因为它不再依赖 context。
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      animationDuration: Duration.zero,
    );

    _tabController.addListener(() {
      setState(() {
        _tabbarIndex = _tabController.index;
        _appbarNameIndex = _tabbarIndex;
      });
    });

    _tabController.animation?.addListener(_handleAnimation);
  }

  void _handleAnimation() {
    logger.info("bbbbbbbbbbbbbbbbb：${_tabController.animation!.value}");

    if (_tabController.animation!.value < 1) {
      // 首页的tabbar隐藏
      setState(() {
        _appbarLeft = (1 - _tabController.animation!.value) * 750.w;
        _hiddenAppbar = false;
        _appbarNameIndex = 1;
      });
    } else if (_tabController.animation!.value > 3 &&
        _tabController.animation!.value < 4) {
      // 第四个切换到第五个的情况：个人中心的tabbar隐藏
      setState(() {
        _appbarLeft = (_tabController.animation!.value.floor() -
                _tabController.animation!.value) *
            750.w;
        _hiddenAppbar = false;
        _appbarNameIndex = 3;
      });
    } else if (_tabController.animation!.value == 0 ||
        _tabController.animation!.value == 4) {
      // 第一个 和 第五个 tabbar 隐藏 appbar
      setState(() {
        _hiddenAppbar = true;
      });
    } else {
      // 正常情况
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

  // 辅助方法，用于在 build 方法中获取动态标题列表
  List<String> _getTabTitles(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).tabBarTheme.dividerColor!,
                        width: 1.5.w,
                      ),
                    ),
                  ),
                  child: TabBar(
                    dividerColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                    labelColor: Theme.of(context).tabBarTheme.labelColor,
                    labelStyle: Theme.of(context).tabBarTheme.labelStyle,
                    unselectedLabelColor:
                        Theme.of(context).tabBarTheme.unselectedLabelColor,
                    indicator: null,
                    controller: _tabController,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    tabs: List.generate(
                      _tabs.length,
                      (index) {
                        final tabInfo = _tabs[index];
                        return Tab(
                          height: 105.w,
                          iconMargin: EdgeInsets.only(bottom: 8.w),
                          icon: SizedBox(
                            height: 50.w,
                            width: 50.w,
                            child: Center(
                              child: Icon(
                                index == _tabbarIndex
                                    ? tabInfo.selectedIcon
                                    : tabInfo.icon,
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
                  LJNArts(),
                  LJNDiscovery(),
                  LJNPublisher(),
                  LJNRecentChatsList(),
                  LJNUser(),
                ],
              ),
            ),

            // 顶部Appbar
            // 关于visible说明：如果在聊天界面下拉则隐藏顶部Appbar、如果在Tab1和Tab5（个人中心）则隐藏
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
                      ? Theme.of(context).appBarTheme.backgroundColor
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
                            // 联系列表按钮
                            if (_tabbarIndex == 3)
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/contact',
                                  );
                                },
                                child: Container(
                                  color: AppColors.transparent,
                                  height: 90.w,
                                  padding: EdgeInsets.only(right: 33.w),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .titleTextStyle!
                                        .color,
                                    const IconData(
                                      0xe608,
                                      fontFamily: 'Iconfont',
                                    ),
                                    size: 42.w,
                                  ),
                                ),
                              ),

                            // 添加联系人按钮
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
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle!
                                      .color,
                                  const IconData(
                                    0xe726,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 42.w,
                                ),
                              ),
                            ),

                            // 占位
                            SizedBox(
                              width: 7.w,
                            )
                          ],
                          leading: _tabbarIndex == 3
                              ?
                              // 搜索按钮
                              GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    color: AppColors.transparent,
                                    height: 90.w,
                                    padding: EdgeInsets.only(left: 33.w),
                                    child: Icon(
                                      color: Theme.of(context)
                                          .appBarTheme
                                          .titleTextStyle!
                                          .color,
                                      const IconData(
                                        0xe612,
                                        fontFamily: 'Iconfont',
                                      ),
                                      size: 40.w,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 弹框
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
                  child: LJNPopupMenu(
                    showPopup: _showPopup,
                    setShowPopup: (bool value) {
                      _showPopup = !_showPopup;
                    },
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
