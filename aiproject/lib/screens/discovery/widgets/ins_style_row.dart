import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'media_action_popup.dart';

// 新的数据模型
class MediaItem {
  final bool isVideo;
  final String thumbnailUrl;
  final String mediaUrl;
  MediaItem({
    required this.isVideo,
    required this.thumbnailUrl,
    required this.mediaUrl,
  });
}

// 定义布局类型
enum RowLayoutType { videoFirst, videoMiddle, videoLast }

class InsStyleRow extends StatelessWidget {
  final List<MediaItem> items;
  final RowLayoutType layoutType;
  final bool canPlay; // 【新增】
  final ValueChanged<MediaItem>? onItemTap;
  final ValueChanged<MediaItem>? onCommentTap;
  final bool isCommentPanelOpen;

  const InsStyleRow({
    super.key,
    required this.items,
    required this.layoutType,
    required this.canPlay, // 【新增】
    this.onItemTap,
    this.onCommentTap,
    this.isCommentPanelOpen = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.length != 5) {
      return SizedBox(height: 250.w, child: const Center(child: Text("数据错误")));
    }
    // 【修改】将 canPlay 传递给 _MediaTile
    final bigItem = _MediaTile(
      item: items[0],
      isBig: true,
      canPlay: canPlay,
      onTap: () => onItemTap?.call(items[0]),
      isCommentPanelOpen: isCommentPanelOpen,
    );
    final smallItems1 = Column(children: [
      Expanded(child: _MediaTile(
        item: items[1],
        canPlay: canPlay,
        onTap: () => onItemTap?.call(items[1]),
        isCommentPanelOpen: isCommentPanelOpen,
      )),
      SizedBox(height: 2.w),
      Expanded(child: _MediaTile(
        item: items[2],
        canPlay: canPlay,
        onTap: () => onItemTap?.call(items[2]),
        isCommentPanelOpen: isCommentPanelOpen,
      )),
    ]);
    final smallItems2 = Column(children: [
      Expanded(child: _MediaTile(
        item: items[3],
        canPlay: canPlay,
        onTap: () => onItemTap?.call(items[3]),
        isCommentPanelOpen: isCommentPanelOpen,
      )),
      SizedBox(height: 2.w),
      Expanded(child: _MediaTile(
        item: items[4],
        canPlay: canPlay,
        onTap: () => onItemTap?.call(items[4]),
        isCommentPanelOpen: isCommentPanelOpen,
      )),
    ]);
    final List<Widget> widgets;
    switch (layoutType) {
      case RowLayoutType.videoFirst:
        widgets = [bigItem, smallItems1, smallItems2];
        break;
      case RowLayoutType.videoMiddle:
        widgets = [smallItems1, bigItem, smallItems2];
        break;
      case RowLayoutType.videoLast:
        widgets = [smallItems1, smallItems2, bigItem];
        break;
    }
    return SizedBox(
      height: 500.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: widgets[0]),
          SizedBox(width: 2.w),
          Expanded(child: widgets[1]),
          SizedBox(width: 2.w),
          Expanded(child: widgets[2]),
        ],
      ),
    );
  }
}

class _MediaTile extends StatefulWidget {
  final MediaItem item;
  final bool isBig;
  final bool canPlay;
  final VoidCallback? onTap;

  final bool isCommentPanelOpen;

  const _MediaTile({
    required this.item,
    this.isBig = false,
    required this.canPlay,
    this.onTap,
    required this.isCommentPanelOpen,
  });
  @override
  State<_MediaTile> createState() => _MediaTileState();
}

class _MediaTileState extends State<_MediaTile> {
  OverlayEntry? _overlayEntry;
  final GlobalKey<MediaActionPopupState> _popupKey = GlobalKey();
  double? _realAspectRatio;

