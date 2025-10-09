import 'dart:async';
import 'package:flutter/material.dart';

// =================================================================
// 1. Data Model for a Liked Video
// =================================================================
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

  final List<dynamic> _displayList = [];
  bool _isLoading = false;
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

  /// Helper function to format DateTime into headers like "Today", "Yesterday", "Monday", etc.
  String _formatDateHeader(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToFormat =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (dateToFormat == today) {
      return '今天';
    } else if (dateToFormat == yesterday) {
      return '昨天';
    } else if (today.difference(dateToFormat).inDays < now.weekday) {
      const weekdays = {
        1: '星期一', 2: '星期二', 3: '星期三', 4: '星期四',
        5: '星期五', 6: '星期六', 7: '星期日'
      };
      return weekdays[timestamp.weekday] ?? '';
    } else {
      return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';
    }
  }

  /// Core logic to process a list of videos and insert date headers.
  void _processAndGroupVideos(List<_LikedVideo> videos) {
    if (videos.isEmpty) return;

    String? lastHeader;
    final lastVideoItem = _displayList.lastWhere((item) => item is _LikedVideo,
        orElse: () => null);
    if (lastVideoItem != null) {
      lastHeader = _formatDateHeader(lastVideoItem.timestamp);
    }

    for (var video in videos) {
      String currentHeader = _formatDateHeader(video.timestamp);
      if (currentHeader != lastHeader) {
        _displayList.add(currentHeader);
        lastHeader = currentHeader;
      }
      _displayList.add(video);
    }
    _lastTimestamp = videos.last.timestamp;
  }

  /// Loads the initial set of videos with varied timestamps.
  void _loadInitialData() {
    final now = DateTime.now();
    // A single source of truth for all videos, sorted by timestamp descending.
    final List<_LikedVideo> initialVideos = [
      // Today
      _LikedVideo(timestamp: now.subtract(const Duration(hours: 1)), thumbnailUrl: 'assets/images/avatar/chat_2.jpg', duration: '01:07', title: '《快乐星球》老顽童爷爷赵克明去世...《快乐星球》老顽童爷爷赵克明去世...《快乐星球》老顽童爷爷赵克明去世...', author: '森森说八卦', viewCount: '9.2万次播放'),
      _LikedVideo(timestamp: now.subtract(const Duration(hours: 3)), thumbnailUrl: 'assets/images/avatar/chat_2.jpg', duration: '01:26', title: '迪丽热巴中秋限定造型美到心巴上', author: '娱乐媒体分享', viewCount: '374次播放'),
      // Yesterday
      _LikedVideo(timestamp: now.subtract(const Duration(days: 1, hours: 2)), thumbnailUrl: 'assets/images/avatar/chat_2.jpg', duration: '08:56', title: '鬼魂最怕的不是佛号？地藏王透露...', author: '禅心不二', viewCount: '2829次播放'),
      // This week
      _LikedVideo(timestamp: now.subtract(Duration(days: now.weekday > 2 ? 3 : 2)), thumbnailUrl: 'assets/images/avatar/chat_2.jpg', duration: '01:06', title: '不可思议的全地形电动车，底部18个轮子', author: '胖爷科技', viewCount: '16万次播放'),
      // Older dates
      _LikedVideo(timestamp: now.subtract(const Duration(days: 8)), thumbnailUrl: 'assets/image_extra1.png', duration: '05:30', title: '超治愈的猫咪日常，可爱瞬间大合集', author: '萌宠部落', viewCount: '25.4万次播放'),
      _LikedVideo(timestamp: now.subtract(const Duration(days: 9)), thumbnailUrl: 'assets/image_extra2.png', duration: '10:15', title: '新手必看，10分钟学会基础烹饪技巧', author: '美食家小王', viewCount: '8.8万次播放'),
      _LikedVideo(timestamp: now.subtract(const Duration(days: 30)), thumbnailUrl: 'assets/image_extra3.png', duration: '03:45', title: '地球上最壮观的自然奇景', author: '环球旅行家', viewCount: '30.1万次播放'),
    ];

    _processAndGroupVideos(initialVideos);
  }

  /// Listens to scroll events to trigger fetching more data.
  void _onScroll() {
    if (!_isLoading &&
        _hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _fetchMoreVideos();
    }
  }

  /// Simulates fetching more paginated data.
  Future<void> _fetchMoreVideos() async {
    if (_isLoading) return;
    setState(() { _isLoading = true; });
    await Future.delayed(const Duration(seconds: 2));

    List<_LikedVideo> newVideos = [];
    DateTime lastDate = _lastTimestamp ?? DateTime.now();

    // Simulate running out of data after ~90 days.
    if (DateTime.now().difference(lastDate).inDays > 90) {
      newVideos = [];
    } else {
      // Generate 5 new videos with progressively older timestamps.
      newVideos = List.generate(
        5,
        (index) {
          final newTimestamp = lastDate.subtract(Duration(days: index + 1, hours: index));
          return _LikedVideo(
            timestamp: newTimestamp,
            thumbnailUrl: 'assets/image_new.png', // Ensure you have a placeholder for this
            duration: '0${index + 1}:45',
            title: '分页加载的旧视频 ${DateTime.now().difference(newTimestamp).inDays} 天前',
            author: '分页作者',
            viewCount: '${1500 - index * 10}次播放',
          );
        },
      );
    }

    if (newVideos.isEmpty) {
      setState(() { _hasMore = false; });
    } else {
      // Process the new data and add it to the display list.
      _processAndGroupVideos(newVideos);
    }

    setState(() { _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('我的点赞', style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20)),
        centerTitle: true,
        actions: [

        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: _displayList.length + 1,
        itemBuilder: (context, index) {
          if (index == _displayList.length) {
            if (_isLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (!_hasMore) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(
                  child: Text('--- 没有更多了 ---', style: TextStyle(color: Colors.grey)),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }

          final item = _displayList[index];
          if (item is String) {
            return _SectionHeader(title: item);
          } else if (item is _LikedVideo) {
            return _VideoListItem(video: item);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// =================================================================
// 3. Helper Widgets for the LikedVideosPage
// =================================================================

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
          // MODIFIED: Thumbnail size adjusted
          _Thumbnail(imageUrl: video.thumbnailUrl, duration: video.duration),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              // MODIFIED: Height adjusted for text content
              height: 70, // Reduced height for a more compact item
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    video.title,
                    maxLines: 2, // Allow title to wrap if needed
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14), // Optionally reduce font size
                  ),
                  Row(
                    children: [
                      Text(video.author, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(width: 8),
                      Text(video.viewCount, style: Theme.of(context).textTheme.bodySmall),
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
      // MODIFIED: Width and Height adjusted for thumbnail
      width: 120, // Reduced width
      height: 70, // Reduced height
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // Layer 1: The Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40),
                );
              },
            ),
          ),

          // Layer 2: The Play Icon in the center
          Icon(
            Icons.play_circle_outline,
            color: Colors.white.withAlpha(230),
            size: 32, // Slightly reduced play icon size to fit smaller thumbnail
            shadows: const [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black45,
                offset: Offset(0, 0),
              ),
            ],
          ),

          // Layer 3: The Duration text
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(153),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(duration, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}