import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import '../components/LJNFunctionItem.dart';

class LJNSettingPage extends StatefulWidget {
  const LJNSettingPage({super.key});

  @override
  State<LJNSettingPage> createState() => _LJNSettingPage();
}

class _LJNSettingPage extends State<LJNSettingPage> {
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
                  title: const Text('设置'),
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
                    minHeight: screenSize.height - 90.w - _statusHeight),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(children: [
                      // 账户与安全
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "账户与安全",
                        link: '/account_and_secure',
                        underline: false,
                      ),

                      SizedBox(height: 16.w),

                      // 青少年模式 与 关怀模式
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "青少年模式",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "青少年模式",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      // 新消息通知 与 聊天 和 通用
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "新消息通知",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "聊天",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "通用",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      // 朋友权限 与 个人信息与权限 和 个人信息收集清单 和 第三方信息共享清单
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "朋友权限",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "个人信息与权限",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "个人信息收集清单",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "第三方信息共享清单",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "插件",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "关于微信",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "帮助与反馈",
                        link: '',
                        underline: false,
                      ),
                    ])))));
  }
}
