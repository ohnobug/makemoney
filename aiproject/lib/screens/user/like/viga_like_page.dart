import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/widgets/loading.dart';

class _LikedVideo {
  final String thumbnailUrl;
  final String duration;
  final String title;
  final String author;
  final String viewCount;
  final DateTime timestamp;

  const _LikedVideo({
    required this.thumbnailUrl,
    required this.duration,
    required this.title,
    required this.author,
    required this.viewCount,
    required this.timestamp,
  });
}

// =================================================================
// 2. The "My Likes" Page (Stateful Widget)
// =================================================================
class LikedVideosPage extends StatefulWidget {
  const LikedVideosPage({super.key});

  @override
  State<LikedVideosPage> createState() => _LikedVideosPageState();
}

class _LikedVideosPageState extends State<LikedVideosPage> {
  final ScrollController _scrollController = ScrollController();

  final List<_LikedVideo> _displayList = [];
  // MODIFIED: Start in a loading state.
  bool _isLoading = true;
  bool _hasMore = true;
  DateTime? _lastTimestamp;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _processAndGroupVideos(List<_LikedVideo> videos) {
    if (videos.isEmpty) return;
    _displayList.addAll(videos);
    _lastTimestamp = videos.last.timestamp;
  }

  // MODIFIED: This function is now asynchronous to simulate an initial fetch.
  Future<void> _loadInitialData() async {
    // Simulate a network delay for the initial load.
    await Future.delayed(const Duration(milliseconds: 1500));

    final now = DateTime.now();
    final List<_LikedVideo> initialVideos = [
      _LikedVideo(
          timestamp: now.subtract(const Duration(hours: 1)),
          thumbnailUrl: 'assets/images/avatar/chat_2.jpg',
          duration: '01:07',
          title: '《快乐星球》老顽童爷爷赵克明去世...',
          author: '森森说八卦',
          viewCount: '9.2万次播放'),
      _LikedVideo(
          timestamp: now.subtract(const Duration(hours: 3)),
          thumbnailUrl: 'assets/images/avatar/chat_2.jpg',
          duration: '01:26',
          title: '迪丽热巴中秋限定造型美到心巴上',
          author: '娱乐媒体分享',
          viewCount: '374次播放'),
      _LikedVideo(
          timestamp: now.subtract(const Duration(days: 1, hours: 2)),
          thumbnailUrl: 'assets/images/avatar/chat_2.jpg',
          duration: '08:56',
          title: '鬼魂最怕的不是佛号？地藏王透露...',
          author: '禅心不二',
          viewCount: '2829次播放'),
      _LikedVideo(
          timestamp: now.subtract(Duration(days: now.weekday > 2 ? 3 : 2)),
          thumbnailUrl: 'assets/images/avatar/chat_2.jpg',
          duration: '01:06',
          title: '不可思议的全地形电动车，底部18个轮子',
          author: '胖爷科技',
          viewCount: '16万次播放'),
      _LikedVideo(
          timestamp: now.subtract(const Duration(days: 8)),
          thumbnailUrl: 'assets/image_extra1.png',
          duration: '05:30',
          title: '超治愈的猫咪日常，可爱瞬间大合集',
          author: '萌宠部落',
          viewCount: '25.4万次播放'),
    ];

    _processAndGroupVideos(initialVideos);

    // After data is processed, update the state to stop loading.
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (!_isLoading &&
        _hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _fetchMoreVideos();
    }
  }

  Future<void> _fetchMoreVideos() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    List<_LikedVideo> newVideos = [];
    DateTime lastDate = _lastTimestamp ?? DateTime.now();

    if (DateTime.now().difference(lastDate).inDays > 90) {
      newVideos = [];
    } else {
      newVideos = List.generate(
        5,
        (index) {
          final newTimestamp =
              lastDate.subtract(Duration(days: index + 1, hours: index));
          return _LikedVideo(
            timestamp: newTimestamp,
            thumbnailUrl: 'assets/image_new.png',
            duration: '0${index + 1}:45',
            title:
                '分页加载的旧视频 ${DateTime.now().difference(newTimestamp).inDays} 天前',
            author: '分页作者',
            viewCount: '${1500 - index * 10}次播放',
          );
        },
      );
    }

    if (newVideos.isEmpty) {
      setState(() {
        _hasMore = false;
      });
    } else {
      _processAndGroupVideos(newVideos);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // MODIFIED: The body of the Scaffold now handles the initial loading state.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('我的点赞',
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: _isLoading && _displayList.isEmpty
          // If it's the initial load, show the indicator in the center.
          ? const Center(child: VigaLoadingIndicator())
          // Otherwise, build the list. The "load more" indicator is handled inside.
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              itemCount: _displayList.length + 1,
              itemBuilder: (context, index) {
                if (index == _displayList.length) {
                  if (_isLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: VigaLoadingIndicator()),
                    );
                  } else if (!_hasMore) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(
                        child: Text('--- 没有更多了 ---',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                final video = _displayList[index];
                return _VideoListItem(video: video);
              },
            ),
    );
  }
}

class _VideoListItem extends StatelessWidget {
  final _LikedVideo video;
  const _VideoListItem({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Thumbnail(imageUrl: video.thumbnailUrl, duration: video.duration),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(video.author,
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(width: 8),
                      Text(video.viewCount,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
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

class _Thumbnail extends StatelessWidget {
  final String imageUrl;
  final String duration;
  const _Thumbnail({required this.imageUrl, required this.duration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 70,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: VigaAppNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Icon(
            Icons.play_circle_outline,
            color: Colors.white.withAlpha(230),
            size:
                32, // Slightly reduced play icon size to fit smaller thumbnail
            shadows: const [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black45,
                offset: Offset(0, 0),
              ),
            ],
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(153),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(duration,
                  style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}
