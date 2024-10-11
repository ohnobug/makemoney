import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNWalletPage extends StatefulWidget {
  const LJNWalletPage({super.key});

  @override
  State<LJNWalletPage> createState() => _LJNWalletPage();
}

class _LJNWalletPage extends State<LJNWalletPage> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});

    Future.delayed(const Duration(milliseconds: 300), () {
      myStore.dispatch({"type": "mainpage3isload", "payload": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return vm.mainpage3isload! ? _buildPage() : const LJNPageLoading();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage() {
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
                      // wallet
                    }, // 点击事件
                    child: Icon(
                      const IconData(
                        0xed9e,
                        fontFamily: 'Iconfont',
                      ), // 使用的图标
                      color: Colors.black, // 图标颜色
                      size: 36.w, // 图标大小
                    ),
                  ),
                  primary: false,
                  centerTitle: true,
                  title: const Text('钱包'),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      fontSize: 30.w,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  foregroundColor: const Color.fromARGB(255, 237, 237, 237),
                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(1.w),
                  //   child: Container(
                  //     color: const Color.fromARGB(255, 220, 220, 220),
                  //     height: 1.w,
                  //   ),
                  // ),
                  actions: [
                    // 三个点
                    GestureDetector(
                        onTap: () {
                          // 点击事件
                        },
                        child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(right: 33.w),
                            child: Text("账单",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.w,
                                    fontWeight: FontWeight.w500)))),
                  ],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ColoredBox(
                color: const Color.fromARGB(255, 237, 237, 237),
                child: Column(children: [
                  // 朋友圈
                  const FunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "零钱",
                    icon: "images/icon/discovery_icon1.png",
                    link: '',
                    underline: false,
                  ),

                  // 视频号、直播
                  const FunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "零钱通",
                    icon: "images/icon/discovery_icon2.png",
                    link: '',
                    underline: true,
                    showStyle: 1,
                  ),
                  const FunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "银行卡",
                    icon: "images/icon/discovery_icon3.png",
                    link: '',
                    underline: false,
                    showStyle: 2,
                  ),

                  // 扫一扫、听一听
                  const FunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "亲属卡",
                    icon: "images/icon/discovery_icon4.png",
                    link: '',
                    underline: false,
                  ),

                  SizedBox(height: 16.w),

                  const FunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "支付分",
                    icon: "images/icon/discovery_icon5.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 消费者保护
                  const FunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "消费者保护",
                    icon: "images/icon/discovery_icon6.png",
                    link: '',
                    underline: false,
                  ),
                ]))));
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
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() {
          containerColor = const Color.fromARGB(255, 229, 229, 229);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = Colors.white;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = Colors.white;
          });

          if (mounted) {
            Navigator.pushNamed(context, '/services');
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            // 头像
            Container(
              width: 40.0.w,
              height: 40.0.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(assetPath(widget.icon)),
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
                              padding:
                                  const EdgeInsets.only(right: 28, left: 28).w,
                              // color: Colors.red,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6).w,
                                        child: Image.asset(
                                          assetPath(
                                              'images/avatar_webp/chat_4.webp'),
                                          width: 60.w,
                                          height: 60.w,
                                          fit: BoxFit.cover,
                                        )),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Flexible(
                                        child: Text(
                                      "爱八方集团💖陈翠",
                                      style: TextStyle(
                                          fontSize: 26.w,
                                          color: const Color.fromARGB(
                                              255, 80, 80, 80)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
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
                              padding:
                                  const EdgeInsets.only(left: 28, right: 28).w,
                              // color: Colors.red,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "小歪今天穿什么直播中",
                                        style: TextStyle(
                                            fontSize: 26.w,
                                            color: const Color.fromARGB(
                                                255, 80, 80, 80)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(500).w,
                                        child: Image.asset(
                                          assetPath(
                                              'images/avatar_webp/chat_4.webp'),
                                          width: 60.w,
                                          height: 60.w,
                                          fit: BoxFit.cover,
                                        )),
                                  ]))),

                    Container(
                        margin: const EdgeInsets.only(right: 32).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
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
