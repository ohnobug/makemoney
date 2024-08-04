import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNDiscoveryPage extends StatefulWidget {
  const LJNDiscoveryPage({super.key});

  @override
  State<LJNDiscoveryPage> createState() => _LJNDiscoveryPage();
}

class _LJNDiscoveryPage extends State<LJNDiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0.w), // 此处设置您想要的高度，例如 80.0
          child: AppBar(
            centerTitle: true, // 添加这一行
            title: const Text('服务'),
            titleTextStyle: TextStyle(fontSize: 32.0.w),
            backgroundColor: const Color.fromARGB(255, 247, 247, 247),
            foregroundColor: const Color.fromARGB(255, 247, 247, 247),
          ),
        ),
        body: NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollEndNotification) {
                print('NotificationListener onNotification: ${notification.dragDetails?.primaryVelocity}');
              }
              return false;
            },
            child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(children: [
                  Container(
                      // height: MediaQuery.of(context).size.height,
                      constraints:
                          BoxConstraints(minHeight: screenSize.height - 107.w),
                      color: const Color.fromARGB(255, 237, 237, 237),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // 朋友圈
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "朋友圈",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: false,
                              )
                            ]),

                            // 视频号、直播
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "视频号",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: true,
                                showStyle: 1,
                              ),
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "直播",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: false,
                                showStyle: 2,
                              )
                            ]),

                            // 扫一扫、听一听
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "扫一扫",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: true,
                              ),
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "听一听",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: false,
                              )
                            ]),

                            // 看一看、搜一搜
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "看一看",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: true,
                              ),
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "搜一搜",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: false,
                              )
                            ]),

                            // 附近
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "附近",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: false,
                              ),
                            ]),

                            // 购物、游戏
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "购物",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: true,
                              ),
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "游戏",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: true,
                              )
                            ]),

                            // 小程序
                            FunctionView(chatItems: [
                              FunctionItem(
                                id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                title: "小程序",
                                icon: "assets/images/icon/icon1.png",
                                link: '',
                                underline: false,
                              ),
                            ]),
                          ]))
                ]))));
  }
}

class FunctionView extends StatefulWidget {
  final List<FunctionItem> chatItems;

  const FunctionView({super.key, required this.chatItems});

  @override
  State<FunctionView> createState() => _FunctionViewState();
}

class _FunctionViewState extends State<FunctionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.chatItems.length * 105.0.w,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16).w,
      child: ListView.builder(
        itemCount: widget.chatItems.length,
        itemBuilder: (context, index) {
          return widget.chatItems[index];
        },
      ),
    );
  }
}

// 功能列表
class FunctionItem extends StatefulWidget {
  final String id;
  final String icon;
  final String title;
  final String link;
  final bool underline;
  final int? showStyle;

  const FunctionItem({
    super.key,
    required this.id,
    required this.icon,
    required this.title,
    required this.link,
    required this.underline,
    this.showStyle,
  });

  @override
  State<FunctionItem> createState() => _FunctionItemState();
}

class _FunctionItemState extends State<FunctionItem> {
  // bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Listener(
      // onTapDown: (tapDownDetails) {
      //   setState(() {
      //     isClicked = true;
      //     containerColor = const Color.fromARGB(255, 229, 229, 229);
      //   });
      // },
      // onTapCancel: () {
      //   setState(() {
      //     isClicked = false;
      //     containerColor = Colors.white;
      //     logger.info("取消点击");
      //   });
      // },
      // onTapUp: (tapDownDetails) {
      //   setState(() {
      //     isClicked = false;
      //     containerColor = Colors.white;

      //     Navigator.pushNamed(context, '/services');
      //   });
      // },
      onPointerMove: (PointerMoveEvent event) {
        // 判断是否为垂直滚动方向的移动
        if (event.delta.dy.abs() > event.delta.dx.abs()) {
          // 将事件传递给父级的 SingleChildScrollView
          print("aaaaaa");
          GestureBinding.instance.pointerRouter.route(event);
        } else {
          // 处理您自己的水平方向的操作逻辑
        }
      },
      onPointerDown: (event) {
        setState(() {
          containerColor = const Color.fromARGB(255, 229, 229, 229);
        });
      },
      onPointerUp: (event) {
        setState(() {
          containerColor = Colors.white;
        });
        // Navigator.pushNamed(context, '/services');
      },
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            // 头像
            Container(
              width: 45.0.w,
              height: 45.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.icon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Container(
                height: 100.w,
                width: 400.w,
                decoration: widget.underline
                    ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                        color: const Color.fromARGB(255, 233, 233, 233),
                        width: 1.w,
                        style: BorderStyle.solid,
                      )))
                    : BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 1.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Expanded(
                      flex: 0,
                      // width: 100.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 30.0.w,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    if (widget.showStyle == 1)
                      Flexible(
                          flex: 1,
                          child: Container(
                              padding: const EdgeInsets.only(right: 20).w,
                              // color: Colors.red,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6).w,
                                        child: Image.asset(
                                          'images/avatar/chat_4.jpg',
                                          width: 60.w,
                                          height: 60.w,
                                          fit: BoxFit.cover,
                                        )),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text(
                                      "爱八方集团💖陈翠",
                                      style: TextStyle(
                                          fontSize: 26.w,
                                          color: const Color.fromARGB(
                                              255, 80, 80, 80)),
                                    ),
                                    Text(
                                      " 最近💖",
                                      style: TextStyle(
                                          fontSize: 26.w,
                                          color: const Color.fromARGB(
                                              255, 80, 80, 80)),
                                    ),
                                  ]))),

                    if (widget.showStyle == 2)
                      Flexible(
                          flex: 1,
                          child: Container(
                              padding: const EdgeInsets.only(right: 20).w,
                              // color: Colors.red,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "小歪今天穿什么直播中",
                                      style: TextStyle(
                                          fontSize: 26.w,
                                          color: const Color.fromARGB(
                                              255, 80, 80, 80)),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500).w,
                                        child: Image.asset(
                                          'images/avatar/chat_4.jpg',
                                          width: 60.w,
                                          height: 60.w,
                                          fit: BoxFit.cover,
                                        )),
                                  ]))),

                    Container(
                        margin: const EdgeInsets.only(right: 32).w,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 26.0.w,
                          color: const Color.fromARGB(255, 170, 170, 170),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
