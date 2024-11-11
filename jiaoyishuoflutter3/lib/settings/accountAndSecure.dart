import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import '../components/LJNFunctionItem.dart';

class LJNAccountAndSecure extends StatefulWidget {
  const LJNAccountAndSecure({super.key});

  @override
  State<LJNAccountAndSecure> createState() => LJNAaccountAndSecure();
}

class LJNAaccountAndSecure extends State<LJNAccountAndSecure> {
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
                  title: const Text('账号与安全'),
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
                        title: "微信号",
                        link: '',
                        showStyle: "TheMonsterClub",
                        underline: true,
                      ),
                      // 手机号
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "手机号",
                        link: '',
                        showStyle: "+8618825130917",
                        underline: false,
                      ),

                      SizedBox(height: 16.w),

                      // 微信密码
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "微信密码",
                        link: '',
                        underline: true,
                      ),
                      // 声音锁
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "声音锁",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),

                      // 应急联系人
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "应急联系人",
                        link: '',
                        underline: true,
                      ),
                      // 登录过的设备
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "登录过的设备",
                        link: '',
                        underline: true,
                      ),
                      // 更多安全设置
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "更多安全设置",
                        link: '',
                        underline: false,
                      ),

                      SizedBox(height: 16.w),
                      // 微信安全中心
                      LJNSpecialFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "微信安全中心",
                        height: 178.w,
                        link: '',
                        showStyle: Text(
                          "如果你遇到账号被盗，无法登录等问题，可以前往安全中心",
                          maxLines: 3,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 193, 193, 193),
                            fontSize: 24.w,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                        underline: false,
                      ),
                    ])))));
  }
}

class LJNSpecialFunctionItem extends StatefulWidget {
  final String id;
  final String? icon;
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Widget? showStyle;

  const LJNSpecialFunctionItem({
    super.key,
    required this.id,
    this.icon,
    this.height,
    required this.title,
    this.link,
    required this.underline,
    this.showStyle,
  });

  @override
  State<LJNSpecialFunctionItem> createState() => _LJNSpecialFunctionItemState();
}

class _LJNSpecialFunctionItemState extends State<LJNSpecialFunctionItem> {
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
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                // height: double.infinity,
                // width: 400.w,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: widget.underline
                      ? const Color.fromARGB(255, 242, 242, 242)
                      : Colors.transparent,
                  width: 1.5.w,
                  style: BorderStyle.solid,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    SizedBox(
                      // flex: 1,
                      // color: Colors.red,
                      width: 600.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 14.w,
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            // color: Colors.red,
                            child: widget.showStyle,
                          )
                        ],
                      ),
                    ),

                    Container(
                        width: 30.w,
                        margin: const EdgeInsets.only(right: 32).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 30.0.w,
                          color: const Color.fromARGB(255, 164, 164, 164),
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
