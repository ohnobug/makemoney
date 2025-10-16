import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/widgets/ljn_app_network_image.dart';
import 'media_action_popup.dart'; // 【核心修复】添加这行 import 语句

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
  const InsStyleRow({super.key, required this.items, required this.layoutType});

  @override
  Widget build(BuildContext context) {
    if (items.length != 5) {
      return const SizedBox(height: 250, child: Center(child: Text("数据错误")));
    }
    final bigItem = _MediaTile(item: items[0], isBig: true);
    final smallItems1 = Column(children: [
      Expanded(child: _MediaTile(item: items[1])),
      const SizedBox(height: 2),
      Expanded(child: _MediaTile(item: items[2])),
    ]);
    final smallItems2 = Column(children: [
      Expanded(child: _MediaTile(item: items[3])),
      const SizedBox(height: 2),
      Expanded(child: _MediaTile(item: items[4])),
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
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: widgets[0]),
          const SizedBox(width: 2),
          Expanded(child: widgets[1]),
          const SizedBox(width: 2),
          Expanded(child: widgets[2]),
        ],
      ),
    );
  }
}

class _MediaTile extends StatefulWidget {
  final MediaItem item;
  final bool isBig;
  const _MediaTile({required this.item, this.isBig = false});
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
    _fetchMediaInfo();
  }

  Future<void> _fetchMediaInfo() async {
    if (widget.item.isVideo) {
      if (mounted) setState(() => _realAspectRatio = 16 / 9);
      return;
    }
    try {
      final fileInfo = await DefaultCacheManager()
          .getFileFromCache(widget.item.thumbnailUrl);
      if (fileInfo != null) {
        final image =
            await decodeImageFromList(fileInfo.file.readAsBytesSync());
        if (mounted)
          setState(() => _realAspectRatio = image.width / image.height);
      }
    } catch (e) {
      logger.warning("获取图片 '${widget.item.thumbnailUrl}' 尺寸失败: $e");
      if (mounted) setState(() => _realAspectRatio = 1.0);
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
    // 现在 `MediaAction` 是已知的了
    final selectedAction =
        _popupKey.currentState?.getActiveAction() ?? MediaAction.none;
    _removeOverlay();
    if (selectedAction != MediaAction.none) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("执行了连贯手势操作: $selectedAction"),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final displayAspectRatio = (constraints.maxHeight > 0)
            ? constraints.maxWidth / constraints.maxHeight
            : 1.0;

        return RawGestureDetector(
          gestures: <Type, GestureRecognizerFactory>{
            LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(
                  duration: const Duration(milliseconds: 300)),
              (LongPressGestureRecognizer instance) {
                instance.onLongPressStart = (details) {
                  final aspectRatioToShow =
                      _realAspectRatio ?? displayAspectRatio;
                  _showOverlay(context, aspectRatioToShow);
                };
                instance.onLongPressMoveUpdate = (details) =>
                    _handleLongPressMoveUpdate(details.globalPosition);
                instance.onLongPressEnd = (details) => _handleLongPressEnd();
                instance.onLongPressCancel = () => _removeOverlay();
              },
            ),
            VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
              (VerticalDragGestureRecognizer instance) {},
            ),
            TapGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
              (TapGestureRecognizer instance) {
                instance.onTap = () => logger.info("跳转到链接...");
              },
            ),
          },
          child: LJNAppNetworkImage(
            imageUrl: widget.item.thumbnailUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
