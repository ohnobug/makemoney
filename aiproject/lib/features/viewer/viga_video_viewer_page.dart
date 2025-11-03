// G:\t\detection\aiproject\lib\screens\user\video_viewer\viga_video_viewer_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

enum VideoViewerState {
  idle,
  dragging,
  animating,
  zooming,
}

class VigaVideoViewerPage extends StatefulWidget {
  final List<String> videoSources;
  final int initialIndex;
  final String? heroTagPrefix;

  const VigaVideoViewerPage({
    super.key,
    required this.videoSources,
    required this.initialIndex,
    Rect? initialRect,
    this.heroTagPrefix,
  });

  @override
  State<VigaVideoViewerPage> createState() => _VigaVideoViewerPageState();
}

class _VigaVideoViewerPageState extends State<VigaVideoViewerPage>
    with TickerProviderStateMixin {
  // --- 控制器 ---
  late PageController _pageController;
  late AnimationController _dragAnimationController;
  late AnimationController _zoomAnimationController;
  // ADDED: Controller for smooth background fade-in.
  late AnimationController _backgroundAnimationController;

  // --- 视频播放器 ---
  // CHANGED: Made nullable for safer lifecycle management.
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _showVideoControls = false;

  // --- 状态 ---
  late int _currentIndex;
  VideoViewerState _currentState = VideoViewerState.idle;
  Offset _dragOffset = Offset.zero;
  double _dragScale = 1.0;
  double _zoomScale = 1.0;
  Offset _zoomOffset = Offset.zero;
  late Animation<Offset> _dragAnimationOffset;
  late Animation<double> _dragAnimationScale;
  late Animation<Offset> _zoomAnimationOffset;
  late Animation<double> _zoomAnimationScale;
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

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _dragAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50));
    _zoomAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 80));
    // ADDED: Initialize background controller.
    _backgroundAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _pageController.addListener(_onPageScroll);

    // ADDED: Start the background fade-in animation.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _backgroundAnimationController.forward();
    });

    _initializeVideoPlayer(_currentIndex);
  }

  // CHANGED: Improved video player lifecycle management.
  void _initializeVideoPlayer(int index) {
    // Ensure the old controller is disposed before creating a new one.
    _disposeVideoController();

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoSources[index]),
    );
    _videoController = controller;

    controller.initialize().then((_) {
      // Check if the widget is still mounted and if this is still the current controller.
      if (mounted && _videoController == controller) {
        setState(() {
          _isVideoInitialized = true;
        });
        controller.play();
        controller.setLooping(true);
      }
    }).catchError((error) {
      if (mounted && _videoController == controller) {
        setState(() {
          _isVideoInitialized = false;
        });
      }
    });
  }

  void _disposeVideoController() {
    if (_videoController != null) {
      _videoController!.pause();
      _videoController!.dispose();
      _videoController = null;
      _isVideoInitialized = false;
    }
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
    _backgroundAnimationController.dispose(); // ADDED
    _disposeVideoController();
    super.dispose();
  }

  // --- 手势处理 (逻辑基本保持不变) ---
  void _onScaleStart(ScaleStartDetails details) {
    _dragAnimationController.stop();
    _zoomAnimationController.stop();
    _startingFocalPoint = details.focalPoint;
    _initialZoomScale = _zoomScale;
    _initialZoomOffset = _zoomOffset;
    if (_currentState == VideoViewerState.idle) {
      if (details.pointerCount > 1) {
        setState(() => _currentState = VideoViewerState.zooming);
      } else {
        setState(() => _currentState = VideoViewerState.dragging);
      }
    } else if (_currentState == VideoViewerState.zooming ||
        _currentState == VideoViewerState.animating) {
      setState(() => _currentState = VideoViewerState.zooming);
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (_currentState == VideoViewerState.dragging) {
      _dragOffset = details.focalPoint - _startingFocalPoint;
      final vDrag = _dragOffset.dy.abs();
      final screenH = MediaQuery.of(context).size.height;
      _dragScale = 1.0 - (vDrag / (screenH / 2)).clamp(0.0, 0.6);
      setState(() {});
    } else if (_currentState == VideoViewerState.zooming) {
      _zoomScale = math.max(0.5, _initialZoomScale * details.scale);
      _zoomOffset =
          _initialZoomOffset + (details.focalPoint - _startingFocalPoint);
      setState(() {});
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (_currentState == VideoViewerState.dragging) {
      if (_dragScale < 0.8) {
        context.pop();
      } else {
        _runDragSnapBackAnimation();
      }
    } else if (_currentState == VideoViewerState.zooming) {
      if (_zoomScale < 1.0) {
        _runZoomAnimation(
            toScale: 1.0,
            toOffset: Offset.zero,
            finalState: VideoViewerState.idle);
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
    if (_doubleTapDetails == null ||
        _currentState == VideoViewerState.dragging) {
      return;
    }
    if (_zoomScale > 1.0) {
      _runZoomAnimation(
          toScale: 1.0,
          toOffset: Offset.zero,
          finalState: VideoViewerState.idle);
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
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return offset;
    }
    final screenSize = MediaQuery.of(context).size;
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);
    final viewport = Rect.fromLTRB(_zoomPadding, _zoomPadding,
        screenSize.width - _zoomPadding, screenSize.height - _zoomPadding);
    final videoAspectRatio = _videoController!.value.aspectRatio;
    final imageRenderSize = videoAspectRatio > 1.0
        ? Size(screenSize.width, screenSize.width / videoAspectRatio)
        : Size(screenSize.height * videoAspectRatio, screenSize.height);
    double dxCorrection = 0.0;
    double dyCorrection = 0.0;
    final imageCenter = screenCenter + offset;
    final imageRect = Rect.fromCenter(
        center: imageCenter,
        width: imageRenderSize.width * scale,
        height: imageRenderSize.height * scale);
    if (imageRenderSize.width * scale > viewport.width) {
      if (imageRect.left > viewport.left) {
        dxCorrection = viewport.left - imageRect.left;
      } else if (imageRect.right < viewport.right) {
        dxCorrection = viewport.right - imageRect.right;
      }
    } else {
      dxCorrection = screenCenter.dx - imageCenter.dx;
    }
    if (imageRenderSize.height * scale > viewport.height) {
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

  // --- 动画 (逻辑基本保持不变) ---
  void _runZoomAnimation(
      {required double toScale,
      required Offset toOffset,
      VideoViewerState finalState = VideoViewerState.zooming}) {
    if ((_zoomScale - toScale).abs() < 0.01 &&
        (_zoomOffset - toOffset).distance < 1) {
      if (_currentState != finalState) {
        setState(() => _currentState = finalState);
      }
      return;
    }
    setState(() => _currentState = VideoViewerState.animating);
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
    setState(() => _currentState = VideoViewerState.animating);
    _dragAnimationOffset = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _dragAnimationController, curve: Curves.easeOut));
    _dragAnimationScale = Tween<double>(begin: _dragScale, end: 1.0).animate(
        CurvedAnimation(
            parent: _dragAnimationController, curve: Curves.easeOut));
    _dragAnimationController.forward().whenComplete(() {
      if (_currentState == VideoViewerState.animating) {
        setState(() {
          _dragOffset = Offset.zero;
          _dragScale = 1.0;
          _currentState = VideoViewerState.idle;
        });
      }
      _dragAnimationController.reset();
    });
  }

  void _toggleVideoControls() {
    setState(() {
      _showVideoControls = !_showVideoControls;
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
                  _currentState == VideoViewerState.dragging
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
              if (_currentState == VideoViewerState.animating) return;
              // CHANGED: Single tap now toggles controls, not dismisses.
              if (_currentState == VideoViewerState.idle) {
                _toggleVideoControls();
                return;
              }
              if (_currentState == VideoViewerState.zooming) {
                _runZoomAnimation(
                  toScale: 1.0,
                  toOffset: Offset.zero,
                  finalState: VideoViewerState.idle,
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
        _currentState != VideoViewerState.idle || _pointerCount > 1;
    return Stack(
      children: [
        PageView.builder(
          // REMOVED: Key is not strictly necessary here.
          controller: _pageController,
          physics: isPageViewLocked
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          itemCount: widget.videoSources.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              _isVideoInitialized = false; // Reset to show loading indicator
            });
            _initializeVideoPlayer(index);
          },
          itemBuilder: (context, index) {
            final videoUrl = widget.videoSources[index];

            final videoWidget = _VideoPlayerWidget(
              // Only pass the controller if it's for the current page
              videoController: _currentIndex == index ? _videoController : null,
              isInitialized:
                  _currentIndex == index ? _isVideoInitialized : false,
              showControls: _showVideoControls,
              onTap: _toggleVideoControls,
            );

            // *** 关键修正：使用与起始页完全相同的方式生成 tag ***
            final heroTag = '${widget.heroTagPrefix ?? ''}_$videoUrl';

            // CHANGED: Simplified Hero logic.
            // It's now always present to handle entry and exit animations.
            return Hero(
              tag: heroTag,
              child: videoWidget,
            );
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: _currentState == VideoViewerState.idle && !_isPageScrolling
                ? 1.0
                : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Text(
              "${_currentIndex + 1} / ${widget.videoSources.length}",
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

class _VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? videoController;
  final bool isInitialized;
  final bool showControls;
  final VoidCallback onTap;

  const _VideoPlayerWidget({
    required this.videoController,
    required this.isInitialized,
    required this.showControls,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (videoController != null && isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: videoController!.value.aspectRatio,
                child: VideoPlayer(videoController!),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          if (showControls && isInitialized && videoController != null)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _VideoProgressBar(videoController!),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// _VideoProgressBar remains unchanged
class _VideoProgressBar extends StatefulWidget {
  final VideoPlayerController controller;
  const _VideoProgressBar(this.controller);
  @override
  _VideoProgressBarState createState() => _VideoProgressBarState();
}

class _VideoProgressBarState extends State<_VideoProgressBar> {
  bool _controllerWasPlaying = false;
  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(_updateState);
  }

  @override
  void dispose() {
    controller.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  void _seekToRelativePosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final x = globalPosition.dx - box.localToGlobal(Offset.zero).dx;
    final relativePosition = x / box.size.width;
    final position = controller.value.duration * relativePosition;
    controller.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (details) {
        if (!controller.value.isInitialized) return;
        _controllerWasPlaying = controller.value.isPlaying;
        if (_controllerWasPlaying) controller.pause();
      },
      onHorizontalDragUpdate: (details) {
        if (!controller.value.isInitialized) return;
        _seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (details) {
        if (_controllerWasPlaying) controller.play();
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(77),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (controller.value.isInitialized &&
                controller.value.duration.inMilliseconds > 0)
              FractionallySizedBox(
                widthFactor: (controller.value.position.inMilliseconds /
                        controller.value.duration.inMilliseconds)
                    .clamp(0.0, 1.0),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            if (controller.value.isInitialized)
              Padding(
                padding: EdgeInsets.only(
                  left: controller.value.duration.inMilliseconds > 0
                      ? ((controller.value.position.inMilliseconds /
                                  controller.value.duration.inMilliseconds) *
                              (MediaQuery.of(context).size.width - 40))
                          .clamp(
                              0.0, MediaQuery.of(context).size.width - 40 - 12)
                      : 0,
                ),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
