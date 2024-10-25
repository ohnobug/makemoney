import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNTest2Page extends StatefulWidget {
  const LJNTest2Page({super.key});

  @override
  State<LJNTest2Page> createState() => _LJNTest2Page();
}

class _LJNTest2Page extends State<LJNTest2Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 初始化 AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50), // 动画持续时间
      vsync: this,
    );

    // 创建 Tween 来控制 left 从 360.w 到 0.w 的动画
    _animation = Tween<double>(begin: 360.w, end: 0.w).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // 这里设置加速曲线
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // 销毁控制器
    super.dispose();
  }

  void _startAnimation() {
    // 触发动画
    if (_controller.isCompleted) {
      _controller.reverse(); // 反向动画
    } else {
      _controller.forward(); // 正向动画
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text("aaaa"),
          ),
          primary: true,
          body: Column(
            children: [
              Container(
                width: 360.w,
                height: 75.w,
                color: const Color.fromARGB(255, 247, 19, 19), // 外层盒子的红色背景
                child: Stack(
                  children: [
                    // 红色盒子本身
                    Positioned(
                      top: 0,
                      left: _animation.value,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 0.w),
                        width: 360.w,
                        height: 75.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 76, 76, 76),
                          borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Baseline(
                                    baseline: 19.w,
                                    baselineType: TextBaseline.alphabetic,
                                    child: Icon(
                                      const IconData(
                                        0xe682,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: Colors.white,
                                      size: 31.w,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 8.w),
                                ),
                                TextSpan(
                                  text: "点赞",
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 28.w,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              height: 45.w,
                              width: 2.w,
                              color: const Color.fromARGB(255, 134, 134, 134),
                            ),
                            Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  style: const TextStyle(height: 1.08),
                                  child: Icon(
                                    const IconData(0xe605,
                                        fontFamily: 'Iconfont'),
                                    color: Colors.white,
                                    size: 28.w,
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 8.w),
                                ),
                                TextSpan(
                                  text: "评论",
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 28.w,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _startAnimation();
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.blue, // 按钮的背景颜色
                    borderRadius: BorderRadius.circular(10.0), // 圆角边框
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                    child: const Text(
                      '点击我',
                      style: TextStyle(
                        color: Colors.white, // 按钮文字的颜色
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
