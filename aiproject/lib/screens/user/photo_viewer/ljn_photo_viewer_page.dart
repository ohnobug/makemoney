// 文件路径: lib/ljn_photo_viewer_page.dart

import 'package:flutter/material.dart';
// 仅导入 PhotoView 核心库，以获取 PhotoView 组件和相关属性
import 'package:photo_view/photo_view.dart';

class LJNPhotoViewerPage extends StatefulWidget {
  final List<String> imageSources;
  final int initialIndex;

  const LJNPhotoViewerPage({
    super.key,
    required this.imageSources,
    this.initialIndex = 0,
  });

  @override
  State<LJNPhotoViewerPage> createState() => _LJNPhotoViewerPageState();
}

class _LJNPhotoViewerPageState extends State<LJNPhotoViewerPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;
  late int _currentIndex;

  // 拖拽关闭动画所需的状态变量
  Offset _dragOffset = Offset.zero;
  double _dragScale = 1.0;
  bool _isDragging = false;

  // 【核心修正】: 我们将通过 `scaleStateChangedCallback` 来更新这个状态
  PhotoViewScaleState _scaleState = PhotoViewScaleState.initial;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

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
    super.dispose();
  }

  // 【核心修正】: 这是来自 PhotoView 的回调，用于更新缩放状态
  void _onScaleStateChanged(PhotoViewScaleState state) {
    if (mounted) {
      setState(() {
        _scaleState = state;
      });
    }
  }

  // --- 拖拽关闭手势逻辑 ---

  void _onVerticalDragStart(DragStartDetails details) {
    // 仅当图片处于初始（未放大）状态时，才允许启动拖拽关闭
    if (_scaleState == PhotoViewScaleState.initial) {
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
                _buildPhotoViewGallery(),
                _buildCloseButton(),
                _buildIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- UI 构建辅助方法 ---

  Widget _buildPhotoViewGallery() {
    // 【核心修正】: 使用 PageView.builder 手动构建画廊
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageSources.length,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
          // 翻页时，强制重置缩放状态为初始状态
          _scaleState = PhotoViewScaleState.initial;
        });
      },
      itemBuilder: (context, index) {
        // 每一页都是一个配置好的 PhotoView
        return PhotoView(
          imageProvider: NetworkImage(widget.imageSources[index]),
          // 【核心修正】: 直接在这里使用 scaleStateChangedCallback
          scaleStateChangedCallback: _onScaleStateChanged,
          heroAttributes:
              PhotoViewHeroAttributes(tag: widget.imageSources[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.5,
          initialScale: PhotoViewComputedScale.contained,
          loadingBuilder: (context, event) => const Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // 关闭/退出缩放按钮 (现在可以完美工作)
  Widget _buildCloseButton() {
    bool isZoomed = _scaleState != PhotoViewScaleState.initial;
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      child: AnimatedOpacity(
        opacity: !_isDragging ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 100),
        child: IconButton(
          icon: Icon(isZoomed ? Icons.arrow_back : Icons.close,
              color: Colors.white, size: 30),
          onPressed: () {
            if (isZoomed) {
              // 这里我们无法像控制器那样直接命令它复位，
              // 但双击图片本身就可以复位，这个按钮可以引导用户或直接关闭页面。
              // 为了更好的体验，我们直接关闭页面。
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          tooltip: isZoomed ? '返回' : '关闭',
        ),
      ),
    );
  }

  // 页码指示器
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
