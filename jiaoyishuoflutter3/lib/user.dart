import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import 'components/LJNFunctionItem.dart';

class LJNUserPage extends StatefulWidget {
  const LJNUserPage({super.key});

  @override
  State<LJNUserPage> createState() => _LJNUserPageState();
}

class _LJNUserPageState extends State<LJNUserPage> {
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
      myStore.dispatch({"type": "mainpage4isload", "payload": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return vm.mainpage4isload!
              ? ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                          constraints: BoxConstraints(
                              minHeight: screenSize.height - 106.w),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 237, 237, 237)
                              ],
                              stops: [0.3, 0.5],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // 顶部功能区域
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      top: 120.0.w + _statusHeight,
                                      left: 32.w,
                                      right: 32.w,
                                      bottom: 50.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/userinfo');
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10).w,
                                            child: Image(
                                              image: ResizeImage(
                                                  AssetImage(assetPath(
                                                      vm.userinfoAvatar!)),
                                                  width: 240.w.toInt(),
                                                  height: 240.w.toInt()),
                                              width: 120.w,
                                              height: 120.w,
                                              fit: BoxFit.cover,
                                            ),
                                          )),

                                      SizedBox(width: 30.w),

                                      // 用户信息区域
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // 用户名
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context, '/userinfo');
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        vm.userinfoName
                                                            as String,
                                                        style: TextStyle(height: 1.08,
                                                          fontSize: 42.w,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )),

                                                SizedBox(height: 20.w),

                                                // 微信号
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, '/userinfo');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '微信号：${vm.userinfoAccount}',
                                                        style: TextStyle(height: 1.08,
                                                          fontSize: 28.w,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              111, 111, 111),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            const IconData(
                                                              0xe74b,
                                                              fontFamily:
                                                                  'Iconfont',
                                                            ),
                                                            size: 24.w,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                170, 170, 170),
                                                          ),
                                                          SizedBox(width: 43.w),
                                                          Icon(
                                                            const IconData(
                                                              0xed9d,
                                                              fontFamily:
                                                                  'Iconfont',
                                                            ),
                                                            size: 28.w,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                170, 170, 170),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 40.w),

                                                Row(
                                                  children: [
                                                    LJNStatusButton(
                                                        text: '+ 状态',
                                                        onPressed: () {
                                                          logger.info('点击状态');
                                                        }),
                                                    SizedBox(width: 14.w),
                                                    LJNStatusButton(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 60.w,
                                                              width: 85.w,
                                                              child: Stack(
                                                                children: <Widget>[
                                                                  Positioned(
                                                                    top: 6.w,
                                                                    left: 0.w,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 2.0.w),
                                                                        borderRadius:
                                                                            BorderRadius.circular(200).w,
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(1000).w,
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/avatar_webp/chat_4.webp',
                                                                          width:
                                                                              30.w,
                                                                          height:
                                                                              30.w,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 6.w,
                                                                    left: 25.w,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 2.0.w),
                                                                        borderRadius:
                                                                            BorderRadius.circular(200).w,
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(1000).w,
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/avatar_webp/chat_5.webp',
                                                                          width:
                                                                              30.w,
                                                                          height:
                                                                              30.w,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: 6.w,
                                                                    left: 50.w,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 2.0.w),
                                                                        borderRadius:
                                                                            BorderRadius.circular(200).w,
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100).w,
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/avatar_webp/chat_6.webp',
                                                                          width:
                                                                              30.w,
                                                                          height:
                                                                              30.w,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 10.w),
                                                            Text(
                                                              '等8个朋友',
                                                              style: TextStyle(height: 1.08,
                                                                fontSize: 24.w,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    116,
                                                                    116,
                                                                    116),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        onPressed: () {
                                                          logger.info('等四个朋友');
                                                        }),
                                                  ],
                                                ),
                                              ])),
                                    ],
                                  ),
                                ),

                                Container(
                                  width: double.infinity,
                                  height: 16.w,
                                  color:
                                      const Color.fromARGB(255, 237, 237, 237),
                                ),

                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "服务",
                                  icon: "images/icon/icon1.png",
                                  link: '/services',
                                  underline: false,
                                ),

                                // 间隔
                                Container(
                                  width: double.infinity,
                                  height: 16.w,
                                  color:
                                      const Color.fromARGB(255, 237, 237, 237),
                                ),

                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "收藏",
                                  icon: "images/icon/icon2.png",
                                  link: '',
                                  underline: true,
                                ),
                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "朋友圈",
                                  icon: "images/icon/icon3.png",
                                  link: '',
                                  underline: true,
                                ),
                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "视频号",
                                  icon: "images/icon/icon4.png",
                                  link: '',
                                  underline: true,
                                ),
                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "订单与卡包",
                                  icon: "images/icon/icon5.png",
                                  link: '',
                                  underline: true,
                                ),
                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "表情",
                                  icon: "images/icon/icon6.png",
                                  link: '',
                                  underline: false,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 16.w,
                                  color:
                                      const Color.fromARGB(255, 237, 237, 237),
                                ),

                                const LJNFunctionItem(
                                  id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                                  title: "设置",
                                  icon: "images/icon/icon7.png",
                                  link: '',
                                  underline: false,
                                ),
                              ]))),
                )
              : const LJNPageLoading();
        });
  }
}

// 状态按钮
class LJNStatusButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final Function() onPressed;

  const LJNStatusButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
  });

  @override
  State<LJNStatusButton> createState() => _LJNStatusButton();
}

class _LJNStatusButton extends State<LJNStatusButton> {
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
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12).w,
          height: 48.w,
          decoration: BoxDecoration(
            color: _isPressed
                ? const Color.fromARGB(255, 229, 229, 229)
                : Colors.transparent,
            border: Border.all(
              color: const Color.fromARGB(255, 231, 231, 231),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(24).w,
          ),
          child: widget.text == null
              ? widget.child
              : Center(
                  child: Text(
                  widget.text!,
                  style: TextStyle(height: 1.08,
                    fontSize: 24.w,
                    color: const Color.fromARGB(255, 116, 116, 116),
                  ),
                )),
        ));
  }
}
