// G:\t\detection\aiproject\lib\screens\arts\viga_arts_page.dart (已修复)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/screens/arts/widgets/viga_video_info.dart';
import 'package:vigaviga/screens/arts/widgets/viga_art_info.dart';
import 'package:vigaviga/screens/arts/widgets/viga_video_data.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_comment_panel.dart';
import 'package:vigaviga/widgets/viga_custom_video_player.dart';

// --- 主页面 ---
class VigaArtsPage extends StatefulWidget {
  const VigaArtsPage({super.key});

  @override
  State<VigaArtsPage> createState() => _VigaArtsPageState();
}

class _VigaArtsPageState extends State<VigaArtsPage>
    with
        TickerProviderStateMixin,
        WidgetsBindingObserver,
        AutomaticKeepAliveClientMixin<VigaArtsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final Map<int, VideoPlayerController> _videoControllers;
  late final VigaSystemCubit _systemCubit;
  late final List<VideoData> _videoDataList;

  // ############### 1. 新增状态标志 ###############
  // 用于记录用户离开前视频是否在播放
  bool _wasPlaying = false;
  // #########################################

  bool _isPanelOpen = false;
  bool _isCommentPanel = false;
  bool _hideVideoInfo = false;

  // 滑动透明度相关
  double _pageScrollOpacity = 1.0;

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
  bool get wantKeepAlive => true;

  // ############### 2. 核心修改：deactivate 和 activate ###############
  @override
  void deactivate() {
    // 当页面变为不活动时（例如切换Tab）
    super.deactivate();
    // 1. 记录下当前视频是否正在播放
    if (_currentVideoController?.value.isInitialized ?? false) {
      _wasPlaying = _currentVideoController!.value.isPlaying;
    }
    // 2. 强制暂停视频，防止后台播放
    _currentVideoController?.pause();
  }

  @override
  void activate() {
    // 当页面被重新激活时
    super.activate();
    // 3. 重置状态栏样式，确保视觉正确
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    // 4. 如果离开前视频是在播放状态，则恢复播放
    if (_wasPlaying) {
      _currentVideoController?.play();
    }
  }
  // ###############################################################

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scrollableController = DraggableScrollableController();

    _videoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );

    _systemCubit = context.read<VigaSystemCubit>();
    _videoControllers = {};
    _videoDataList = _createMockVideoData();

    _pageController.addListener(() {
      if (!_pageController.hasClients || _pageController.page == null) return;

      // 计算滑动透明度
      final currentPage = _pageController.page!;
      final pageFraction = currentPage - currentPage.floor();
      final opacity = 1.0 - pageFraction.abs();

      // 确保透明度在0.3到1.0之间（不完全透明）
      final clampedOpacity = opacity.clamp(0.3, 1.0);

      if (_pageScrollOpacity != clampedOpacity) {
        setState(() {
          _pageScrollOpacity = clampedOpacity;
        });
      }

      final newPage = currentPage.round();
      if (_currentPage != newPage) {
        // 暂停旧视频
        _videoControllers[_currentPage]?.pause();
        _videoControllers[_currentPage]?.removeListener(_onVideoChange);

        setState(() {
          _currentPage = newPage;

          // 播放新视频
          _currentVideoController?.play();
          _currentVideoController?.addListener(_onVideoChange);

          // 更新wasPlaying状态
          _wasPlaying = _currentVideoController?.value.isPlaying ?? false;
          _onVideoChange();
        });
      }
    });
  }

  @override
  Future<bool> didPopRoute() async {
    // 当系统返回按钮被按下时，确保评论面板状态正确重置
    if (_isPanelOpen) {
      _hideCommentsPanel();
      return false; // 允许默认返回行为继续处理
    }
    return false; // 允许默认返回行为
  }

  List<VideoData> _createMockVideoData() {
    return [
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video2.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_10.jpg',
        userName: '牛马的home',
        description:
            '我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间男生房间 #INGREM #治愈 #生活...',
        likeCount: 1050,
        commentCount: 241,
        collectionCount: 421,
        viewCount: 1000,
        shareCount: 934,
      ),
      VideoData(
        videoPath:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_11.jpg',
        userName: 'Flutter开发者',
        description: '用Flutter做出的短视频流，性能和体验都非常棒！#Flutter #App开发 #编程',
        likeCount: 2048,
        commentCount: 512,
        collectionCount: 1024,
        viewCount: 1000,
        shareCount: 128,
        isLiked: true,
      ),
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
          // 首次播放时，更新wasPlaying状态
          _wasPlaying = true;
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
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _videoControllers.forEach((_, controller) {
      controller.removeListener(_onVideoChange);
      controller.dispose();
    });
    _systemCubit.updateVideoProgress(progress: 0.0, show: false);
    _systemCubit.updateShowHomeTabbar(true);
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
    logger.info('_showCommentsPanel called - setting _hideVideoInfo to true');
    _systemCubit.updateVideoProgress(show: false);
    _systemCubit.updateShowHomeTabbar(false);

    // 打开评论面板前暂停视频
    if (_currentVideoController?.value.isInitialized ?? false) {
      _wasPlaying = _currentVideoController!.value.isPlaying;
      _currentVideoController!.pause();
    }

    setState(() {
      _isPanelOpen = true;
      _isCommentPanel = true;
      _hideVideoInfo = true;
    });

    late Animation<double> transitionAnimation;
    // 入场动画监听
    void entryAnimationListener() {
      _videoAnimationController.value = 1.0 - transitionAnimation.value;
    }

    final route = showModalBottomSheet<void>(
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
                onTap: () => modalContext.pop(),
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
                return BlocBuilder<VigaSystemCubit, SystemState>(
                    builder: (context, systemState) {
                  return VigaCommentPanel(
                    comments: _comments,
                    onClose: () => context.pop(),
                    showInput: true,
                    scrollController: scrollController,
                    systemState: systemState,
                    onCommentSubmitted: (comment) {
                      logger.info('用户提交评论: $comment');
                    },
                  );
                });
              },
            ),
          ],
        );
      },
    );

    route.then((_) {
      _scrollableController.removeListener(_onPanelDrag);
      transitionAnimation.removeListener(entryAnimationListener);
      _hideCommentsPanel();
    });
  }

  void _hideCommentsPanel() {
    logger.info(
        '_hideCommentsPanel called - _isPanelOpen: $_isPanelOpen, _hideVideoInfo: $_hideVideoInfo');

    _systemCubit.updateShowHomeTabbar(true);
    _systemCubit.updateVideoProgress(show: true);

    // 关闭评论面板后，如果之前在播放，则恢复播放
    if (_wasPlaying) {
      _currentVideoController?.play();
    }

    if (mounted) {
      logger.info('Setting _hideVideoInfo to false in setState');
      setState(() {
        _isPanelOpen = false;
        _isCommentPanel = false;
        _hideVideoInfo = false;
      });
    } else {
      logger.info('Widget not mounted, cannot call setState');
    }

    if (mounted && _videoAnimationController.value != 1.0) {
      _videoAnimationController.animateTo(1.0, curve: Curves.easeOutQuart);
    }
  }

  void _showArtInfoModalSheet(BuildContext context) {
    final currentVideoData = _videoDataList[_currentPage];

    setState(() {
      _isPanelOpen = true;
      _isCommentPanel = false;
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
            return BlocBuilder<VigaSystemCubit, SystemState>(
              builder: (context, systemState) {
                return VigaArtInfoModalContent(
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
    });
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
                onPressed: () => context.pop(),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    logger.info(
        'build called - _hideVideoInfo: $_hideVideoInfo, _isPanelOpen: $_isPanelOpen, _isCommentPanel: $_isCommentPanel');
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        final viewPadding = MediaQuery.of(context).padding;
        final screenHeight = systemState.screenSize.height;
        final screenWidth = systemState.screenSize.width;

        final panelMaxSize = 0.6;
        final topAreaHeight = screenHeight * (1.0 - panelMaxSize);

        final shrunkVideoTopMargin = viewPadding.top + 20.h;

        final shrunkVideoHeight = topAreaHeight;
        final videoAspectRatio =
            _currentVideoController?.value.isInitialized ?? false
                ? _currentVideoController!.value.aspectRatio
                : 9.0 / 16.0;
        final shrunkVideoWidth = shrunkVideoHeight * videoAspectRatio;
        final normalVideoHeight =
            screenHeight - systemState.bottomNavigationBarHeight;

        double interpolate(double start, double end, double progress) {
          return start + (end - start) * progress;
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            ),
            child: AnimatedBuilder(
              animation: _videoAnimationController,
              builder: (context, child) {
                final progress = _videoAnimationController.value;

                final currentVideoHeight = (_isPanelOpen && _isCommentPanel)
                    ? interpolate(
                        shrunkVideoHeight, normalVideoHeight, progress)
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
                      alignment: Alignment.center,
                      children: [
                        if (controller.value.isInitialized)
                          FittedBox(
                            fit: controller.value.aspectRatio < 1.0
                                ? BoxFit.cover
                                : BoxFit.contain,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: controller.value.size.width,
                              height: controller.value.size.height,
                              child: VigaCustomVideoPlayer(
                                key: ValueKey('video_$index'),
                                canPlay: index == _currentPage,
                                controller: controller,
                                videoHeight: normalVideoHeight,
                                enableTapToPlay: !_isPanelOpen,
                                isPanelOpen: _isPanelOpen,
                              ),
                            ),
                          ),
                        if (!_hideVideoInfo)
                          Opacity(
                            opacity: _pageScrollOpacity,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  bottom: 0.w,
                                  child: VigaVideoInfoSection(
                                    avatarUrl: videoData.avatarPath,
                                    userName: videoData.userName,
                                    description: videoData.description,
                                  ),
                                ),
                                Positioned(
                                  bottom: 30.w,
                                  right: 10.w,
                                  width: 100.w,
                                  child: _buildActionButtons(videoData),
                                ),
                                Positioned(
                                  top: 15.w + systemState.statusHeight,
                                  right: 28.w,
                                  child: GestureDetector(
                                    onTap: () => context.push(
                                      '/discovery/search',
                                    ),
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 58.w,
                                      child: Icon(
                                        const IconData(
                                          0xe612,
                                          fontFamily: 'Iconfont',
                                        ),
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
        SizedBox(height: 20.w),
        _buildActionButton(
          const IconData(0xe665, fontFamily: 'Iconfont'),
          count: videoData.commentCount.toString(),
          onTap: _showCommentsPanel,
        ),
        SizedBox(height: 20.w),
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
        SizedBox(height: 20.w),
        _buildActionButton(
          const IconData(0xe6c7, fontFamily: 'Iconfont'),
          count: videoData.shareCount.toString(),
          onTap: () => _showArtShareModalSheet(context),
        ),
        SizedBox(height: 20.w),
        _buildActionButton(
          const IconData(0xe6e6, fontFamily: 'Iconfont'),
          count: '',
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
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.w,
          horizontal: 12.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icondata, color: color, size: 63.w),
            SizedBox(height: 8.w),
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
      ),
    );
  }
}
