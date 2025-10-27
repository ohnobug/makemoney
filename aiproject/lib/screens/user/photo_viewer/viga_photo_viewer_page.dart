// 文件路径: lib/viga_photo_viewer_page.dart

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class VigaPhotoViewerPage extends StatefulWidget {
  final List<String> imageSources;
  final int initialIndex;

  const VigaPhotoViewerPage({
    super.key,
    required this.imageSources,
    this.initialIndex = 0,
  });

  @override
  State<VigaPhotoViewerPage> createState() => _VigaPhotoViewerPageState();
}

class _VigaPhotoViewerPageState extends State<VigaPhotoViewerPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;
  late int _currentIndex;

  // 1. 【核心】用于程序化控制 InteractiveViewer 的缩放/平移
  late TransformationController _transformationController;

  // 拖拽关闭动画所需的状态变量
  Offset _dragOffset = Offset.zero;
  double _dragScale = 1.0;
  bool _isDragging = false;

  // 记录是否处于放大状态
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _transformationController = TransformationController();

    // 监听变换，以判断是否处于缩放状态
    _transformationController.addListener(() {
      // Matrix4.identity() 是一个单位矩阵，代表没有变换（即未缩放）
      final isZoomedNow = _transformationController.value != Matrix4.identity();
      if (isZoomedNow != _isZoomed) {
        setState(() {
          _isZoomed = isZoomedNow;
        });
      }
    });

    // 拖拽归位动画的控制器
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animationController.addListener(() {
      setState(() {
        _dragOffset = _offsetAnimation.value;
        _dragScale = _scaleAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  // --- 手势处理 ---

  void _onVerticalDragStart(DragStartDetails details) {
    // 仅当图片未缩放时，才允许启动拖拽关闭
    if (!_isZoomed) {
      setState(() {
        _isDragging = true;
      });
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    setState(() {
      _dragOffset += details.delta;
      final screenHeight = MediaQuery.of(context).size.height;
      _dragScale = (1 - (_dragOffset.dy.abs() / screenHeight)).clamp(0.4, 1.0);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (!_isDragging) return;
    final screenHeight = MediaQuery.of(context).size.height;
    final velocity = details.primaryVelocity ?? 0;

    if (_dragOffset.dy.abs() > screenHeight * 0.2 || velocity.abs() > 500) {
      setState(() {
        _dragScale = 0.1;
      });
      Navigator.of(context).pop();
    } else {
      _runSnapBackAnimation();
    }

    setState(() {
      _isDragging = false;
    });
  }

  void _runSnapBackAnimation() {
    _offsetAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(_animationController);
    _scaleAnimation = Tween<double>(begin: _dragScale, end: 1.0)
        .animate(_animationController);
    _animationController.reset();
    _animationController.forward();
  }

  // 双击缩放处理
  void _onDoubleTap() {
    Matrix4 targetMatrix;
    if (_isZoomed) {
      // 如果已放大，则恢复原状
      targetMatrix = Matrix4.identity();
    } else {
      // 如果未放大，则放大到2倍
      targetMatrix = Matrix4.identity()..scaleByVector3(Vector3(2.0, 2.0, 0));
    }

    // 使用动画平滑地过渡到目标变换
    final animation = Matrix4Tween(
      begin: _transformationController.value,
      end: targetMatrix,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    animation.addListener(() {
      _transformationController.value = animation.value;
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double backgroundOpacity = _isDragging ? _dragScale.clamp(0.0, 1.0) : 1.0;

    return Scaffold(
      backgroundColor:
          Colors.black.withAlpha((backgroundOpacity * 255).toInt()),
      body: GestureDetector(
        onVerticalDragStart: _onVerticalDragStart,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: Transform.translate(
          offset: _dragOffset,
          child: Transform.scale(
            scale: _dragScale,
            child: Stack(
              children: [
                _buildGallery(),
                _buildCloseButton(),
                _buildIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGallery() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageSources.length,
      onPageChanged: (index) {
        // 翻页时，重置缩放状态
        _transformationController.value = Matrix4.identity();
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onDoubleTap: _onDoubleTap,
          child: InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.8, // 允许缩小
            maxScale: 2.5, // 允许放大
            child: Hero(
              tag: widget.imageSources[index],
              child: Image.network(
                widget.imageSources[index],
                fit: BoxFit.contain, // 必须是 contain 才能正确缩放
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      child: AnimatedOpacity(
        opacity: !_isDragging ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 100),
        child: IconButton(
          icon: Icon(_isZoomed ? Icons.arrow_back : Icons.close,
              color: Colors.white, size: 30),
          onPressed: () {
            if (_isZoomed) {
              // 如果已放大，则恢复
              _transformationController.value = Matrix4.identity();
            } else {
              Navigator.of(context).pop();
            }
          },
          tooltip: _isZoomed ? '退出缩放' : '关闭',
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 20,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        opacity: _isDragging ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Text(
          "${_currentIndex + 1} / ${widget.imageSources.length}",
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              shadows: [Shadow(blurRadius: 4, color: Colors.black87)]),
        ),
      ),
    );
  }
}
