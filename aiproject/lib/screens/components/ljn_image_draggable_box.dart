import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/themes.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:image_size_getter/image_size_getter.dart' as imagegetter;

// 可拖动和缩放的图片框状态组件。
class LJNImaeDraggableBox extends StatefulWidget {
  final double minScale; // 图片允许的最小缩放比例。
  final double maxScale; // 图片允许的最大缩放比例。
  final Size openBoxSize;
  final Offset openPosition;
  final String imagePath;
  final VoidCallback? onClose;

  const LJNImaeDraggableBox({
    super.key,
    required this.imagePath,
    this.minScale = 0.5,
    this.maxScale = 5.0,
    this.openBoxSize = const Size(0, 0),
    this.openPosition = const Offset(0, 0),
    this.onClose,
  });

  @override
  State<LJNImaeDraggableBox> createState() => _LJNImaeDraggableBoxState();
}

class _LJNImaeDraggableBoxState extends State<LJNImaeDraggableBox>
    with TickerProviderStateMixin {
  late Matrix4 _matrix; // 图片的变换矩阵。
  // Size? _imageSize; // 图片的实际尺寸。
  Offset initOffset = Offset.zero; // 初始偏移量。

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;

  double _currentScale = 1.0; // 图片当前的缩放比例。
  Offset _currentOffset = Offset.zero; // 图片当前的平移位置。

  // 手势交互过程中的辅助变量
  double _gestureStartScale = 1.0; // 手势开始时的缩放比例。
  Offset _gestureStartOffset = Offset.zero; // 手势开始时的偏移量。
  Offset _gestureStartFocalPoint = Offset.zero; // 手势开始时的焦点位置。

  Future<void> getImageSize(String filename) async {
    final buffer = await rootBundle.load(filename); // get the byte buffer
    final memoryImageSizeResult = imagegetter.ImageSizeGetter.getSizeResult(
        imagegetter.MemoryInput.byteBuffer(buffer.buffer));
    final size = memoryImageSizeResult.size;
    logger.info("qqqqqqqqqqqq: $size");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getImageSize(assetPath(widget.imagePath));

    // 放大缩小
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animationController.addListener(() {
      setState(() {
        _matrix = _buildTransformMatrix(); // 重新构建变换矩阵。
      });
    });

    _offsetAnimation =
        Tween<Offset>(begin: widget.openPosition, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation =
        Tween<double>(begin: (widget.openBoxSize.width / 750.w), end: 1)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    _matrix = Matrix4.identity(); // 初始化变换矩阵
  }

  Offset delta = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              alignment: Alignment.topLeft,
              color: AppColors.navyBlueTransparent64,
              child: Stack(
                children: [
                  // 图片
                  GestureDetector(
                    onDoubleTap: () {
                      _internalCloseScaleScreen();
                    },
                    onScaleStart: (details) {
                      // 放大缩小
                      _animationController.reset();

                      _offsetAnimation =
                          Tween<Offset>(begin: _currentOffset, end: Offset.zero)
                              .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      );

                      _scaleAnimation =
                          Tween<double>(begin: _currentScale, end: 1).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      );

                      setState(() {
                        _gestureStartScale = _currentScale; // 存储当前缩放比例。
                        _gestureStartOffset = _currentOffset; // 存储当前偏移量。
                        _gestureStartFocalPoint = details.focalPoint; // 存储焦点位置。
                        _matrix = _buildTransformMatrix(); // 重新构建变换矩阵。
                      });
                    },
                    onScaleUpdate: (details) {
                      final double newTargetScaleOverall = (_gestureStartScale *
                              details.scale)
                          .clamp(widget.minScale, widget.maxScale); // 限制新的缩放比例。

                      setState(() {
                        delta = details.focalPoint - _gestureStartFocalPoint;
                      });
                      final Offset newOffset = _gestureStartOffset + delta;

                      setState(() {
                        _currentScale = newTargetScaleOverall; // 更新当前缩放比例。
                        _currentOffset = newOffset; // 更新当前偏移量。

                        _offsetAnimation = Tween<Offset>(
                                begin: _currentOffset, end: Offset.zero)
                            .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        );

                        _scaleAnimation =
                            Tween<double>(begin: _currentScale, end: 1).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        );

                        _matrix = _buildTransformMatrix(); // 重新构建变换矩阵。
                      });
                    },
                    onScaleEnd: (details) {
                      if (_currentScale == 1) {
                        _animationController.forward().then((v) {
                          setState(() {
                            _currentOffset = Offset.zero; // 重置偏移量。
                            _gestureStartScale = 1.0; // 重置手势开始时的缩放比例。
                            _gestureStartOffset = Offset.zero; // 重置手势开始时的偏移量。
                            _gestureStartFocalPoint =
                                Offset.zero; // 重置手势开始时的焦点位置。
                          });
                        });
                      }

                      _offsetAnimation =
                          Tween<Offset>(begin: _currentOffset, end: Offset.zero)
                              .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      );

                      _scaleAnimation =
                          Tween<double>(begin: _currentScale, end: 1).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          alignment: Alignment.topLeft,
                          color: AppColors.navyBlueTransparent76,
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Image.asset(
                                assetPath(widget.imagePath),
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
                                  child: Text(
                                      AppLocalizations.of(context)!.loadFailed),
                                ),
                                frameBuilder: (
                                  context,
                                  child,
                                  frame,
                                  wasSynchronouslyLoaded,
                                ) {
                                  return Transform(
                                    transform: _matrix,
                                    alignment: Alignment.topLeft,
                                    child: Opacity(
                                      opacity:
                                          _scaleAnimation.value.clamp(0.5, 1),
                                      child: child,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: _offsetAnimation.value.dy,
                          left: _offsetAnimation.value.dx,
                          child: Container(
                            width: 30.w,
                            height: 30.w,
                            color: AppColors.accentRedPure,
                          ),
                        )
                      ],
                    ),
                  ),
                  // 关闭按钮。
                  Positioned(
                    top: 90.w,
                    right: 30.w,
                    child: GestureDetector(
                      onTap: () {
                        _internalCloseScaleScreen(); // 处理点击以关闭全屏。
                        // widget.onClose?.call(); // 可选地调用外部回调。
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
                          size: 30.w,
                          color: AppColors.neutralBlack,
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
    );
  }

  final double focalX = 0; // Widget 内部的缩放中心点 X 坐标
  final double focalY = 0; // Widget 内部的缩放中心点 Y 坐标

  // 根据当前缩放比例和偏移量构建变换矩阵。
  Matrix4 _buildTransformMatrix() {
    return Matrix4.identity()
      ..translate(_offsetAnimation.value.dx, _offsetAnimation.value.dy)
      ..scale(_scaleAnimation.value);
    // ..translate(-focalX, -focalY);
  }

  // 将图片重置为原始状态（关闭全屏）。
  void _internalCloseScaleScreen() {
    // setState(() {
    //   _animationController.addListener(() {
    //     _currentScale = 1.0; // 重置缩放比例。
    //     _currentOffset = Offset.zero; // 重置偏移量。
    //     _gestureStartScale = 1.0; // 重置手势开始时的缩放比例。
    //     _gestureStartOffset = Offset.zero; // 重置手势开始时的偏移量。
    //     _gestureStartFocalPoint = Offset.zero; // 重置手势开始时的焦点位置。
    //     _matrix = _buildTransformMatrix(); // 重新构建变换矩阵。
    //   });
    // });

    _animationController.forward().then((v) {
      setState(() {
        _currentScale = 1.0; // 重置缩放比例。
        _currentOffset = Offset.zero; // 重置偏移量。
        _gestureStartScale = 1.0; // 重置手势开始时的缩放比例。
        _gestureStartOffset = Offset.zero; // 重置手势开始时的偏移量。
        _gestureStartFocalPoint = Offset.zero; // 重置手势开始时的焦点位置。
      });
    });
  }
}
