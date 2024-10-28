import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:video_player/video_player.dart';

class LJNTestPage extends StatefulWidget {
  const LJNTestPage({super.key});

  @override
  State<LJNTestPage> createState() => _LJNTestPage();
}

class _LJNTestPage extends State<LJNTestPage> {
  final PageController _controller = PageController();
  List<Widget> pages = [];
  List<VideoPlayerController> videoControllers = []; // 视频控制器列表

  @override
  void initState() {
    super.initState();
    addPage(); // 添加首页
    addPage(); // 添加第二页

    // 监听 PageController 的滚动
    _controller.addListener(() {
      // 检查当前滚动位置是否接近最后一页
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 100) {
        addPage(); // 添加新页面
      }
    });
  }

  @override
  void dispose() {
    // 清理所有控制器
    for (var controller in videoControllers) {
      controller.dispose();
    }
    _controller.dispose(); // 清理控制器
    super.dispose();
  }

  void addPage() {
    // 创建视频控制器并添加到列表
    VideoPlayerController videoController = VideoPlayerController.asset(
      assetPath('images/ins/video2.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    );

    // 初始化视频控制器
    videoController.initialize().then((_) {
      setState(() {
        videoControllers.add(videoController); // 添加控制器到列表
        pages.add(Container(
          width: double.infinity,
          height: double.infinity,
          // color: Colors.primaries[pages.length % Colors.primaries.length],
          color: Colors.black,
          child: Stack(
            children: [
              // 视频
              Container(
                width: double.infinity, // 按屏幕宽度适配
                child: FittedBox(
                  fit: BoxFit.cover, // 按宽度覆盖，同时保持比例
                  child: SizedBox(
                    width: videoController.value.size.width,
                    height: videoController.value.size.height,
                    child: VideoPlayer(videoController),
                  ),
                ),
              ),

              // 简介
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 575.w,
                    padding: EdgeInsets.all(25.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(
                            children: buildTextSpans(
                                "深圳黑马眼科💖",
                                TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(33.w),
                                    color: Colors.white,
                                    fontFamily: "AlibabaPuHuiTi-Medium"),
                                TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(33.w),
                                    fontFamily: "NotoColorEmoji-Regular")))),
                        SizedBox(
                          height: 20.w,
                        ),
                        Text.rich(TextSpan(
                            children: buildTextSpans(
                                "深圳黑马眼科, 一家只做近视手术的专科医院,抖音推出1元近视手术",
                                TextStyle(
                                    height: 1.25,
                                    fontSize: fontSizeScale(28.w),
                                    color: Colors.white,
                                    fontFamily: "AlibabaPuHuiTi"),
                                TextStyle(
                                    height: 1.25,
                                    fontSize: fontSizeScale(28.w),
                                    fontFamily: "NotoColorEmoji-Regular"))))
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
                          borderRadius: BorderRadius.circular(100.w),
                          image: DecorationImage(
                            image: ResizeImage(
                                AssetImage(assetPath(
                                    'images/avatar_webp/chat_10.webp')),
                                width: 180.w.toInt(),
                                height: 180.w.toInt()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // 添加
                      Transform.translate(
                        offset: Offset(0, -20.w),
                        child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 254, 61, 83),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.w)),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            style:
                                TextStyle(fontSize: 22.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 43.w,
                      ),

                      // 评论
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            style:
                                TextStyle(fontSize: 22.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 43.w,
                      ),

                      // 收藏
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            style:
                                TextStyle(fontSize: 22.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 43.w,
                      ),

                      // 转发
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            style:
                                TextStyle(fontSize: 22.w, color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      });
    });

    videoController.setLooping(true); // 循环播放
    videoController.setVolume(1.0); // 设置音量
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return pages[index];
                    },
                    onPageChanged: (index) {
                      // 暂停其他视频
                      for (int i = 0; i < videoControllers.length; i++) {
                        if (i != index) {
                          videoControllers[i].pause();
                        } else {
                          videoControllers[i].play(); // 播放当前视频
                        }
                      }
                    },
                  ))),

          // 底部
          Container(
            width: double.infinity,
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
                      height: 1.08,
                      color: const Color.fromARGB(255, 181, 181, 181)),
                ),
                Text(
                  "朋友",
                  style: TextStyle(
                      fontFamily: "AlibabaPuHuiTi-Medium",
                      fontSize: 32.w,
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
                        borderRadius: BorderRadius.all(Radius.circular(15.w)),
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
                      height: 1.08,
                      color: const Color.fromARGB(255, 181, 181, 181)),
                ),
                Text(
                  "我",
                  style: TextStyle(
                      fontFamily: "AlibabaPuHuiTi-Medium",
                      fontSize: 32.w,
                      height: 1.08,
                      color: const Color.fromARGB(255, 181, 181, 181)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
