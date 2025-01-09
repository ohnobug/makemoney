import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:video_player/video_player.dart';

class LJNTiktikPage extends StatefulWidget {
  const LJNTiktikPage({super.key});

  @override
  State<LJNTiktikPage> createState() => _LJNTiktikPage();
}

class _LJNTiktikPage extends State<LJNTiktikPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 使用白色背景确保图标变为黑色
      statusBarIconBrightness: Brightness.light, // 确保图标颜色为黑色
    ));

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // 清理控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
            primary: false,
            appBar: null,
            body: Column(
              children: [
                Container(
                  color: Colors.black,
                  width: 750.w,
                  height: vm.statusHeight!,
                ),

                SizedBox(
                    width: 750.w,
                    height: vm.screenSize!.height - 115.w - vm.statusHeight!,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      itemCount: 100,
                      itemBuilder: (context, index) {
                        bool isCurrentPage = index == _currentPage;

                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black,
                          child: Stack(
                            children: [
                              // 视频播放
                              CustomVideoPlayer(canPlay: isCurrentPage),

                              // 简介
                              Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 575.w,
                                    padding: EdgeInsets.all(25.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(TextSpan(
                                            children: buildTextSpans(
                                                "@深圳黑马眼科💖",
                                                TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(33.w),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        "AlibabaPuHuiTi"),
                                                TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(33.w),
                                                    fontFamily:
                                                        "NotoColorEmoji-Regular")))),
                                        SizedBox(
                                          height: 20.w,
                                        ),
                                        Text.rich(TextSpan(
                                            children: buildTextSpans(
                                                "深圳黑马眼科, 一家只做近视手术的专科医院,抖音推出1元近视手术",
                                                TextStyle(
                                                    height: 1.35,
                                                    fontSize:
                                                        fontSizeScale(28.w),
                                                    color: Colors.white,
                                                    fontFamily:
                                                        "AlibabaPuHuiTi"),
                                                TextStyle(
                                                    height: 1.35,
                                                    fontSize:
                                                        fontSizeScale(28.w),
                                                    fontFamily:
                                                        "NotoColorEmoji-Regular"))))
                                      ],
                                    ),
                                  )),

                              // 点赞等
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
                                                  AssetImage(assetPath(
                                                      'images/avatar_webp/chat_10.webp')),
                                                  width: 180.w.toInt(),
                                                  height: 180.w.toInt()),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 4.w)),
                                      ),

                                      // 添加
                                      Transform.translate(
                                        offset: Offset(0, -20.w),
                                        child: Container(
                                            width: 40.w,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 254, 61, 83),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40.w)),
                                            ),
                                            child: Center(
                                                child: Icon(
                                              const IconData(
                                                0xe616,
                                                fontFamily: 'Iconfont',
                                              ), // 使用的图标
                                              color: Colors.white, // 图标颜色
                                              size: 28.w, // 图标大小
                                            ))),
                                      ),

                                      // 点赞
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe61e,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: Colors.white, // 图标颜色
                                            size: 63.w, // 图标大小
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                                fontSize: 22.w,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 43.w,
                                      ),

                                      // 评论
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe665,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: Colors.white, // 图标颜色
                                            size: 63.w, // 图标大小
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                                fontSize: 22.w,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 43.w,
                                      ),

                                      // 收藏
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe602,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: Colors.white, // 图标颜色
                                            size: 63.w, // 图标大小
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                                fontSize: 22.w,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 43.w,
                                      ),

                                      // 转发
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            const IconData(
                                              0xe6c7,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: Colors.white, // 图标颜色
                                            size: 63.w, // 图标大小
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "1024",
                                            style: TextStyle(
                                                fontSize: 22.w,
                                                color: Colors.white),
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
                    )),

                // 底部
                Container(
                  width: vm.screenSize!.width,
                  height: 115.w,
                  color: const Color.fromARGB(255, 80, 80, 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "首页",
                        style: TextStyle(
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold,
                            height: 1.08,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Text(
                        "朋友",
                        style: TextStyle(
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold,
                            height: 1.08,
                            color: const Color.fromARGB(255, 181, 181, 181)),
                      ),
                      Transform.translate(
                        offset: Offset(0, 0.w),
                        child: Container(
                            width: 75.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 254, 61, 83),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.w)),
                              border: Border.all(
                                color: Colors.white,
                                width: 6.0.w,
                              ),
                            ),
                            child: Center(
                                child: Icon(
                              const IconData(
                                0xe60c,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Colors.white, // 图标颜色
                              size: 28.w, // 图标大小
                            ))),
                      ),
                      Text(
                        "消息",
                        style: TextStyle(
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold,
                            height: 1.08,
                            color: const Color.fromARGB(255, 181, 181, 181)),
                      ),
                      Text(
                        "我",
                        style: TextStyle(
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold,
                            height: 1.08,
                            color: const Color.fromARGB(255, 181, 181, 181)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

class CustomVideoPlayer extends StatefulWidget {
  final bool? canPlay;

  const CustomVideoPlayer({super.key, this.canPlay});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController? _videoController;

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.canPlay != widget.canPlay) {
      // if (_videoController == null) {
      //   initVideoState();
      // }

      if (_videoController!.value.isInitialized) {
        if (widget.canPlay == true) {
          setState(() {
            _videoController!.play();
          });
        } else {
          // setState(() {
          _videoController!.pause();
          //   _videoController!.dispose();
          //   _videoController = null;
          // });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initVideoState();
  }

  void initVideoState() {
    // 创建视频控制器并初始化
    _videoController = VideoPlayerController.asset(
      assetPath('images/ins/video2.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    );

    // 初始化视频控制器
    _videoController!.initialize().then((_) {
      setState(() {
        _videoController!.setLooping(true); // 循环播放
        _videoController!.setVolume(1.0); // 设置音量

        if (widget.canPlay == true) {
          _videoController!.play();
        }
      });
    });
  }

  @override
  void dispose() {
    logger.info("我销毁啦！！！");
    _videoController!.dispose(); // 销毁视频控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return SizedBox(
            width: 750.w,
            height: vm.screenSize!.height - 115.w,
            child: _videoController != null &&
                    _videoController!.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover, // 居中裁剪
                    child: SizedBox(
                        width: _videoController!.value.size.width,
                        height: _videoController!.value.size.height,
                        child: AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        )))
                : Container(
                    width: 750.w,
                    height: vm.screenSize!.height - 115.w,
                    color: Colors.black,
                  ),
          );
        });
  }
}
