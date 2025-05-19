import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

// 可拖动和缩放的图片框状态组件。
class LJNImaeDraggableBox extends StatefulWidget {
  final String imageUrl; // 图片的URL地址。
  final double minScale; // 图片允许的最小缩放比例。
  final double maxScale; // 图片允许的最大缩放比例。

  const LJNImaeDraggableBox({
    super.key,
    required this.imageUrl,
    this.minScale = 0.5,
    this.maxScale = 5.0,
  });

  @override
  State<LJNImaeDraggableBox> createState() => _LJNImaeDraggableBoxState();
}

class _LJNImaeDraggableBoxState extends State<LJNImaeDraggableBox> {
  late Matrix4 _matrix; // 图片的变换矩阵。
  Size? _imageSize; // 图片的实际尺寸。
  Offset initOffset = Offset.zero; // 初始偏移量。

  double _currentScale = 1.0; // 图片当前的缩放比例。
  Offset _currentOffset = Offset.zero; // 图片当前的平移位置。

  // 手势交互过程中的辅助变量。
  double _gestureStartScale = 1.0; // 手势开始时的缩放比例。
  Offset _gestureStartOffset = Offset.zero; // 手势开始时的偏移量。
  Offset _gestureStartFocalPoint = Offset.zero; // 手势开始时的焦点位置。

  @override
  void initState() {
    super.initState();
    _matrix = Matrix4.identity(); // 初始化变换矩阵。
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _internalCloseFullScreen(); // 处理双击以关闭全屏。
      },
      onScaleStart: (details) {
        setState(() {
          _gestureStartScale = _currentScale; // 存储当前缩放比例。
          _gestureStartOffset = _currentOffset; // 存储当前偏移量。
          _gestureStartFocalPoint = details.focalPoint; // 存储焦点位置。
        });
      },
      onScaleUpdate: (details) {
        final double newTargetScaleOverall =
            (_gestureStartScale * details.scale)
                .clamp(widget.minScale, widget.maxScale); // 限制新的缩放比例。

        final Offset delta = details.focalPoint - _gestureStartFocalPoint;
        final Offset newOffset = _gestureStartOffset + (delta);

        setState(() {
          _currentScale = newTargetScaleOverall; // 更新当前缩放比例。
          _currentOffset = newOffset; // 更新当前偏移量。
          _matrix = _buildTransformMatrix(); // 重新构建变换矩阵。
        });
      },
      onScaleEnd: (details) {}, // 处理缩放手势结束。
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // 背景。
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 0, 0, 0),
              ),

              // 图片。
              Center(
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Image.asset(
                    assetPath(widget.imageUrl),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Text('加载失败')), // 如果图片加载失败，显示错误信息。
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      // 一旦图片加载完成，记录图片尺寸。
                      if (frame != null && _imageSize == null) {
                        final ImageStream imageStream =
                            NetworkImage(assetPath(widget.imageUrl))
                                .resolve(ImageConfiguration.empty);
                        imageStream.addListener(ImageStreamListener(
                            (ImageInfo imageInfo, bool synchronousCall) {
                          setState(() {
                            _imageSize = Size(imageInfo.image.width.toDouble(),
                                imageInfo.image.height.toDouble());
                          });
                        }));
                      }
                      return Transform(
                        transform: _matrix,
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  ),
                ),
              ),

              // 关闭按钮。
              Positioned(
                top: 90.w,
                right: 30.w,
                child: GestureDetector(
                  onTap: () {
                    _internalCloseFullScreen(); // 处理点击以关闭全屏。
                    // widget.onClose?.call(); // 可选地调用外部回调。
                  },
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 根据当前缩放比例和偏移量构建变换矩阵。
  Matrix4 _buildTransformMatrix() {
    return Matrix4.identity()
      ..translate(_currentOffset.dx, _currentOffset.dy) // 应用平移。
      ..scale(_currentScale); // 应用缩放。
  }

  // 将图片重置为原始状态（关闭全屏）。
  void _internalCloseFullScreen() {
    setState(() {
      _currentScale = 1.0; // 重置缩放比例。
      _currentOffset = Offset.zero; // 重置偏移量。
      _gestureStartScale = 1.0; // 重置手势开始时的缩放比例。
      _gestureStartOffset = Offset.zero; // 重置手势开始时的偏移量。
      _gestureStartFocalPoint = Offset.zero; // 重置手势开始时的焦点位置。
      _matrix = _buildTransformMatrix(); // 重新构建变换矩阵。
    });
    // 可以在此处添加额外的关闭逻辑（例如，动画）。
  }
}
