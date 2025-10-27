// G:\t\detection\aiproject\lib\screens\user\photo_viewer\viga_photo_viewer_page.dart

import 'package:flutter/material.dart';

// 定义查看器的核心状态
enum ViewerState {
  idle, // 默认状态，可左右滑动
  dragging, // 拖拽中
  animating, // 正在执行回弹动画
}

class VigaPhotoViewerPage extends StatefulWidget {
  final List<String> imageSources;
  final int initialIndex;
  final Rect initialRect;

  const VigaPhotoViewerPage({
    super.key,
    required this.imageSources,
    required this.initialIndex,
    required this.initialRect,
  });

  @override
  State<VigaPhotoViewerPage> createState() => _VigaPhotoViewerPageState();
}

class _VigaPhotoViewerPageState extends State<VigaPhotoViewerPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late int _currentIndex;

  // 状态管理
  ViewerState _currentState = ViewerState.idle;
  Offset _dragOffset = Offset.zero; // 拖拽位移
  double _dragScale = 1.0; // 拖拽缩放
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // --- 手势处理 ---

  // 【改动 1】方法名从 onVerticalDragStart 改为 onPanStart
  void _onPanStart(DragStartDetails details) {
    if (_currentState == ViewerState.idle) {
      setState(() {
        _currentState = ViewerState.dragging;
      });
    }
  }

  // 【改动 2】方法名从 onVerticalDragUpdate 改为 onPanUpdate
  void _onPanUpdate(DragUpdateDetails details) {
    if (_currentState != ViewerState.dragging) return;
    setState(() {
      // 【核心改动】让 _dragOffset 接收完整的 delta (包含 dx 和 dy)
      _dragOffset += details.delta;

      // 【保持不变】计算缩放比例的逻辑，依然只依赖垂直拖拽距离
      final verticalDragDistance = _dragOffset.dy.abs();
      final screenHeight = MediaQuery.of(context).size.height;
      final ratio = (verticalDragDistance / (screenHeight / 3)).clamp(0.0, 1.0);
      _dragScale = 1.0 - (ratio * 0.4); // 最小缩放到0.6倍
    });
  }

  // 【改动 3】方法名从 onVerticalDragEnd 改为 onPanEnd
  void _onPanEnd(DragEndDetails details) {
    if (_currentState != ViewerState.dragging) return;

    // 结束逻辑完全不变
    if (_dragScale < 0.8 || details.primaryVelocity!.abs() > 500) {
      Navigator.of(context).pop();
    } else {
      _runSnapBackAnimation();
    }
  }

  // --- 动画 ---

  void _runSnapBackAnimation() {
    setState(() {
      _currentState = ViewerState.animating;
    });

    _offsetAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: _dragScale,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward().whenComplete(() {
      setState(() {
        _dragOffset = Offset.zero;
        _dragScale = 1.0;
        _currentState = ViewerState.idle;
      });
      _animationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Offset currentOffset = _currentState == ViewerState.animating
        ? _offsetAnimation.value
        : _dragOffset;
    final double currentScale = _currentState == ViewerState.animating
        ? _scaleAnimation.value
        : _dragScale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            color: Colors.black
                .withAlpha((_dragScale.clamp(0.4, 1.0) * 255).toInt()),
          ),
          GestureDetector(
            onTap: () {
              if (_currentState == ViewerState.idle) {
                Navigator.of(context).pop();
              }
            },
            // 【改动 4】将手势回调绑定到 onPan 系列
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: currentOffset,
                  child: Transform.scale(
                    scale: currentScale,
                    child: child,
                  ),
                );
              },
              child: _buildPageView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          physics: _currentState == ViewerState.idle
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemCount: widget.imageSources.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Hero(
              tag: widget.imageSources[index],
              flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                final toHero = toHeroContext.widget as Hero;
                if (flightDirection == HeroFlightDirection.pop) {
                  // 【重要】您之前的修改，这里应该是 cover 才能解决形变问题
                  return ClipRect(
                    child: Image.network(
                      widget.imageSources[index],
                      width: widget.initialRect.width,
                      height: widget.initialRect.height,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return toHero.child;
              },
              child: Center(
                child: Image.network(
                  widget.imageSources[index],
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: _currentState == ViewerState.idle ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Text(
              "${_currentIndex + 1} / ${widget.imageSources.length}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                shadows: [Shadow(blurRadius: 4, color: Colors.black87)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
