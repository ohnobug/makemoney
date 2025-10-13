import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_custom_video_player.dart';

// [新增] 用于承载每个视频独立数据的模型类
class VideoData {
  final String videoPath;
  final String avatarPath;
  final String userName;
  final String description;
  bool isLiked;
  bool isCollected;
  int likeCount;
  int commentCount;
  int collectionCount;
  int shareCount;

  VideoData({
    required this.videoPath,
    required this.avatarPath,
    required this.userName,
    required this.description,
    this.isLiked = false,
    this.isCollected = false,
    required this.likeCount,
    required this.commentCount,
    required this.collectionCount,
    required this.shareCount,
  });
}

// 主页面，承载垂直滚动的视频流
class LJNArtsPage extends StatefulWidget {
  const LJNArtsPage({super.key});

  @override
  State<LJNArtsPage> createState() => _LJNArtsPage();
}

class _LJNArtsPage extends State<LJNArtsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final Map<int, VideoPlayerController> _videoControllers;
  late final LJNSystemCubit _systemCubit;

  // [新增] 模拟的视频数据列表，真实场景中应从服务器获取
  late final List<VideoData> _videoDataList;

  VideoPlayerController? get _currentVideoController =>
      _videoControllers.containsKey(_currentPage)
          ? _videoControllers[_currentPage]
          : null;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _systemCubit = context.read<LJNSystemCubit>();
    _videoControllers = {};

    // [新增] 初始化模拟数据
    _videoDataList = _createMockVideoData();

    _pageController.addListener(() {
      if (!_pageController.hasClients || _pageController.page == null) return;
      final newPage = _pageController.page!.round();
      if (_currentPage != newPage) {
        // 暂停上一个视频
        _videoControllers[_currentPage]?.pause();
        _videoControllers[_currentPage]?.removeListener(_onVideoChange);

        setState(() {
          _currentPage = newPage;

          // 播放当前视频
          _currentVideoController?.play();
          _currentVideoController?.addListener(_onVideoChange);
          _onVideoChange();
        });
      }
    });
  }

  // [新增] 创建模拟数据的方法
  List<VideoData> _createMockVideoData() {
    // 假设你有多个不同的视频文件
    return [
      VideoData(
        videoPath: '/ins/video2.mp4', // 第一个视频
        avatarPath: '/avatar/chat_10.jpg',
        userName: '牛马的home',
        description: '我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏...',
        likeCount: 1050,
        commentCount: 241,
        collectionCount: 421,
        shareCount: 934,
      ),
      VideoData(
        videoPath: '/ins/video2.mp4', // 第二个视频
        avatarPath: '/avatar/chat_11.jpg',
        userName: 'Flutter开发者',
        description: '用Flutter做出的短视频流，性能和体验都非常棒！#Flutter #App开发 #编程',
        likeCount: 2048,
        commentCount: 512,
        collectionCount: 1024,
        shareCount: 128,
        isLiked: true,
      ),
      VideoData(
        videoPath: '/ins/video2.mp4', // 第三个视频
        avatarPath: '/avatar/chat_12.jpg',
        userName: '旅行的风',
        description: '世界的尽头是什么样子？跟我一起来看看吧。#旅行 #风景 #Vlog',
        likeCount: 996,
        commentCount: 188,
        collectionCount: 350,
        shareCount: 77,
      ),
    ];
  }

  void _onVideoChange() {
    if (!mounted ||
        _currentVideoController == null ||
        !_currentVideoController!.value.isInitialized) {
      _systemCubit.updateVideoProgress(progress: 0.0);
      return;
    }

    final duration = _currentVideoController!.value.duration;
    final position = _currentVideoController!.value.position;
    double progressValue = 0.0;
    if (duration.inMilliseconds > 0) {
      progressValue = position.inMilliseconds / duration.inMilliseconds;
    }

    _systemCubit.updateVideoProgress(progress: progressValue, show: true);
  }

  VideoPlayerController _createVideoControllerForIndex(int index) {
    if (_videoControllers.containsKey(index)) {
      return _videoControllers[index]!;
    }

    // 从数据列表中获取对应index的视频路径
    final videoData = _videoDataList[index];
    final cdnUrl = '${_systemCubit.state.cdnBase}${videoData.videoPath}';
    // final cdnUrl = 'http://localhost/video2.mp4';

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(cdnUrl),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    controller.initialize().then((_) {
      if (mounted) {
        controller.setLooping(true);
        controller.setVolume(1.0);
        if (index == _currentPage) {
          controller.play();
          controller.addListener(_onVideoChange);
          _onVideoChange();
        }
        if (mounted) setState(() {});
      }
    }).catchError((error) {
      // 这里的日志非常重要，如果视频无法加载，请务必查看！
      logger.warning("视频初始化失败 (URL: $cdnUrl): $error");
    });

    _videoControllers[index] = controller;
    return controller;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoControllers.forEach((_, controller) {
      controller.removeListener(_onVideoChange);
      controller.dispose();
    });
    _systemCubit.updateVideoProgress(progress: 0.0, show: false);
    super.dispose();
  }

  void _showArtInfoModalSheet(BuildContext context) {}
  void _showArtShareModalSheet(BuildContext context) {}
  void _showArtCommentModalSheet(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        final videoHeight =
            MediaQuery.of(context).size.height - systemState.tabbarHeight;

        return Scaffold(
          primary: false,
          backgroundColor: Colors.black,
          body: SizedBox(
            width: 750.w,
            height: videoHeight,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _videoDataList.length,
              itemBuilder: (context, index) {
                final videoData = _videoDataList[index];
                bool isCurrentPage = index == _currentPage;
                final controller = _createVideoControllerForIndex(index);

                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: theme.colorScheme.onSurface,
                  child: Stack(
                    children: [
                      // --- 视频播放器 ---
                      LJNCustomVideoPlayer(
                        key: ValueKey('video_$index'),
                        canPlay: isCurrentPage,
                        controller: controller,
                        videoHeight: videoHeight,
                      ),

                      // --- 顶部的搜索按钮 ---
                      Positioned(
                        top: 15.w + systemState.statusHeight,
                        right: 28.w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/discovery/search');
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 58.w,
                            child: Icon(
                              const IconData(0xe612, fontFamily: 'Iconfont'),
                              color: AppColors.neutralWhite,
                              size: 48.w,
                            ),
                          ),
                        ),
                      ),

                      // --- 左下角的视频简介信息 ---
                      Positioned(
                        left: 0,
                        bottom: 0,
                        // 传递当前视频的数据
                        child: _VideoInfoSection(
                          avatarUrl: Uri.parse(
                            '${systemState.cdnBase}${videoData.avatarPath}',
                          ),
                          userName: videoData.userName,
                          description: videoData.description,
                        ),
                      ),

                      // --- 右侧的点赞、评论等操作按钮 ---
                      Positioned(
                        bottom: 0,
                        right: 10.w,
                        width: 100.w,
                        height: 700.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 点赞
                            _buildActionButton(
                              const IconData(0xe61e, fontFamily: 'Iconfont'),
                              // [修复] 使用当前视频的点赞状态和数量
                              color: videoData.isLiked
                                  ? const Color.fromARGB(255, 247, 21, 5)
                                  : Colors.white,
                              count: videoData.likeCount.toString(),
                              onTap: () {
                                logger.info("点赞视频 $index");
                                setState(() {
                                  // [修复] 只修改当前视频的状态
                                  if (videoData.isLiked) {
                                    videoData.isLiked = false;
                                    videoData.likeCount--;
                                  } else {
                                    videoData.isLiked = true;
                                    videoData.likeCount++;
                                  }
                                });
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 评论
                            _buildActionButton(
                              const IconData(0xe665, fontFamily: 'Iconfont'),
                              count: videoData.commentCount.toString(),
                              onTap: () {
                                logger.info("评论");
                                _showArtCommentModalSheet(context);
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 收藏
                            _buildActionButton(
                              const IconData(0xe602, fontFamily: 'Iconfont'),
                              // [修复] 使用当前视频的收藏状态和数量
                              color: videoData.isCollected
                                  ? const Color.fromARGB(255, 209, 15, 1)
                                  : Colors.white,
                              count: videoData.collectionCount.toString(),
                              onTap: () {
                                logger.info("收藏视频 $index");
                                setState(() {
                                  // [修复] 只修改当前视频的状态
                                  videoData.isCollected =
                                      !videoData.isCollected;
                                });
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 转发
                            _buildActionButton(
                              const IconData(0xe6c7, fontFamily: 'Iconfont'),
                              count: videoData.shareCount.toString(),
                              onTap: () {
                                logger.info("转发");
                                _showArtShareModalSheet(context);
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 更多
                            GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    const IconData(0xe6e6,
                                        fontFamily: 'Iconfont'),
                                    color: AppColors.neutralWhite,
                                    size: 63.w,
                                  ),
                                ],
                              ),
                              onTap: () {
                                _showArtInfoModalSheet(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    IconData icondata, {
    String count = "0",
    Color color = AppColors.neutralWhite,
    GestureTapCallback? onTap,
  }) {
    // ... 这个辅助 Widget 无需改动 ...
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icondata,
            color: color,
            size: 63.w,
          ),
          SizedBox(height: 10.w),
          Text(
            count,
            style: TextStyle(
              fontSize: 22.w,
              color: AppColors.neutralWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoInfoSection extends StatefulWidget {
  final String userName;
  final Uri avatarUrl;
  final String description;

  const _VideoInfoSection({
    required this.userName,
    required this.avatarUrl,
    required this.description,
  });

  @override
  State<_VideoInfoSection> createState() => _VideoInfoSectionState();
}

class _VideoInfoSectionState extends State<_VideoInfoSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final int _descriptionThreshold = 50;

  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.description.length > _descriptionThreshold;
    final descriptionStyle = TextStyle(
      height: 1.4,
      fontSize: fontSizeScale(28.w),
      color: AppColors.neutralWhite,
      fontFamily: "AlibabaPuHuiTi",
    );

    return Container(
      width: 600.w,
      padding: EdgeInsets.all(25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.avatarUrl.toString(),
                  width: 64.w,
                  height: 64.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey.shade300),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                widget.userName,
                style: TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(30.w),
                  color: AppColors.neutralWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => logger.info("点击了关注按钮"),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentRedVibrant1.withAlpha(230),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Text(
                    "关注",
                    style: TextStyle(
                      color: AppColors.neutralWhite,
                      fontSize: fontSizeScale(26.w),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                if (isLongText) {
                  setState(() => _isExpanded = !_isExpanded);
                }
              },
              child: _isExpanded
                  ? _buildExpandedDescription(descriptionStyle)
                  : _buildCollapsedDescription(isLongText, descriptionStyle),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCollapsedDescription(
      bool isLongText, TextStyle descriptionStyle) {
    String displayedText = isLongText
        ? widget.description.substring(0, _descriptionThreshold)
        : widget.description;

    return RichText(
      text: TextSpan(
        style: descriptionStyle,
        children: [
          TextSpan(text: displayedText),
          if (isLongText)
            TextSpan(
              text: "... 更多",
              style: descriptionStyle.copyWith(
                color: Colors.white.withAlpha(180),
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExpandedDescription(TextStyle descriptionStyle) {
    ThemeData theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 350.w,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20).w,
              child: SingleChildScrollView(
                child: Text(
                  widget.description,
                  style: descriptionStyle,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15.w,
            right: 15.w,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8.w),
              ),
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5).w,
              child: Text(
                "收起",
                textAlign: TextAlign.center,
                style: descriptionStyle.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
