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

  // ############### 1. 状态标志 ###############
  bool _wasPlaying = false;
  bool _wasPlayingBeforeTabSwitch = false;
  // #########################################

  // ===================== 1. 静音状态管理 =====================
  // 初始状态为静音，以符合浏览器自动播放策略
  bool _isMuted = true;
  // ==========================================================

  bool _isPanelOpen = false;
  bool _isCommentPanel = false;
  bool _hideVideoInfo = false;

  // 滑动透明度相关
  double _currentPageOpacity = 1.0;
  double _nextPageOpacity = 1.0;

  // 播放按钮状态
  bool _showPlayIcon = false;

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

  @override
  void deactivate() {
    super.deactivate();
    _handleTabInactive();
  }

  @override
  void activate() {
    super.activate();
    _handleTabActive();
  }

  void _handleTabInactive() {
    if (_currentVideoController?.value.isInitialized ?? false) {
      _wasPlaying = _currentVideoController!.value.isPlaying;
    }
    _currentVideoController?.pause();
  }

  void _handleTabActive() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    if (_wasPlaying && _currentVideoController?.value.isInitialized == true) {
      _currentVideoController?.play().catchError((error) {
        logger.warning("恢复播放失败: $error");
      });
    }
  }

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

      final currentPage = _pageController.page!;
      final pageFraction = currentPage - currentPage.floor();

      final currentOpacity = 1.0 - pageFraction.abs();
      final nextOpacity = 1.0;

      final clampedCurrentOpacity = currentOpacity.clamp(0.3, 1.0);
      final clampedNextOpacity = nextOpacity.clamp(0.3, 1.0);

      if (_currentPageOpacity != clampedCurrentOpacity ||
          _nextPageOpacity != clampedNextOpacity) {
        setState(() {
          _currentPageOpacity = clampedCurrentOpacity;
          _nextPageOpacity = clampedNextOpacity;
        });
      }

      final newPage = currentPage.round();
      if (_currentPage != newPage) {
        _videoControllers[_currentPage]?.pause();
        _videoControllers[_currentPage]?.removeListener(_onVideoChange);

        setState(() {
          _currentPage = newPage;

          if (_currentVideoController?.value.isInitialized == true) {
            // 切换视频时，保持当前的静音/有声状态
            _currentVideoController?.setVolume(_isMuted ? 0.0 : 1.0);
            _currentVideoController?.play().catchError((error) {
              logger.warning("切换视频播放失败: $error");
            });
          }
          _currentVideoController?.addListener(_onVideoChange);

          _wasPlaying = _currentVideoController?.value.isPlaying ?? false;
          _showPlayIcon = false;
          _onVideoChange();
        });
      }
    });
  }

  @override
  Future<bool> didPopRoute() async {
    if (_isPanelOpen) {
      _hideCommentsPanel();
      return false;
    }
    _handleRouteActive();
    return false;
  }

  @override
  Future<bool> didPushRoute(String route) async {
    _handleRouteInactive();
    return false;
  }

  void _handleRouteInactive() {
    if (_currentVideoController?.value.isInitialized ?? false) {
      _wasPlaying = _currentVideoController!.value.isPlaying;
    }
    _currentVideoController?.pause();
  }

  void _handleRouteActive() {
    if (_wasPlaying && _currentVideoController?.value.isInitialized == true) {
      _currentVideoController?.play().catchError((error) {
        logger.warning("路由恢复播放失败: $error");
      });
    }
  }

  List<VideoData> _createMockVideoData() {
    return [
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/test.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_10.jpg',
        userName: '牛马的home',
        description:
            '我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活',
        likeCount: 1050,
        commentCount: 241,
        collectionCount: 421,
        viewCount: 1000,
        shareCount: 934,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/butterfly.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_2.jpg',
        userName: 'Flutter开发者',
        description: '用Flutter做出的短视频流，性能和体验都非常棒！#Flutter #App开发 #编程',
        likeCount: 2048,
        commentCount: 512,
        collectionCount: 1024,
        viewCount: 1000,
        shareCount: 128,
        isLiked: true,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_21.jpg',
        userName: '美食探索家',
        description:
            '今天发现了一家超好吃的火锅店！汤底浓郁，食材新鲜，强烈推荐给大家！🔥 #美食探店 #火锅 #吃货日常 #美食分享',
        likeCount: 3250,
        commentCount: 689,
        collectionCount: 1250,
        viewCount: 1000,
        shareCount: 256,
        isLiked: false,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video2.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_33.jpg',
        userName: '旅行日记',
        description:
            '大理的洱海真的太美了！蓝天白云，微风拂面，感觉整个人都被治愈了～🌊 #大理旅行 #洱海 #旅行日记 #治愈系风景',
        likeCount: 4280,
        commentCount: 892,
        collectionCount: 1560,
        viewCount: 1000,
        shareCount: 312,
        isLiked: true,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video3.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_15.jpg',
        userName: '健身达人',
        description: '坚持健身的第365天！从胖子到肌肉男，感谢那个没有放弃的自己💪 #健身 #坚持 #蜕变 #健身日记',
        likeCount: 5120,
        commentCount: 1024,
        collectionCount: 2048,
        viewCount: 1000,
        shareCount: 512,
        isLiked: false,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video4.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_7.jpg',
        userName: '萌宠日常',
        description: '我家猫咪今天又解锁了新睡姿，太可爱了！🐱 #猫咪 #萌宠 #宠物日常 #可爱猫咪',
        likeCount: 2890,
        commentCount: 456,
        collectionCount: 890,
        viewCount: 1000,
        shareCount: 189,
        isLiked: true,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video5.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_25.jpg',
        userName: '美妆博主',
        description: '秋冬必备的温柔奶茶妆教程来啦！新手也能轻松上手～💄 #美妆教程 #奶茶妆 #化妆技巧 #美妆分享',
        likeCount: 3750,
        commentCount: 678,
        collectionCount: 1120,
        viewCount: 1000,
        shareCount: 245,
        isLiked: false,
      ),
      VideoData(
        videoPath: '${_systemCubit.state.cdnBase}/ins/video6.mp4',
        avatarPath: '${_systemCubit.state.cdnBase}/avatar/chat_18.jpg',
        userName: '音乐爱好者',
        description: '深夜弹唱一首《成都》，有没有人也在听这首歌？🎸 #音乐 #弹唱 #成都 #深夜音乐',
        likeCount: 2980,
        commentCount: 512,
        collectionCount: 980,
        viewCount: 1000,
        shareCount: 156,
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

  // ===================== 2. 新增：独立的静音切换方法 =====================
  void _toggleMute() {
    if (!mounted || !_currentVideoController!.value.isInitialized) return;
    setState(() {
      _isMuted = !_isMuted;
      _currentVideoController!.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }
  // ===================================================================

  // ===================== 3. 修改：点击屏幕中央只负责播放/暂停 =====================
  void _togglePlaying() {
    if (!mounted ||
        !_currentVideoController!.value.isInitialized ||
        _isPanelOpen) {
      return;
    }

    setState(() {
      if (_currentVideoController!.value.isPlaying) {
        _currentVideoController!.pause();
        _showPlayIcon = true;
      } else {
        _currentVideoController!.play().catchError((error) {
          logger.warning("用户点击播放失败: $error");
          _showPlayIcon = true;
        });
        _showPlayIcon = false;
      }
    });
  }
  // ========================================================================

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
        // 初始化时，根据全局静音状态设置音量
        controller.setVolume(_isMuted ? 0.0 : 1.0);
        if (index == _currentPage) {
          if (controller.value.isInitialized &&
              controller.value.duration != Duration.zero) {
            controller.play().catchError((playError) {
              logger
                  .warning("视频播放失败 (URL: ${videoData.videoPath}): $playError");
              if (mounted) {
                setState(() {
                  _showPlayIcon = true;
                });
              }
            });
            _wasPlaying = true;
            _showPlayIcon = false;
          } else {
            logger.warning("视频无法播放 (URL: ${videoData.videoPath}): 视频未初始化或时长为0");
            if (mounted) {
              setState(() {
                _showPlayIcon = true;
              });
            }
          }
          controller.addListener(_onVideoChange);
          _onVideoChange();
        }
        setState(() {});
      }
    }).catchError((error) {
      logger.warning("视频初始化失败 (URL: ${videoData.videoPath}): $error");
      if (mounted && index == _currentPage) {
        setState(() {
          _showPlayIcon = true;
        });
      }
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

    if (_wasPlaying && _currentVideoController?.value.isInitialized == true) {
      _currentVideoController?.play().catchError((error) {
        logger.warning("评论面板关闭后恢复播放失败: $error");
      });
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
        if (systemState.mainTabIndex != 0) {
          if (_currentVideoController?.value.isPlaying ?? false) {
            _wasPlayingBeforeTabSwitch = true;
            _currentVideoController?.pause();
          }
        } else {
          if (_wasPlayingBeforeTabSwitch &&
              !(_currentVideoController?.value.isPlaying ?? false) &&
              _currentVideoController?.value.isInitialized == true) {
            _currentVideoController?.play().catchError((error) {
              logger.warning("标签页切换后恢复播放失败: $error");
            });
            _wasPlayingBeforeTabSwitch = false;
          }
        }

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
                      alignment: Alignment.center,
                      children: [
                        if (controller.value.isInitialized)
                          SizedBox(
                            width: controller.value.size.width,
                            height: controller.value.size.height,
                            child: VigaCustomVideoPlayer(
                              key: ValueKey('video_$index'),
                              canPlay: index == _currentPage,
                              controller: controller,
                              videoHeight: normalVideoHeight,
                              enableTapToPlay: !_isPanelOpen,
                              isPanelOpen: _isPanelOpen,
                              fit: controller.value.aspectRatio < 1.0
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                          ),

                        // 播放按钮 - 只在当前页面且视频暂停时显示
                        if (index == _currentPage &&
                            _showPlayIcon &&
                            !_isPanelOpen)
                          Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 80.w,
                            ),
                          ),

                        // 主点击区域 - 覆盖整个视频区域
                        if (index == _currentPage && !_isPanelOpen)
                          GestureDetector(
                            onTap: _togglePlaying,
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),

                        if (!_hideVideoInfo)
                          Opacity(
                            opacity: index == _currentPage
                                ? _currentPageOpacity
                                : _nextPageOpacity,
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
                                // ===================== 4. 修改：右上角按钮区域 =====================
                                Positioned(
                                  top: 15.w + systemState.statusHeight,
                                  right: 15.w, // 调整右边距
                                  child: Row(
                                    children: [
                                      // 静音/有声 切换按钮
                                      GestureDetector(
                                        onTap: _toggleMute,
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.all(12.w),
                                          child: Icon(
                                            _isMuted
                                                ? Icons.volume_off_rounded
                                                : Icons.volume_up_rounded,
                                            color: AppColors.neutralWhite,
                                            size: 48.w,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      // 搜索按钮
                                      GestureDetector(
                                        onTap: () => context.push(
                                          '/search',
                                        ),
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.all(12.w),
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
                                    ],
                                  ),
                                ),
                                // =================================================================
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
