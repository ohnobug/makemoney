import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNFunctionItem.dart';

class LJNDiscoveryPage extends StatefulWidget {
  const LJNDiscoveryPage({super.key});

  @override
  State<LJNDiscoveryPage> createState() => _LJNDiscoveryPage();
}

class _LJNDiscoveryPage extends State<LJNDiscoveryPage> {
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
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ColoredBox(
            color: const Color.fromARGB(255, 237, 237, 237),
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(children: [
                  SizedBox(height: _statusHeight + 90.w),

                  // 朋友圈
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "朋友圈",
                    icon: "images/icon/discovery_icon1.png",
                    link: '/friendmoments',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 视频号、直播
                  LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "视频号",
                    icon: "images/icon/discovery_icon2.png",
                    link: '/video_player',
                    underline: true,
                    showStyle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(6).w,
                              child: Image.asset(
                                assetPath('images/avatar_webp/chat_4.webp'),
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 14.w,
                          ),
                          Flexible(
                              child: RichText(
                            text: TextSpan(
                              children: buildTextSpans(
                                  "李俊南集团💖李俊男  最近💖",
                                  TextStyle(
                                      fontSize: 26.w,
                                      color:
                                          const Color.fromARGB(255, 80, 80, 80),
                                      fontFamily: "AlibabaPuHuiTi"),
                                  TextStyle(
                                      fontSize: 26.w,
                                      fontFamily: "NotoColorEmoji-Regular")),
                            ),
                          )),
                        ]),
                  ),
                  LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "直播",
                    icon: "images/icon/discovery_icon3.png",
                    link: '',
                    underline: false,
                    showStyle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "小歪今天穿什么直播中",
                              style: TextStyle(
                                  fontSize: 26.w,
                                  color: const Color.fromARGB(255, 80, 80, 80)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60).w,
                              child: Image.asset(
                                assetPath('images/avatar_webp/chat_4.webp'),
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.cover,
                              )),
                        ]),
                  ),
                  SizedBox(height: 16.w),

                  // 扫一扫、听一听
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "扫一扫",
                    icon: "images/icon/discovery_icon4.png",
                    link: '/qrcode_scanner',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "听一听",
                    icon: "images/icon/discovery_icon5.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 看一看、搜一搜
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "看一看",
                    icon: "images/icon/discovery_icon6.png",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "搜一搜",
                    icon: "images/icon/discovery_icon7.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 附近
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "附近",
                    icon: "images/icon/discovery_icon8.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 购物、游戏
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "购物",
                    icon: "images/icon/discovery_icon9.png",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "游戏",
                    icon: "images/icon/discovery_icon10.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 小程序
                  const LJNFunctionItem(
                    id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                    title: "小程序",
                    icon: "images/icon/discovery_icon11.png",
                    link: '',
                    underline: false,
                  ),
                ]))));
  }
}
