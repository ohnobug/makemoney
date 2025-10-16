// G:\t\detection\aiproject\lib\screens\discovery\widgets\media_action_popup.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_app_network_image.dart';

// 枚举保持不变
enum MediaAction { like, speed, favorite, download, share, viewHomepage, none }

class MediaActionPopup extends StatefulWidget {
  final bool isVideo;
  final String mediaUrl;
  final double aspectRatio;

  const MediaActionPopup({
    super.key,
    required this.isVideo,
    required this.mediaUrl,
    required this.aspectRatio,
  });

  @override
  MediaActionPopupState createState() => MediaActionPopupState();
}

class MediaActionPopupState extends State<MediaActionPopup> {
  VideoPlayerController? _videoController;
  MediaAction _activeAction = MediaAction.none;
  double _activeSpeed = 1.0;
  bool _showSpeedMenu = false;

  final Map<MediaAction, GlobalKey> _buttonKeys = {
    MediaAction.like: GlobalKey(),
    MediaAction.speed: GlobalKey(),
    MediaAction.favorite: GlobalKey(),
    MediaAction.download: GlobalKey(),
    MediaAction.share: GlobalKey(),
    MediaAction.viewHomepage: GlobalKey(),
  };
  final Map<double, GlobalKey> _speedButtonKeys = {
    1.0: GlobalKey(),
    2.0: GlobalKey(),
    3.0: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(widget.mediaUrl))
            ..initialize().then((_) {
              if (mounted) {
                setState(() {});
                _videoController?.setLooping(true);
                _videoController?.play();
              }
            });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  MediaAction getActiveAction() => _activeAction;

  void updateActiveButton(Offset globalPosition) {
    MediaAction newAction = MediaAction.none;
    double newSpeed = 1.0;
    bool isOverSpeedMenu = false;

    if (_showSpeedMenu) {
      for (var entry in _speedButtonKeys.entries) {
        final key = entry.value;
        if (key.currentContext != null) {
          final renderBox = key.currentContext!.findRenderObject() as RenderBox;
          final rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
          if (rect.contains(globalPosition)) {
            newSpeed = entry.key;
            isOverSpeedMenu = true;
            break;
          }
        }
      }
    }

    if (!isOverSpeedMenu) {
      for (var entry in _buttonKeys.entries) {
        final key = entry.value;
        if (key.currentContext != null) {
          final renderBox = key.currentContext!.findRenderObject() as RenderBox;
          final rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
          if (rect.contains(globalPosition)) {
            newAction = entry.key;
            break;
          }
        }
      }
    }

    final bool shouldShowSpeedMenu =
        newAction == MediaAction.speed || isOverSpeedMenu;
    if (newAction != _activeAction ||
        newSpeed != _activeSpeed ||
        shouldShowSpeedMenu != _showSpeedMenu) {
      setState(() {
        _activeAction = isOverSpeedMenu ? MediaAction.none : newAction;
        _activeSpeed = shouldShowSpeedMenu ? newSpeed : 1.0;
        _showSpeedMenu = shouldShowSpeedMenu;
        _videoController?.setPlaybackSpeed(_activeSpeed);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = 32.0.w;
    final popupWidth = 750.w - (horizontalPadding * 2);
    final imageDisplayHeight = popupWidth / widget.aspectRatio;
    final maxHeight = screenSize.height * 0.75;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black.withAlpha(102),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: popupWidth,
                              height: imageDisplayHeight > maxHeight
                                  ? maxHeight - 90.w
                                  : imageDisplayHeight,
                              child: widget.isVideo
                                  ? (_videoController?.value.isInitialized ??
                                          false
                                      ? VideoPlayer(_videoController!)
                                      : const Center(
                                          child: CircularProgressIndicator()))
                                  : LJNAppNetworkImage(
                                      imageUrl: widget.mediaUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Container(
                              height: 90.w,
                              color: Colors.white,
                              padding: EdgeInsets.all(5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildActionButton(
                                      MediaAction.like, Icons.favorite),
                                  if (widget.isVideo)
                                    _buildActionButton(
                                        MediaAction.speed, Icons.fast_forward),
                                  _buildActionButton(
                                      MediaAction.favorite, Icons.star),
                                  _buildActionButton(
                                      MediaAction.download, Icons.download),
                                  _buildActionButton(
                                      MediaAction.share, Icons.reply),
                                  _buildActionButton(
                                      MediaAction.viewHomepage, Icons.person),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.isVideo) _buildSpeedMenuOverlay(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedMenuOverlay() {
    final itemHeight = 70.0.w;
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: _showSpeedMenu ? 1.0 : 0.0,
        child: IgnorePointer(
          ignoring: !_showSpeedMenu,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final speedBtnKey = _buttonKeys[MediaAction.speed];
              if (speedBtnKey?.currentContext == null) {
                return const SizedBox.shrink();
              }
              final renderBox =
                  speedBtnKey!.currentContext!.findRenderObject() as RenderBox;
              final position = renderBox.localToGlobal(Offset.zero,
                  ancestor: context.findRenderObject());
              return Stack(
                children: [
                  Positioned(
                    left: position.dx + (renderBox.size.width / 2) - 30.w,
                    top: position.dy - (itemHeight * 2),
                    child: _buildSpeedSelector(itemHeight),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(MediaAction action, IconData icon) {
    final bool isActive = _activeAction == action;

    if (action == MediaAction.speed) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: _showSpeedMenu ? 0.0 : 1.0,
        child: Container(
          key: _buttonKeys[action],
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.red : Colors.grey[800],
            size: 50.w,
          ),
        ),
      );
    }

    return Container(
      key: _buttonKeys[action],
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.grey[200],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey[800],
        size: 50.w,
      ),
    );
  }

  Widget _buildSpeedSelector(double itemHeight) {
    return Container(
      width: 70.w,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [3.0, 2.0, 1.0].map((speed) {
          final bool isSelected = _activeSpeed == speed && _showSpeedMenu;
          return Container(
            key: _speedButtonKeys[speed],
            width: double.infinity,
            height: itemHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.red : Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "x${speed.toInt()}",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32.w,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
