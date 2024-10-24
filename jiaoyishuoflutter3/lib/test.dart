import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';

class LJNTestPage extends StatefulWidget {
  const LJNTestPage({super.key});

  @override
  State<LJNTestPage> createState() => _LJNTestPage();
}

class _LJNTestPage extends State<LJNTestPage> {
  late bool _visible = false;

  Offset touchPosition = Offset.zero;
  bool isInsideBox = false;

  void checkIfInsideBox(Offset position) {
    // 获取目标盒子的渲染对象
    final renderBox = boxKey.currentContext?.findRenderObject() as RenderBox;

    // 获取盒子的实际边界
    final boxRect =
        renderBox.localToGlobal(Offset.zero) & renderBox.size; // 盒子的边界

    logger.info(position);

    // 盒子边界
    // logger.info(boxRect);

    // 检查鼠标位置是否在盒子内
    setState(() {
      isInsideBox = boxRect.contains(position);
    });
  }

  final GlobalKey boxKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.blueAccent,
        child: Stack(
          children: [
            Center(
                child: GestureDetector(
                    onLongPressStart: (details) {
                      logger.info('onLongPressStart');
                    },
                    onLongPressEnd: (details) {
                      logger.info('onLongPressEnd');
                    },
                    onLongPressUp: () {
                      setState(() {
                        _visible = false;
                      });
                      logger.info('onLongPressUp');
                    },
                    onLongPressDown: (LongPressDownDetails details) {
                      logger.info('onLongPressDown');
                    },
                    onLongPressCancel: () {
                      logger.info('onLongPressCancel');
                    },
                    onLongPress: () {
                      setState(() {
                        _visible = true;
                      });
                      logger.info('onLongPress');
                    },
                    onLongPressMoveUpdate: (details) {
                      // 更新手指位置并检查是否在盒子内
                      checkIfInsideBox(details.globalPosition);
                      logger.info('onLongPressMoveUpdate');
                    },
                    child: Container(
                        width: 100.w,
                        height: 100.w,
                        color: Colors.cyanAccent))),
            Visibility(
                visible: _visible,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  color: const Color.fromARGB(158, 44, 233, 186),
                  child: Center(
                      child: Container(
                          color: Colors.red,
                          width: screenSize.width - 200.w,
                          height: screenSize.height - 500.w,
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 100.w,
                                  top: 200.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      // 盒子的点击事件
                                      logger.info("盒子被点击");
                                    },
                                    child: Container(
                                      key: boxKey,
                                      width: 100,
                                      height: 100,
                                      color: const Color.fromARGB(255, 72, 109, 12),
                                      child: Center(
                                        child: Text(
                                          isInsideBox ? "Inside" : "Outside",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ))),
                ))
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
