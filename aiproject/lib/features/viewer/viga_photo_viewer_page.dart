// G:\t\detection\aiproject\lib\screens\user\photo_viewer\viga_photo_viewer_page.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

enum ViewerState {
  idle,
  dragging,
  animating,
  zooming,
}

class VigaPhotoViewerPage extends StatefulWidget {
  final List<String> imageSources;
  final int initialIndex;
  // *** 关键修正：恢复 heroTagPrefix 参数 ***
  final String? heroTagPrefix;

  const VigaPhotoViewerPage({
    super.key,
    required this.imageSources,
    required this.initialIndex,
    this.heroTagPrefix,
  });

  @override
  State<VigaPhotoViewerPage> createState() => _VigaPhotoViewerPageState();
}

class _VigaPhotoViewerPageState extends State<VigaPhotoViewerPage>
    with TickerProviderStateMixin {
  // ... (所有其他代码，如控制器、状态、手势处理等，都与上一轮的最终版本完全相同) ...
  // ... (为避免重复，此处省略) ...
  // --- 控制器 ---
  late PageController _pageController;
  late AnimationController _dragAnimationController;
  late AnimationController _zoomAnimationController;
  late AnimationController _backgroundAnimationController;

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
    _backgroundAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _pageController.addListener(_onPageScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _backgroundAnimationController.forward();
    });
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
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  // --- 手势处理 (逻辑保持不变) ---
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

  // --- 动画 (逻辑保持不变) ---
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
      body: AnimatedBuilder(
        animation: _backgroundAnimationController,
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: Color.fromRGBO(
                  0,
                  0,
                  0,
                  _currentState == ViewerState.dragging
                      ? _dragScale
                      : _backgroundAnimationController.value.clamp(0.0, 1.0),
                ),
              ),
              child!,
            ],
          );
        },
        child: Listener(
          onPointerDown: (_) => setState(() => _pointerCount++),
          onPointerUp: (_) => setState(() => _pointerCount = 0),
          child: GestureDetector(
            onTapUp: (details) {
              if (_currentState == ViewerState.animating) return;
              if (_currentState == ViewerState.idle) {
                context.pop();
                return;
              }
              if (_currentState == ViewerState.zooming) {
                _runZoomAnimation(
                  toScale: 1.0,
                  toOffset: Offset.zero,
                  finalState: ViewerState.idle,
                );
              }
            },
            onDoubleTapDown: (details) => _doubleTapDetails = details,
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
      ),
    );
  }

  Widget _buildPageView() {
    final bool isPageViewLocked =
        _currentState != ViewerState.idle || _pointerCount > 1;
    return Stack(
      children: [
        PageView.builder(
          key: _pageViewKey,
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
            final imageUrl = widget.imageSources[index];
            final imageWidget = _ImageWithSizeProvider(
              imageUrl: imageUrl,
              onSizeAvailable: (size) {
                if (mounted && _imageSizes[index] != size) {
                  setState(() {
                    _imageSizes[index] = size;
                  });
                }
              },
            );

            final heroTag = '${widget.heroTagPrefix ?? ''}_$imageUrl';

            return Hero(
              tag: heroTag,
              child: imageWidget,
            );
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

// _ImageWithSizeProvider 保持不变
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onSizeAvailable(size);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VigaAppNetworkImage(
        imageUrl: widget.imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
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
