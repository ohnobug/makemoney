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

  void _onPanStart(DragStartDetails details) {
    if (_currentState == ViewerState.idle) {
      setState(() {
        _currentState = ViewerState.dragging;
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_currentState != ViewerState.dragging) return;
    setState(() {
      _dragOffset += details.delta;

      final verticalDragDistance = _dragOffset.dy.abs();
      final screenHeight = MediaQuery.of(context).size.height;
      final ratio = (verticalDragDistance / (screenHeight / 3)).clamp(0.0, 1.0);
      _dragScale = 1.0 - (ratio * 0.4); // 最小缩放到0.6倍
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentState != ViewerState.dragging) return;

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
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            // 【核心修正】将计算偏移和缩放的逻辑移入 AnimatedBuilder 的 builder 内部
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                // 在这里计算，保证动画每一帧都能获取最新值
                final Offset currentOffset =
                    _currentState == ViewerState.animating
                        ? _offsetAnimation.value
                        : _dragOffset;
                final double currentScale =
                    _currentState == ViewerState.animating
                        ? _scaleAnimation.value
                        : _dragScale;

                return Transform.translate(
                  offset: currentOffset,
                  child: Transform.scale(
                    scale: currentScale,
                    child: child, // child 就是下面的 _buildPageView()
                  ),
                );
              },
              // 这个 child 不会随着动画重建，提高了性能
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
                  return Image.network(
                    widget.imageSources[index],
                    width: widget.initialRect.width,
                    height: widget.initialRect.height,
                    fit: BoxFit.contain,
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
