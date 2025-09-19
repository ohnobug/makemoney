import 'dart:async'; // 导入 Timer 用于UI自动隐藏

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

// 主页面，承载垂直滚动的视频流
class LJNArts extends StatefulWidget {
  const LJNArts({super.key});

  @override
  State<LJNArts> createState() => _LJNArts();
}

class _LJNArts extends State<LJNArts> {
  // PageView 的控制器，用于管理页面切换
  final PageController _pageController = PageController();
  // 当前正在显示的页面索引
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // 设置状态栏样式为透明背景和亮色图标（白色）
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent, // 状态栏背景透明
        statusBarIconBrightness: Brightness.light, // 状态栏图标（时间、电量）为亮色
      ),
    );

    // 监听 PageView 的滚动事件
    _pageController.addListener(() {
      // 当页面滚动时，计算出当前页面的索引并更新状态
      // `page!.round()` 可以准确地在页面切换动画完成时获取到目标页面的索引
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // 在 widget 销毁时释放控制器资源，防止内存泄漏
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 使用 BlocBuilder 获取系统状态，主要是为了适配状态栏高度
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false, // Scaffold 的 body 是否延伸到状态栏区域
          appBar: null, // 不使用标准的 AppBar
          body: Stack(
            children: [
              // 视频流的主体内容
              Column(
                children: [
                  SizedBox(
                    width: 750.w,
                    // 计算 PageView 的高度，减去底部导航栏的高度
                    height: MediaQuery.of(context).size.height - 106.w,
                    // PageView 用于实现垂直滑动切换视频
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical, // 垂直方向滚动
                      itemCount: 100, // 假设有100个视频
                      itemBuilder: (context, index) {
                        // 判断当前构建的这个页面是否为正在显示的页面
                        bool isCurrentPage = index == _currentPage;

                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: theme.colorScheme.onSurface, // 视频加载时的背景色
                          child: Stack(
                            children: [
                              // 视频播放器组件
                              CustomVideoPlayer(canPlay: isCurrentPage),

                              // 顶部的搜索按钮
                              Positioned(
                                top: 30.w + systemState.statusHeight, // 适配状态栏
                                right: 28.w,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/search',
                                      );
                                    },
                                    child: Container(
                                      color: Colors.transparent, // 增大点击区域
                                      height: 58.w,
                                      child: Icon(
                                        color: AppColors.neutralWhite,
                                        const IconData(
                                          0xe612,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 42.w,
                                      ),
                                    )),
                              ),

                              // 左下角的视频简介信息
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: 575.w,
                                  padding: EdgeInsets.all(25.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 用户名
                                      LJNTextSpans(
                                        text: "@深圳黑马眼科💖",
                                        style: TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(33.w),
                                          color: AppColors.neutralWhite,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "AlibabaPuHuiTi",
                                        ),
                                        emojiStyle: TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(33.w),
                                          fontFamily: "NotoColorEmoji-Regular",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.w,
                                      ),
                                      // 视频描述
                                      LJNTextSpans(
                                        text:
                                            "深圳黑马眼科, 一家只做近视手术的专科医院,抖音推出1元近视手术",
                                        style: TextStyle(
                                          height: 1.35,
                                          fontSize: fontSizeScale(28.w),
                                          color: AppColors.neutralWhite,
                                          fontFamily: "AlibabaPuHuiTi",
                                        ),
                                        emojiStyle: TextStyle(
                                          height: 1.35,
                                          fontSize: fontSizeScale(28.w),
                                          fontFamily: "NotoColorEmoji-Regular",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // 右侧的点赞、评论等操作按钮
                              Positioned(
                                bottom: 0,
                                right: 10.w,
                                child: SizedBox(
                                  width: 100.w,
                                  height: 778.w,
                                  child: Column(
                                    children: [
                                      // 头像
                                      Container(
                                        width: 100.0.w,
                                        height: 100.0.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(100.w),
                                          image: DecorationImage(
                                            image: ResizeImage(
                                              AssetImage(
                                                assetPath(
                                                    'images/avatar_webp/chat_10.webp'),
                                              ),
                                              width: 180.w.toInt(),
                                              height: 180.w.toInt(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                              color: AppColors.neutralWhite,
                                              width: 4.w),
                                        ),
                                      ),

                                      // “加关注”图标
                                      Transform.translate(
                                        offset: Offset(0, -20.w),
                                        child: Container(
                                          width: 40.w,
                                          height: 40.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.accentRedVibrant1,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(40.w),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              const IconData(
                                                0xe616,
                                                fontFamily: 'Iconfont',
                                              ),
                                              color: AppColors.neutralWhite,
                                              size: 28.w,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // 点赞按钮和数量
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe61e,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: AppColors.neutralWhite,
                                            size: 63.w,
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                                fontSize: 22.w,
                                                color: AppColors.neutralWhite),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 43.w,
                                      ),

                                      // 评论按钮和数量
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe665,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: AppColors.neutralWhite,
                                            size: 63.w,
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                                fontSize: 22.w,
                                                color: AppColors.neutralWhite),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 43.w,
                                      ),

                                      // 收藏按钮和数量
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe602,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: AppColors.neutralWhite,
                                            size: 63.w,
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                              fontSize: 22.w,
                                              color: AppColors.neutralWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 43.w,
                                      ),

                                      // 转发按钮和数量
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe6c7,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: AppColors.neutralWhite,
                                            size: 63.w,
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                              fontSize: 22.w,
                                              color: AppColors.neutralWhite,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// 自定义视频播放器组件
class CustomVideoPlayer extends StatefulWidget {
  // `canPlay` 标志位，由父组件（PageView）传递，用于控制视频是否应该播放
  final bool? canPlay;

  const CustomVideoPlayer({super.key, this.canPlay});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  // 视频播放控制器，用于控制视频的播放、暂停、进度等
  late VideoPlayerController? _videoController;

  // 控制播放/暂停按钮、进度条等UI是否可见
  bool _controlsVisible = false;
  // 用于自动隐藏控制UI的计时器
  Timer? _hideControlsTimer;

  // 监听父组件的 `canPlay` 属性变化
  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果 `canPlay` 的状态发生了变化
    if (oldWidget.canPlay != widget.canPlay) {
      // 确保视频控制器已初始化
      if (_videoController != null && _videoController!.value.isInitialized) {
        // 如果 `canPlay` 变为 true，则播放视频
        if (widget.canPlay == true) {
          setState(() {
            _videoController!.play();
          });
        } else {
          // 如果 `canPlay` 变为 false，则暂停视频
          _videoController!.pause();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initVideoState(); // 初始化视频
  }

  // 视频初始化逻辑
  void initVideoState() {
    // 1. 创建视频控制器，并指定视频资源路径
    _videoController = VideoPlayerController.asset(
      assetPath('images/ins/video2.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true, // 允许与其他音频混合播放
        allowBackgroundPlayback: false, // 不允许后台播放
      ),
    );

    // 2. 添加监听器，监听视频播放状态（如进度）的变化
    _videoController!.addListener(() {
      // 只需要调用 setState 就可以触发 UI 更新（例如进度条）
      if (mounted) {
        setState(() {});
      }
    });

    // 3. 初始化视频控制器
    _videoController!.initialize().then((_) {
      // 初始化完成后，更新UI
      if (mounted) {
        setState(() {
          _videoController!.setLooping(true); // 设置循环播放
          _videoController!.setVolume(1.0); // 设置音量

          // 如果当前页面可见，则自动播放
          if (widget.canPlay == true) {
            _videoController!.play();
          }
        });
      }
    });
  }

  // [MODIFIED] - 切换播放和暂停状态，现在由单击屏幕触发
  void _togglePlaying() {
    if (!mounted) return;

    // 切换播放状态
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
        _hideControlsTimer?.cancel(); // 暂停时，取消隐藏计时器，让UI保持可见
      } else {
        _videoController!.play();
        _startHideControlsTimer(); // 播放时，启动隐藏计时器
      }
      // 无论播放还是暂停，都让控制UI可见
      _controlsVisible = true;
    });
  }

  // 启动一个3秒后隐藏控制UI的计时器
  void _startHideControlsTimer() {
    // 如果已有计时器，先取消
    _hideControlsTimer?.cancel();
    // 创建一个新的计时器
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _controlsVisible = false; // 3秒后将UI设为不可见
        });
      }
    });
  }

  @override
  void dispose() {
    logger.info("视频播放器已销毁！！！");
    _hideControlsTimer?.cancel(); // 销毁计时器
    _videoController?.dispose(); // 销毁视频控制器，释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return SizedBox(
          width: 750.w,
          height: MediaQuery.of(context).size.height - 106.w,
          child: _videoController != null &&
                  _videoController!.value.isInitialized
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    // --- 视频画面 ---
                    // [MODIFIED] - 使用 FittedBox 和 BoxFit.cover 实现真正的全屏铺满效果。
                    // 这是实现无黑边视频播放的最佳实践。
                    // 它会等比缩放视频，直到完全填满容器，然后裁剪超出部分。
                    SizedBox.expand(
                      // 让 FittedBox 充满整个 Stack
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController!.value.size.width,
                          height: _videoController!.value.size.height,
                          child: VideoPlayer(_videoController!),
                        ),
                      ),
                    ),

                    // --- 覆盖层：用于手势检测和显示控制UI ---
                    // [MODIFIED] - GestureDetector 现在直接控制播放/暂停
                    GestureDetector(
                      onTap: _togglePlaying, // 单击屏幕任意位置即可播放/暂停
                      child: AnimatedOpacity(
                        opacity: _controlsVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          color: Colors.black.withAlpha(77),
                          child: Center(
                            // --- 播放/暂停按钮 ---
                            // 这个按钮现在只是一个视觉指示，实际的点击事件由外层 GestureDetector 处理
                            child: Icon(
                              _videoController!.value.isPlaying
                                  ? Icons
                                      .pause_circle_outline // 使用 outline 图标，视觉上更轻
                                  : Icons.play_circle_outline, // 使用 outline 图标
                              color: Colors.white.withAlpha(204),
                              size: 120.w,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --- 底部视频进度条 ---
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        _videoController!,
                        allowScrubbing: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.w),
                        colors: VideoProgressColors(
                          playedColor: AppColors.accentRedPure,
                          bufferedColor: Colors.white.withAlpha(77),
                          backgroundColor: Colors.white.withAlpha(26),
                        ),
                      ),
                    ),
                  ],
                )
              // 如果视频还未初始化，则显示一个深色背景
              : Container(
                  width: 750.w,
                  height: MediaQuery.of(context).size.height - 106.w,
                  color: theme.colorScheme.onSurface,
                ),
        );
      },
    );
  }
}
