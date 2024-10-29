import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'logger.dart';

class LJNMiniProgramPage extends StatefulWidget {
  const LJNMiniProgramPage({super.key});

  @override
  State<LJNMiniProgramPage> createState() => _LJNMiniProgramPage();
}

class _LJNMiniProgramPage extends State<LJNMiniProgramPage> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();
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
          return Scaffold(
              primary: false,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(90.0.w + _statusHeight),
                  child: Container(
                      color: const Color.fromARGB(255, 237, 237, 237),
                      padding: EdgeInsets.only(top: _statusHeight),
                      child: AppBar(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          }, // 点击事件
                          child: Container(
                            // 加盒子是为了扩大点击区域
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(
                                0xed9e,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Colors.black, // 图标颜色
                              size: 36.w, // 图标大小
                            ),
                          ),
                        ),
                        primary: false,
                        centerTitle: true,
                        title: const Text('小程序'),
                        toolbarHeight: 90.w,
                        titleTextStyle: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.w),
                            color: Colors.black,
                            fontFamily: "AlibabaPuHuiTi-Medium"),
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor:
                            const Color.fromARGB(255, 237, 237, 237),
                        foregroundColor:
                            const Color.fromARGB(255, 237, 237, 237),
                        // bottom: PreferredSize(
                        //   preferredSize: Size.fromHeight(1.w),
                        //   child: Container(
                        //     color: const Color.fromARGB(255, 220, 220, 220),
                        //     height: 1.w,
                        //   ),
                        // ),
                        actions: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Colors.transparent,
                              height: 90.w,
                              padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                              child: Icon(
                                const IconData(
                                  0xe612,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 40.w, // 图标大小
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Colors.transparent,
                              height: 90.w,
                              padding: EdgeInsets.only(right: 40.w), // 设置右侧内边距
                              child: Icon(
                                const IconData(
                                  0xe726,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 42.w, // 图标大小
                              ),
                            ),
                          ),
                        ],
                      ))),
              body: ColoredBox(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight: screenSize.height - 205.w),
                            color: const Color.fromARGB(255, 237, 237, 237),
                            child: Column(
                              children: [
                                // 最近使用
                                FunctionButtonsSection(
                                  title: '最近使用',
                                  moreUrl: "/",
                                  buttons: [
                                    FunctionButton(
                                      icon: "images/icon/server_icon1.png",
                                      title: '信用卡还款',
                                      onPressed: () {
                                        logger.info('点击了信用卡还款按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon2.png",
                                      title: '理财通',
                                      onPressed: () {
                                        logger.info('点击了理财通按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon3.png",
                                      title: '保险服务',
                                      onPressed: () {
                                        logger.info('点击了保险服务按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon4.png",
                                      title: '保险服务',
                                      onPressed: () {
                                        logger.info('点击了保险服务按钮~~');
                                      },
                                    ),
                                  ],
                                ),

                                // 我的常用
                                FunctionButtonsSection(
                                  title: '我的常用',
                                  moreUrl: "",
                                  buttons: [
                                    FunctionButton(
                                      icon: "images/icon/server_icon4.png",
                                      title: '手机充值',
                                      onPressed: () {
                                        logger.info('点击了手机充值按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon5.png",
                                      title: '生活缴费',
                                      onPressed: () {
                                        logger.info('点击了生活缴费按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon6.png",
                                      title: 'Q币充值',
                                      onPressed: () {
                                        logger.info('点击了Q币充值按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon7.png",
                                      title: '城市服务',
                                      onPressed: () {
                                        logger.info('点击了城市服务按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon8.png",
                                      title: '腾讯公益',
                                      onPressed: () {
                                        logger.info('点击了腾讯公益按钮~~');
                                      },
                                    ),
                                    FunctionButton(
                                      icon: "images/icon/server_icon9.png",
                                      title: '医疗健康',
                                      onPressed: () {
                                        logger.info('点击了医疗健康按钮~~');
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )))));
        });
  }
}

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
              Image.asset(
                assetPath(widget.icon),
                width: 95.w,
                height: 95.w,
              ), // 图标颜色
              SizedBox(height: 22.w), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                    height: 1.08,
                    decoration: TextDecoration.none,
                    color: const Color.fromARGB(255, 92, 92, 92),
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

// FunctionButtonsSection 组件
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;
  final String moreUrl;

  const FunctionButtonsSection(
      {super.key,
      required this.title,
      required this.buttons,
      required this.moreUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 18, left: 18, right: 18).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0).w,
        ),
        padding: const EdgeInsets.only(bottom: 16).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 33.w, bottom: 16.w, left: 30.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(28.w),
                          color: Colors.black,
                        )),
                    if (moreUrl != '')
                      // 三个点
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            moreUrl,
                          );
                        },
                        child: Container(
                          height: 90.w,
                          color: Colors.transparent,
                          padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                          child: Icon(
                            const IconData(
                              0xe659,
                              fontFamily: 'Iconfont',
                            ),
                            size: 37.w, // 图标大小
                          ),
                        ),
                      )
                  ]),
            ),

            // 使用 SizedBox 控制 GridView 的大小
            Container(
              padding: const EdgeInsets.all(16.0).w,
              // height: 200, // 根据实际需要调整高度
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
