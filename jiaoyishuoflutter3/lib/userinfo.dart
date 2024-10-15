import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNFunctionItem.dart';

class LJNUserinfoPage extends StatefulWidget {
  const LJNUserinfoPage({super.key});

  @override
  State<LJNUserinfoPage> createState() => _LJNUserinfoPage();
}

class _LJNUserinfoPage extends State<LJNUserinfoPage> {
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
    Size screenSize = MediaQuery.of(context).size;

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
                            fontSize: 30.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
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
                          //             style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontSize: 30.w,
                          //                 fontWeight: FontWeight.w500)))),
                        ],
                      ))),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  screenSize.height - 90.w - _statusHeight),
                          color: const Color.fromARGB(255, 237, 237, 237),
                          child: Column(children: [
                            // 头像
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "头像",
                              height: 150.w,
                              link: '',
                              showStyle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10).w,
                                      child: Image.asset(
                                        vm.userinfoAvatar as String,
                                        width: 120.w,
                                        height: 120.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ]),
                              underline: true,
                            ),
                            // 姓名
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "名字",
                              // icon: "images/icon/discovery_icon2.png",
                              link: '',
                              showStyle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      vm.userinfoName!,
                                      style: TextStyle(
                                        fontSize: 30.w,
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                      ),
                                    )
                                  ]),
                              underline: true,
                            ),
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "拍一拍",
                              link: '',
                              underline: true,
                            ),

                            // 微信号
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "微信号",
                              link: '',
                              showStyle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      vm.userinfoAccount!,
                                      style: TextStyle(
                                        fontSize: 30.w,
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                      ),
                                    )
                                  ]),
                              underline: true,
                            ),

                            // 二维码名片
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "二维码名片",
                              link: '',
                              showStyle: Row(
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
                                  ]),
                              underline: true,
                            ),

                            // 更多信息
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "更多信息",
                              link: '',
                              underline: false,
                            ),

                            SizedBox(height: 16.w),

                            // 来电铃声
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "来电铃声",
                              link: '',
                              showStyle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'SISTER SISTER - JAVA',
                                      style: TextStyle(
                                        fontSize: 29.w,
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                      ),
                                    )
                                  ]),
                              underline: false,
                            ),

                            SizedBox(height: 16.w),

                            // 微信豆
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "微信豆",
                              link: '',
                              showStyle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '3个',
                                      style: TextStyle(
                                        fontSize: 29.w,
                                        color: const Color.fromARGB(
                                            255, 170, 170, 170),
                                      ),
                                    )
                                  ]),
                              underline: false,
                            ),
                            SizedBox(height: 16.w),

                            // 我的地址
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "我的地址",
                              link: '',
                              underline: true,
                            ),

                            // 我的发票抬头
                            const LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "我的发票抬头",
                              link: '',
                              underline: false,
                            ),
                          ])))));
        });
  }
}
