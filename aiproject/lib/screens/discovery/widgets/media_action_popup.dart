import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/widgets/ljn_app_network_image.dart'; // 确保这个路径是正确的

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
    const horizontalPadding = 20.0;
    final popupWidth = screenSize.width - (horizontalPadding * 2);
    final imageDisplayHeight = popupWidth / widget.aspectRatio;
    final maxHeight = screenSize.height * 0.75;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: popupWidth,
                              height: imageDisplayHeight > maxHeight
                                  ? maxHeight - 66
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
                              color: Colors.white,
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
    const double itemHeight = 36.0;
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: _showSpeedMenu ? 1.0 : 0.0,
        child: IgnorePointer(
          ignoring: !_showSpeedMenu,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final speedBtnKey = _buttonKeys[MediaAction.speed];
              if (speedBtnKey?.currentContext == null)
                return const SizedBox.shrink();
              final renderBox =
                  speedBtnKey!.currentContext!.findRenderObject() as RenderBox;
              final position = renderBox.localToGlobal(Offset.zero,
                  ancestor: context.findRenderObject());
              return Stack(
                children: [
                  Positioned(
                    left:
                        position.dx + (renderBox.size.width / 2) - 30, // 菜单宽度60
                    // 【核心修复】计算 top 值，让 x1 与原图标重叠
                    // 原图标的 top 是 position.dy
                    // 菜单总高 3 * itemHeight，x1 在最下面
                    // 我们需要把菜单向上移动 2 * itemHeight 的距离
                    top: position.dy - (itemHeight * 2),
                    child: _buildSpeedSelector(),
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

    // 【核心修复】当是倍速按钮时，用 AnimatedOpacity 包裹
    if (action == MediaAction.speed) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        // 当二级菜单显示时，隐藏这个图标
        opacity: _showSpeedMenu ? 0.0 : 1.0,
        child: Container(
          key: _buttonKeys[action],
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
              color: isActive ? Colors.red : Colors.grey[800], size: 28),
        ),
      );
    }

    // 其他按钮保持不变
    return Container(
      key: _buttonKeys[action],
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child:
          Icon(icon, color: isActive ? Colors.red : Colors.grey[800], size: 28),
    );
  }

  Widget _buildSpeedSelector() {
    const double itemHeight = 36.0;
    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // 【UI 修复】将顺序反转，让 x1 在最下面
        children: [3.0, 2.0, 1.0].map((speed) {
          final bool isSelected = _activeSpeed == speed && _showSpeedMenu;
          return Container(
            key: _speedButtonKeys[speed],
            width: double.infinity,
            height: itemHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isSelected ? Colors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "x${speed.toInt()}",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
