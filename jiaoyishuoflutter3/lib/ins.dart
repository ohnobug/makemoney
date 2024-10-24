import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:video_player/video_player.dart';

class LJNInsPage extends StatefulWidget {
  const LJNInsPage({super.key});

  @override
  State<LJNInsPage> createState() => _LJNInsPage();
}

class ImageInfo {
  final int id; // 图片 ID
  final bool isPics; // 是否是图片
  final String source; // 图片源路径
  final String url; // 详细页面的 URL

  ImageInfo({
    required this.id,
    required this.isPics,
    required this.source,
    required this.url,
  });

  // 可以添加一个 toString 方法以便于调试
  @override
  String toString() {
    return 'ImageInfo{id: $id, isPics: $isPics, source: $source, url: $url}';
  }
}

// 生成二维数组，每个数字都是1到64之间的随机数
List<List<ImageInfo>> generateRandomImageList(int rows, int cols) {
  final random = Random();
  return List.generate(rows, (i) {
    return List.generate(cols, (j) {
      return ImageInfo(
        id: random.nextInt(1000),
        isPics: random.nextInt(2) == 1 ? true : false,
        source: 'images/ins/${random.nextInt(52)}.jpg',
        url: '/insdetail',
      );
    });
  });
}

class _LJNInsPage extends State<LJNInsPage> {
  double _statusHeight = 0;

  late List<List<ImageInfo>> mylist;

  final ScrollController _scrollController = ScrollController();

  bool setStatusLight = false;

  @override
  void initState() {
    super.initState();
    mylist = generateRandomImageList(1000, 5);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 使用白色背景确保图标变为黑色
      statusBarIconBrightness: Brightness.dark, // 确保图标颜色为黑色
    ));
  }

  late double scrollPixels = 0;

  void _scrollListener() {
    setState(() {
      scrollPixels = _scrollController.position.pixels;
    });

    if (_scrollController.position.pixels >= _statusHeight) {
      setState(() {
        setStatusLight = true;
      });
    } else if (_scrollController.position.pixels == 0 &&
        _scrollController.position.atEdge) {
      setState(() {
        setStatusLight = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
            primary: false,
            body: Stack(
              children: [
                // 滚动条
                CustomScrollView(
                  primary: false,
                  controller: _scrollController,
                  slivers: <Widget>[
                    // SliverAppBar
                    SliverAppBar(
                      primary: false,
                      expandedHeight: _statusHeight + 100.0.w,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent, // 设置状态栏透明
                          statusBarIconBrightness: setStatusLight
                              ? Brightness.light
                              : Brightness.dark),
                      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      // foregroundColor: Colors.red,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 0.w),
                          margin: EdgeInsets.only(top: _statusHeight),
                          // color: const Color.fromARGB(255, 221, 76, 76), // 设置背景颜色
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  // color: Colors.blue,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  height: 65.w,
                                  child: TextField(
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    cursorHeight: 35.w,
                                    cursorWidth: 3.w,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        const IconData(
                                          0xe612,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.black,
                                        size: 40.w,
                                      ),
                                      prefixIconConstraints: BoxConstraints(
                                        minWidth: 70.w, // 控制图标与文字的最小宽度
                                        // minHeight: 36.w,
                                      ),
                                      hintText: "搜索",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 30.w,
                                          color: const Color.fromARGB(
                                              255, 69, 75, 83)),
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 217, 220, 224),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8.0.w, horizontal: 20.0.w),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      floating: true,
                      pinned: false,
                    ),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if ((index + 1) % 3 == 1) {
                            // 样式1
                            return LJNInsStyle(
                              scrollPixels: scrollPixels,
                              imageList: mylist[index],
                              bigImgPosition: 1,
                            );
                          } else if ((index + 1) % 3 == 2) {
                            // 样式2
                            return LJNInsStyle(
                              scrollPixels: scrollPixels,
                              imageList: mylist[index],
                              bigImgPosition: 2,
                            );
                          } else {
                            // 样式3
                            return LJNInsStyle(
                              scrollPixels: scrollPixels,
                              imageList: mylist[index],
                              bigImgPosition: 3,
                            );
                          }
                        },
                        childCount: mylist.length, // 这里替换为你的列表长度
                      ),
                    ),
                  ],
                ),
              
              
                // Container()
              ],
            ),
          );
        });
  }
}

class BigImageBox extends StatefulWidget {
  final String image; // 图片路径
  final Function() onTap; // 点击事件
  final Function() onLongPress; // 长按事件
  final Function() onTapCancel; // 释放事件

  const BigImageBox(
      {super.key,
      required this.image,
      required this.onTap,
      required this.onLongPress,
      required this.onTapCancel});

  @override
  State<BigImageBox> createState() => _BigImageBox();
}

