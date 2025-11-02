// G:\t\detection\aiproject\lib\screens\discovery\widgets\media_action_popup.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

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
  File? _cachedImageFile;
  bool _isImageLoading = false;

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
    // 【修复】延迟执行所有初始化操作，避免在初始化时阻塞微任务队列
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
      } else {
        // 【优化】从缓存获取图片文件，避免重新下载
        _loadCachedImage();
      }
    });
  }

  Future<void> _loadCachedImage() async {
    if (_isImageLoading) return;

    setState(() {
      _isImageLoading = true;
    });

    try {
      final fileInfo = await DefaultCacheManager()
          .getFileFromCache(widget.mediaUrl);

      if (fileInfo != null && mounted) {
        setState(() {
          _cachedImageFile = fileInfo.file;
          _isImageLoading = false;
        });
      } else {
        // 如果缓存中没有，预下载到缓存
        final file = await DefaultCacheManager().getSingleFile(widget.mediaUrl);
        if (mounted) {
          setState(() {
            _cachedImageFile = file;
            _isImageLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isImageLoading = false;
        });
      }
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

    // 【修复】添加防抖逻辑，避免在长按移动时频繁调用 setState
    final bool needsUpdate = newAction != _activeAction ||
        newSpeed != _activeSpeed ||
        shouldShowSpeedMenu != _showSpeedMenu;

    if (needsUpdate && mounted) {
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
    final horizontalPadding = 32.0.w;
    final popupWidth = 750.w - (horizontalPadding * 2);
    final imageDisplayHeight = popupWidth / widget.aspectRatio;

    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      final maxHeight = systemState.screenSize.height -
          systemState.appbarHeight -
          systemState.statusHeight;

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
                                    ? maxHeight - 100.w
                                    : imageDisplayHeight,
                                child: widget.isVideo
                                    ? (_videoController?.value.isInitialized ??
                                            false
                                        ? VideoPlayer(_videoController!)
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ))
                                    : _buildImageContent(),
                              ),
                              Container(
                                height: 100.w,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildActionButton(
                                      MediaAction.like,
                                      Icons.favorite,
                                    ),
                                    if (widget.isVideo)
                                      _buildActionButton(
                                        MediaAction.speed,
                                        Icons.fast_forward,
                                      ),
                                    _buildActionButton(
                                      MediaAction.favorite,
                                      Icons.star,
                                    ),
                                    _buildActionButton(
                                      MediaAction.download,
                                      Icons.download,
                                    ),
                                    _buildActionButton(
                                      MediaAction.share,
                                      Icons.reply,
                                    ),
                                    _buildActionButton(
                                      MediaAction.viewHomepage,
                                      Icons.person,
                                    ),
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
    });
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

  Widget _buildImageContent() {
    // 【优化】优先使用缓存文件，避免重新下载
    if (_cachedImageFile != null && _cachedImageFile!.existsSync()) {
      return Image.file(
        _cachedImageFile!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // 如果缓存文件有问题，回退到网络图片
          return VigaAppNetworkImage(
            imageUrl: widget.mediaUrl,
            fit: BoxFit.cover,
          );
        },
      );
    }

    // 如果还在加载中，显示加载指示器
    if (_isImageLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 最后回退到网络图片
    return VigaAppNetworkImage(
      imageUrl: widget.mediaUrl,
      fit: BoxFit.cover,
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
