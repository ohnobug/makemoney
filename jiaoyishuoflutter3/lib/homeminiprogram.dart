import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNHomeMiniProgram extends StatefulWidget {
  const LJNHomeMiniProgram({super.key});

  @override
  State<LJNHomeMiniProgram> createState() => _LJNHomeMiniProgram();
}

class _LJNHomeMiniProgram extends State<LJNHomeMiniProgram> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          logger.info("在边缘下拉");
        } else {
          logger.info("在边缘上拉");
          myStore.dispatch({"type": "showMiniProgramDrawer", "payload": false});
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ColoredBox(
            color: const Color.fromARGB(255, 57, 55, 77),
            child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: SizedBox(
                  width: screenSize.width,
                  child: Column(
                    children: [
                      // 最近使用的小程序
                      FunctionButtonsSection(
                        title: '最近使用的小程序',
                        rightWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('我的小程序',
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(28.w),
                                  color:
                                      const Color.fromARGB(255, 175, 175, 175),
                                )),
                            Icon(
                              const IconData(
                                0xe8d4,
                                fontFamily: 'Iconfont',
                              ),
                              size: fontSizeScale(28.w),
                              color: const Color.fromARGB(255, 175, 175, 175),
                            )
                          ],
                        ),
                        moreUrl: "",
                        buttons: [
                          FunctionButton(
                              icon: "images/miniprogram_icon/duitang.jpg",
                              title: "堆糖",
                              onPressed: () {}),
                          FunctionButton(
                              icon:
                                  "images/miniprogram_icon/tiankongyueduqi.jpg",
                              title: "天空阅读器",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/qishuwang.jpg",
                              title: "奇书网",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/xueyouyoujiao.jpg",
                              title: "学有优教",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/haiziwang.jpg",
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
                          FunctionButton(
                              icon: "images/miniprogram_icon/meituxiuxiu.jpg",
                              title: "美图秀秀",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/luobokuaipao.jpg",
                              title: "萝卜快跑",
                              onPressed: () {}),
                        ],
                      ),

                      // 我的常用小程序
                      FunctionButtonsSection(
                        title: '我的常用小程序',
                        rightWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('我的小程序',
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(28.w),
                                  color:
                                      const Color.fromARGB(255, 175, 175, 175),
                                )),
                            Icon(
                              const IconData(
                                0xe8d4,
                                fontFamily: 'Iconfont',
                              ),
                              size: fontSizeScale(28.w),
                              color: const Color.fromARGB(255, 175, 175, 175),
                            )
                          ],
                        ),
                        moreUrl: "",
                        buttons: [
                          FunctionButton(
                              icon: "images/miniprogram_icon/duitang.jpg",
                              title: "堆糖",
                              onPressed: () {}),
                          FunctionButton(
                              icon:
                                  "images/miniprogram_icon/tiankongyueduqi.jpg",
                              title: "天空阅读器",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/qishuwang.jpg",
                              title: "奇书网",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/xueyouyoujiao.jpg",
                              title: "学有优教",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/haiziwang.jpg",
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
                          FunctionButton(
                              icon: "images/miniprogram_icon/meituxiuxiu.jpg",
                              title: "美图秀秀",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/luobokuaipao.jpg",
                              title: "萝卜快跑",
                              onPressed: () {}),
                        ],
                      ),

                      // 加多一层
                      FunctionButtonsSection(
                        title: '加多一层',
                        rightWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('我的小程序',
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(28.w),
                                  color:
                                      const Color.fromARGB(255, 175, 175, 175),
                                )),
                            Icon(
                              const IconData(
                                0xe8d4,
                                fontFamily: 'Iconfont',
                              ),
                              size: fontSizeScale(28.w),
                              color: const Color.fromARGB(255, 175, 175, 175),
                            )
                          ],
                        ),
                        moreUrl: "",
                        buttons: [
                          FunctionButton(
                              icon: "images/miniprogram_icon/duitang.jpg",
                              title: "堆糖",
                              onPressed: () {}),
                          FunctionButton(
                              icon:
                                  "images/miniprogram_icon/tiankongyueduqi.jpg",
                              title: "天空阅读器",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/qishuwang.jpg",
                              title: "奇书网",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/xueyouyoujiao.jpg",
                              title: "学有优教",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/haiziwang.jpg",
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
                          FunctionButton(
                              icon: "images/miniprogram_icon/meituxiuxiu.jpg",
                              title: "美图秀秀",
                              onPressed: () {}),
                          FunctionButton(
                              icon: "images/miniprogram_icon/luobokuaipao.jpg",
                              title: "萝卜快跑",
                              onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                ))));
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
        margin: const EdgeInsets.only(bottom: 18, left: 18, right: 18).w,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(16.0).w,
        // ),
        padding: const EdgeInsets.only(bottom: 16).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50.w,
              margin: EdgeInsets.only(top: 33.w, left: 45.w, right: 45.w),
              // color: Colors.red,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(28.w),
                          color: const Color.fromARGB(255, 175, 175, 175),
                        )),
                    if (rightWidget != null) rightWidget!,
                  ]),
            ),

            // 使用 SizedBox 控制 GridView 的大小
            Container(
              padding: const EdgeInsets.all(16.0).w,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 每行显示4个子组件
                  crossAxisSpacing: 16.w, // 列间距
                  mainAxisSpacing: 50.w, // 行间距
                  childAspectRatio: (1 / 1),
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return Center(child: buttons[index]);
                },
                shrinkWrap: true, // 根据内容调整 GridView 大小
                physics: const NeverScrollableScrollPhysics(), // 禁用滚动
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
              SizedBox(height: 20.w), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                    height: 1.08,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: fontSizeScale(25.0.w),
                    overflow: TextOverflow.ellipsis), // 标题颜色
              ),
            ],
          ),
        ),
      ),
    );
  }
}
