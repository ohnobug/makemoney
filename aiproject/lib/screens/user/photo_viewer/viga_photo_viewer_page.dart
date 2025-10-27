import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ViewState {
  swipeMode, // 左右切换状态
  dragMode,  // 拖拽状态
}

class VigaPhotoViewerPage extends StatefulWidget {
  final List<String> imageSources;
  final int initialIndex;
  final Rect? heroRect;

  const VigaPhotoViewerPage({
    super.key,
    required this.imageSources,
    this.initialIndex = 0,
    this.heroRect,
  });

  @override
  State<VigaPhotoViewerPage> createState() => _VigaPhotoViewerPageState();
}

class _VigaPhotoViewerPageState extends State<VigaPhotoViewerPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _opacityAnimation;
  late int _currentIndex;

  // 缩放状态管理
  late TransformationController _transformationController;
  double _currentScale = 1.0;
  bool _isZoomed = false;
  bool _isScaling = false;

  // 状态管理
  ViewState _currentState = ViewState.swipeMode; // 当前状态

  // 拖拽状态
  Offset _dragOffset = Offset.zero;
  double _dragScale = 1.0;
  double _backgroundOpacity = 1.0; // 背景透明度
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _transformationController = TransformationController();

    // 监听变换控制器
    _transformationController.addListener(() {
      final matrix = _transformationController.value;
      final scale = matrix.getMaxScaleOnAxis();

      if (!_isScaling) {
        setState(() {
          _currentScale = scale;
          _isZoomed = scale > 1.1; // 大于1.1倍认为是放大状态
        });
      }
    });

    // 动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // 初始化时播放放大动画
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playEnterAnimation();
    });
  }

  void _playEnterAnimation() {
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  // --- 手势处理 ---

  void _onPanStart(DragStartDetails details) {
    // 仅在未放大且未缩放时允许拖拽
    if (!_isZoomed && _currentScale == 1.0) {
      setState(() {
        _isDragging = true;
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      _dragOffset += details.delta;

      // 如果向下拖拽超过阈值，切换到拖拽状态
      if (_dragOffset.dy > 10.w && _currentState == ViewState.swipeMode) {
        _currentState = ViewState.dragMode;
      }

      // 计算背景透明度和缩放（仅基于上下移动距离）
      // 从拖拽开始就立即变化，即使只有一点点拖拽
      final dragDistance = _dragOffset.dy.abs();
      final maxDistance = 100.w; // 最大距离为关闭阈值
      final opacityRatio = (dragDistance / maxDistance).clamp(0.0, 1.0);
      _backgroundOpacity = 1.0 - (opacityRatio * 0.6); // 背景透明度从1.0到0.4
      _dragScale = 1.0 - (opacityRatio * 0.4); // 图片缩小到0.6倍
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isDragging) return;

    // 只考虑上下拖拽距离（不考虑左右拖拽）
    final dragDistance = _dragOffset.dy.abs();
    final velocity = details.primaryVelocity?.abs() ?? 0;

    // 关闭阈值：100.w
    final closeThreshold = 100.w;

    if (dragDistance > closeThreshold || velocity > 500) {
      // 关闭页面，回到grid位置
      _closeToGrid();
    } else {
      // 无论拖拽距离多少，只要没达到关闭条件，都归位到左右切换状态
      _runSnapBackAnimation();
    }

    setState(() {
      _isDragging = false;
    });
  }

  void _runSnapBackAnimation() {
    final scaleTween = Tween<double>(begin: _dragScale, end: 1.0);
    final offsetTween = Tween<Offset>(begin: _dragOffset, end: Offset.zero);
    final opacityTween = Tween<double>(begin: _backgroundOpacity, end: 1.0);

    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    animation.addListener(() {
      setState(() {
        _dragScale = scaleTween.evaluate(animation);
        _dragOffset = offsetTween.evaluate(animation);
        _backgroundOpacity = opacityTween.evaluate(animation);
      });
    });

    _animationController.reset();
    _animationController.forward().then((_) {
      // 动画完成后回到左右切换状态
      setState(() {
        _currentState = ViewState.swipeMode;
      });
    });
  }

  void _closeToGrid() {
    // 计算动画目标：缩小到0.1倍，并移动到屏幕外
    final targetScale = 0.1;
    final targetOffset = Offset(_dragOffset.dx, MediaQuery.of(context).size.height);

    final scaleTween = Tween<double>(begin: _dragScale, end: targetScale);
    final offsetTween = Tween<Offset>(begin: _dragOffset, end: targetOffset);
    final opacityTween = Tween<double>(begin: _backgroundOpacity, end: 0.0);

    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    animation.addListener(() {
      setState(() {
        _dragScale = scaleTween.evaluate(animation);
        _dragOffset = offsetTween.evaluate(animation);
        _backgroundOpacity = opacityTween.evaluate(animation);
      });
    });

    _animationController.reset();
    _animationController.forward().then((_) {
      // 动画完成后关闭页面
      Navigator.of(context).pop();
    });
  }

  // 双指缩放手势处理
  void _onScaleStart(ScaleStartDetails details) {
    _isScaling = true;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (!_isScaling) return;

    final newScale = _currentScale * details.scale;

    // 限制缩放范围在 0.5 到 3.0 之间
    final clampedScale = newScale.clamp(0.5, 3.0);

    // 更新变换
    final newMatrix = Matrix4.identity()..scaleByVector3(Vector3(clampedScale, clampedScale, 1.0));
    _transformationController.value = newMatrix;
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _isScaling = false;

    // 如果缩放小于1倍，自动归位到1倍
    if (_currentScale < 1.0) {
      _animateToScale(1.0);
    }
  }

  void _animateToScale(double targetScale) {
    final targetMatrix = Matrix4.identity()..scaleByVector3(Vector3(targetScale, targetScale, 1.0));

    final animation = Matrix4Tween(
      begin: _transformationController.value,
      end: targetMatrix,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    animation.addListener(() {
      _transformationController.value = animation.value;
    });

    _animationController.reset();
    _animationController.forward();
  }

  // 双击缩放处理
  void _onDoubleTap() {
    if (_isZoomed) {
      // 如果已放大，则恢复原状
      _animateToScale(1.0);
    } else {
      // 如果未放大，则放大到2倍
      _animateToScale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, _backgroundOpacity),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final opacity = _opacityAnimation?.value ?? 1.0;
          final scale = _scaleAnimation?.value ?? 1.0;

          return Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildGallery() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageSources.length,
      physics: _currentState == ViewState.dragMode ? const NeverScrollableScrollPhysics() : null, // 拖拽状态时禁用左右滑动
      onPageChanged: (index) {
        // 翻页时重置缩放状态
        _transformationController.value = Matrix4.identity();
        setState(() {
          _currentIndex = index;
          _currentScale = 1.0;
          _isZoomed = false;
        });
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onDoubleTap: _onDoubleTap,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          child: InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.5, // 最小缩小到0.5倍
            maxScale: 3.0, // 最大放大到3倍
            panEnabled: true,
            scaleEnabled: true,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            child: Hero(
              tag: widget.imageSources[index],
              child: Image.network(
                widget.imageSources[index],
                fit: BoxFit.contain,
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
              _animateToScale(1.0);
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