import 'package:flutter/material.dart';
import 'package:flutter_application_1/store.dart';
import 'package:flutter_application_1/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LJNTestMessage extends StatefulWidget {
  const LJNTestMessage(
      {super.key,
      required this.message,
      required this.showName,
      required this.name});

  final String name;
  final bool showName;
  final String message;

  @override
  State<LJNTestMessage> createState() => _LJNTestMessage();
}

class _LJNTestMessage extends State<LJNTestMessage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
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
                                  widget.name,
                                  style: TextStyle(
                                      fontSize: 20.w,
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
                          Flexible(
                              child: Container(
                            constraints: const BoxConstraints(maxWidth: 510).w,
                            // width: 640.w,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 158, 236, 114),
                                // border: Border.all(
                                //     color:
                                //         Colors.white,
                                //     width: 1.0.w),
                                borderRadius: BorderRadius.circular(8).w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 18.w),
                            child: Lottie.asset(
                              assetPath('lotties/Animation1.json'),
                              width: 300.w,
                              height: 300.w,
                              fit: BoxFit.fill,
                              controller: _controller,
                              onLoaded: (composition) {
                                // Configure the AnimationController with the duration of the
                                // Lottie file and start the animation.
                                _controller
                                  ..duration = composition.duration
                                  ..forward();
                              },
                            ),
                          )),

                          // 箭头
                          Container(
                            padding:
                                const EdgeInsets.only(top: 32, right: 10).w,
                            child: Image.asset(
                              assetPath("images/icon/right.png"),
                              width: 10.w,
                              fit: BoxFit.fitWidth,
                              // fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 头像
                ClipRRect(
                    borderRadius: BorderRadius.circular(10).w,
                    child: Image.asset(
                      vm.userinfoAvatar as String,
                      width: 78.w,
                      height: 78.w,
                    )),
              ],
            ),
          );
        });
  }
}
