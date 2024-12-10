import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import 'components/LJNFunctionItem.dart';

class LJNUserinfoPage extends StatefulWidget {
  const LJNUserinfoPage({super.key});

  @override
  State<LJNUserinfoPage> createState() => _LJNUserinfoPage();
}

class _LJNUserinfoPage extends State<LJNUserinfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + vm.statusHeight!),
            child: Container(
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: vm.statusHeight!),
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
                  title: const Text('个人信息'),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Colors.black,
                      fontFamily: "AlibabaPuHuiTi-Medium"),
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
                  actions: const [
                    // // 三个点
                    // GestureDetector(
                    //     onTap: () {
                    //       // 点击事件
                    //     },
                    //     child: Container(
                    //         color: Colors.transparent,
                    //         padding: EdgeInsets.only(right: 33.w),
                    //         child: Text("账单",
                    //             style: TextStyle(height: 1.08,
                    //                 color: Colors.black,
                    //                 fontSize: fontSizeScale(30.w),
                    //                 fontWeight: FontWeight.w500)))),
                  ],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: screenSize.height - 90.w - vm.statusHeight!),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(children: [
                      // 头像
                      LJNFunctionItem(
                        title: "头像",
                        height: 150.w,
                        link: '',
                        showStyle: Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10).w,
                                      child: Image.asset(
                                        assetPath(vm.userinfoAvatar!),
                                        cacheWidth: 240.w.toInt(),
                                        cacheHeight: 240.w.toInt(),
                                        width: 120.w,
                                        height: 120.w,
                                        fit: BoxFit.cover,
                                      )),
                                ])),
                        underline: true,
                      ),
                      // 姓名
                      LJNFunctionItem(
                        title: "名字",
                        // icon: "images/icon/discovery_icon2.png",
                        link: '',
                        showStyle: vm.userinfoName!,
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        title: "拍一拍",
                        link: '',
                        underline: true,
                      ),

                      // 微信号
                      LJNFunctionItem(
                        title: "微信号",
                        link: '/accountinfo',
                        showStyle: vm.userinfoAccount!,
                        underline: true,
                      ),

                      // 二维码名片
                      LJNFunctionItem(
                        title: "二维码名片",
                        link: '',
                        showStyle: Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    const IconData(
                                      0xe74b,
                                      fontFamily: 'Iconfont',
                                    ),
                                    size: 30.w,
                                    color: const Color.fromARGB(
                                        255, 170, 170, 170),
                                  ),
                                ])),
                        underline: true,
                      ),

                      // 更多信息
                      const LJNFunctionItem(
                        title: "更多信息",
                        link: '',
                        underline: false,
                      ),

                      SizedBox(height: 16.w),

                      // 来电铃声
                      const LJNFunctionItem(
                        title: "来电铃声",
                        link: '',
                        showStyle: 'SISTER SISTER - JAVA',
                        underline: false,
                      ),

                      SizedBox(height: 16.w),

                      // 微信豆
                      const LJNFunctionItem(
                        title: "微信豆",
                        link: '',
                        showStyle: '3个',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      // 我的地址
                      const LJNFunctionItem(
                        title: "我的地址",
                        link: '',
                        underline: true,
                      ),

                      // 我的发票抬头
                      const LJNFunctionItem(
                        title: "我的发票抬头",
                        link: '',
                        underline: false,
                      ),
                    ])))));
  }
}
