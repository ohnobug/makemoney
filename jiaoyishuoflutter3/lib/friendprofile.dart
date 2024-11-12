import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNFunctionItemButton.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import 'components/LJNFunctionItem.dart';
import 'components/LJNVideoFunctionItem.dart';

class LJNFriendProfilePage extends StatefulWidget {
  const LJNFriendProfilePage({
    super.key,
    this.name,
    this.avatar,
    this.nickname,
    this.account,
  });

  final String? name;
  final String? avatar;
  final String? nickname;
  final String? account;

  @override
  State<LJNFriendProfilePage> createState() => _LJNFriendProfilePage();
}

class _LJNFriendProfilePage extends State<LJNFriendProfilePage> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

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
                      color: Colors.white,
                      padding: EdgeInsets.only(top: _statusHeight),
                      child: AppBar(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            // wallet
                          }, // 点击事件
                          child: Container(
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
                        title: const Text(''),
                        toolbarHeight: 90.w,
                        titleTextStyle: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.w),
                            color: Colors.black,
                            fontFamily: "AlibabaPuHuiTi-Medium"),
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        actions: [
                          // 三个点
                          GestureDetector(
                            onTap: () {
                              // 点击事件
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
                          ),
                        ],
                      ))),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight: screenSize.height - 90.w - _statusHeight),
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
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(children: [
                            Container(
                                width: 750.w,
                                height: 260.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 242, 242, 242),
                                      width: 1.5.w,
                                      style: BorderStyle.solid,
                                    ))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 55.w,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          child: Image.asset(
                                            assetPath(widget.avatar!),
                                            width: 120.w,
                                            height: 120.w,
                                            cacheWidth: 240.w.toInt(),
                                            cacheHeight: 240.w.toInt(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 45.w,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // 姓名
                                              RichText(
                                                text: TextSpan(
                                                  children: buildTextSpans(
                                                      widget.name!,
                                                      TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(40.w),
                                                        color: Colors.black,
                                                        fontFamily:
                                                            "AlibabaPuHuiTi-Medium",
                                                      ),
                                                      TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(40.w),
                                                      )),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 20.w,
                                              ),

                                              // 昵称
                                              RichText(
                                                text: TextSpan(
                                                  children: buildTextSpans(
                                                      '昵称: ${widget.nickname!}',
                                                      TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(27.w),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 99, 99, 99),
                                                        fontFamily:
                                                            "AlibabaPuHuiTi-Medium",
                                                      ),
                                                      TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(27.w),
                                                      )),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 20.w,
                                              ),

                                              // 微信号
                                              Text('微信号: ${widget.account!}',
                                                  style: TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(27.w),
                                                    color: const Color.fromARGB(
                                                        255, 99, 99, 99),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),

                            // 设置备注与标签
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "设置备注与标签",
                              link: '',
                              underline: true,
                            ),

                            // 朋友权限
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "朋友权限",
                              link: '',
                              underline: true,
                            ),

                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),

                            // 朋友圈
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "朋友圈",
                              link: '/friendmoments',
                              height: 151.w,
                              showStyle: Container(
                                  margin: EdgeInsets.only(left: 68.w),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          assetPath(
                                              'images/avatar_webp/chat_81.webp'),
                                          cacheWidth: 180.w.toInt(),
                                          cacheHeight: 180.w.toInt(),
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Image.asset(
                                          assetPath(
                                              'images/avatar_webp/chat_92.webp'),
                                          cacheWidth: 180.w.toInt(),
                                          cacheHeight: 180.w.toInt(),
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Image.asset(
                                          assetPath(
                                              'images/avatar_webp/chat_93.webp'),
                                          cacheWidth: 180.w.toInt(),
                                          cacheHeight: 180.w.toInt(),
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Image.asset(
                                          assetPath(
                                              'images/avatar_webp/chat_86.webp'),
                                          cacheWidth: 180.w.toInt(),
                                          cacheHeight: 180.w.toInt(),
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ])),
                              underline: true,
                            ),

                            // 视频号
                            LJNVideoFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "视频号",
                              link: '/ins',
                              height: 216.w,
                              showStyle: Container(
                                  height: 215.w,
                                  margin: EdgeInsets.only(left: 68.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // 标题
                                      Expanded(
                                        flex: 0,
                                        // width: 100.w,
                                        child: Container(
                                            // color: Colors.red,
                                            padding: EdgeInsets.only(top: 38.w),
                                            child: Text(
                                              widget.name!,
                                              style: TextStyle(
                                                height: 1.08,
                                                fontSize: fontSizeScale(30.0.w),
                                                // fontFamily: "AlibabaPuHuiTi",
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 28.w,
                                      ),
                                      // 视频
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_55.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_43.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_96.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_97.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ])
                                    ],
                                  )),
                              underline: true,
                            ),

                            // 更多信息
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "更多信息",
                              link: '',
                              underline: false,
                            ),

                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),

                            LJNFunctionItemButton(
                              title: '发信息',
                              underline: true,
                              link: '/chat',
                              icon: Icon(
                                const IconData(
                                  0xe7b3,
                                  fontFamily: 'Iconfont',
                                ),
                                color: const Color.fromARGB(
                                    255, 58, 81, 124), // 图标颜色
                                size: fontSizeScale(35.w), // 图标大小
                              ),
                            ),
                            LJNFunctionItemButton(
                              title: '音视频通话',
                              underline: false,
                              icon: Icon(
                                const IconData(
                                  0xe88d,
                                  fontFamily: 'Iconfont',
                                ),
                                color: const Color.fromARGB(
                                    255, 58, 81, 124), // 图标颜色
                                size: fontSizeScale(35.w), // 图标大小
                              ),
                            )
                          ])))));
        });
  }
}
