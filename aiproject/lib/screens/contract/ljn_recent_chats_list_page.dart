import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/api_manager/api.dart';
import 'package:vigaviga/widgets/ljn_cloud_animation.dart';
import 'package:vigaviga/screens/contract/widgets/ljn_chat_miniprogram.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_chatlist_item.dart';
import 'package:vigaviga/widgets/ljn_custom_physics.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LJNRecentChatsListPage extends StatefulWidget {
  const LJNRecentChatsListPage({super.key});

  @override
  State<LJNRecentChatsListPage> createState() => _LJNRecentChatsListPage();
}

class _LJNRecentChatsListPage extends State<LJNRecentChatsListPage>
    with TickerProviderStateMixin {
  final _miniprogramScrollController = ScrollController();

  late final List<ChatListItem> chatItems;
  AnimationController? _animationController;

  ScrollPhysics _physics = const MyBouncingScrollPhysics();
  late final AnimationController _lottieController;
  late final AnimationController _bglottieController;
  double initialY = 0.0;
  double deltaY = 0.0;
  double downHomescrollpixels = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateMainpage4isload(true);
    });

    _lottieController = AnimationController(vsync: this);
    _bglottieController = AnimationController(vsync: this);

    _miniprogramScrollController.addListener(scrollListener);

    chatItems = getChatItems(context);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _bglottieController.dispose();
    super.dispose();
  }

  void scrollListener() {
    // 下拉的时候
    if (_miniprogramScrollController.position.pixels <= 0) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(
            _miniprogramScrollController.position.pixels.abs(),
          );
    } else {
      // 上拉
      double newValue = context.read<LJNSystemCubit>().state.homescrollpixels +
          _miniprogramScrollController.position.pixels;
      if (newValue < 0) {
        context.read<LJNSystemCubit>().updateHomescrollpixels(newValue);
      } else {
        context.read<LJNSystemCubit>().updateHomescrollpixels(0.0);
      }
    }
  }

  // 恢复
  void reverse() {
    // 使开始位置变成下拉的位置
    _miniprogramScrollController.jumpTo(0);
    _animationController!.value =
        context.read<LJNSystemCubit>().state.homescrollpixels;
    _physics = const NeverScrollableScrollPhysics();

    _miniprogramScrollController.removeListener(scrollListener);
    _animationController!.reverse().then((_) {
      _miniprogramScrollController.jumpTo(0);
      _physics = const MyBouncingScrollPhysics();
      _miniprogramScrollController.addListener(scrollListener);

      context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
    });
  }

  double initialCoverLayerHeight = 42.w;

  Size screenSize = Size(0, 0);
  double statusHeight = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      if (systemState.screenSize == Size.zero ||
          systemState.statusHeight == 0) {
        screenSize = MediaQuery.of(context).size;
        statusHeight = MediaQuery.of(context).padding.top;
      } else {
        screenSize = systemState.screenSize;
        statusHeight = systemState.statusHeight;
      }

      if (_animationController == null) {
        // 这里描述的是appbar的位置, listview依据这个位置进行调整
        _animationController = AnimationController(
          vsync: this,
          lowerBound: 0,
          // 这里到底部是新appbar的高度 + 原本的statusHeight, 因为一个控制器, 既给新的用, 也给旧的用
          upperBound: screenSize.height -
              (statusHeight +
                  systemState.appbarHeight +
                  initialCoverLayerHeight),
          duration: const Duration(milliseconds: 350), // 动画持续时间
        );

        _animationController!.addListener(() {
          context
              .read<LJNSystemCubit>()
              .updateHomescrollpixels(_animationController!.value);
        });
      }

      return systemState.mainpage4isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
  }

  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    double newAppbarHeight = systemState.appbarHeight + initialCoverLayerHeight;

    // 新appbar透明度
    double percent25Position = screenSize.height * 0.25;
    double coverOpacity =
        ((systemState.homescrollpixels + statusHeight) - percent25Position) /
            (screenSize.height - newAppbarHeight - percent25Position);
    if (coverOpacity < 0) {
      coverOpacity = 0;
    } else if (coverOpacity > 1) {
      coverOpacity = 1;
    }

    double percent75TargetPosition = screenSize.height * 0.75;
    double newAppbarOpacity = ((systemState.homescrollpixels + statusHeight) -
            percent75TargetPosition) /
        (screenSize.height - newAppbarHeight - percent75TargetPosition);
    if (newAppbarOpacity < 0) {
      newAppbarOpacity = 0;
    } else if (newAppbarOpacity > 1) {
      newAppbarOpacity = 1;
    }

    // 顶部动画控制器
    _lottieController.value =
        (systemState.homescrollpixels + statusHeight) / 600.w;
    if (_lottieController.value < 0) {
      _lottieController.value = 0;
    } else if (_lottieController.value > 1) {
      _lottieController.value = 1;
    }

    // 顶部动画背景
    double topLottieOpacity =
        (systemState.homescrollpixels + statusHeight - 400.w) /
            (screenSize.height - newAppbarHeight - 400.w);
    if (topLottieOpacity < 0) {
      topLottieOpacity = 0;
    } else if (topLottieOpacity > 1) {
      topLottieOpacity = 1;
    }

    logger.info(
        "topLottieOpacity: $topLottieOpacity   systemState.homescrollpixels: ${systemState.homescrollpixels}");

    return Stack(
      children: [
        // 小程序背景
        Visibility(
          visible: systemState.homescrollpixels > 0,
          child: LJNCloudAnimation(),
        ),

        // 小程序列表, 需要现在在appbar下面
        Visibility(
          visible: systemState.homescrollpixels > 0,
          child: Positioned(
            top: 0,
            left: 0,
            // 需要增高一点, 因为Transform.scale缩小后, SingleChildScrollView的高度不能自动适配.
            height:
                systemState.homescrollpixels + (90.w + statusHeight + 200.w),
            width: screenSize.width,
            child: LJNChatMiniProgram(reverse: reverse),
          ),
        ),

        // // 列表背景
        // Visibility(
        //   visible: systemState.homescrollpixels > 0,
        //   child: Positioned(
        //     top: systemState.appbarHeight +
        //         statusHeight +
        //         systemState.homescrollpixels,
        //     left: 0,
        //     // 需要增高一点, 因为Transform.scale缩小后, SingleChildScrollView的高度不能自动适配.
        //     height:
        //         screenSize.height - (systemState.appbarHeight + statusHeight),
        //     width: screenSize.width,
        //     child: Container(
        //       color: Colors.red,
        //     ),
        //   ),
        // ),

        // 列表
        Positioned(
          // 不能使用systemState.homescrollpixels, 需要用_animationController!.value
          top: systemState.appbarHeight +
              statusHeight +
              _animationController!.value,
          left: 0,
          width: screenSize.width,
          height: screenSize.height - (systemState.appbarHeight + statusHeight),
          child: Listener(
            onPointerUp: (event) {
              logger.info(
                  "释放那一刻 ${_miniprogramScrollController.position.pixels}");
              if (_miniprogramScrollController.position.pixels < -100) {
                // _forwarding = true;
                logger.info(
                    "this is systemState.homescrollpixels: ${systemState.homescrollpixels}");

                // ???
                _animationController!.value = systemState.homescrollpixels;
                _miniprogramScrollController.jumpTo(0);
                _physics = const NeverScrollableScrollPhysics();

                context
                    .read<LJNSystemCubit>()
                    .updateShowMiniProgramDrawer(true);

                _miniprogramScrollController.removeListener(scrollListener);

                _animationController!.forward().then((_) {
                  _miniprogramScrollController.jumpTo(0);
                  _physics = const MyBouncingScrollPhysics();
                  _miniprogramScrollController.addListener(scrollListener);
                });
              }
            },
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior().copyWith(
                scrollbars: false,
                physics: _physics,
              ),
              child: ListView.builder(
                primary: false,
                padding: EdgeInsets.only(bottom: 106.w),
                // padding: EdgeInsets.all(0.w),
                itemCount: chatItems.length,
                shrinkWrap: true,
                controller: _miniprogramScrollController,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return chatItems[index];
                },
              ),
            ),
          ),
        ),

        // 三个点点动画
        Visibility(
          visible: !_lottieController.isCompleted,
          child: Opacity(
            opacity:
                systemState.homescrollpixels > 0 ? 1 - topLottieOpacity : 0,
            child: Container(
              color: theme.colorScheme.surfaceContainer,
              width: screenSize.width,
              height: systemState.homescrollpixels +
                  (systemState.appbarHeight + statusHeight),
              child: Lottie.asset(
                assetPath('lotties/homeminiprogramdarwing.json'),
                width: screenSize.width,
                height: systemState.homescrollpixels +
                    statusHeight +
                    systemState.appbarHeight,
                fit: BoxFit.contain,
                renderCache: RenderCache.drawingCommands,
                controller: _lottieController,
                onLoaded: (composition) {
                  // _lottieController
                  //   ..duration = const Duration(milliseconds: 600)
                  //   ..forward();
                },
              ),
            ),
          ),
        ),

        // 下拉时候的新appbar
        Visibility(
          visible:
              (systemState.homescrollpixels + statusHeight) > percent25Position,
          child: Positioned(
            height: systemState.appbarHeight +
                (screenSize.height -
                    (systemState.homescrollpixels +
                        statusHeight +
                        systemState.appbarHeight)),
            width: 750.w,
            top: systemState.homescrollpixels + statusHeight,
            child: Listener(
              onPointerDown: (event) {
                // 记录手指按下时的 Y 轴位置
                initialY = event.position.dy;
                downHomescrollpixels = systemState.homescrollpixels;
              },
              onPointerMove: (event) {
                logger.info('Y轴移动距离: $deltaY');

                // 不允许下拉, 只允许上拉
                if (initialY < event.position.dy) {
                  return;
                }

                // 计算手指在Y轴上移动的距离
                deltaY = event.position.dy - initialY;

                double newHomescrollpixels =
                    downHomescrollpixels - deltaY.abs();

                context
                    .read<LJNSystemCubit>()
                    .updateHomescrollpixels(newHomescrollpixels);

                _animationController!.value = newHomescrollpixels;
              },
              onPointerUp: (event) {
                // 恢复
                reverse();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App标题栏（此App标题栏仅用作显示，无实际用途）
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.w),
                      topRight: Radius.circular(12.w),
                    ),
                    child: AppBar(
                      primary: false,
                      title: Text(l10n.tabbar_label_chat),
                      centerTitle: true,
                      titleTextStyle: theme.appBarTheme.titleTextStyle,
                      toolbarHeight: theme.appBarTheme.toolbarHeight,
                      elevation: theme.appBarTheme.elevation,
                      scrolledUnderElevation:
                          theme.appBarTheme.scrolledUnderElevation,
                      backgroundColor:
                          theme.appBarTheme.backgroundColor!.withAlpha(
                        (min(newAppbarOpacity + 0.8, 1) * 255).toInt(),
                      ),
                      foregroundColor:
                          theme.appBarTheme.foregroundColor!.withAlpha(
                        (min(newAppbarOpacity + 0.8, 1) * 255).toInt(),
                      ),
                      actions: [
                        // 联系列表按钮
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
                              color: theme.appBarTheme.titleTextStyle!.color,
                              const IconData(
                                0xe608,
                                fontFamily: 'Iconfont',
                              ),
                              size: 42.w,
                            ),
                          ),
                        ),

                        // 添加联系人按钮
                        Container(
                          color: Colors.transparent,
                          height: 90.w,
                          padding: EdgeInsets.only(right: 33.w),
                          alignment: Alignment.center,
                          child: Icon(
                            color: theme.appBarTheme.titleTextStyle!.color,
                            const IconData(
                              0xe726,
                              fontFamily: 'Iconfont',
                            ),
                            size: 42.w,
                          ),
                        ),

                        // 占位
                        SizedBox(
                          width: 7.w,
                        )
                      ],
                      leading: Container(
                        color: Colors.transparent,
                        height: 90.w,
                        padding: EdgeInsets.only(left: 33.w),
                        child: Icon(
                          color: theme.appBarTheme.titleTextStyle!.color,
                          const IconData(
                            0xe612,
                            fontFamily: 'Iconfont',
                          ),
                          size: 40.w,
                        ),
                      ),
                    ),
                  ),

                  // AppBar底部遮挡层
                  Opacity(
                    // opacity: 0.5,
                    opacity: coverOpacity,
                    child: Container(
                      height: screenSize.height -
                          (systemState.homescrollpixels +
                              statusHeight +
                              systemState.appbarHeight),
                      child: null,
                      color: theme.listTileTheme.tileColor!,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
