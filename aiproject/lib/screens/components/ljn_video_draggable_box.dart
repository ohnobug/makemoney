import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_popup_cubit.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

import 'package:vigaviga/tools/ljn_cancelable_delay.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:video_player/video_player.dart';

class LJNVideoDraggableBox extends StatefulWidget {
  final VoidCallback? onClose;

  final Size openBoxSize;
  final Offset openPosition;
  final String videoPath;

  const LJNVideoDraggableBox({
    super.key,
    this.onClose,
    required this.openBoxSize,
    required this.openPosition,
    required this.videoPath,
  });

  @override
  State<LJNVideoDraggableBox> createState() => _LJNVideoDraggableBoxState();
}

class _LJNVideoDraggableBoxState extends State<LJNVideoDraggableBox>
    with TickerProviderStateMixin {
  // 位置控制器
  late AnimationController _positionAnimationController;
  late Animation<Offset> _positionAnimation;

  // 背景透明度控制器
  late AnimationController _bgTransparentController;
  late Animation<double> _bganimation;

  // 盒子大小控制器
  late AnimationController _sizedController;
  late Animation<Size> _sizedAnimation;

  // 视频控制器
  VideoPlayerController? _videoController;
  Offset _boxOffset = Offset.zero; // 小盒子的偏移量

  double videoWidth = 0;
  double videoHeight = 0;
  bool canBeCloseFlag = false;
  Size oldSize = const Size(0, 0);
  Offset? originPoint;
  Offset currentPosition = Offset(0, 0);

  @override
  void initState() {
    super.initState();

    // 位置控制器
    _positionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 回弹动画时长
    );
    _positionAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
      CurvedAnimation(
          parent: _positionAnimationController,
          curve: Curves.easeInOutCubicEmphasized),
    );

    // 背景透明度控制器
    _bgTransparentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _bganimation = Tween<double>(begin: 0, end: 255).animate(
      CurvedAnimation(
          parent: _bgTransparentController, curve: Curves.easeInOut),
    );

    // 盒子大小控制器
    _sizedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // 大小
    _sizedAnimation = Tween<Size>(
      begin: widget.openBoxSize,
      end: Size(videoWidth, videoHeight),
    ).animate(
      CurvedAnimation(parent: _sizedController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _positionAnimationController.dispose();
    _bgTransparentController.dispose();
    _sizedController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LJNPopupCubit, PopupState>(
      listener: (context, state) {
        logger.info(
            'qqqqqqqqqqqqqqqqqq showFullScreenVideo ${state.showFullScreenVideo}');
        logger.info(
            'qqqqqqqqqqqqqqqqqq returnButtonEvent ${state.returnButtonEvent}');

        // 当前为显示满屏视频窗口并且返回按钮被按下
        if (state.showFullScreenVideo == true &&
            state.returnButtonEvent == true) {
          logger.info('qqqqqqqqqqqqqqqqqq 3333333333');

          closeFullScreen(currentPosition);
        }
      },
      child: BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          _videoController ??= VideoPlayerController.asset(
            assetPath(widget.videoPath),
            videoPlayerOptions: VideoPlayerOptions(
              mixWithOthers: false,
              allowBackgroundPlayback: false,
            ),
          )..initialize().then((_) {
              // 动态计算视频宽高
              videoWidth = systemState.screenSize.width;
              videoHeight = videoWidth / _videoController!.value.aspectRatio;

              // 中心点坐标
              originPoint = Offset(
                  (systemState.screenSize.width - videoWidth) / 2,
                  (systemState.screenSize.height - videoHeight) / 2);

              // 位置
              _positionAnimation = Tween<Offset>(
                begin: widget.openPosition,
                end: Offset(0, originPoint!.dy),
              ).animate(_positionAnimationController);

              // 背景
              _bgTransparentController.forward(from: 0.0);
              _positionAnimationController.forward(from: 0).then((_) {
                setState(() {
                  _videoController?.play();
                });
              });

              // 大小
              _sizedAnimation = Tween<Size>(
                begin: widget.openBoxSize,
                end: Size(videoWidth, videoHeight),
              ).animate(_sizedController);
              _sizedController.forward();
            });

          return AnimatedBuilder(
            animation: _positionAnimationController,
            builder: (context, child) {
              Offset currentPosition = Offset(
                _positionAnimation.value.dx +
                    _boxOffset.dx +
                    max((oldSize.width - _sizedAnimation.value.width) / 2, 0),
                _positionAnimation.value.dy +
                    _boxOffset.dy +
                    max((oldSize.height - _sizedAnimation.value.height) / 2, 0),
              );

              return GestureDetector(
                onTap: () {
                  closeFullScreen(currentPosition);
                },
                onPanDown: (details) {
                  _positionAnimationController.stop();
                  _bgTransparentController.stop();
                  _sizedController.stop();

                  // 缩小或者放大过程再次被点击，取消关闭
                  cancelableDelay?.cancel();

                  setState(() {
                    oldSize = _sizedAnimation.value;
                  });
                },
                onPanUpdate: (details) {
                  // 更新偏移量
                  setState(() {
                    // 偏移
                    _boxOffset += details.delta;

                    // 背景
                    double distance = _boxOffset.dy.abs();
                    double v =
                        distance / (MediaQuery.of(context).size.height / 2);

                    if (v > 1) v = 1;
                    _bgTransparentController.value = 1 - v;

                    // 大小
                    _sizedController.value = 1 - v;

                    if (distance > 100) {
                      canBeCloseFlag = true;
                    } else {
                      canBeCloseFlag = false;
                    }
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  if (canBeCloseFlag) {
                    closeFullScreen(currentPosition);
                    return;
                  }

                  // 使用 Tween 动画将偏移量平滑过渡到 (0, 0)
                  _positionAnimation = Tween<Offset>(
                    begin: currentPosition,
                    end: Offset(0,
                        (MediaQuery.of(context).size.height - videoHeight) / 2),
                  ).animate(
                    CurvedAnimation(
                      parent: _positionAnimationController,
                      curve: Curves.easeInOutCubicEmphasized, // 使用缓动曲线
                    ),
                  );

                  setState(() {
                    _boxOffset = Offset.zero;
                    oldSize = Size.zero;
                  });

                  _positionAnimationController.reset();
                  _positionAnimationController.forward(from: 0.0); // 开始动画

                  _bganimation = Tween<double>(
                          begin: _bgTransparentController.value, end: 255)
                      .animate(_bgTransparentController);
                  _bgTransparentController.forward();

                  _sizedController.forward();
                },
                child: Stack(
                  children: [
                    // 背景
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color:
                          Color.fromARGB(_bganimation.value.toInt(), 0, 0, 0),
                    ),

                    // 视频窗口
                    Positioned(
                      left: currentPosition.dx,
                      top: currentPosition.dy,
                      child: Container(
                        width: _sizedAnimation.value.width,
                        height: _sizedAnimation.value.height,
                        color: AppColors.transparent,
                        child: AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        ),
                      ),
                    ),

                    // 关闭按钮
                    if (currentPosition == originPoint)
                      Positioned(
                        top: 90.w,
                        right: 30.w,
                        child: GestureDetector(
                          onTap: () {
                            closeFullScreen(currentPosition);
                          },
                          child: Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.w),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              const IconData(
                                0xe60f,
                                fontFamily: 'Iconfont',
                              ),
                              size: 30.w, // 图标的大小
                              color: AppColors.neutralBlack, // 图标颜色
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  LJNCancelableDelay? cancelableDelay;

  // 关闭全屏
  void closeFullScreen(Offset currentPosition) {
    _videoController?.pause();
    _positionAnimationController.stop();
    _bgTransparentController.stop();
    _sizedController.stop();
    canBeCloseFlag = false;
    cancelableDelay = LJNCancelableDelay();

    setState(() {
      _boxOffset = Offset.zero;
      oldSize = Size.zero;
    });

    // 使用 Tween 动画将偏移量平滑过渡到 (0, 0)
    _positionAnimation = Tween<Offset>(
      begin: widget.openPosition,
      end: currentPosition,
    ).animate(
      CurvedAnimation(
        parent: _positionAnimationController,
        curve: Curves.linear,
      ),
    );

    _positionAnimationController.value = 1;
    _positionAnimationController.reverse().then((_) {});

    _bgTransparentController.reverse();

    _sizedController.reverse().then(
      (_) {
        // 创建一个可取消的延迟任务
        cancelableDelay!.delayed(
          const Duration(milliseconds: 100),
          () {
            setState(
              () {
                context.read<LJNPopupCubit>().updateReturnButtonEvent(false);
                context.read<LJNPopupCubit>().updateShowFullScreenVideo(false);
                if (widget.onClose != null) widget.onClose!();
              },
            );
          },
        );
      },
    );
  }
}
