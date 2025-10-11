import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class LJNVideoMessage extends StatefulWidget {
  const LJNVideoMessage({
    super.key,
    required this.video,
    required this.showName,
    this.name,
    this.onTap,
    required this.width,
    required this.height,
  });

  final Function(Offset, Size)? onTap;
  final String? name;
  final bool showName;
  final String video;
  final double width;
  final double height;

  @override
  State<LJNVideoMessage> createState() => _LJNVideoMessage();
}

class _LJNVideoMessage extends State<LJNVideoMessage> {
  final GlobalKey videoContainerKey = GlobalKey();
  VideoPlayerController? _controller;
  late double videoWidth;
  late double videoHeight;
  String? picPath;

  // 【已移除】: 不再需要内部播放状态
  // bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _calculateVideoDimensions();

    if (kIsWeb) {
      // 在Web端，我们仍然初始化播放器以显示第一帧
      _controller = VideoPlayerController.asset(assetPath(widget.video))
        ..initialize().then((_) {
          if (mounted) setState(() {});
        });
    } else {
      // 在移动端，获取视频封面图
      _getVideoFirstFrame();
    }
  }

  void _calculateVideoDimensions() {
    double aspectRatio = widget.width / widget.height;
    if (aspectRatio > 1) {
      videoWidth = 300.w;
      videoHeight = videoWidth / aspectRatio;
    } else {
      videoHeight = 700.w * aspectRatio;
      if (videoHeight > 906.w) {
        videoHeight = 906.w;
      }
      videoWidth = videoHeight * aspectRatio;
    }
  }

  Future<void> _getVideoFirstFrame() async {
    var picPathTemp = await getFirstFrame(assetPath(widget.video));
    if (mounted) {
      setState(() {
        picPath = picPathTemp;
      });
    }
  }

  // 【已移除】: 不再需要内部播放视频的方法
  // Future<void> _playVideo() async { ... }
  // void _videoPlaybackListener() { ... }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// 构建消息气泡内的内容（视频封面或加载指示器）
  Widget _buildVideoContent() {
    // --- Web 平台 ---
    if (kIsWeb) {
      if (_controller != null && _controller!.value.isInitialized) {
        // 在Web端显示视频播放器作为封面
        return Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
            Container(color: AppColors.blackTransparent41),
            Icon(
              const IconData(0xe6c5, fontFamily: 'Iconfont'),
              color: AppColors.neutralWhite,
              size: 78.w,
            ),
          ],
        );
      }
      // 显示加载动画
      return const Center(child: CircularProgressIndicator());
    }

    // --- 移动端平台 ---
    // 如果封面图路径存在
    if (picPath != null) {
      // 【关键修改】: 直接返回封面图，并移除内部的GestureDetector
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.file(
            File(picPath!),
            width: videoWidth,
            height: videoHeight,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error_outline, color: Colors.red, size: 40),
              );
            },
          ),
          Container(color: AppColors.blackTransparent41),
          Icon(
            const IconData(0xe6c5, fontFamily: 'Iconfont'),
            color: AppColors.neutralWhite,
            size: 78.w,
          ),
        ],
      );
    } else {
      // 封面图还未加载好时，显示加载动画
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        final userState = context.watch<LJNUserCubit>().state;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 11.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 姓名与消息气泡
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 姓名
                    if (widget.showName)
                      Padding(
                        padding: EdgeInsets.only(right: 8.w, bottom: 4.w),
                        child: Text(
                          widget.name ?? userState.userinfoName ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.neutralGrey66,
                          ),
                        ),
                      ),
                    // 消息气泡
                    // 【行为核心】: 这个GestureDetector会捕获点击事件，并调用外部的onTap回调
                    GestureDetector(
                      onTap: () {
                        if (widget.onTap != null) {
                          final RenderBox? renderBox = videoContainerKey
                              .currentContext
                              ?.findRenderObject() as RenderBox?;
                          if (renderBox != null) {
                            Offset position =
                                renderBox.localToGlobal(Offset.zero);
                            Size size = renderBox.size;
                            widget.onTap!(position, size);
                          }
                        }
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        key: videoContainerKey,
                        width: videoWidth,
                        height: videoHeight,
                        decoration: BoxDecoration(
                          color: AppColors.brandGreenLighter,
                          borderRadius: BorderRadius.circular(8).w,
                        ),
                        child: _buildVideoContent(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.w),
              // 头像
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/chat/friend/profile',
                      arguments: <String, String>{
                        'name': userState.userinfoName!,
                        'avatar': userState.userinfoAvatar!,
                        'nickname': userState.userinfoName!,
                        'account': userState.userinfoAccount!,
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8).w,
                  child: Image.asset(
                    assetPath(userState.userinfoAvatar!),
                    width: 78.w,
                    height: 78.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
