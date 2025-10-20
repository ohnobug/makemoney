// G:\t\detection\aiproject\lib\screens\arts\ljn_arts_page.dart

import 'package:vigaviga/widgets/ljn_app_network_image.dart';
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
import 'package:vigaviga/widgets/ljn_comment_panel.dart';

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

// --- 主页面 (已重构) ---
class LJNArtsPage extends StatefulWidget {
  const LJNArtsPage({super.key});

  @override
  State<LJNArtsPage> createState() => _LJNArtsPageState();
}

class _LJNArtsPageState extends State<LJNArtsPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final Map<int, VideoPlayerController> _videoControllers;
  late final LJNSystemCubit _systemCubit;
  late final List<VideoData> _videoDataList;

  late AnimationController _animationController;
  late Animation<double> _panelAnimation;

  // 保存视频播放状态
  bool _wasPlayingBeforePanel = false;

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
    // 添加更多评论数据以测试滚动
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

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    _systemCubit = context.read<LJNSystemCubit>();
    _videoControllers = {};
    _videoDataList = _createMockVideoData();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    _panelAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

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

  // --- 数据和视频控制方法 (无需改动) ---
  List<VideoData> _createMockVideoData() {
    return [
      VideoData(
          videoPath: '${_systemCubit.state.cdnBase}/ins/video2.mp4',
          avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_10.jpg',
          userName: '牛马的home',
          description:
              '我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活...',
          likeCount: 1050,
          commentCount: 241,
          collectionCount: 421,
          shareCount: 934),
      VideoData(
          videoPath: '${_systemCubit.state.cdnBase}/ins/video2.mp4',
          avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_11.jpg',
          userName: 'Flutter开发者',
          description: '用Flutter做出的短视频流，性能和体验都非常棒！#Flutter #App开发 #编程',
          likeCount: 2048,
          commentCount: 512,
          collectionCount: 1024,
          shareCount: 128,
          isLiked: true),
      VideoData(
          videoPath: '${_systemCubit.state.cdnBase}/ins/video2.mp4',
          avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_12.jpg',
          userName: '旅行的风',
          description: '世界的尽头是什么样子？跟我一起来看看吧。#旅行 #风景 #Vlog',
          likeCount: 996,
          commentCount: 188,
          collectionCount: 350,
          shareCount: 77),
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

    // [修改] 现在，只要视频在播放，就更新进度。显示/隐藏由其他逻辑控制
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
    _animationController.dispose();
    _videoControllers.forEach((_, controller) {
      controller.removeListener(_onVideoChange);
      controller.dispose();
    });

    // [新增] 确保退出页面时重置偏移量
    _systemCubit.updateVideoProgressBottomOffset(0);
    _systemCubit.updateVideoProgress(progress: 0.0, show: false);
    super.dispose();
  }

  void _showCommentsPanel() {
    // 保存当前视频的播放状态
    if (_currentVideoController != null &&
        _currentVideoController!.value.isInitialized) {
      _wasPlayingBeforePanel = _currentVideoController!.value.isPlaying;
    }

    // 确保打开面板时，Cubit中的进度条是可见的
    _systemCubit.updateVideoProgress(show: true);
    _animationController.forward();
  }

  void _hideCommentsPanel() {
    _animationController.reverse().then((_) {
      // 面板完全关闭后，根据之前保存的状态恢复视频播放
      if (_wasPlayingBeforePanel &&
          _currentVideoController != null &&
          _currentVideoController!.value.isInitialized &&
          !_currentVideoController!.value.isPlaying) {
        _currentVideoController!.play();
      }
    });
  }

  void _showArtInfoModalSheet(BuildContext context) {
    final currentVideoData = _videoDataList[_currentPage];

    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          return _ArtInfoModalContent(
            currentVideoData: currentVideoData,
            systemState: systemState,
          );
        },
      ),
    );
  }

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
        final screenHeight = MediaQuery.of(context).size.height;
        final videoHeight = screenHeight - systemState.tabbarHeight;
        final double commentPanelMaxHeight = screenHeight * 0.55;

        return Scaffold(
          backgroundColor: Colors.black,
          body: SizedBox(
            height: videoHeight,
            child: AnimatedBuilder(
              animation: _panelAnimation,
              builder: (context, child) {
                final panelProgress = _panelAnimation.value;
                final videoScale = 1.0 - (panelProgress * 0.25);
                final videoTopOffset = panelProgress * -(screenHeight * 0.1);
                final isPanelOpen =
                    _animationController.status != AnimationStatus.dismissed;

                // [新增逻辑] 在动画的每一帧计算并更新进度条的底部偏移量
                final double currentProgressBarOffset =
                    panelProgress * commentPanelMaxHeight;
                _systemCubit
                    .updateVideoProgressBottomOffset(currentProgressBarOffset);

                return Stack(
                  children: [
                    // --- 1. 背景视频 & 主界面 UI ---
                    Transform.translate(
                      offset: Offset(0, videoTopOffset),
                      child: Transform.scale(
                        scale: videoScale,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              scrollDirection: Axis.vertical,
                              physics: isPanelOpen
                                  ? const NeverScrollableScrollPhysics()
                                  : const PageScrollPhysics(),
                              itemCount: _videoDataList.length,
                              itemBuilder: (context, index) {
                                final controller =
                                    _createVideoControllerForIndex(index);
                                final videoData = _videoDataList[index];
                                return Stack(
                                  children: [
                                    LJNCustomVideoPlayer(
                                      key: ValueKey('video_$index'),
                                      canPlay: index == _currentPage,
                                      controller: controller,
                                      videoHeight: videoHeight,
                                      enableTapToPlay: !isPanelOpen,
                                      isPanelOpen: isPanelOpen,
                                    ),
                                    // 作者信息和作品简介 - 跟随视频滑动
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: _VideoInfoSection(
                                        avatarUrl: videoData.avatarPath,
                                        userName: videoData.userName,
                                        description: videoData.description,
                                      ),
                                    ),
                                    // 操作按钮 - 跟随视频滑动
                                    Positioned(
                                      bottom: 0,
                                      right: 10.w,
                                      width: 100.w,
                                      height: 700.w,
                                      child: _buildActionButtons(videoData),
                                    ),
                                  ],
                                );
                              },
                            ),
                            FadeTransition(
                              opacity: Tween<double>(begin: 1.0, end: 0.0)
                                  .animate(_panelAnimation),
                              child: IgnorePointer(
                                ignoring: isPanelOpen,
                                child: Stack(
                                  children: [
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
                                                    color:
                                                        AppColors.neutralWhite,
                                                    size: 48.w)))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- 2. 评论面板覆盖层 ---
                    if (isPanelOpen)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: _hideCommentsPanel,
                          child: Container(
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  height: commentPanelMaxHeight,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                            begin: const Offset(0, 1),
                                            end: Offset.zero)
                                        .animate(_panelAnimation),
                                    child: GestureDetector(
                                      onTap: () {}, // 消费点击事件，防止点击面板关闭
                                      child: LJNCommentPanel(
                                        comments: _comments,
                                        onClose: _hideCommentsPanel,
                                        panelHeight: commentPanelMaxHeight,
                                        showInput: true,
                                        // [核心交互] 连接主页面和评论面板的滚动
                                        onOverScroll: (delta) {
                                          // scrollDelta 在向下拉时是负数
                                          _animationController.value -=
                                              delta / commentPanelMaxHeight;
                                        },
                                        onOverScrollEnd: () {
                                          if (_animationController.value <
                                              0.5) {
                                            _hideCommentsPanel();
                                          } else {
                                            _showCommentsPanel();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // --- 辅助构建方法 ---
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
        _buildActionButton(const IconData(0xe665, fontFamily: 'Iconfont'),
            count: videoData.commentCount.toString(),
            onTap: _showCommentsPanel),
        SizedBox(height: 35.w),
        _buildActionButton(const IconData(0xe602, fontFamily: 'Iconfont'),
            color: videoData.isCollected ? Colors.yellow : Colors.white,
            count: videoData.collectionCount.toString(), onTap: () {
          setState(() {
            videoData.isCollected = !videoData.isCollected;
          });
        }),
        SizedBox(height: 35.w),
        _buildActionButton(const IconData(0xe6c7, fontFamily: 'Iconfont'),
            count: videoData.shareCount.toString(),
            onTap: () => _showArtShareModalSheet(context)),
        SizedBox(height: 35.w),
        GestureDetector(
            child: Icon(const IconData(0xe6e6, fontFamily: 'Iconfont'),
                color: AppColors.neutralWhite, size: 63.w),
            onTap: () => _showArtInfoModalSheet(context)),
      ],
    );
  }

  Widget _buildActionButton(IconData icondata,
      {String count = "0",
      Color color = AppColors.neutralWhite,
      GestureTapCallback? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(icondata, color: color, size: 63.w),
          SizedBox(height: 10.w),
          Text(count,
              style: TextStyle(
                  fontSize: 22.w,
                  color: AppColors.neutralWhite,
                  fontWeight: FontWeight.bold))
        ]));
  }
}

// --- 作品信息弹框内容组件 (支持下拉拖拽关闭) ---
class _ArtInfoModalContent extends StatefulWidget {
  final VideoData currentVideoData;
  final SystemState systemState;

  const _ArtInfoModalContent({
    required this.currentVideoData,
    required this.systemState,
  });

  @override
  State<_ArtInfoModalContent> createState() => _ArtInfoModalContentState();
}

class _ArtInfoModalContentState extends State<_ArtInfoModalContent> {
  double _dragOffset = 0.0;
  bool _isDragging = false;
  final double _closeThreshold = 150.0; // 拖拽关闭阈值

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDragging && details.delta.dy > 0) {
      // 开始向下拖拽
      setState(() {
        _isDragging = true;
      });
    }

    if (_isDragging) {
      setState(() {
        _dragOffset += details.delta.dy;
        // 限制最小偏移量
        if (_dragOffset < 0) _dragOffset = 0;
      });
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isDragging) {
      if (_dragOffset > _closeThreshold) {
        // 超过阈值，关闭弹框
        Navigator.of(context).pop();
      } else {
        // 未超过阈值，恢复原位
        setState(() {
          _dragOffset = 0.0;
          _isDragging = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double opacity = 1.0 - (_dragOffset / _closeThreshold).clamp(0.0, 0.5);
    final double scale = 1.0 - (_dragOffset / _closeThreshold * 0.1).clamp(0.0, 0.1);

    return GestureDetector(
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: AnimatedContainer(
        duration: _isDragging ? Duration.zero : const Duration(milliseconds: 300),
        curve: _isDragging ? Curves.linear : Curves.easeOut,
        transform: Matrix4.translationValues(0, _dragOffset, 0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha((204 * opacity).toInt()), // 动态透明度
              Colors.black.withAlpha((230 * opacity).toInt()), // 动态透明度
            ],
          ),
        ),
        child: Transform.scale(
          scale: scale,
          child: Column(
            children: [
              // 顶部关闭按钮
              Container(
                padding: EdgeInsets.only(
                  top: widget.systemState.statusHeight + 20.w,
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
                        color: Colors.white.withAlpha((255 * opacity).toInt()),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((30 * opacity).toInt()),
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close,
                          color: Colors.white.withAlpha((255 * opacity).toInt()),
                          size: 32.w,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),

              // 作品信息卡片
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 基本信息卡片
                      _buildInfoCard(
                        icon: Icons.info_outline,
                        title: '基本信息',
                        children: [
                          _buildInfoItem('作品名称', widget.currentVideoData.userName),
                          _buildInfoItem('作者', widget.currentVideoData.userName),
                          _buildInfoItem('发布时间', '2024-10-20 15:30:00'),
                          _buildInfoItem('地点', '中国·广州'),
                        ],
                      ),

                      SizedBox(height: 16.w),

                      // 作品内容卡片
                      _buildInfoCard(
                        icon: Icons.description,
                        title: '作品内容',
                        children: [
                          _buildDescriptionItem('作品描述', widget.currentVideoData.description),
                          _buildTagsItem('作品标签', ['#懒人救星', '#居家办公', '#电竞', '#游戏', '#男生房间', '#INGREM', '#治愈', '#生活']),
                        ],
                      ),

                      SizedBox(height: 16.w),

                      // 技术信息卡片
                      _buildInfoCard(
                        icon: Icons.storage,
                        title: '技术信息',
                        children: [
                          _buildInfoItem('文件大小', '2.3 MB'),
                          _buildInfoItem('文件格式', 'MP4'),
                          _buildInfoItem('分辨率', '1080x1920'),
                          _buildInfoItem('时长', '15秒'),
                          _buildInfoItem('IPFS地址', 'https://ipfs.io/ipfs/Qm${widget.currentVideoData.videoPath.hashCode.toRadixString(16)}'),
                        ],
                      ),

                      SizedBox(height: 16.w),

                      // 互动数据卡片
                      _buildInfoCard(
                        icon: Icons.analytics,
                        title: '互动数据',
                        children: [
                          Wrap(
                            spacing: 12.w,
                            runSpacing: 12.w,
                            children: [
                              _buildStatsItem('点赞', widget.currentVideoData.likeCount.toString(), Icons.favorite),
                              _buildStatsItem('评论', widget.currentVideoData.commentCount.toString(), Icons.comment),
                              _buildStatsItem('转发', widget.currentVideoData.shareCount.toString(), Icons.share),
                              _buildStatsItem('收藏', widget.currentVideoData.collectionCount.toString(), Icons.bookmark),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 16.w),

                      // 版权信息卡片
                      _buildInfoCard(
                        icon: Icons.copyright,
                        title: '版权信息',
                        children: [
                          _buildInfoItem('版权状态', '原创作品'),
                          _buildInfoItem('授权方式', 'CC BY-NC 4.0'),
                          _buildInfoItem('区块链哈希', '0x${widget.currentVideoData.videoPath.hashCode.toRadixString(16)}'),
                        ],
                      ),

                      // 底部额外空隙，便于滚动
                      SizedBox(height: 100.w),
                    ],
                  ),
                ),
              ),

              // 底部间距
              SizedBox(height: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  // 构建方法需要从外部类复制过来，或者通过参数传递
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25), // 0.1 opacity
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(color: Colors.white.withAlpha(51)), // 0.2 opacity
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 卡片标题
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white.withAlpha(204), // 0.8 opacity
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
            // 卡片内容
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
                color: Colors.white.withAlpha(204), // 0.8 opacity
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
              color: Colors.white.withAlpha(204), // 0.8 opacity
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
              color: Colors.white.withAlpha(204), // 0.8 opacity
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.w),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            children: tags.map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
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
            )).toList(),
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

// --- 视频信息组件 (无需改动) ---
class _VideoInfoSection extends StatefulWidget {
  final String userName;
  final String avatarUrl;
  final String description;
  const _VideoInfoSection(
      {required this.userName,
      required this.avatarUrl,
      required this.description});
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
        color: AppColors.neutralWhite);
    return Container(
      width: 600.w,
      padding: EdgeInsets.all(25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/author/detail', arguments: {
                'author_id': widget.userName,
                'author_name': widget.userName,
                'author_avatar': widget.avatarUrl,
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
              // decoration: BoxDecoration(
              //   color: Colors.black.withAlpha(120),
              //   borderRadius: BorderRadius.circular(32.w),
              // ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: LJNAppNetworkImage(
                      imageUrl: widget.avatarUrl,
                      width: 64.w,
                      height: 64.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    widget.userName,
                    style: TextStyle(
                      fontSize: fontSizeScale(30.w),
                      color: AppColors.neutralWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () => logger.info("点击了关注按钮"),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
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
            ),
          ),
          SizedBox(height: 20.w),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                if (isLongText) setState(() => _isExpanded = !_isExpanded);
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
        text: TextSpan(style: descriptionStyle, children: [
      TextSpan(text: displayedText),
      if (isLongText)
        TextSpan(
            text: "... 更多",
            style: descriptionStyle.copyWith(
                color: Colors.white.withAlpha(180),
                fontWeight: FontWeight.bold))
    ]));
  }

  Widget _buildExpandedDescription(TextStyle descriptionStyle) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(200),
          borderRadius: BorderRadius.circular(12.w)),
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 350.w),
            child: Padding(
                padding: EdgeInsets.all(20.w),
                child: SingleChildScrollView(
                    child: Text(widget.description, style: descriptionStyle))),
          ),
          Positioned(
              bottom: 15.w,
              right: 15.w,
              child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = false),
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8.w)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
                      child: Text("收起",
                          textAlign: TextAlign.center,
                          style: descriptionStyle.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.w))))),
        ],
      ),
    );
  }
}
