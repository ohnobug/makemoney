import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

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

  void _scrollListener() {
    logger.info(_scrollController.position.pixels);
    logger.info(_scrollController.position.atEdge);

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
            body: CustomScrollView(
              primary: false,
              controller: _scrollController,
              slivers: <Widget>[
                // SliverAppBar
                SliverAppBar(
                  primary: false,
                  expandedHeight: _statusHeight + 100.0.w,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent, // 设置状态栏透明
                      statusBarIconBrightness:
                          setStatusLight ? Brightness.light : Brightness.dark),
                  // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  // foregroundColor: Colors.red,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.w),
                      margin: EdgeInsets.only(top: _statusHeight),
                      // color: const Color.fromARGB(255, 221, 76, 76), // 设置背景颜色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              // color: Colors.blue,
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                                  fillColor:
                                      const Color.fromARGB(255, 217, 220, 224),
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
                          imageList: mylist[index],
                          bigImgPosition: 1,
                        );
                      } else if ((index + 1) % 3 == 2) {
                        // 样式2
                        return LJNInsStyle(
                          imageList: mylist[index],
                          bigImgPosition: 1,
                        );
                      } else {
                        // 样式3
                        return LJNInsStyle(
                          imageList: mylist[index],
                          bigImgPosition: 1,
                        );
                      }
                    },
                    childCount: mylist.length, // 这里替换为你的列表长度
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// 大图片
class BigImageBox extends StatelessWidget {
  final String image; // 图片路径
  final bool isPics; // 控制图标
  final Function() onTap; // 点击事件
  final Function() onLongPress; // 长按事件
  final Function() onTapCancel; // 释放事件

  const BigImageBox({
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
            height: 500.w,
            color: const Color.fromARGB(255, 247, 247, 247),
            child: Image.asset(
              assetPath(image),
              fit: BoxFit.cover,
            ),
          ),
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

// 样式
class LJNInsStyle extends StatefulWidget {
  final List<ImageInfo> imageList;
  final int bigImgPosition;

  const LJNInsStyle(
      {super.key, required this.imageList, required this.bigImgPosition});

  @override
  State<LJNInsStyle> createState() => _LJNInsStyle();
}

class _LJNInsStyle extends State<LJNInsStyle> {
  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    // 大图
    var a = BigImageBox(
      image: widget.imageList[0].source,
      isPics: widget.imageList[0].isPics,
      onTap: () {},
      onLongPress: () {},
      onTapCancel: () {},
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