  @override
  void initState() {
    super.initState();
    // 【修复】延迟执行所有异步操作，避免在初始化时阻塞微任务队列
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMediaInfo();
      _preloadPopupData();
    });
  }

  Future<void> _fetchMediaInfo() async {
    if (widget.item.isVideo) {
      VideoPlayerController? tempController;
      try {
        tempController =
            VideoPlayerController.networkUrl(Uri.parse(widget.item.mediaUrl));
        await tempController.initialize();
        if (mounted) {
          setState(() {
            _realAspectRatio = tempController?.value.aspectRatio;
          });
        }
      } catch (e) {
        logger.warning("获取视频 '${widget.item.mediaUrl}' 尺寸失败: $e");
        if (mounted) setState(() => _realAspectRatio = 16 / 9);
      } finally {
        await tempController?.dispose();
      }
    } else {
      try {
        final fileInfo = await DefaultCacheManager()
            .getFileFromCache(widget.item.thumbnailUrl);
        if (fileInfo != null) {
          final image =
              await decodeImageFromList(fileInfo.file.readAsBytesSync());
          if (mounted) {
            setState(() {
              _realAspectRatio = image.width / image.height;
            });
          }
        }
      } catch (e) {
        logger.warning("获取图片 '${widget.item.thumbnailUrl}' 尺寸失败: $e");
        if (mounted) setState(() => _realAspectRatio = 1.0);
      }
    }
  }

  void _showOverlay(BuildContext context, double aspectRatio) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return MediaActionPopup(
          key: _popupKey,
          isVideo: widget.item.isVideo,
          mediaUrl: widget.item.mediaUrl,
          aspectRatio: aspectRatio,
        );
      },
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _handleLongPressMoveUpdate(Offset globalPosition) {
    _popupKey.currentState?.updateActiveButton(globalPosition);
  }

  void _handleLongPressEnd() {
    final selectedAction =
        _popupKey.currentState?.getActiveAction() ?? MediaAction.none;
    _removeOverlay();
    if (selectedAction != MediaAction.none) {
      if (selectedAction == MediaAction.viewHomepage) {
        // 导航到作者详情页面
        _navigateToAuthorDetail();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("执行了连贯手势操作: $selectedAction"),
          duration: const Duration(seconds: 1),
        ));
      }
    }
  }

  void _navigateToAuthorDetail() {
    // 生成作者信息（这里使用模拟数据，实际应用中应该从数据源获取）
    final authorId = 'author_${widget.item.thumbnailUrl.hashCode}';
    final authorName = '作者${widget.item.thumbnailUrl.hashCode % 1000}';
    final authorAvatar = 'https://picsum.photos/seed/author_${widget.item.thumbnailUrl.hashCode}/200/200';

    // 导航到作者详情页面
    Navigator.pushNamed(context, '/author/detail', arguments: {
      'author_id': authorId,
      'author_name': authorName,
      'author_avatar': authorAvatar,
    });
  }

  void _handleTap() {
    widget.onTap?.call();
  }

  // 【优化】预加载弹出框数据
  void _preloadPopupData() {
    if (!widget.item.isVideo) {
      // 对于图片，预加载到缓存中（忽略任何错误）
      try {
        DefaultCacheManager().getSingleFile(widget.item.mediaUrl);
      } catch (_) {
        // 忽略预加载错误
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        LongPressGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
          () => LongPressGestureRecognizer(
              duration: const Duration(milliseconds: 250)),
          (LongPressGestureRecognizer instance) {
            instance.onLongPressStart = (details) {
              final aspectRatioToShow = _realAspectRatio ?? 1.0;
              _showOverlay(context, aspectRatioToShow);
            };
            instance.onLongPressMoveUpdate =
                (details) => _handleLongPressMoveUpdate(details.globalPosition);
            instance.onLongPressEnd = (details) => _handleLongPressEnd();
            instance.onLongPressCancel = () => _removeOverlay();
          },
        ),
        VerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer(),
          (VerticalDragGestureRecognizer instance) {},
        ),
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          (TapGestureRecognizer instance) {
            instance.onTap = () => _handleTap();
          },
        ),
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.item.isVideo
              ? _VideoTilePreview(
                  videoUrl: widget.item.mediaUrl,
                  thumbnailUrl: widget.item.thumbnailUrl,
                  canPlay: widget.canPlay,
                  isCommentPanelOpen: widget.isCommentPanelOpen,
                )
              : VigaAppNetworkImage(
                  imageUrl: widget.item.thumbnailUrl,
                  fit: widget.isCommentPanelOpen ? BoxFit.contain : BoxFit.cover,
                )
        ],
      ),
    );
  }
}

class _VideoTilePreview extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final bool canPlay;
  final bool isCommentPanelOpen;

  const _VideoTilePreview({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.canPlay,
    required this.isCommentPanelOpen,
  });

  @override
  State<_VideoTilePreview> createState() => _VideoTilePreviewState();
}

class _VideoTilePreviewState extends State<_VideoTilePreview> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // 【修复】延迟执行视频控制器初始化，避免在初始化时阻塞微任务队列
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _controller?.setVolume(0);
              _controller?.setLooping(true);
              if (widget.canPlay) {
                _controller?.play();
              }
            });
          }
        }).catchError((error) {
          logger.warning("视频初始化失败 (URL: ${widget.videoUrl}): $error");
        });
    });
  }

  @override
  void didUpdateWidget(covariant _VideoTilePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.canPlay != widget.canPlay) {
      if (widget.canPlay) {
        _controller?.play();
      } else {
        _controller?.pause();
      }
    }
    // 确保评论面板状态变化不会影响视频播放
    if (oldWidget.isCommentPanelOpen != widget.isCommentPanelOpen) {
      // 当评论面板状态改变时，只更新显示模式，不影响播放状态
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller?.value.isInitialized ?? false) {
      return FittedBox(
        fit: widget.isCommentPanelOpen ? BoxFit.contain : BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      );
    }
    // 视频未加载时显示封面图片
    return VigaAppNetworkImage(
      imageUrl: widget.thumbnailUrl,
      fit: widget.isCommentPanelOpen ? BoxFit.contain : BoxFit.cover,
    );
  }
}
