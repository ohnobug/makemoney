import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_page_loading.dart';

import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/ljn_function_item.dart';

class LJNDiscoveryPage extends StatefulWidget {
  const LJNDiscoveryPage({super.key});

  @override
  State<LJNDiscoveryPage> createState() => _LJNDiscoveryPage();
}

class _LJNDiscoveryPage extends State<LJNDiscoveryPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SystemCubit>().updateHomescrollpixels(0);
      context.read<SystemCubit>().updateShowMiniProgramDrawer(false);
      context.read<SystemCubit>().updateMainpage3isload(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage3isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ColoredBox(
            color: const Color.fromARGB(255, 237, 237, 237),
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(children: [
                  SizedBox(height: systemState.statusHeight + 90.w),

                  // 朋友圈
                  const LJNFunctionItem(
                    title: "朋友圈",
                    icon: "images/icon/discovery_icon1.png",
                    link: '/friendmoments',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 视频号、直播
                  LJNFunctionItem(
                    title: "视频号",
                    icon: "images/icon/discovery_icon2.png",
                    link: '/ins',
                    underline: true,
                    showStyle: SizedBox(
                        width: 400.w,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(6).w,
                                  child: Image.asset(
                                    assetPath('images/avatar_webp/chat_4.webp'),
                                    width: 60.w,
                                    height: 60.w,
                                    cacheWidth: 120.w.toInt(),
                                    cacheHeight: 120.w.toInt(),
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 14.w,
                              ),
                              Expanded(
                                  child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: buildTextSpans(
                                      "李俊南集团💖李俊男李俊男李俊男李俊男李俊男李俊男李俊男李俊男  最近💖",
                                      TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(26.w),
                                          color: const Color.fromARGB(
                                              255, 80, 80, 80),
                                          fontFamily: "AlibabaPuHuiTi"),
                                      TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(26.w),
                                          fontFamily:
                                              "NotoColorEmoji-Regular")),
                                ),
                              )),
                            ])),
                  ),
                  LJNFunctionItem(
                    title: "直播",
                    icon: "images/icon/discovery_icon3.png",
                    link: '/tiktik',
                    underline: false,
                    showStyle: SizedBox(
                        width: 400.w,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "小歪今天穿什么直播中",
                                  style: TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(26.w),
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
                                  borderRadius: BorderRadius.circular(60).w,
                                  child: Image.asset(
                                    assetPath('images/avatar_webp/chat_4.webp'),
                                    cacheWidth: 120.w.toInt(),
                                    cacheHeight: 120.w.toInt(),
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                  )),
                            ])),
                  ),
                  SizedBox(height: 16.w),

                  // 扫一扫、听一听
                  const LJNFunctionItem(
                    title: "扫一扫",
                    icon: "images/icon/discovery_icon4.png",
                    link: '/qrcode_scanner',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "听一听",
                    icon: "images/icon/discovery_icon5.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 看一看、搜一搜
                  const LJNFunctionItem(
                    title: "看一看",
                    icon: "images/icon/discovery_icon6.png",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "搜一搜",
                    icon: "images/icon/discovery_icon7.png",
                    link: '/search',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 附近
                  const LJNFunctionItem(
                    title: "附近",
                    icon: "images/icon/discovery_icon8.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 购物、游戏
                  const LJNFunctionItem(
                    title: "购物",
                    icon: "images/icon/discovery_icon9.png",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "游戏",
                    icon: "images/icon/discovery_icon10.png",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),

                  // 小程序
                  const LJNFunctionItem(
                    title: "小程序",
                    icon: "images/icon/discovery_icon11.png",
                    link: '/miniprogram',
                    underline: false,
                  ),
                ]))));
  }
}
