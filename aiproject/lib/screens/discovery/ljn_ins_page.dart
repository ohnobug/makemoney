// G:\t\detection\aiproject\lib\screens\discovery\ljn_ins_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/discovery/ljn_post_detail_page.dart';
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
      final isVideo = random.nextBool();
      return List.generate(5, (itemIndex) {
        final seed = rowIndex * 5 + itemIndex;
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
    } else if (info.visibleFraction < 1 / 3) {
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
    final visibleList = _visibleRows.toList()..sort();
    final newPlayingRows = <int>[];
    for (int i = 0; i < visibleList.length && i < _maxPlayingVideos; i++) {
      newPlayingRows.add(visibleList[i]);
    }

    if (!_listsAreEqual(_playingRows, newPlayingRows) && mounted) {
      setState(() {
        _playingRows.clear();
        _playingRows.addAll(newPlayingRows);
      });
    }
  }

  bool _listsAreEqual(List<int> list1, List<int> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  void _onMediaItemTap(MediaItem item) {
    // 创建详情页数据
    final postData = PostDetailData(
      id: '${item.thumbnailUrl.hashCode}',
      username: '用户${item.thumbnailUrl.hashCode % 1000}',
      avatarUrl:
          'https://picsum.photos/seed/user${item.thumbnailUrl.hashCode % 100}/100/100',
      imageUrls: [item.mediaUrl],
      title: '这是一个根据点击的图片生成的详情页',
      tags: ['动态标签', '瀑布流', 'Flutter'],
      timestamp: '刚刚',
      location: '随机地点',
      likes: Random().nextInt(1000),
      favorites: Random().nextInt(500),
      comments: Random().nextInt(200),
      isFollowed: Random().nextBool(),
    );

    // 导航到详情页
    Navigator.pushNamed(
      context,
      '/discovery/ins/post_detail_page',
      arguments: postData,
    );
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
              title: const Text("发现"),
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
                      onItemTap: _onMediaItemTap,
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