// 大图片
class _BigImageBox extends State<BigImageBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapCancel: widget.onTapCancel,
      child: Stack(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 2.w) / 3,
            height: 500.w,
            color: const Color.fromARGB(255, 247, 247, 247),
            child: Image.asset(
              assetPath(widget.image),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 15.w,
            left: 200.w,
            child: Icon(
              color: Colors.white,
              const IconData(
                0xe777,
                fontFamily: 'Iconfont',
              ),
              size: 36.w, // 图标大小
            ),
          )
        ],
      ),
    );
  }
}

// 小图片
class SmallImageBox extends StatelessWidget {
  final String image; // 图片
  final bool isPics; // 是否图片
  final Function() onTap; // 点击事件
  final Function() onLongPress; // 长按事件
  final Function() onTapCancel; // 释放事件

  const SmallImageBox({
    super.key,
    required this.image,
    required this.isPics,
    required this.onTap,
    required this.onLongPress,
    required this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onTapCancel: onTapCancel,
      child: Stack(
        children: [
          Container(
              width: (MediaQuery.of(context).size.width - 2.w) / 3,
              height: (500.w - 1.w) / 2,
              color: const Color.fromARGB(255, 247, 247, 247),
              child: Image.asset(
                assetPath(image),
                fit: BoxFit.cover,
              )),
          if (isPics)
            Positioned(
              top: 15.w,
              left: 200.w,
              child: Icon(
                color: Colors.white,
                const IconData(
                  0xe777,
                  fontFamily: 'Iconfont',
                ),
                size: 36.w, // 图标大小
              ),
            )
          else
            Positioned(
              top: 15.w,
              left: 200.w,
              child: Icon(
                color: Colors.white,
                const IconData(
                  0xe61d,
                  fontFamily: 'Iconfont',
                ),
                size: 32.w, // 图标大小
              ),
            ),
        ],
      ),
    );
  }
}

// 大视频
class VideoBox2 extends StatefulWidget {
  final String videoPath; // 图片路径
  final bool canPlay;
  final Function() onTap; // 点击事件
  final Function() onLongPress; // 长按事件
  final Function() onTapCancel; // 释放事件

  const VideoBox2(
      {super.key,
      required this.videoPath,
      required this.canPlay,
      required this.onTap,
      required this.onLongPress,
      required this.onTapCancel});

  @override
  State<VideoBox2> createState() => _VideoBox2();
}

class _VideoBox2 extends State<VideoBox2> {
  late VideoPlayerController _controller;

  Future<void> initializePlayer() async {}

  // 监听 scrollPixels 的变化，类似于 useEffect 的效果
  @override
  void didUpdateWidget(VideoBox2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查 scrollPixels 是否发生变化
    if (oldWidget.canPlay != widget.canPlay) {
      if (widget.canPlay) {
        _controller.play();
      } else {
        _controller.pause();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // _videoPlayerController = VlcPlayerController.asset(
    //   assetPath('images/ins/video.mp4'),
    //   hwAcc: HwAcc.auto,
    //   autoPlay: true,
    //   options: VlcPlayerOptions(),
    // );

    _controller = VideoPlayerController.asset(
      assetPath('images/ins/video.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() async {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapCancel: widget.onTapCancel,
      child: Stack(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 2.w) / 3,
            height: 500.w,
            color: const Color.fromARGB(255, 247, 247, 247),
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Positioned(
            top: 15.w,
            left: 200.w,
            child: Icon(
              color: Colors.white,
              const IconData(
                0xe61d,
                fontFamily: 'Iconfont',
              ),
              size: 32.w, // 图标大小
            ),
          )
        ],
      ),
    );
  }
}

// 样式
class LJNInsStyle extends StatefulWidget {
  final List<ImageInfo> imageList;
  final int bigImgPosition;
  final double scrollPixels;

  const LJNInsStyle({
    super.key,
    required this.imageList,
    required this.bigImgPosition,
    required this.scrollPixels,
  });

  @override
  State<LJNInsStyle> createState() => _LJNInsStyle();
}

class _LJNInsStyle extends State<LJNInsStyle> {
  List<Widget> widgetList = [];
  final GlobalKey _containerKey = GlobalKey();

  // 监听 scrollPixels 的变化，类似于 useEffect 的效果
  @override
  void didUpdateWidget(LJNInsStyle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查 scrollPixels 是否发生变化
    if (oldWidget.scrollPixels != widget.scrollPixels) {
      _getPosition();
    }
  }

  late bool canPlay = false;
  late Offset myPosition = const Offset(0, 0);

