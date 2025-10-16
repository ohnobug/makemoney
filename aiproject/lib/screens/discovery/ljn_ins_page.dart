import 'dart:async'; // 【新增】导入 dart:async 用于 Timer
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'widgets/ins_style_row.dart';

class LJNInsPage extends StatefulWidget {
  const LJNInsPage({super.key});
  @override
  State<LJNInsPage> createState() => _LJNInsPageState();
}

class _LJNInsPageState extends State<LJNInsPage> {
  late List<List<MediaItem>> _mediaRows;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarLight = false;

  final Set<int> _visibleRows = <int>{};
  final List<int> _playingRows = <int>[];
  final int _maxPlayingVideos = 2;

  final Key visibilityKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _mediaRows = _generateMockData();
    _scrollController.addListener(_scrollListener);

    // 【核心修复】将 notifyNow 放在一个微小的延迟后执行
    // 这给了所有 Widget 的 initState 一个完成初始化的机会
    Timer.run(() {
      if (mounted) {
        VisibilityDetectorController.instance.notifyNow();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    VisibilityDetectorController.instance.forget(visibilityKey);
    super.dispose();
  }

  void _scrollListener() {
    final threshold = 100.0.w;
    final bool shouldBeLight = _scrollController.offset >= threshold;
    if (shouldBeLight != _isAppBarLight) {
      setState(() {
        _isAppBarLight = shouldBeLight;
      });
    }
  }

  List<List<MediaItem>> _generateMockData() {
    final random = Random();
    return List.generate(100, (rowIndex) {
      // 修复您添加的随机逻辑
      final isVideo = random.nextBool();
      return List.generate(5, (itemIndex) {
        final seed = rowIndex * 5 + itemIndex;
        // 让视频只出现在第一个大图位置
        final currentItemIsVideo = (itemIndex == 0) ? isVideo : false;
        return MediaItem(
          isVideo: currentItemIsVideo,
          thumbnailUrl: 'https://picsum.photos/seed/$seed/300/500',
          mediaUrl: currentItemIsVideo
              ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
              : 'https://picsum.photos/seed/$seed/600/1000',
        );
      });
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    final rowIndex = (info.key as ValueKey<int>).value;

    if (info.visibleFraction > 2 / 3) {
      _addRowToVisibleSet(rowIndex);
    } else {
      _removeRowFromVisibleSet(rowIndex);
    }
  }

  void _addRowToVisibleSet(int rowIndex) {
    if (_visibleRows.contains(rowIndex)) return;
    _visibleRows.add(rowIndex);
    _updatePlayingRows();
  }

  void _removeRowFromVisibleSet(int rowIndex) {
    if (!_visibleRows.contains(rowIndex)) return;
    _visibleRows.remove(rowIndex);
    _updatePlayingRows();
  }

  void _updatePlayingRows() {
    _playingRows.clear();
    final visibleList = _visibleRows.toList()..sort();
    for (int i = 0; i < visibleList.length && i < _maxPlayingVideos; i++) {
      _playingRows.add(visibleList[i]);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VisibilityDetector(
        key: visibilityKey,
        onVisibilityChanged: (info) {},
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              title: const Text("Ins-Style Page (Optimized)"),
              floating: true,
              snap: true,
              systemOverlayStyle: _isAppBarLight
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isOdd) return SizedBox(height: 2.w);
                  final rowIndex = index ~/ 2;
                  if (rowIndex >= _mediaRows.length) return null;

                  return VisibilityDetector(
                    key: ValueKey(rowIndex),
                    onVisibilityChanged: _onVisibilityChanged,
                    child: InsStyleRow(
                      items: _mediaRows[rowIndex],
                      layoutType: RowLayoutType.values[rowIndex % 3],
                      canPlay: _playingRows.contains(rowIndex),
                    ),
                  );
                },
                childCount: _mediaRows.length * 2 - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
