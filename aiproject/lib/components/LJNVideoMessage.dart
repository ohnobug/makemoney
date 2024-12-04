import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class LJNVideoMessage extends StatefulWidget {
  const LJNVideoMessage(
      {super.key,
      required this.video,
      required this.showName,
      this.name,
      this.onTap,
      required this.width,
      required this.height});

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

  @override
  void initState() {
    super.initState();

    double aspectRatio = widget.width / widget.height;
    if (aspectRatio > 1) {
      videoWidth = 400.w;
      videoHeight = videoWidth / aspectRatio;
    } else {
      videoHeight = 400.w / aspectRatio;
      if (videoHeight > 906.w) {
        videoHeight = 906.w;
      }
      videoWidth = videoHeight * aspectRatio;
    }

    _controller ??= VideoPlayerController.asset(assetPath(widget.video))
      ..initialize().then((_) {
        setState(() {});
      });

    FFprobeKit.getMediaInformation(assetPath(widget.video))
        .then((session) async {
      final information = session.getMediaInformation();

      if (information == null) {
        // CHECK THE FOLLOWING ATTRIBUTES ON ERROR
        final state =
            FFmpegKitConfig.sessionStateToString(await session.getState());
        // final returnCode = await session.getReturnCode();
        // final failStackTrace = await session.getFailStackTrace();
        // final duration = await session.getDuration();
        final output = await session.getOutput();

        logger.info("state: ${state}");
        logger.info("output: ${output}");
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
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
                                  right: 23, top: 0, bottom: 3)
                              .w,
                          // height: 33.w,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.name ?? vm.userinfoName!,
                                  style: TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(20.w),
                                      color: const Color.fromARGB(
                                          255, 130, 130, 130)),
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
                                    color: const Color.fromARGB(
                                        255, 158, 236, 114),
                                    borderRadius: BorderRadius.circular(8).w),
                                child: AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                ),
                              )),

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
                            'name': vm.userinfoName!,
                            'avatar': vm.userinfoAvatar!,
                            'nickname': vm.userinfoName!,
                            'account': vm.userinfoAccount!,
                          });
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8).w,
                        child: Image.asset(
                          assetPath(vm.userinfoAvatar!),
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
