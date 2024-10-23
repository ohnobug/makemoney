import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class _LJNInsPage extends State<LJNInsPage> {
  double _statusHeight = 0;

// 生成二维数组，每个数字都是1到64之间的随机数
  List<List<String>> generateRandomImageList(int rows, int cols) {
    final random = Random();
    return List.generate(
        rows,
        (i) =>
            List.generate(cols, (j) => 'images/ins/${random.nextInt(52)}.jpg'));
  }

  late List<List<String>> mylist = [];

  FocusNode focusNode = FocusNode();

  void _loseFocus() {
    focusNode.unfocus(); // 失去焦点
  }

  @override
  void initState() {
    super.initState();

    mylist = generateRandomImageList(1000, 5);
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
              slivers: <Widget>[
                // SliverAppBar
                SliverAppBar(
                  primary: false,
                  expandedHeight: _statusHeight + 90.0.w,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 500.w,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.w),
                      margin: EdgeInsets.only(top: _statusHeight),
                      // color: const Color.fromARGB(255, 221, 76, 76), // 设置背景颜色
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              // color: Colors.blue,
                              height: 65.w,
                              child: TextField(
                                focusNode: focusNode,
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
                                  hintText: "Search here...",
                                  hintStyle: const TextStyle(
                                      // fontSize: 12.w,
                                      color: Color.fromARGB(255, 69, 75, 83)),
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
                // SliverList to include your items
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if ((index + 1) % 3 == 1) {
                        // 样式1
                        return LJNInsStyle1(
                          imageList: mylist[index],
                        );
                      } else if ((index + 1) % 3 == 2) {
                        // 样式2
                        return LJNInsStyle2(
                          imageList: mylist[index],
                        );
                      } else {
                        // 样式3
                        return LJNInsStyle3(
                          imageList: mylist[index],
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

// 样式1
class LJNInsStyle1 extends StatelessWidget {
  final List<String> imageList;

  const LJNInsStyle1({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 1.w),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  logger.info("按下");
                },
                onLongPress: () {
                  logger.info("长按");
                },
                onTapCancel: () {
                  logger.info("释放");
                },
                child: Container(
                    width: (MediaQuery.of(context).size.width - 2.w) / 3,
                    height: 500.w,
                    color: const Color.fromARGB(255, 247, 247, 247),
                    child: imageList.isNotEmpty
                        ? Image.asset(
                            assetPath(imageList[0]),
                            fit: BoxFit.cover,
                          )
                        : null)),
            SizedBox(
              width: 1.w,
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                        width: (MediaQuery.of(context).size.width - 2.w) / 3,
                        height: (500.w - 1.w) / 2,
                        color: const Color.fromARGB(255, 247, 247, 247),
                        child: imageList.isNotEmpty
                            ? Image.asset(
                                assetPath(imageList[1]),
                                fit: BoxFit.cover,
                              )
                            : null)),
                SizedBox(
                  height: 1.w,
                ),
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                        width: (MediaQuery.of(context).size.width - 2.w) / 3,
                        height: (500.w - 1.w) / 2,
                        color: const Color.fromARGB(255, 247, 247, 247),
                        child: imageList.isNotEmpty
                            ? Image.asset(
                                assetPath(imageList[2]),
                                fit: BoxFit.cover,
                              )
                            : null)),
              ],
            ),
            SizedBox(
              width: 1.w,
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: imageList.isNotEmpty
                          ? Image.asset(
                              assetPath(imageList[3]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    )),
                SizedBox(
                  height: 1.w,
                ),
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: imageList.isNotEmpty
                          ? Image.asset(
                              assetPath(imageList[4]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    )),
              ],
            ),
          ],
        ));
  }
}

// 样式2
class LJNInsStyle2 extends StatelessWidget {
  final List<String> imageList;

  const LJNInsStyle2({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 1.w),
        child: Row(
          children: [
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: imageList.isNotEmpty
                          ? Image.asset(
                              assetPath(imageList[1]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    )),
                SizedBox(
                  height: 1.w,
                ),
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: imageList.isNotEmpty
                          ? Image.asset(
                              assetPath(imageList[2]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    )),
              ],
            ),
            SizedBox(
              width: 1.w,
            ),
            GestureDetector(
                onTap: () {
                  logger.info("按下");
                },
                onLongPress: () {
                  logger.info("长按");
                },
                onTapCancel: () {
                  logger.info("释放");
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 2.w) / 3,
                  height: 500.w,
                  color: const Color.fromARGB(255, 247, 247, 247),
                  child: imageList.isNotEmpty
                      ? Image.asset(
                          assetPath(imageList[0]),
                          fit: BoxFit.cover,
                        )
                      : null,
                )),
            SizedBox(
              width: 1.w,
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: imageList.isNotEmpty
                          ? Image.asset(
                              assetPath(imageList[3]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    )),
                SizedBox(
                  height: 1.w,
                ),
                GestureDetector(
                    onTap: () {
                      logger.info("按下");
                    },
                    onLongPress: () {
                      logger.info("长按");
                    },
                    onTapCancel: () {
                      logger.info("释放");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 2.w) / 3,
                      height: (500.w - 1.w) / 2,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: imageList.isNotEmpty
                          ? Image.asset(
                              assetPath(imageList[4]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    )),
              ],
            ),
          ],
        ));
  }
}

// 样式3
class LJNInsStyle3 extends StatelessWidget {
  final List<String> imageList;

  const LJNInsStyle3({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 1.w),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 2.w) / 3,
                  height: (500.w - 1.w) / 2,
                  color: const Color.fromARGB(255, 247, 247, 247),
                  child: imageList.isNotEmpty
                      ? Image.asset(
                          assetPath(imageList[1]),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                SizedBox(
                  height: 1.w,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 2.w) / 3,
                  height: (500.w - 1.w) / 2,
                  color: const Color.fromARGB(255, 247, 247, 247),
                  child: imageList.isNotEmpty
                      ? Image.asset(
                          assetPath(imageList[2]),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ],
            ),
            SizedBox(
              width: 1.w,
            ),
            Column(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width - 2.w) / 3,
                  height: (500.w - 1.w) / 2,
                  color: const Color.fromARGB(255, 247, 247, 247),
                  child: imageList.isNotEmpty
                      ? Image.asset(
                          assetPath(imageList[3]),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                SizedBox(
                  height: 1.w,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 2.w) / 3,
                  height: (500.w - 1.w) / 2,
                  color: const Color.fromARGB(255, 247, 247, 247),
                  child: imageList.isNotEmpty
                      ? Image.asset(
                          assetPath(imageList[4]),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ],
            ),
            SizedBox(
              width: 1.w,
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 2.w) / 3,
              height: 500.w,
              color: const Color.fromARGB(255, 247, 247, 247),
              child: imageList.isNotEmpty
                  ? Image.asset(
                      assetPath(imageList[0]),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ],
        ));
  }
}
