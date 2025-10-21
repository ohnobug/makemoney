// G:\t\detection\aiproject\lib\screens\arts\ljn_arts_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/screens/arts/widgets/ljn_video_info.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/widgets/ljn_comment_panel.dart';
import 'package:vigaviga/widgets/ljn_custom_video_player.dart';

// --- 数据模型 (无需改动) ---
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

// --- 主页面 ---
class LJNArtsPage extends StatefulWidget {
  const LJNArtsPage({super.key});

  @override
  State<LJNArtsPage> createState() => _LJNArtsPageState();
}

class _LJNArtsPageState extends State<LJNArtsPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final Map<int, VideoPlayerController> _videoControllers;
  late final LJNSystemCubit _systemCubit;
  late final List<VideoData> _videoDataList;

  bool _isPanelOpen = false;
  bool _isCommentPanel = false;

  final List<CommentData> _comments = [
    CommentData(
        username: '小红薯6514199C',
        avatarUrl: 'https://picsum.photos/seed/user2/100/100',
        content: '广州算接地气了，你看深圳。不过为啥粤语系城市的城中村都乱糟糟的，不论是广州，深圳还是香港都有点这种影子。',
        timestamp: '2小时前',
        location: '北京',
        likes: 20),
    CommentData(
        username: '高能小作坊',
        avatarUrl: 'https://picsum.photos/seed/user3/100/100',
        content: '高能小作坊',
        timestamp: '昨天 23:04',
        location: '广东',
        likes: 8,
        imageUrl:
            'https://images.pexels.com/photos/162031/dubai-tower-arab-khalifa-162031.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    for (int i = 0; i < 20; i++)
      CommentData(
          username: '用户 $i',
          avatarUrl: 'https://picsum.photos/seed/user$i/100/100',
          content: '这是第 $i 条测试评论内容，用于填充列表。',
          timestamp: '1小时前',
          location: '网络',
          likes: i * 5),
  ];

  VideoPlayerController? get _currentVideoController =>
      _videoControllers[_currentPage];

  late DraggableScrollableController _scrollableController;
  late AnimationController _videoAnimationController;

  @override
  void initState() {
    super.initState();

    _scrollableController = DraggableScrollableController();

    _videoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    _systemCubit = context.read<LJNSystemCubit>();
    _videoControllers = {};
    _videoDataList = _createMockVideoData();

    _pageController.addListener(() {
      if (!_pageController.hasClients || _pageController.page == null) return;
      final newPage = _pageController.page!.round();
      if (_currentPage != newPage) {
        _videoControllers[_currentPage]?.pause();
        _videoControllers[_currentPage]?.removeListener(_onVideoChange);
        setState(() {
          _currentPage = newPage;
          _currentVideoController?.play();
          _currentVideoController?.addListener(_onVideoChange);
          _onVideoChange();
        });
      }
    });
  }

  List<VideoData> _createMockVideoData() {
    return [
      VideoData(
          videoPath: '${_systemCubit.state.cdnBase}/ins/video2.mp4',
          avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_10.jpg',
          userName: '牛马的home',
          description:
              '我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...',
          likeCount: 1050,
          commentCount: 241,
          collectionCount: 421,
          shareCount: 934),
      VideoData(
          videoPath:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_11.jpg',
          userName: 'Flutter开发者',
          description: '用Flutter做出的短视频流，性能和体验都非常棒！#Flutter #App开发 #编程',
          likeCount: 2048,
          commentCount: 512,
          collectionCount: 1024,
          shareCount: 128,
          isLiked: true),
    ];
  }

  void _onVideoChange() {
    if (!mounted ||
        _currentVideoController == null ||
        !_currentVideoController!.value.isInitialized) {
      _systemCubit.updateVideoProgress(progress: 0.0, show: false);
      return;
    }
    final duration = _currentVideoController!.value.duration;
    final position = _currentVideoController!.value.position;
    double progressValue = (duration.inMilliseconds > 0)
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;
    _systemCubit.updateVideoProgress(progress: progressValue);
  }

  VideoPlayerController _createVideoControllerForIndex(int index) {
    if (_videoControllers.containsKey(index)) {
      return _videoControllers[index]!;
    }
    final videoData = _videoDataList[index];
    final controller = VideoPlayerController.networkUrl(
        Uri.parse(videoData.videoPath),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    controller.initialize().then((_) {
      if (mounted) {
        controller.setLooping(true);
        controller.setVolume(1.0);
        if (index == _currentPage) {
          controller.play();
          controller.addListener(_onVideoChange);
          _onVideoChange();
        }
        setState(() {});
      }
    }).catchError((error) {
      logger.warning("视频初始化失败 (URL: ${videoData.videoPath}): $error");
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
    _systemCubit.updateShowCommentsPanel(false);
    _scrollableController.dispose();
    _videoAnimationController.dispose();
    super.dispose();
  }

  void _onPanelDrag() {
    const double initialSize = 0.6;
    final double currentExtent = _scrollableController.size;
    double progress = 1.0 - (currentExtent / initialSize);
    _videoAnimationController.value = progress.clamp(0.0, 1.0);
  }

  void _showCommentsPanel() {
    _systemCubit.updateVideoProgress(show: false);
    _systemCubit.updateShowCommentsPanel(true);

    setState(() {
      _isPanelOpen = true;
      _isCommentPanel = true;
    });

    late Animation<double> transitionAnimation;
    void entryAnimationListener() {
      _videoAnimationController.value = 1.0 - transitionAnimation.value;
    }

    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext modalContext) {
        transitionAnimation = ModalRoute.of(modalContext)!.animation!;
        transitionAnimation.addListener(entryAnimationListener);
        transitionAnimation.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            transitionAnimation.removeListener(entryAnimationListener);
            _scrollableController.addListener(_onPanelDrag);
          }
        });

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(modalContext).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.1,
              maxChildSize: 0.6,
              snap: true,
              snapSizes: const [0.6],
              controller: _scrollableController,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return LJNCommentPanel(
                  comments: _comments,
                  onClose: () => Navigator.pop(context),
                  showInput: true,
                  scrollController: scrollController,
                );
              },
            ),
          ],
        );
      },
    ).then((_) {
      _scrollableController.removeListener(_onPanelDrag);
      transitionAnimation.removeListener(entryAnimationListener);
      _hideCommentsPanel();
    });
  }

  void _hideCommentsPanel() {
    if (mounted && _isPanelOpen) {
      setState(() {
        _isPanelOpen = false;
        _isCommentPanel = false;
      });
      _videoAnimationController.animateTo(1.0, curve: Curves.easeOutQuart);
      _systemCubit.updateVideoProgress(show: true);
      _systemCubit.updateShowCommentsPanel(false);
    }
  }

  // 🚀 [RESTORED] _showArtInfoModalSheet
  void _showArtInfoModalSheet(BuildContext context) {
    final currentVideoData = _videoDataList[_currentPage];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    setState(() {
      _isPanelOpen = true;
      _isCommentPanel = false; // Note: This will not trigger video scaling
    });

    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.1,
          maxChildSize: 1,
          snap: true,
          snapSizes: const [1.0],
          builder: (BuildContext context, ScrollController scrollController) {
            return BlocBuilder<LJNSystemCubit, SystemState>(
              builder: (context, systemState) {
                return _ArtInfoModalContent(
                  scrollController: scrollController,
                  currentVideoData: currentVideoData,
                  systemState: systemState,
                );
              },
            );
          },
        );
      },
    ).then((_) {
      setState(() {
        _isPanelOpen = false;
      });
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });
  }

  // 🚀 [RESTORED] _showArtShareModalSheet
  void _showArtShareModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('转发作品'),
              const SizedBox(height: 20),
              ElevatedButton(
                  child: const Text('关闭'),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        final mediaQuery = MediaQuery.of(context);
        final screenSize = mediaQuery.size;
        final viewPadding = mediaQuery.padding;
        final screenHeight = screenSize.height;
        final screenWidth = screenSize.width;

        final panelMaxSize = 0.6;
        final topAreaHeight = screenHeight * (1.0 - panelMaxSize);
        final shrunkVideoTopMargin = viewPadding.top + 20.h;
        final shrunkVideoHeight = topAreaHeight - shrunkVideoTopMargin;
        final videoAspectRatio =
            _currentVideoController?.value.isInitialized ?? false
                ? _currentVideoController!.value.aspectRatio
                : 9.0 / 16.0;
        final shrunkVideoWidth = shrunkVideoHeight * videoAspectRatio;
        final normalVideoHeight = screenHeight - systemState.tabbarHeight;

        double interpolate(double start, double end, double progress) {
          return start + (end - start) * progress;
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: AnimatedBuilder(
            animation: _videoAnimationController,
            builder: (context, child) {
              final progress = _videoAnimationController.value;

              // Only apply the transformation if it's the comment panel
              final currentVideoHeight = (_isPanelOpen && _isCommentPanel)
                  ? interpolate(shrunkVideoHeight, normalVideoHeight, progress)
                  : normalVideoHeight;
              final currentVideoWidth = (_isPanelOpen && _isCommentPanel)
                  ? interpolate(shrunkVideoWidth, screenWidth, progress)
                  : screenWidth;
              final currentVideoTop = (_isPanelOpen && _isCommentPanel)
                  ? interpolate(shrunkVideoTopMargin, 0.0, progress)
                  : 0.0;
              final currentVideoLeft = (_isPanelOpen && _isCommentPanel)
                  ? interpolate(
                      (screenWidth - shrunkVideoWidth) / 2, 0.0, progress)
                  : 0.0;

              return Stack(
                children: [
                  Positioned(
                    top: currentVideoTop,
                    left: currentVideoLeft,
                    width: currentVideoWidth,
                    height: currentVideoHeight,
                    child: child!,
                  ),
                ],
              );
            },
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              physics: _isPanelOpen
                  ? const NeverScrollableScrollPhysics()
                  : const PageScrollPhysics(),
              itemCount: _videoDataList.length,
              itemBuilder: (context, index) {
                final controller = _createVideoControllerForIndex(index);
                final videoData = _videoDataList[index];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      (_isPanelOpen && _isCommentPanel)
                          ? interpolate(
                              12.0, 0.0, _videoAnimationController.value)
                          : 0.0,
                    ),
                    color: Colors.black,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (controller.value.isInitialized)
                        
                        LJNCustomVideoPlayer(
                          key: ValueKey('video_$index'),
                          canPlay: index == _currentPage,
                          controller: controller,
                          videoHeight: normalVideoHeight,
                          enableTapToPlay: !_isPanelOpen,
                          isPanelOpen: _isPanelOpen,
                        ),
                      Opacity(
                        opacity: (_isPanelOpen && _isCommentPanel)
                            ? _videoAnimationController.value
                            : 1.0,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              bottom: 0.w,
                              child: LJNVideoInfoSection(
                                avatarUrl: videoData.avatarPath,
                                userName: videoData.userName,
                                description: videoData.description,
                              ),
                            ),
                            Positioned(
                              bottom: 0.w,
                              right: 10.w,
                              width: 100.w,
                              height: 680.w,
                              child: _buildActionButtons(videoData),
                            ),
                            Positioned(
                              top: 15.w + systemState.statusHeight,
                              right: 28.w,
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/discovery/search'),
                                child: Container(
                                  color: Colors.transparent,
                                  height: 58.w,
                                  child: Icon(
                                    const IconData(0xe612,
                                        fontFamily: 'Iconfont'),
                                    color: AppColors.neutralWhite,
                                    size: 48.w,
                                  ),
                                ),
                              ),
                            ),
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

  Widget _buildActionButtons(VideoData videoData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildActionButton(const IconData(0xe61e, fontFamily: 'Iconfont'),
            color: videoData.isLiked ? Colors.red : Colors.white,
            count: videoData.likeCount.toString(), onTap: () {
          setState(() {
            if (videoData.isLiked) {
              videoData.isLiked = false;
              videoData.likeCount--;
            } else {
              videoData.isLiked = true;
              videoData.likeCount++;
            }
          });
        }),
        SizedBox(height: 35.w),
        _buildActionButton(
          const IconData(0xe665, fontFamily: 'Iconfont'),
          count: videoData.commentCount.toString(),
          onTap: _showCommentsPanel,
        ),
        SizedBox(height: 35.w),
        _buildActionButton(
          const IconData(0xe602, fontFamily: 'Iconfont'),
          color: videoData.isCollected ? Colors.yellow : Colors.white,
          count: videoData.collectionCount.toString(),
          onTap: () {
            setState(() {
              videoData.isCollected = !videoData.isCollected;
            });
          },
        ),
        SizedBox(height: 35.w),
        _buildActionButton(
          const IconData(0xe6c7, fontFamily: 'Iconfont'),
          count: videoData.shareCount.toString(),
          onTap: () => _showArtShareModalSheet(context),
        ),
        SizedBox(height: 35.w),
        GestureDetector(
          child: Icon(const IconData(0xe6e6, fontFamily: 'Iconfont'),
              color: AppColors.neutralWhite, size: 63.w),
          onTap: () => _showArtInfoModalSheet(context),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icondata, {
    String count = "0",
    Color color = AppColors.neutralWhite,
    GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icondata, color: color, size: 63.w),
          SizedBox(height: 10.w),
          Text(
            count,
            style: TextStyle(
              fontSize: 22.w,
              color: AppColors.neutralWhite,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

// 🚀 [RESTORED] _ArtInfoModalContent and its helpers
class _ArtInfoModalContent extends StatelessWidget {
  final ScrollController scrollController;
  final VideoData currentVideoData;
  final SystemState systemState;

  const _ArtInfoModalContent({
    required this.scrollController,
    required this.currentVideoData,
    required this.systemState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xCC000000),
            Color(0xE6000000),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ListView(
            controller: scrollController,
            padding: EdgeInsets.only(top: 120.w + systemState.statusHeight),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildInfoCard(
                      icon: Icons.info_outline,
                      title: '基本信息',
                      children: [
                        _buildInfoItem('作品名称', currentVideoData.userName),
                        _buildInfoItem('作者', currentVideoData.userName),
                        _buildInfoItem('发布时间', '2024-10-20 15:30:00'),
                        _buildInfoItem('地点', '中国·广州'),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.description,
                      title: '作品内容',
                      children: [
                        _buildDescriptionItem(
                            '作品描述', currentVideoData.description),
                        _buildTagsItem('作品标签', [
                          '#懒人救星',
                          '#居家办公',
                          '#电竞',
                          '#游戏',
                          '#男生房间',
                          '#INGREM',
                          '#治愈',
                          '#生活'
                        ]),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.storage,
                      title: '技术信息',
                      children: [
                        _buildInfoItem('文件大小', '2.3 MB'),
                        _buildInfoItem('文件格式', 'MP4'),
                        _buildInfoItem('分辨率', '1080x1920'),
                        _buildInfoItem('时长', '15秒'),
                        _buildInfoItem('IPFS地址',
                            'https://ipfs.io/ipfs/Qm${currentVideoData.videoPath.hashCode.toRadixString(16)}'),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.analytics,
                      title: '互动数据',
                      children: [
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 12.w,
                          children: [
                            _buildStatsItem(
                                '点赞',
                                currentVideoData.likeCount.toString(),
                                Icons.favorite),
                            _buildStatsItem(
                                '评论',
                                currentVideoData.commentCount.toString(),
                                Icons.comment),
                            _buildStatsItem(
                                '转发',
                                currentVideoData.shareCount.toString(),
                                Icons.share),
                            _buildStatsItem(
                                '收藏',
                                currentVideoData.collectionCount.toString(),
                                Icons.bookmark),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.copyright,
                      title: '版权信息',
                      children: [
                        _buildInfoItem('版权状态', '原创作品'),
                        _buildInfoItem('授权方式', 'CC BY-NC 4.0'),
                        _buildInfoItem('区块链哈希',
                            '0x${currentVideoData.videoPath.hashCode.toRadixString(16)}'),
                      ],
                    ),
                    SizedBox(height: 100.w),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 14, 14, 10),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.w + systemState.statusHeight,
                  bottom: 20.w,
                  left: 20.w,
                  right: 20.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '作品信息',
                      style: TextStyle(
                        fontSize: 36.w,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 32.w,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(
          color: Colors.white.withAlpha(51),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white.withAlpha(204),
                  size: 32.w,
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.w,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.white.withAlpha(204),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 26.w,
              color: Colors.white.withAlpha(204),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.w),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsItem(String label, List<String> tags) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 26.w,
              color: Colors.white.withAlpha(204),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.w),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            children: tags
                .map((tag) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(20.w),
                        border: Border.all(color: Colors.white.withAlpha(80)),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 22.w,
                          color: Colors.white,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsItem(String label, String value, IconData icon) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32.w,
          ),
          SizedBox(height: 8.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.w,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 20.w,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}
