import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  VideoPlayerController? _controller;
  GlobalKey videoContainerKey = GlobalKey();
  late double videoWidth;
  late double videoHeight;
  String? picPath;
  Uint8List? imageBytes;

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
          setState(() {});
        });
    } else {
      getVideoFirstFrame();
    }
  }

  // 获取视频首帧
  void getVideoFirstFrame() {
    setState(() async {
      picPath = await getFirstFrame(
        assetPath(widget.video),
      );
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget? firstFrame;

  @override
  Widget build(BuildContext context) {
    if (firstFrame == null) {
      // 如果是网页则直接显示视频
      if (kIsWeb) {
        firstFrame = Stack(
          children: [
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            ),
            Positioned.fill(
              child: Container(
                width: videoWidth,
                height: videoHeight,
                alignment: Alignment.center,
                color: AppColors.blackTransparent41,
                child: Icon(
                  const IconData(
                    0xe6c5,
                    fontFamily: 'Iconfont',
                  ),
                  color: AppColors.neutralWhite,
                  size: 78.w,
                ),
              ),
            ),
          ],
        );
      } else {
        // 如果是app则先通过api获取视频首帧
        if (picPath == null) {
          firstFrame = Container();
        } else {
          firstFrame = Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  File(picPath!),
                  width: videoWidth,
                  height: videoHeight,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned.fill(
                child: Container(
                  width: videoWidth,
                  height: videoHeight,
                  alignment: Alignment.center,
                  color: AppColors.blackTransparent41,
                  child: Icon(
                    const IconData(
                      0xe6c5,
                      fontFamily: 'Iconfont',
                    ),
                    color: AppColors.neutralWhite,
                    size: 78.w,
                  ),
                ),
              ),
            ],
          );
        }
      }
    }

    // 对方发的消息
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Container(
          padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 姓名与消息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 姓名
                    if (widget.showName)
                      Container(
                        padding: const EdgeInsets.only(
                          right: 23,
                          top: 0,
                          bottom: 3,
                        ).w,
                        // height: 33.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.name ??
                                  context
                                      .read<LJNUserCubit>()
                                      .state
                                      .userinfoName!,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(20.w),
                                color: AppColors.neutralGrey66,
                              ),
                            )
                          ],
                        ),
                      ),

                    // 消息
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // 消息
                        GestureDetector(
                          onTap: () {
                            final RenderBox renderBox = videoContainerKey
                                .currentContext
                                ?.findRenderObject() as RenderBox;

                            Offset position =
                                renderBox.localToGlobal(Offset.zero);
                            Size size = renderBox.size;

                            widget.onTap!(position, size);
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            key: videoContainerKey,
                            width: videoWidth,
                            height: videoHeight,
                            // color: Colors.grey,
                            decoration: BoxDecoration(
                              color: AppColors.brandGreenLighter,
                              borderRadius: BorderRadius.circular(8).w,
                            ),
                            child: firstFrame,
                          ),
                        ),
                        // 箭头
                        SizedBox(
                          width: 20.w,
                          // padding: const EdgeInsets.only(top: 32).w,
                          // child: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 头像
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/friendprofile',
                      arguments: <String, String>{
                        'name':
                            context.read<LJNUserCubit>().state.userinfoName!,
                        'avatar':
                            context.read<LJNUserCubit>().state.userinfoAvatar!,
                        'nickname':
                            context.read<LJNUserCubit>().state.userinfoName!,
                        'account':
                            context.read<LJNUserCubit>().state.userinfoAccount!,
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8).w,
                  child: Image.asset(
                    assetPath(
                        context.read<LJNUserCubit>().state.userinfoAvatar!),
                    cacheWidth: 156.w.toInt(),
                    cacheHeight: 156.w.toInt(),
                    width: 78.w,
                    height: 78.w,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
