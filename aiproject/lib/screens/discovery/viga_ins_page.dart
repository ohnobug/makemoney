// G:\t\detection\aiproject\lib\screens\discovery\viga_ins_page.dart
// 发现页面 - 瀑布流展示媒体内容

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/screens/discovery/viga_post_detail_page.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'widgets/ins_style_row.dart';

class VigaInsPage extends StatefulWidget {
  const VigaInsPage({super.key});
  @override
  State<VigaInsPage> createState() => _VigaInsPageState();
}

class _VigaInsPageState extends State<VigaInsPage> {
  // 数据管理
  late List<List<MediaItem>> _mediaRows; // 媒体数据，每行包含5个媒体项
  final ScrollController _scrollController = ScrollController(); // 滚动控制器
  bool _isAppBarLight = false; // AppBar 颜色状态

  // 视频播放管理
  final Set<int> _visibleRows = <int>{}; // 当前可见的行索引集合
  final List<int> _playingRows = <int>[]; // 正在播放视频的行索引
  final int _maxPlayingVideos = 2; // 最大同时播放视频数量

  // 可见性检测
  final Key visibilityKey = UniqueKey(); // 可见性检测的唯一标识

  @override
  void initState() {
    super.initState();
    _mediaRows = _generateMockData(); // 生成模拟数据
    _scrollController.addListener(_scrollListener); // 添加滚动监听器
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    VisibilityDetectorController.instance.forget(visibilityKey);
    super.dispose();
  }

  /// 滚动监听器 - 控制 AppBar 颜色变化
  void _scrollListener() {
    final threshold = 100.0.w; // 滚动阈值
    final bool shouldBeLight = _scrollController.offset >= threshold;
    if (shouldBeLight != _isAppBarLight) {
      setState(() {
        _isAppBarLight = shouldBeLight; // 更新 AppBar 颜色状态
      });
    }
  }

  /// 生成模拟数据 - 创建100行媒体数据
  List<List<MediaItem>> _generateMockData() {
    final random = Random();
    return List.generate(100, (rowIndex) {
      final isVideo = random.nextBool(); // 每行随机决定是否包含视频
      return List.generate(5, (itemIndex) {
        final seed = rowIndex * 5 + itemIndex; // 唯一种子值
        final currentItemIsVideo = (itemIndex == 0) ? isVideo : false; // 只有第一个位置可能是视频
        return MediaItem(
          isVideo: currentItemIsVideo,
          thumbnailUrl: 'https://picsum.photos/seed/$seed/300/500', // 缩略图URL
          mediaUrl: currentItemIsVideo
              ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' // 视频URL
              : 'https://picsum.photos/seed/$seed/600/1000', // 图片URL
        );
      });
    });
  }

  /// 可见性变化回调 - 管理哪些行应该播放视频
  void _onVisibilityChanged(VisibilityInfo info) {
    final rowIndex = (info.key as ValueKey<int>).value;

    if (info.visibleFraction > 2 / 3) {
      // 当行可见度超过2/3时，添加到可见集合
      _addRowToVisibleSet(rowIndex);
    } else if (info.visibleFraction < 1 / 3) {
      // 当行可见度低于1/3时，从可见集合移除
      _removeRowFromVisibleSet(rowIndex);
    }
  }

  /// 添加行到可见集合
  void _addRowToVisibleSet(int rowIndex) {
    if (_visibleRows.contains(rowIndex)) return;
    _visibleRows.add(rowIndex);
    _updatePlayingRows(); // 更新播放状态
  }

  /// 从可见集合移除行
  void _removeRowFromVisibleSet(int rowIndex) {
    if (!_visibleRows.contains(rowIndex)) return;
    _visibleRows.remove(rowIndex);
    _updatePlayingRows(); // 更新播放状态
  }

  /// 更新正在播放的行 - 限制同时播放的视频数量
  void _updatePlayingRows() {
    final visibleList = _visibleRows.toList()..sort(); // 排序可见行
    final newPlayingRows = <int>[];
    // 只允许前 _maxPlayingVideos 个可见行播放视频
    for (int i = 0; i < visibleList.length && i < _maxPlayingVideos; i++) {
      newPlayingRows.add(visibleList[i]);
    }

    // 如果播放列表发生变化，则更新状态
    if (!_listsAreEqual(_playingRows, newPlayingRows) && mounted) {
      setState(() {
        _playingRows.clear();
        _playingRows.addAll(newPlayingRows);
      });
    }
  }

  /// 比较两个列表是否相等
  bool _listsAreEqual(List<int> list1, List<int> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  /// 媒体项点击事件 - 导航到详情页面
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
    context.push(
      '/discovery/ins/post_detail_page',
      extra: postData,
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
            // 浮动 AppBar - 根据滚动状态改变颜色
            SliverAppBar(
              title: const Text("发现"),
              floating: true,
              snap: true,
              systemOverlayStyle: _isAppBarLight
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
            ),
            // 瀑布流列表
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index.isOdd) return SizedBox(height: 2.w); // 奇数索引为间距
                  final rowIndex = index ~/ 2; // 计算行索引
                  if (rowIndex >= _mediaRows.length) return null;

                  // 每行使用 VisibilityDetector 检测可见性
                  return VisibilityDetector(
                    key: ValueKey(rowIndex),
                    onVisibilityChanged: _onVisibilityChanged,
                    child: InsStyleRow(
                      items: _mediaRows[rowIndex],
                      layoutType: RowLayoutType.values[rowIndex % 3], // 三种布局类型循环
                      canPlay: _playingRows.contains(rowIndex), // 控制视频播放
                      onItemTap: _onMediaItemTap,
                    ),
                  );
                },
                childCount: _mediaRows.length * 2 - 1, // 总项目数 = 行数 * 2 - 1（包含间距）
              ),
            ),
          ],
        ),
      ),
    );
  }
}
