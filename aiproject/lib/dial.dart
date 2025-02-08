import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNDial extends StatefulWidget {
  const LJNDial({
    super.key,
  });

  @override
  State<LJNDial> createState() => _LJNDial();
}

class _LJNDial extends State<LJNDial> {
  // 音频播放器
  late VideoPlayerController _voiceController;

  // 画中画
  final floating = Floating();

  // 用于保存原来的状态栏样式
  SystemUiOverlayStyle? originalStatusBarStyle;

  // // 启动pip
  // Future<void> _enablePip(
  //   BuildContext context, {
  //   bool autoEnable = false,
  // }) async {
  //   final rational = Rational.landscape();
  //   final screenSize =
  //       MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio;
  //   final height = screenSize.width ~/ rational.aspectRatio;

  //   final arguments = autoEnable
  //       ? OnLeavePiP(
  //           aspectRatio: rational,
  //           sourceRectHint: Rectangle<int>(
  //             0,
  //             (screenSize.height ~/ 2) - (height ~/ 2),
  //             screenSize.width.toInt(),
  //             height,
  //           ),
  //         )
  //       : ImmediatePiP(
  //           aspectRatio: rational,
  //           sourceRectHint: Rectangle<int>(
  //             0,
  //             (screenSize.height ~/ 2) - (height ~/ 2),
  //             screenSize.width.toInt(),
  //             height,
  //           ),
  //         );

  //   final status = await floating.enable(arguments);
  //   debugPrint('PiP enabled? $status');
  // }

  @override
  void initState() {
    super.initState();

    // 实例化播放器
    _voiceController =
        VideoPlayerController.asset(assetPath("sounds/scan_success.mp3"))
          ..initialize().then((_) {
            setState(() {});
          });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 使用白色背景确保图标变为黑色
      statusBarIconBrightness: Brightness.light, // 确保图标颜色为黑色
    ));

    PictureInPicture.updatePiPParams(
      pipParams: PiPParams(
        pipWindowHeight: 300.w,
        pipWindowWidth: 300.w,
        bottomSpace: 5,
        leftSpace: 5,
        rightSpace: 5,
        topSpace: 5,
        maxSize: Size(300, 300),
        minSize: Size(200, 200),
        movable: true,
        resizable: false,
        initialCorner: PIPViewCorner.bottomRight,
      ),
    );
  }

  @override
  Future<void> dispose() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 使用白色背景确保图标变为黑色
      statusBarIconBrightness: Brightness.dark, // 确保图标颜色为黑色
    ));

    await _voiceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return PiPSwitcher(
          childWhenEnabled: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
            child: Text("hello world"),
          ),
          childWhenDisabled: Scaffold(
              primary: false,
              appBar: null,
              body: Container(
                  width: 750.w,
                  color: const Color.fromARGB(255, 22, 22, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LJNAppBar(
                        title: "",
                        bgColor: Colors.transparent,
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Future.delayed(Duration(milliseconds: 100), () {
                              // 应用级画中画
                              PictureInPicture.startPiP(
                                  pipWidget: PiPWidget(
                                      pipBorderRadius: 100,
                                      elevation: 20,
                                      onPiPClose: () {},
                                      child: LJNDialFloatingWidget(
                                          systemState: systemState)));
                            });

                            // 进入系统级画中画
                            // _enablePip(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(0xe68f, fontFamily: 'Iconfont'),
                              color: Colors.white,
                              size: 36.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 297.w,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16.0.w), // Adjust the radius as needed
                            child: Image.asset(
                              assetPath("images/avatar_webp/chat_55.webp"),
                              width: 183.0.w,
                              height: 183.0.w,
                              cacheWidth: 360.w.toInt(),
                              cacheHeight: 360.w.toInt(),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Text(
                            "罗绮娴",
                            style:
                                TextStyle(color: Colors.white, fontSize: 40.w),
                          ),
                        ],
                      )),
                      Text(
                        "等待对方接受邀请...",
                        style: TextStyle(
                            fontSize: 30.w,
                            color: const Color.fromARGB(255, 141, 143, 142)),
                      ),
                      SizedBox(
                        height: 115.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140.w,
                            height: 242.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 140.w,
                                  height: 140.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(140.w)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    const IconData(
                                      0xec8c,
                                      fontFamily: 'Iconfont',
                                    ),
                                    color: Colors.black,
                                    size: 64.w,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.w,
                                ),
                                Text(
                                  "麦克风已开",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.w),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 77.w,
                          ),
                          SizedBox(
                            width: 140.w,
                            height: 242.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      // 播放音乐
                                      await _voiceController.play();

                                      // 等待一会再跳转
                                      await Future.delayed(
                                          Duration(milliseconds: 600), () {
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 140.w,
                                      height: 140.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 217, 79, 77),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(140.w)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        const IconData(
                                          0xe781,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.white,
                                        size: 64.w,
                                      ),
                                    )),
                                SizedBox(
                                  height: 20.w,
                                ),
                                Text(
                                  "取消",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.w),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 77.w,
                          ),
                          SizedBox(
                            width: 140.w,
                            height: 242.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 140.w,
                                  height: 140.w,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 13, 13, 11),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(140.w)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    const IconData(
                                      0xe69c,
                                      fontFamily: 'Iconfont',
                                    ),
                                    color: Colors.white,
                                    size: 64.w,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.w,
                                ),
                                Text(
                                  "扬声器已关",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.w),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ))));
    });
  }
}

// 打电话浮窗
class LJNDialFloatingWidget extends StatelessWidget {
  const LJNDialFloatingWidget({super.key, required this.systemState});

  final SystemState systemState;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Stack(children: [
        Text("hello"),
        ElevatedButton(
          onPressed: () {
            PictureInPicture.stopPiP();
            systemState.navigatorKey.currentState!.pushNamed('/dial');
          },
          child: Text("close"),
        )
      ]),
    );
  }
}
