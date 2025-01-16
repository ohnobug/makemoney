import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class LJNMyVoiceMessage extends StatefulWidget {
  const LJNMyVoiceMessage(
      {super.key,
      required this.message,
      required this.showName,
      this.name,
      required this.voicePath});

  final String? name;
  final bool showName;
  final String message;
  final String voicePath;

  @override
  State<LJNMyVoiceMessage> createState() => _LJNMyMessage();
}

class _LJNMyMessage extends State<LJNMyVoiceMessage>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;

  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _lottieController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _lottieController.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return BlocBuilder<SystemCubit, SystemState>(
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
                      padding:
                          const EdgeInsets.only(right: 23, top: 0, bottom: 3).w,
                      // height: 33.w,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.name ??
                                  context.read<UserCubit>().state.userinfoName!,
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(20.w),
                                  color:
                                      const Color.fromARGB(255, 130, 130, 130)),
                            )
                          ]),
                    ),
                  // 消息
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 消息
                      GestureDetector(
                          onTap: () {
                            logger.info("播放录音");

                            if (_controller == null) {
                              // 实例化播放器
                              _controller = VideoPlayerController.file(
                                  File(widget.voicePath))
                                ..initialize().then((_) {
                                  setState(() {});
                                });

                              // 添加事件
                              _controller!.addListener(() {
                                if (_controller!.value.isPlaying) {
                                  _lottieController.repeat();
                                  _lottieController.forward();
                                } else if (_controller!.value.isCompleted) {
                                  _lottieController.value = 1;
                                  _lottieController.stop();
                                }
                              });
                            }

                            if (_controller!.value.isPlaying) {
                              // 若播放中点击，则停止
                              _controller!.pause();
                            } else {
                              // 若第一次点击则播放
                              _controller!.play();
                            }
                          },
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 510).w,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 158, 236, 114),
                                borderRadius: BorderRadius.circular(8).w),
                            padding: EdgeInsets.only(
                                top: 20.w,
                                bottom: 18.w,
                                left: 23.w,
                                right: 22.w),
                            child: Text.rich(
                              // softWrap: true,
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              TextSpan(children: [
                                WidgetSpan(
                                  child: SizedBox(width: 30.w),
                                ),
                                TextSpan(
                                  text: widget.message,
                                  style: TextStyle(
                                      height: 1.25,
                                      fontSize: fontSizeScale(31.w),
                                      color: Colors.black,
                                      fontFamily: ""),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 7.w),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  style: const TextStyle(height: 1.0),
                                  child: Lottie.asset(
                                    assetPath('lotties/voiceplayicon.json'),
                                    width: 32.w,
                                    height: 32.w,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                    renderCache: RenderCache.drawingCommands,
                                    controller: _lottieController,
                                    onLoaded: (composition) {
                                      // _lottieController
                                      //   ..duration = const Duration(milliseconds: 600)
                                      //   ..forward();
                                    },
                                  ),
                                )
                              ]),
                            ),
                          )),

                      // 箭头
                      Container(
                        padding: const EdgeInsets.only(top: 32, right: 10).w,
                        child: Image.asset(
                          assetPath("images/icon/right.png"),
                          width: 10.w,
                          fit: BoxFit.fitWidth,
                        ),
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
                        'name': context.read<UserCubit>().state.userinfoName!,
                        'avatar':
                            context.read<UserCubit>().state.userinfoAvatar!,
                        'nickname':
                            context.read<UserCubit>().state.userinfoName!,
                        'account':
                            context.read<UserCubit>().state.userinfoAccount!,
                      });
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8).w,
                    child: Image.asset(
                      assetPath(
                          context.read<UserCubit>().state.userinfoAvatar!),
                      cacheWidth: 156.w.toInt(),
                      cacheHeight: 156.w.toInt(),
                      width: 78.w,
                      height: 78.w,
                      fit: BoxFit.cover,
                    )))
          ],
        ),
      );
    });
  }
}
