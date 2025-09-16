import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class LJNReceiveVideoMessage extends StatefulWidget {
  const LJNReceiveVideoMessage({
    super.key,
    required this.video,
    required this.showName,
    required this.name,
    this.onTap,
    required this.width,
    required this.height,
    required this.friendAvatar,
  });

  final Function(Offset, Size)? onTap;
  final String name;
  final bool showName;
  final String video;
  final double width;
  final double height;
  final String friendAvatar;

  @override
  State<LJNReceiveVideoMessage> createState() => _LJNReceiveVideoMessage();
}

class _LJNReceiveVideoMessage extends State<LJNReceiveVideoMessage> {
  VideoPlayerController? _controller;
  final GlobalKey videoContainerKey = GlobalKey();
  late double videoWidth;
  late double videoHeight;
  String? picPath;

  @override
  void initState() {
    super.initState();

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

    if (kIsWeb) {
      _controller = VideoPlayerController.asset(assetPath(widget.video))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
          }
        });
    } else {
      getVideoFirstFrame();
    }
  }

  // 获取视频首帧
  Future<void> getVideoFirstFrame() async {
    // 假设 getFirstFrame 是一个能返回视频首帧本地文件路径的函数
    var picPathTemp = await getFirstFrame(
      assetPath(widget.video),
    );

    // 调用 setState 前检查组件是否还在树上，防止异步操作完成后组件已销毁而报错
    if (mounted) {
      setState(() {
        picPath = picPathTemp;
        logger.info("aaaaaaaaaaaaaaaaaaa 获取视频首帧 {picPath: $picPath}");
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 【关键改动】: 在 build 方法内部根据当前状态直接构建 Widget
    Widget videoContent;

    // 如果是网页则直接显示视频
    if (kIsWeb) {
      logger.info("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 1111111111111111111111");
      // 确保 _controller 已经初始化
      if (_controller != null && _controller!.value.isInitialized) {
        videoContent = Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
            Container(
              color: AppColors.blackTransparent41,
            ),
            Icon(
              const IconData(0xe6c5, fontFamily: 'Iconfont'),
              color: AppColors.neutralWhite,
              size: 78.w,
            ),
          ],
        );
      } else {
        // 在 controller 初始化完成前显示一个加载占位符
        videoContent = const Center(child: CircularProgressIndicator());
      }
    } else {
      logger.info("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 222222222222222222222");

      // 如果是app则先通过api获取视频首帧
      if (picPath == null) {
        logger
            .info("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 3333333333333333333333");
        // picPath 为空时显示一个加载中的占位符
        videoContent = const Center(child: CircularProgressIndicator());
      } else {
        // picPath 不为空，现在可以正确执行到这里了！
        logger.info("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 444444444444444444444");

        videoContent = Stack(
          alignment: Alignment.center,
          children: [
            Image.file(
              File(picPath!),
              width: videoWidth,
              height: videoHeight,
              fit: BoxFit.contain,
              // 添加错误处理，防止图片路径无效导致崩溃
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child:
                      Icon(Icons.error_outline, color: Colors.red, size: 40.w),
                );
              },
            ),
            Container(
              color: AppColors.blackTransparent41,
            ),
            Icon(
              const IconData(0xe6c5, fontFamily: 'Iconfont'),
              color: AppColors.neutralWhite,
              size: 78.w,
            ),
          ],
        );
      }
    }

    // 对方发的消息
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Container(
          padding: EdgeInsets.only(
            left: 22.w,
            right: 22.w,
            top: 22.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头像
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/friendprofile',
                    arguments: <String, String>{
                      'name': widget.name,
                      'avatar': widget.friendAvatar,
                      'nickname': widget.name,
                      'account':
                          context.read<LJNUserCubit>().state.userinfoAccount!,
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8).w,
                  child: Image.asset(
                    assetPath(widget.friendAvatar),
                    cacheWidth: 156, // ScreenUtil 已处理，无需 .w.toInt()
                    cacheHeight: 156,
                    width: 78.w,
                    height: 78.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              // 姓名与消息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 姓名
                    if (widget.showName)
                      Padding(
                        padding: EdgeInsets.only(left: 8.w, bottom: 4.w),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 14.sp, // 使用 sp 适配字体大小
                            color: AppColors.neutralGrey66,
                          ),
                        ),
                      ),
                    // 消息
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // 消息体
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
                              color: Colors.grey[200], // 给一个背景色以防内容加载失败
                              borderRadius: BorderRadius.circular(8).w,
                            ),
                            child: videoContent, // 直接使用在这里构建好的 videoContent
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
