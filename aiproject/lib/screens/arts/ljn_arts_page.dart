// /lib/widgets/ljn_arts.dart

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

  // [FIX 1] Declare a member variable to hold a reference to the Cubit.
  late final LJNSystemCubit _systemCubit;

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

    _pageController.addListener(() {
      if (!_pageController.hasClients || _pageController.page == null) return;
      final newPage = _pageController.page!.round();
      if (_currentPage != newPage) {
        setState(() {
          _videoControllers[_currentPage]?.removeListener(_onVideoChange);
          _currentPage = newPage;
          _currentVideoController?.addListener(_onVideoChange);
          _onVideoChange();
        });
      }
    });
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
    final controller = VideoPlayerController.asset(
      assetPath('images/ins/video2.mp4'),
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
      logger.warning("视频初始化失败 (index $index): $error");
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

  // 更多作品信息
  void _showArtInfoModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // builder 返回的就是你想在 BottomSheet 中显示的任意 Widget
        return Container(
          height: 250, // 可以指定高度
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('更多作品信息'),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('关闭'),
                  onPressed: () => Navigator.pop(context), // 点击按钮关闭
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 转发
  void _showArtShareModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // builder 返回的就是你想在 BottomSheet 中显示的任意 Widget
        return Container(
          height: 250, // 可以指定高度
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('转发作品'),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('关闭'),
                  onPressed: () => Navigator.pop(context), // 点击按钮关闭
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 评论
  void _showArtCommentModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // builder 返回的就是你想在 BottomSheet 中显示的任意 Widget
        return Container(
          height: 250, // 可以指定高度
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('评论作品'),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('关闭'),
                  onPressed: () => Navigator.pop(context), // 点击按钮关闭
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool liked = false;
  bool collected = false;

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
              itemCount: 100,
              itemBuilder: (context, index) {
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
                        child: _VideoInfoSection(
                          // 为了演示，这里使用了一些假数据和长文本
                          avatarUrl: 'images/avatar_webp/chat_10.webp',
                          userName: '牛马的home',
                          description:
                              '我真的太爱我的游戏房了！😭😭😭 这一刻仿佛被钉在了客厅 #懒人救星 #居家办公 #电竞 #游戏 #男生房间 #INGREM #治愈 #生活... 这里省略了很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多-/+--+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+--+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--',
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
                              color: liked
                                  ? const Color.fromARGB(255, 247, 21, 5)
                                  : Colors.white,
                              count: "1050",
                              onTap: () {
                                logger.info("点赞");
                                setState(() {
                                  liked = !liked;
                                });
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 评论
                            _buildActionButton(
                              const IconData(0xe665, fontFamily: 'Iconfont'),
                              count: "241",
                              onTap: () {
                                logger.info("评论");
                                _showArtCommentModalSheet(context);
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 收藏
                            _buildActionButton(
                              const IconData(0xe602, fontFamily: 'Iconfont'),
                              color: collected
                                  ? const Color.fromARGB(255, 209, 15, 1)
                                  : Colors.white,
                              count: "421",
                              onTap: () {
                                logger.info("收藏");
                                setState(() {
                                  collected = !collected;
                                });
                              },
                            ),
                            SizedBox(height: 35.w),
                            // 转发
                            _buildActionButton(
                              const IconData(0xe6c7, fontFamily: 'Iconfont'),
                              count: "934",
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
                                    IconData(0xe6e6, fontFamily: 'Iconfont'),
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

// =======================================================================
// [新增] 封装了用户信息和可展开描述的独立组件
// =======================================================================
class _VideoInfoSection extends StatefulWidget {
  final String userName;
  final String avatarUrl;
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
                child: Image.asset(
                  assetPath(widget.avatarUrl),
                  width: 64.w,
                  height: 64.w,
                  fit: BoxFit.cover,
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

  // [关键改动] _buildExpandedDescription 方法已更新
  Widget _buildExpandedDescription(TextStyle descriptionStyle) {
    ThemeData theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias, // 确保内容不会溢出圆角
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200), // 背景色稍微加深以突显
        borderRadius: BorderRadius.circular(12.w),
      ),
      // 使用 Stack 来实现分层布局
      child: Stack(
        children: [
          // 可滚动的文本区域
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 350.w, // 展开后的最大高度
            ),
            // 使用一个内层Padding来防止文本紧贴边缘，并为“收起”按钮留出空间
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                20,
              ).w,
              child: SingleChildScrollView(
                child: Text(
                  widget.description,
                  style: descriptionStyle,
                ),
              ),
            ),
          ),
          // 固定在右下角的 "收起" 按钮
          Positioned(
            bottom: 15.w,
            right: 15.w,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8.w),
              ),
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 5,
                bottom: 5,
              ).w,
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
