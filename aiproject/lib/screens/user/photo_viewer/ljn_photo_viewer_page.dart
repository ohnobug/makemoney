import 'package:flutter/material.dart';

class LJNPhotoViewerPage extends StatefulWidget {
  final List<String> imageSources;
  final int initialIndex;

  const LJNPhotoViewerPage({
    super.key,
    required this.imageSources,
    required this.initialIndex,
  });

  @override
  State<LJNPhotoViewerPage> createState() => _LJNPhotoViewerPageState();
}

class _LJNPhotoViewerPageState extends State<LJNPhotoViewerPage> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final TransformationController _transformationController;
  late final AnimationController _animationController;

  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // 监听缩放变化，判断是否处于缩放状态
    _transformationController.addListener(() {
      final newScale = _transformationController.value.getMaxScaleOnAxis();
      if (newScale != _scale) {
        setState(() {
          _scale = newScale;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // 处理拖拽更新
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    // 只有在图片未被放大的情况下才允许拖拽关闭
    if (_scale > 1.0) return;
    setState(() {
      _dragOffset += details.delta;
    });
  }

  // 处理拖拽结束
  void _onVerticalDragEnd(DragEndDetails details) {
    if (_scale > 1.0) return;
    final screenHeight = MediaQuery.of(context).size.height;
    // 如果拖拽距离超过屏幕高度的1/4，或者拖拽速度很快，则关闭页面
    if (_dragOffset.dy.abs() > screenHeight / 4 || details.primaryVelocity!.abs() > 500) {
      Navigator.of(context).pop();
    } else {
      // 否则，动画返回原位
      _animationController.addListener(() {
        setState(() {
          _dragOffset = Offset(0, _animationController.value);
        });
      });
      final animation = Tween<double>(begin: _dragOffset.dy, end: 0.0).animate(_animationController);
      animation.addListener(() {
        setState(() {
          _dragOffset = Offset(0, animation.value);
        });
      });
      _animationController.forward(from: 0);
    }
  }

  // 处理缩放结束后的回弹
  void _onInteractionEnd(ScaleEndDetails details) {
    // 如果缩放结束后，图片的宽度小于屏幕宽度，则动画回弹到适应屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    final currentScale = _transformationController.value.getMaxScaleOnAxis();

    // 假设图片原始宽度等于屏幕宽度
    if (currentScale * screenWidth < screenWidth) {
      final animation = Matrix4Tween(
        begin: _transformationController.value,
        end: Matrix4.identity(),
      ).animate(_animationController);

      animation.addListener(() {
        _transformationController.value = animation.value;
      });
       _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 根据拖拽距离计算背景透明度
    final double backgroundOpacity = (1 - _dragOffset.dy.abs() / (MediaQuery.of(context).size.height)).clamp(0.0, 1.0);

    // 如果图片被放大，则背景不透明
    final bool isZoomed = _scale > 1.01;

    return Scaffold(
      backgroundColor: isZoomed ? Colors.black : Colors.black.withAlpha((backgroundOpacity * 255).toInt()),
      body: GestureDetector(
        // 全局手势，用于拖拽关闭
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: Stack(
          children: [
            Transform.translate(
              offset: _dragOffset,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.imageSources.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    // 切换页面时重置缩放状态
                    _transformationController.value = Matrix4.identity();
                  });
                },
                // 只有在图片未放大的情况下才允许左右滑动
                physics: isZoomed ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
                itemBuilder: (context, index) {
                  final imageUrl = widget.imageSources[index];
                  return Hero(
                    tag: imageUrl,
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      minScale: 0.8,
                      maxScale: 5.0,
                      onInteractionEnd: _onInteractionEnd,
                      child: Center(
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // 顶部的关闭按钮和页码指示器
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Opacity(
                  // 拖拽时隐藏UI元素
                  opacity: (1 - _dragOffset.dy.abs() / 100).clamp(0.0, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        '${_currentIndex + 1} / ${widget.imageSources.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 48), // 占位
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}