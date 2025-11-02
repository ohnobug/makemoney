// G:\t\detection\aiproject\lib\screens\user\video_viewer\viga_video_viewer_page.dart

import 'package:flutter/material.dart';
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
  final Rect initialRect;

  const VigaVideoViewerPage({
    super.key,
    required this.videoSources,
    required this.initialIndex,
    required this.initialRect,
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

  // --- 视频播放器 ---
  late VideoPlayerController _videoController;
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

    // 初始化视频播放器
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoSources[_currentIndex]),
    );

    _videoController.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController.play();
        _videoController.setLooping(true);
      }
    }).catchError((error) {
      // Video initialization error handling
    });
  }

  void _disposeVideoController() {
    _videoController.pause();
    _videoController.dispose();
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
    _disposeVideoController();
    super.dispose();
  }

  // --- 手势处理 ---
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
        Navigator.of(context).pop();
      } else {
        _runDragSnapBackAnimation();
      }
    } else if (_currentState == VideoViewerState.zooming) {
      if (_zoomScale < 1.0) {
        _runZoomAnimation(
            toScale: 1.0, toOffset: Offset.zero, finalState: VideoViewerState.idle);
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
    if (_doubleTapDetails == null || _currentState == VideoViewerState.dragging) {
      return;
    }
    if (_zoomScale > 1.0) {
      _runZoomAnimation(
          toScale: 1.0, toOffset: Offset.zero, finalState: VideoViewerState.idle);
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
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);
    final viewport = Rect.fromLTRB(_zoomPadding, _zoomPadding,
        screenSize.width - _zoomPadding, screenSize.height - _zoomPadding);

    // 获取视频的实际宽高比
    final videoAspectRatio = _videoController.value.aspectRatio;
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

  // --- 动画 ---
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
    setState(() {
      _currentState = VideoViewerState.animating;
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
      _currentState = VideoViewerState.animating;
    });
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
                if (_currentState == VideoViewerState.animating) return;

                // 在 idle 状态下，任何单击都应立即关闭
                if (_currentState == VideoViewerState.idle) {
                  Navigator.of(context).pop();
                  return;
                }

                // 在 zooming 状态下，单击图片恢复
                if (_currentState == VideoViewerState.zooming) {
                  _runZoomAnimation(
                    toScale: 1.0,
                    toOffset: Offset.zero,
                    finalState: VideoViewerState.idle,
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
        _currentState != VideoViewerState.idle || _pointerCount > 1;
    return Stack(
      children: [
        PageView.builder(
          key: _pageViewKey,
          controller: _pageController,
          physics: isPageViewLocked
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          itemCount: widget.videoSources.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
            _disposeVideoController();
            _initializeVideoPlayer();
          },
          itemBuilder: (context, index) {
            final Widget videoWidget = _VideoPlayerWidget(
              videoController: _videoController,
              isInitialized: _isVideoInitialized,
              showControls: _showVideoControls,
              onTap: _toggleVideoControls,
            );

            final bool isHeroActive = !_isPageScrolling &&
                ((_currentState == VideoViewerState.idle &&
                        index == _currentIndex) ||
                    (_currentState == VideoViewerState.dragging &&
                        index == _currentIndex));

            if (isHeroActive) {
              return Hero(
                tag: widget.videoSources[index],
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  flightDirection,
                  fromHeroContext,
                  toHeroContext,
                ) {
                  final toHero = toHeroContext.widget as Hero;
                  if (flightDirection == HeroFlightDirection.pop) {
                    return Container(
                      width: widget.initialRect.width,
                      height: widget.initialRect.height,
                      color: Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: widget.initialRect.width / 4,
                        ),
                      ),
                    );
                  }
                  return toHero.child;
                },
                child: videoWidget,
              );
            } else {
              return videoWidget;
            }
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

class _VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoController;
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
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Center(
            child: widget.isInitialized
                ? AspectRatio(
                    aspectRatio: widget.videoController.value.aspectRatio,
                    child: VideoPlayer(widget.videoController),
                  )
                : const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
          ),
          if (widget.showControls && widget.isInitialized)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _VideoProgressBar(widget.videoController),
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
  void deactivate() {
    controller.removeListener(_updateState);
    super.deactivate();
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
      onTapDown: (TapDownDetails details) {
        if (!controller.value.isInitialized) return;
        _controllerWasPlaying = controller.value.isPlaying;
        if (_controllerWasPlaying) {
          controller.pause();
        }
      },
      onTapUp: (TapUpDetails details) {
        if (!controller.value.isInitialized) return;
        if (_controllerWasPlaying) {
          controller.play();
        }
      },
      onTapCancel: () {
        if (!controller.value.isInitialized) return;
        if (_controllerWasPlaying) {
          controller.play();
        }
      },
      onHorizontalDragStart: (DragStartDetails details) {
        if (!controller.value.isInitialized) return;
        _controllerWasPlaying = controller.value.isPlaying;
        controller.pause();
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (!controller.value.isInitialized) return;
        _seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_controllerWasPlaying) {
          controller.play();
        }
        _controllerWasPlaying = false;
      },
      child: Container(
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(77), // ~30% opacity
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (controller.value.isInitialized)
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                width: controller.value.duration.inMilliseconds > 0
                    ? (controller.value.position.inMilliseconds /
                            controller.value.duration.inMilliseconds) *
                        (MediaQuery.of(context).size.width - 40)
                    : 0,
              ),
            Positioned(
              left: controller.value.duration.inMilliseconds > 0
                  ? (controller.value.position.inMilliseconds /
                          controller.value.duration.inMilliseconds) *
                      (MediaQuery.of(context).size.width - 40)
                  : 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
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