  // 获取位置的方法
  void _getPosition() {
    final RenderBox? renderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      // 获取相对于屏幕的偏移量
      final Offset position = renderBox.localToGlobal(Offset.zero);
      // logger.info("Container 位于: ${position.dx}, ${position.dy}");

      setState(() {
        myPosition = position;

        // 当前盒子小于屏幕一半,即可播放
        if ((position.dy < (MediaQuery.of(context).size.height - 500.w)) &&
            (position.dy > 20.w)) {
          canPlay = true;
        } else {
          canPlay = false;
        }
      });
    } else {
      logger.info("无法获取 RenderBox");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 750.w,
    //   height: 500.w,
    //   color: Colors.red,
    //   key: _containerKey,
    //   margin: EdgeInsets.only(bottom: 4.w),
    //   child: Text("key:$_containerKey  position:$myPosition canplay: $canPlay"),
    // );

    // 大图
    var a = widget.imageList[0].isPics
        ? BigImageBox(
            image: widget.imageList[0].source,
            onTap: () {},
            onLongPress: () {},
            onTapCancel: () {},
          )
        : VideoBox2(
            videoPath: '',
            onTap: () {},
            onLongPress: () {},
            onTapCancel: () {},
            canPlay: canPlay,
          );

    // 两图
    var b = Column(
      children: [
        SmallImageBox(
          image: widget.imageList[1].source,
          isPics: widget.imageList[1].isPics,
          onTap: () {},
          onLongPress: () {},
          onTapCancel: () {},
        ),
        SizedBox(
          height: 1.w,
        ),
        SmallImageBox(
          image: widget.imageList[2].source,
          isPics: widget.imageList[2].isPics,
          onTap: () {},
          onLongPress: () {},
          onTapCancel: () {},
        ),
      ],
    );

    // 两图
    var c = Column(
      children: [
        SmallImageBox(
          image: widget.imageList[3].source,
          isPics: widget.imageList[3].isPics,
          onTap: () {},
          onLongPress: () {},
          onTapCancel: () {},
        ),
        SizedBox(
          height: 1.w,
        ),
        SmallImageBox(
          image: widget.imageList[4].source,
          isPics: widget.imageList[4].isPics,
          onTap: () {},
          onLongPress: () {},
          onTapCancel: () {},
        ),
      ],
    );

    if (widget.bigImgPosition == 1) {
      widgetList = [a, b, c];
    } else if (widget.bigImgPosition == 2) {
      widgetList = [b, a, c];
    } else if (widget.bigImgPosition == 3) {
      widgetList = [b, c, a];
    }

    return Container(
        key: _containerKey,
        margin: EdgeInsets.only(bottom: 1.w),
        child: Row(
          children: [
            widgetList[0],
            SizedBox(
              width: 1.w,
            ),
            widgetList[1],
            SizedBox(
              width: 1.w,
            ),
            widgetList[2],
          ],
        ));
  }
}







// // 大视频
// class VideoBox extends StatefulWidget {
//   final String videoPath; // 图片路径
//   final bool canPlay;
//   final Function() onTap; // 点击事件
//   final Function() onLongPress; // 长按事件
//   final Function() onTapCancel; // 释放事件

//   const VideoBox(
//       {super.key,
//       required this.videoPath,
//       required this.canPlay,
//       required this.onTap,
//       required this.onLongPress,
//       required this.onTapCancel});

//   @override
//   State<VideoBox> createState() => _VideoBox();
// }

// class _VideoBox extends State<VideoBox> {
//   late VlcPlayerController _videoPlayerController;

//   Future<void> initializePlayer() async {}

//   // 监听 scrollPixels 的变化，类似于 useEffect 的效果
//   @override
//   void didUpdateWidget(VideoBox oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     // 检查 scrollPixels 是否发生变化
//     if (oldWidget.canPlay != widget.canPlay) {
//       if (widget.canPlay) {
//         _videoPlayerController.play();
//       } else {
//         _videoPlayerController.pause();
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     _videoPlayerController = VlcPlayerController.asset(
//       assetPath('images/ins/video.mp4'),
//       hwAcc: HwAcc.auto,
//       autoPlay: true,
//       options: VlcPlayerOptions(),
//     );
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     await _videoPlayerController.stopRendererScanning();
//     // await _videoViewController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       onLongPress: widget.onLongPress,
//       onTapCancel: widget.onTapCancel,
//       child: Stack(
//         children: [
//           Container(
//             width: (MediaQuery.of(context).size.width - 2.w) / 3,
//             height: 500.w,
//             color: const Color.fromARGB(255, 247, 247, 247),
//             child: VlcPlayer(
//               controller: _videoPlayerController,
//               aspectRatio:
//                   500.w / ((MediaQuery.of(context).size.width - 2.w) / 3),
//               placeholder: Center(
//                   child: SizedBox(
//                       width: 40.w,
//                       height: 40.w,
//                       child: CircularProgressIndicator(
//                           strokeWidth: 4.w,
//                           color: const Color.fromARGB(255, 165, 165, 165)))),
//             ),
//           ),
//           Positioned(
//             top: 15.w,
//             left: 200.w,
//             child: Icon(
//               color: Colors.white,
//               const IconData(
//                 0xe61d,
//                 fontFamily: 'Iconfont',
//               ),
//               size: 32.w, // 图标大小
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
