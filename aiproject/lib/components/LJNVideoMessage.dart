import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class LJNVideoMessage extends StatefulWidget {
  const LJNVideoMessage(
      {super.key,
      required this.message,
      required this.showName,
      this.name,
      this.onTap});

  final Function(Offset, Size)? onTap;
  final String? name;
  final bool showName;
  final String message;

  @override
  State<LJNVideoMessage> createState() => _LJNVideoMessage();
}

class _LJNVideoMessage extends State<LJNVideoMessage> {
  late VideoPlayerController _controller;
  GlobalKey videoContainerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(assetPath('images/ins/test.mp4'))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    double videoWidth = 510.w;
    double videoHeight = videoWidth / _controller.value.aspectRatio;

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
                                  constraints:
                                      const BoxConstraints(maxWidth: 510).w,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 158, 236, 114),
                                      borderRadius: BorderRadius.circular(8).w),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 25.w, vertical: 18.w),
                                  child: Container(
                                    key: videoContainerKey,
                                    width: videoWidth,
                                    height: videoHeight,
                                    color: Colors.grey,
                                    child: AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    ),
                                  )
                                  // _controller.value.isInitialized
                                  //     ? Container(
                                  //         width: 510.w,
                                  //         height: 286.w,
                                  //         color: Colors.grey,
                                  //         child: AspectRatio(
                                  //           aspectRatio:
                                  //               _controller.value.aspectRatio,
                                  //           child: VideoPlayer(_controller),
                                  //         ))
                                  //     : Container(
                                  //         width: 510.w,
                                  //         height: 286.w,
                                  //         color: Colors.grey,
                                  //         // child: Image.asset(
                                  //         //   assetPath("images/avatar/linecode.png"),
                                  //         //   width: 510.0.w,
                                  //         //   height: 286.0.w,
                                  //         //   fit: BoxFit.fill,
                                  //         // ),
                                  //       ),
                                  )),

                          // 箭头
                          Container(
                            width: 10.w,
                            padding:
                                const EdgeInsets.only(top: 32, right: 10).w,
                            child: null,
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
