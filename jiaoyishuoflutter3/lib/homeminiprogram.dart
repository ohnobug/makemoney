import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNHomeMiniProgram extends StatefulWidget {
  final Function reverse;

  const LJNHomeMiniProgram({super.key, required this.reverse});

  @override
  State<LJNHomeMiniProgram> createState() => _LJNHomeMiniProgram();
}

class _LJNHomeMiniProgram extends State<LJNHomeMiniProgram> {
  final ScrollController _scrollController = ScrollController();
  // Size _screenSize = const Size(0, 0);
  bool figerRelease = false;
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // 手指释放才生效
      if (!figerRelease) return;

      // 超出边缘
      if (_scrollController.position.outOfRange) {
        double currentScrollPosition = _scrollController.position.pixels;
        // 获取最大滚动范围
        double maxScrollExtent = _scrollController.position.maxScrollExtent;

        logger.info("超出: ${currentScrollPosition - maxScrollExtent}");

        // 检查是否超出
        if (currentScrollPosition > maxScrollExtent) {
          if (currentScrollPosition - maxScrollExtent > 200.w) {
            _scrollController.jumpTo(0);

            myStore
                .dispatch({"type": "showMiniProgramDrawer", "payload": false});
          }
        }
      }
    });
  }

  @override
  void dispose() {
    logger.info("撤退");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          double newAppbarHeight = 90.w + 17.w;

          double miniprogramboxScale = 0.8 +
              (0.2 *
                  ((vm.homescrollpixels + _statusHeight - 400.w) /
                      (screenSize.height - newAppbarHeight - 400.w)));
          if (miniprogramboxScale < 0) {
            miniprogramboxScale = 0;
          } else if (miniprogramboxScale > 1) {
            miniprogramboxScale = 1;
          }

          return Container(
            width: screenSize.width,
            height: vm.homescrollpixels + (90.w + _statusHeight + 200.w),
            color: const Color.fromARGB(255, 50, 48, 70),
            child: Transform.scale(
                scale: miniprogramboxScale,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // appbar标题
                    Container(
                        width: 750.w,
                        height: 90.0.w + _statusHeight,
                        color: const Color.fromARGB(255, 50, 48, 70),
                        padding: EdgeInsets.only(top: _statusHeight),
                        child: AppBar(
                          leading: null,
                          primary: false,
                          centerTitle: true,
                          title: const Text('最近'),
                          toolbarHeight: 90.w,
                          titleTextStyle: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.w),
                              color: Colors.white,
                              fontFamily: "AlibabaPuHuiTi-Medium"),
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          actions: [
                            // 三个点
                            GestureDetector(
                              onTap: () {
                                // 点击事件
                              },
                              child: Container(
                                height: 90.w,
                                color: Colors.transparent,
                                padding:
                                    EdgeInsets.only(right: 33.w), // 设置右侧内边距
                                child: Icon(
                                  const IconData(
                                    0xe659,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 37.w, // 图标大小
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),

                    // 列表
                    Listener(
                        onPointerDown: (event) {
                          setState(() {
                            figerRelease = false;
                          });
                        },
                        onPointerUp: (event) {
                          setState(() {
                            figerRelease = true;
                          });

                          widget.reverse();
                        },
                        child: SizedBox(
                            // color: Colors.cyan,
                            height: vm.homescrollpixels + 200.w,
                            child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(scrollbars: false),
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  child: Column(
                                    children: [
                                      // 最近使用的小程序
                                      FunctionButtonsSection(
                                        title: '最近使用的小程序',
                                        rightWidget: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('我的小程序',
                                                style: TextStyle(
                                                  height: 1.08,
                                                  fontSize: fontSizeScale(26.w),
                                                  color: const Color.fromARGB(
                                                      255, 175, 175, 175),
                                                )),
                                            Icon(
                                              const IconData(
                                                0xe8d4,
                                                fontFamily: 'Iconfont',
                                              ),
                                              size: fontSizeScale(28.w),
                                              color: const Color.fromARGB(
                                                  255, 175, 175, 175),
                                            )
                                          ],
                                        ),
                                        moreUrl: "",
                                        buttons: [
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/duitang.jpg",
                                              title: "堆糖",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/tiankongyueduqi.jpg",
                                              title: "天空阅读器",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/qishuwang.jpg",
                                              title: "奇书网",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/xueyouyoujiao.jpg",
                                              title: "学有优教",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/haiziwang.jpg",
                                              title: "孩子王",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/qianbixiaoshuo.jpg",
                                              title: "铅笔小说",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/chengquanshipin.jpg",
                                              title: "成全视频",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/xiaomishangcheng.jpg",
                                              title: "小米商城",
                                              onPressed: () {}),
                                        ],
                                      ),

                                      // 我的常用小程序
                                      FunctionButtonsSection(
                                        title: '我的常用小程序',
                                        rightWidget: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('我的小程序',
                                                style: TextStyle(
                                                  height: 1.08,
                                                  fontSize: fontSizeScale(28.w),
                                                  color: const Color.fromARGB(
                                                      255, 175, 175, 175),
                                                )),
                                            Icon(
                                              const IconData(
                                                0xe8d4,
                                                fontFamily: 'Iconfont',
                                              ),
                                              size: fontSizeScale(28.w),
                                              color: const Color.fromARGB(
                                                  255, 175, 175, 175),
                                            )
                                          ],
                                        ),
                                        moreUrl: "",
                                        buttons: [
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/duitang.jpg",
                                              title: "堆糖",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/tiankongyueduqi.jpg",
                                              title: "天空阅读器",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/qishuwang.jpg",
                                              title: "奇书网",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/xueyouyoujiao.jpg",
                                              title: "学有优教",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/chengquanshipin.jpg",
                                              title: "成全视频",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/xiaomishangcheng.jpg",
                                              title: "小米商城",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/meituxiuxiu.jpg",
                                              title: "美图秀秀",
                                              onPressed: () {}),
                                          FunctionButton(
                                              icon:
                                                  "images/miniprogram_icon/luobokuaipao.jpg",
                                              title: "萝卜快跑",
                                              onPressed: () {}),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))))
                  ],
                )),
          );
        });
  }
}

