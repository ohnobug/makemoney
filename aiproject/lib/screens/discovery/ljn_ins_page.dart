import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/discovery/ljn_post_detail_page.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'widgets/ins_style_row.dart';
import '../../widgets/ljn_comment_panel.dart';

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

  // 评论盒子相关状态
  bool _showCommentPanel = false;
  List<CommentData> _currentComments = [];
  bool _isCommentPanelOpen = false;

  @override
  void initState() {
    super.initState();
    _mediaRows = _generateMockData();
    _scrollController.addListener(_scrollListener);

    // 【修复】移除 notifyNow 调用，避免微任务循环
    // VisibilityDetector 会自动在布局完成后检测可见性
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

    // 【修复】添加防抖逻辑，避免频繁触发
    if (info.visibleFraction > 2 / 3) {
      _addRowToVisibleSet(rowIndex);
    } else if (info.visibleFraction < 1 / 3) {
      _removeRowFromVisibleSet(rowIndex);
    }
    // 在 1/3 到 2/3 之间不进行任何操作，避免边界抖动
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
    // 【修复】检查是否需要更新，避免不必要的 setState
    final visibleList = _visibleRows.toList()..sort();
    final newPlayingRows = <int>[];
    for (int i = 0; i < visibleList.length && i < _maxPlayingVideos; i++) {
      newPlayingRows.add(visibleList[i]);
    }

    // 只有当播放行真正发生变化时才调用 setState
    if (!_listsAreEqual(_playingRows, newPlayingRows) && mounted) {
      _playingRows.clear();
      _playingRows.addAll(newPlayingRows);
      setState(() {});
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
      title: '这是一个示例标题',
      tags: ['标签1', '标签2', '标签3'],
      timestamp: '刚刚',
      location: '北京',
      likes: 123,
      favorites: 45,
      comments: 67,
      isFollowed: false,
    );

    // 导航到详情页
    Navigator.pushNamed(
      context,
      '/discovery/ins/post_detail_page',
      arguments: postData,
    );
  }

  void _openCommentPanel(MediaItem item) {
    // 模拟评论数据
    final comments = [
      CommentData(
        username: '小红薯6514199C',
        avatarUrl: 'https://picsum.photos/seed/user2/100/100',
        content: '这个作品真不错！',
        timestamp: '2小时前',
        location: '北京',
        likes: 20,
      ),
      CommentData(
        username: '高能小作坊',
        avatarUrl: 'https://picsum.photos/seed/user3/100/100',
        content: '太美了！',
        timestamp: '昨天 23:04',
        location: '广东',
        likes: 8,
      ),
      CommentData(
        username: '烟熏威士忌',
        avatarUrl: 'https://picsum.photos/seed/user4/100/100',
        content: '朋友带我去的广州塔🙋‍♀️',
        timestamp: '昨天 19:03',
        location: '广东',
        likes: 37,
      ),
    ];

    setState(() {
      _showCommentPanel = true;
      _currentComments = comments;
      _isCommentPanelOpen = true;
    });
  }

  void _hideCommentPanel() {
    setState(() {
      _showCommentPanel = false;
      _currentComments = [];
      _isCommentPanelOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 主内容区域
          VisibilityDetector(
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
                          onItemTap: _onMediaItemTap,
                          onCommentTap: _openCommentPanel,
                          isCommentPanelOpen: _isCommentPanelOpen,
                        ),
                      );
                    },
                    childCount: _mediaRows.length * 2 - 1,
                  ),
                ),
              ],
            ),
          ),
          // 评论面板（从底部弹出）
          if (_showCommentPanel)
            Positioned.fill(
              child: Container(
                color: Colors.black.withAlpha(128),
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _hideCommentPanel,
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    LJNCommentPanel(
                      comments: _currentComments,
                      onClose: _hideCommentPanel,
                      onSendComment: (comment) {
                        // 发送评论的逻辑
                        logger.info("发送评论: $comment");
                      },
                      panelHeight: 800,
                      showInput: true,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
