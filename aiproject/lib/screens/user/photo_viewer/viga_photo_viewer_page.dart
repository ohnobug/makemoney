// G:\t\detection\aiproject\lib\screens\user\photo_viewer\viga_photo_viewer_page.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

enum ViewerState {
  idle,
  dragging,
  animating,
  zooming,
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
  // --- 控制器 ---
  late PageController _pageController;
  late AnimationController _dragAnimationController;
  late AnimationController _zoomAnimationController;

  // --- 状态 ---
  late int _currentIndex;
  ViewerState _currentState = ViewerState.idle;
  Offset _dragOffset = Offset.zero;
  double _dragScale = 1.0;
  double _zoomScale = 1.0;
  Offset _zoomOffset = Offset.zero;
  late Animation<Offset> _dragAnimationOffset;
  late Animation<double> _dragAnimationScale;
  late Animation<Offset> _zoomAnimationOffset;
  late Animation<double> _zoomAnimationScale;

  // --- 手势临时变量 ---
  Offset _startingFocalPoint = Offset.zero;
  double _initialZoomScale = 1.0;
  Offset _initialZoomOffset = Offset.zero;
  TapDownDetails? _doubleTapDetails;

  // --- 常量 ---
  final double _doubleTapZoomScale = 2.0;
  final double _zoomPadding = 30.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _dragAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _zoomAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _dragAnimationController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }

  // --- 手势处理 ---

  // 【核心修正1】重构 onScaleStart，确保状态在任何情况下都能正确重置，解决卡死问题
  void _onScaleStart(ScaleStartDetails details) {
    _dragAnimationController.stop();
    _zoomAnimationController.stop();

    _startingFocalPoint = details.focalPoint;
    _initialZoomScale = _zoomScale;
    _initialZoomOffset = _zoomOffset;

    if (_currentState == ViewerState.idle) {
      if (details.pointerCount > 1) {
        setState(() => _currentState = ViewerState.zooming);
      } else {
        setState(() => _currentState = ViewerState.dragging);
      }
    } else if (_currentState == ViewerState.zooming ||
        _currentState == ViewerState.animating) {
      // 如果当前是缩放或动画状态，任何新的手势都应该立即切换回活跃的 zooming 状态
      setState(() => _currentState = ViewerState.zooming);
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (_currentState == ViewerState.dragging) {
      _dragOffset = details.focalPoint - _startingFocalPoint;
      final vDrag = _dragOffset.dy.abs();
      final screenH = MediaQuery.of(context).size.height;
      _dragScale = 1.0 - (vDrag / (screenH / 2)).clamp(0.0, 0.6);
      setState(() {});
    } else if (_currentState == ViewerState.zooming) {
      _zoomScale = math.max(0.5, _initialZoomScale * details.scale);
      _zoomOffset =
          _initialZoomOffset + (details.focalPoint - _startingFocalPoint);
      setState(() {});
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (_currentState == ViewerState.dragging) {
      if (_dragScale < 0.8) {
        Navigator.of(context).pop();
      } else {
        _runDragSnapBackAnimation();
      }
    } else if (_currentState == ViewerState.zooming) {
      if (_zoomScale < 1.0) {
        _runZoomAnimation(
            toScale: 1.0, toOffset: Offset.zero, finalState: ViewerState.idle);
      } else {
        final clampedOffset = _getClampedOffset(_zoomOffset, _zoomScale);
        _runZoomAnimation(toScale: _zoomScale, toOffset: clampedOffset);
      }
    }
  }

  void _onDoubleTap() {
    if (_doubleTapDetails == null) return;
    final tapPosition = _doubleTapDetails!.localPosition;
    if (_zoomScale > 1.0) {
      _runZoomAnimation(
          toScale: 1.0, toOffset: Offset.zero, finalState: ViewerState.idle);
    } else {
      final screenSize = MediaQuery.of(context).size;
      final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);
      final initialTargetOffset =
          screenCenter - (tapPosition * _doubleTapZoomScale);
      final finalTargetOffset =
          _getClampedOffset(initialTargetOffset, _doubleTapZoomScale);
      _runZoomAnimation(
          toScale: _doubleTapZoomScale, toOffset: finalTargetOffset);
    }
  }

  // 【核心修正2】重写边界检测函数，确保上下左右都有精确的黑边
  Offset _getClampedOffset(Offset offset, double scale) {
    final screenSize = MediaQuery.of(context).size;

    // 1. 估算图片的真实渲染尺寸 (这是关键一步)
    //    由于图片是 fitWidth, 宽度一定是屏幕宽度。高度需要根据宽高比计算。
    //    注意：这里我们仍然需要一个假定的宽高比。在生产级应用中，
    //    您应该通过 ImageProvider 提前加载图片信息来获取真实的宽高比。
    const assumedAspectRatio = 4 / 3;
    final imageRenderSize =
        Size(screenSize.width, screenSize.width / assumedAspectRatio);

    // 2. 计算图片在当前缩放下的总尺寸
    final scaledImageWidth = imageRenderSize.width * scale;
    final scaledImageHeight = imageRenderSize.height * scale;

    // 3. 定义我们的“视窗”(Viewport)，也就是图片可以活动的安全区域
    final viewport = Rect.fromLTRB(
      _zoomPadding,
      _zoomPadding,
      screenSize.width - _zoomPadding,
      screenSize.height - _zoomPadding,
    );

    // 4. 计算当前偏移下，图片内容的四个边的位置
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);
    final imageCenter = screenCenter + offset;
    final imageRect = Rect.fromCenter(
      center: imageCenter,
      width: scaledImageWidth,
      height: scaledImageHeight,
    );

    // 5. 计算需要施加的修正量，让图片边缘回到视窗边缘
    double dxCorrection = 0.0;
    if (scaledImageWidth > viewport.width) {
      if (imageRect.left > viewport.left) {
        dxCorrection = viewport.left - imageRect.left;
      } else if (imageRect.right < viewport.right) {
        dxCorrection = viewport.right - imageRect.right;
      }
    } else {
      // 如果图片比视窗窄，则让它回到中心
      dxCorrection = screenCenter.dx - imageCenter.dx;
    }

    double dyCorrection = 0.0;
    if (scaledImageHeight > viewport.height) {
      if (imageRect.top > viewport.top) {
        dyCorrection = viewport.top - imageRect.top;
      } else if (imageRect.bottom < viewport.bottom) {
        dyCorrection = viewport.bottom - imageRect.bottom;
      }
    } else {
      // 如果图片比视窗矮，则让它回到中心
      dyCorrection = screenCenter.dy - imageCenter.dy;
    }

    return offset + Offset(dxCorrection, dyCorrection);
  }

  // --- 动画 ---
  void _runZoomAnimation(
      {required double toScale,
      required Offset toOffset,
      ViewerState finalState = ViewerState.zooming}) {
    if ((_zoomScale - toScale).abs() < 0.01 &&
        (_zoomOffset - toOffset).distance < 1) {
      if (_currentState != finalState)
        setState(() => _currentState = finalState);
      return;
    }
    setState(() {
      _currentState = ViewerState.animating;
    });
    _zoomAnimationOffset = Tween<Offset>(begin: _zoomOffset, end: toOffset)
        .animate(CurvedAnimation(
            parent: _zoomAnimationController, curve: Curves.easeOut));
    _zoomAnimationScale = Tween<double>(begin: _zoomScale, end: toScale)
        .animate(CurvedAnimation(
            parent: _zoomAnimationController, curve: Curves.easeOut));
    _zoomAnimationController.forward().whenComplete(() {
      setState(() {
        _zoomScale = toScale;
        _zoomOffset = toOffset;
        _currentState = finalState;
      });
      _zoomAnimationController.reset();
    });
  }

  void _runDragSnapBackAnimation() {
    setState(() {
      _currentState = ViewerState.animating;
    });
    _dragAnimationOffset = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _dragAnimationController, curve: Curves.easeOut));
    _dragAnimationScale = Tween<double>(begin: _dragScale, end: 1.0).animate(
        CurvedAnimation(
            parent: _dragAnimationController, curve: Curves.easeOut));
    _dragAnimationController.forward().whenComplete(() {
      if (_currentState == ViewerState.animating) {
        setState(() {
          _dragOffset = Offset.zero;
          _dragScale = 1.0;
          _currentState = ViewerState.idle;
        });
      }
      _dragAnimationController.reset();
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
                  .withAlpha((_dragScale.clamp(0.4, 1.0) * 255).toInt())),
          GestureDetector(
            onTap: () {
              if (_currentState == ViewerState.idle)
                Navigator.of(context).pop();
            },
            onDoubleTapDown: (details) {
              _doubleTapDetails = details;
            },
            onDoubleTap: _onDoubleTap,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onScaleEnd: _onScaleEnd,
            child: AnimatedBuilder(
              animation: Listenable.merge(
                  [_dragAnimationController, _zoomAnimationController]),
              builder: (context, child) {
                final currentDragOffset = _dragAnimationController.isAnimating
                    ? _dragAnimationOffset.value
                    : _dragOffset;
                final currentDragScale = _dragAnimationController.isAnimating
                    ? _dragAnimationScale.value
                    : _dragScale;
                final currentZoomOffset = _zoomAnimationController.isAnimating
                    ? _zoomAnimationOffset.value
                    : _zoomOffset;
                final currentZoomScale = _zoomAnimationController.isAnimating
                    ? _zoomAnimationScale.value
                    : _zoomScale;

                return Transform.translate(
                  offset: currentDragOffset,
                  child: Transform.scale(
                    scale: currentDragScale,
                    child: Transform.translate(
                      offset: currentZoomOffset,
                      child: Transform.scale(
                        scale: currentZoomScale,
                        alignment: Alignment.center,
                        child: child,
                      ),
                    ),
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
    final isPageViewLocked = _currentState != ViewerState.idle;
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          physics: isPageViewLocked
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          itemCount: widget.imageSources.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final Widget imageContent = Center(
              child: Image.network(
                widget.imageSources[index],
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            );
            final bool isHeroActive =
                (_currentState == ViewerState.idle) || (index == _currentIndex);
            if (isHeroActive) {
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
                child: imageContent,
              );
            } else {
              return imageContent;
            }
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 0,
          right: 0,
          child: Visibility(
            visible: _currentState == ViewerState.idle,
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
