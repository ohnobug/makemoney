import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNAccountInfo extends StatefulWidget {
  const LJNAccountInfo({super.key});

  @override
  State<LJNAccountInfo> createState() => _LJNAccountInfo();
}

class _LJNAccountInfo extends State<LJNAccountInfo> {
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
          return vm.mainpage3isload! ? _buildPage(vm) : const LJNPageLoading();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
                color: Colors.transparent,
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
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
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
        body: StoreConnector<StoreType, StoreType>(
            converter: (store) => store.state,
            builder: (context, vm) {
              return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight: screenSize.height - 90.w - _statusHeight),
                      color: Colors.white,
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Container(
                              width: screenSize.width,
                              padding: EdgeInsets.only(left: 70.w, right: 70.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      // color: Colors.red,
                                      height: 300.w,
                                      alignment: Alignment.bottomCenter,
                                      child: Icon(
                                        color: const Color.fromARGB(
                                            255, 212, 212, 212),
                                        const IconData(
                                          0xe883,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 140.w, // 图标大小
                                      )),
                                  SizedBox(
                                    height: 50.w,
                                  ),
                                  Text(
                                    "微信号：${vm.userinfoAccount}",
                                    style: TextStyle(
                                        fontSize: 40.w,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "AlibabaPuHuiTi"),
                                  ),
                                  SizedBox(
                                    height: 45.w,
                                  ),
                                  Text(
                                    "微信号是账号的唯一凭证，一年只能修改一次。",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30.w,
                                        fontFamily: "AlibabaPuHuiTi"),
                                  ),

                                  SizedBox(
                                    height: 620.w,
                                    child: null,
                                  ),

                                  // 修改微信号
                                  Container(
                                      padding: EdgeInsets.only(bottom: 180.w),
                                      child: const LJNChangeAccountButton(
                                        title: '修改微信号',
                                        link: "/change_account",
                                      ))
                                ],
                              )))));
            }));
  }
}