// 小程序按钮项组
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;
  final String moreUrl;
  final Widget? rightWidget;

  const FunctionButtonsSection(
      {super.key,
      required this.title,
      required this.buttons,
      required this.moreUrl,
      this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: 0.w, bottom: 18.w, left: 18.w, right: 18.w),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(16.0).w,
        // ),
        padding: const EdgeInsets.only(bottom: 16).w,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 标题
            Container(
              height: 50.w,
              margin: EdgeInsets.only(top: 33.w, left: 45.w, right: 45.w),
              // color: Colors.yellow,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(26.w),
                          color: const Color.fromARGB(255, 175, 175, 175),
                        )),
                    if (rightWidget != null) rightWidget!,
                  ]),
            ),

            SizedBox(
              height: 20.w,
            ),

            // 使用 SizedBox 控制 GridView 的大小
            Container(
              // color: const Color.fromARGB(255, 24, 237, 201),
              margin: const EdgeInsets.all(0),
              padding: EdgeInsets.only(bottom: 16.w, left: 16.0.w, right: 16.w),
              child: GridView.builder(
                primary: false,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(), // 禁用滚动
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 每行显示4个子组件
                  crossAxisSpacing: 16.w, // 列间距
                  mainAxisSpacing: 10.w, // 行间距
                  childAspectRatio: (1 / 1),
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return buttons[index];
                },
                shrinkWrap: true, // 根据内容调整 GridView 大小
              ),
            ),
          ],
        ));
  }
}

// 小程序按钮
class FunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  FunctionButtonState createState() => FunctionButtonState();
}

class FunctionButtonState extends State<FunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.orange,
          color: _isPressed ? Colors.grey[200] : Colors.transparent, // 按下时背景色
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 使按钮大小适应内容
            children: [
              ClipOval(
                child: Image.asset(
                  assetPath(widget.icon),
                  width: 92.w,
                  height: 92.w,
                  fit: BoxFit.cover, // 让图片完全填满圆形区域
                ),
              ),
              SizedBox(height: 15.w), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                    height: 1.08,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: fontSizeScale(26.0.w),
                    overflow: TextOverflow.ellipsis), // 标题颜色
              ),
            ],
          ),
        ),
      ),
    );
  }
}
