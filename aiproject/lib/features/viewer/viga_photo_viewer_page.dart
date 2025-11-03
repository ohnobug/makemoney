// G:\t\detection\aiproject\lib\screens\user\photo_viewer\viga_photo_viewer_page.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

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
  final String? heroTagPrefix;

  const VigaPhotoViewerPage({
    super.key,
    required this.imageSources,
    required this.initialIndex,
    required this.initialRect,
    this.heroTagPrefix,
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
  final Map<int, Size> _imageSizes = {};
  bool _isPageScrolling = false;
  int _pointerCount = 0;

  // --- 手势临时变量 ---
  Offset _startingFocalPoint = Offset.zero;
  double _initialZoomScale = 1.0;
  Offset _initialZoomOffset = Offset.zero;
  TapDownDetails? _doubleTapDetails;

  // --- 常量 ---
  final double _doubleTapZoomScale = 1.5;
  final double _maxZoomScale = 2.0;
  final double _zoomPadding = 30.0;

  final GlobalKey _pageViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _dragAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50));
    _zoomAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    final isScrolling =
        _pageController.page != _pageController.page?.roundToDouble();
    if (isScrolling != _isPageScrolling) {
      setState(() {
        _isPageScrolling = isScrolling;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    _dragAnimationController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }

  // --- 手势处理 ---
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
        context.pop();
      } else {
        _runDragSnapBackAnimation();
      }
    } else if (_currentState == ViewerState.zooming) {
      if (_zoomScale < 1.0) {
        _runZoomAnimation(
            toScale: 1.0, toOffset: Offset.zero, finalState: ViewerState.idle);
      } else if (_zoomScale > _maxZoomScale) {
        final clampedOffset = _getClampedOffset(_zoomOffset, _maxZoomScale);
        _runZoomAnimation(toScale: _maxZoomScale, toOffset: clampedOffset);
      } else {
        final clampedOffset = _getClampedOffset(_zoomOffset, _zoomScale);
        _runZoomAnimation(toScale: _zoomScale, toOffset: clampedOffset);
      }
    }
  }

  void _onDoubleTap() {
    if (_doubleTapDetails == null || _currentState == ViewerState.dragging) {
      return;
    }
    if (_zoomScale > 1.0) {
      _runZoomAnimation(
          toScale: 1.0, toOffset: Offset.zero, finalState: ViewerState.idle);
    } else {
      final tapPosition = _doubleTapDetails!.localPosition;
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

  Offset _getClampedOffset(Offset offset, double scale) {
    final screenSize = MediaQuery.of(context).size;
    final imageNaturalSize = _imageSizes[_currentIndex] ?? const Size(1, 1);
    final aspectRatio = imageNaturalSize.width / imageNaturalSize.height;
    final imageRenderSize =
        Size(screenSize.width, screenSize.width / aspectRatio);
    final scaledImageWidth = imageRenderSize.width * scale;
    final scaledImageHeight = imageRenderSize.height * scale;
    final viewport = Rect.fromLTRB(_zoomPadding, _zoomPadding,
        screenSize.width - _zoomPadding, screenSize.height - _zoomPadding);
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);
    final imageCenter = screenCenter + offset;
    final imageRect = Rect.fromCenter(
        center: imageCenter,
        width: scaledImageWidth,
        height: scaledImageHeight);
    double dxCorrection = 0.0;
    if (scaledImageWidth > viewport.width) {
      if (imageRect.left > viewport.left) {
        dxCorrection = viewport.left - imageRect.left;
      } else if (imageRect.right < viewport.right) {
        dxCorrection = viewport.right - imageRect.right;
      }
    } else {
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
      if (_currentState != finalState) {
        setState(() => _currentState = finalState);
      }
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
          Listener(
            onPointerDown: (_) => setState(() => _pointerCount++),
            onPointerUp: (_) => setState(() => _pointerCount = 0),
            child: GestureDetector(
              onTapUp: (details) {
                if (_currentState == ViewerState.animating) return;

                // 在 idle 状态下，任何单击都应立即关闭
                if (_currentState == ViewerState.idle) {
                  context.pop();
                  return;
                }

                // 在 zooming 状态下，单击图片恢复
                if (_currentState == ViewerState.zooming) {
                  _runZoomAnimation(
                    toScale: 1.0,
                    toOffset: Offset.zero,
                    finalState: ViewerState.idle,
                  );
                }
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
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    final bool isPageViewLocked =
        _currentState != ViewerState.idle || _pointerCount > 1;
    return Stack(
      children: [
        PageView.builder(
          key: _pageViewKey, // 使用 Key
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
            final Widget imageWidget = _ImageWithSizeProvider(
              imageUrl: widget.imageSources[index],
              onSizeAvailable: (size) {
                if (mounted && _imageSizes[index] != size) {
                  setState(() {
                    _imageSizes[index] = size;
                  });
                }
              },
            );

            final bool isHeroActive = !_isPageScrolling &&
                ((_currentState == ViewerState.idle &&
                        index == _currentIndex) ||
                    (_currentState == ViewerState.dragging &&
                        index == _currentIndex));

            if (isHeroActive) {
              return Hero(
                tag: '${widget.heroTagPrefix ?? ''}_${widget.imageSources[index]}',
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
                child: imageWidget,
              );
            } else {
              return imageWidget;
            }
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: _currentState == ViewerState.idle && !_isPageScrolling
                ? 1.0
                : 0.0,
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

class _ImageWithSizeProvider extends StatefulWidget {
  final String imageUrl;
  final ValueChanged<Size> onSizeAvailable;

  const _ImageWithSizeProvider({
    required this.imageUrl,
    required this.onSizeAvailable,
  });

  @override
  _ImageWithSizeProviderState createState() => _ImageWithSizeProviderState();
}

class _ImageWithSizeProviderState extends State<_ImageWithSizeProvider> {
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(_ImageWithSizeProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl) {
      _resolveImage();
    }
  }

  void _resolveImage() {
    _imageStreamListener = ImageStreamListener(_handleImageFrame);
    final imageProvider = NetworkImage(widget.imageUrl);
    _imageStream =
        imageProvider.resolve(createLocalImageConfiguration(context));
    _imageStream?.addListener(_imageStreamListener!);
  }

  void _handleImageFrame(ImageInfo imageInfo, bool synchronousCall) {
    final size = Size(
        imageInfo.image.width.toDouble(), imageInfo.image.height.toDouble());

    // 使用 addPostFrameCallback 确保 setState 在构建完成后调用
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSizeAvailable(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
        widget.imageUrl,
        width: double.infinity,
        fit: BoxFit.fitWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_imageStreamListener != null) {
      _imageStream?.removeListener(_imageStreamListener!);
    }
    super.dispose();
  }
}
