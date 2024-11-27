import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNFunctionItem.dart';
import 'tools/tools.dart';

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

    myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});
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
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
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
                        title: const Text('钱包'),
                        toolbarHeight: 90.w,
                        titleTextStyle: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.w),
                            color: Colors.black,
                            fontFamily: "AlibabaPuHuiTi-Medium"),
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
                                          height: 1.08,
                                          color: Colors.black,
                                          fontSize: fontSizeScale(30.w),
                                          fontWeight: FontWeight.w500)))),
                        ],
                      ))),
              body: Container(
                  constraints: BoxConstraints(
                    minHeight: screenSize.height - (90.0.w + _statusHeight),
                  ),
                  color: const Color.fromARGB(255, 237, 237, 237),
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(children: [
                            // 朋友圈
                            LJNFunctionItem(
                              title: "零钱",
                              icon: "images/icon/discovery_icon1.png",
                              link: '/pocketmoney',
                              showStyle: Expanded(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: SizedBox(
                                                width: 22.w,
                                                child: Icon(
                                                  const IconData(
                                                    0xe90d,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  size: 25.w, // 图标大小
                                                )),
                                            alignment: PlaceholderAlignment
                                                .middle, // 使图标与文本垂直居中对齐
                                          ),
                                          TextSpan(
                                            text: vm.walletBalance.toString(),
                                            style: TextStyle(
                                              height: 1.08,
                                              fontSize: fontSizeScale(29.w),
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Quicksand",
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ])),
                              underline: true,
                            ),

                            // 视频号、直播
                            LJNFunctionItem(
                              title: "零钱通",
                              icon: "images/icon/discovery_icon2.png",
                              link: '',
                              showStyle: Expanded(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '收益率1.64%',
                                            style: TextStyle(
                                              height: 1.08,
                                              fontSize: fontSizeScale(23.w),
                                              color: const Color.fromARGB(
                                                  255, 249, 136, 39),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: SizedBox(
                                                width: 22.w,
                                                child: Icon(
                                                  const IconData(
                                                    0xe90d,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  size: 25.w, // 图标大小
                                                )),
                                            alignment: PlaceholderAlignment
                                                .middle, // 使图标与文本垂直居中对齐
                                          ),
                                          TextSpan(
                                            text: vm.walletFoundationBalance
                                                .toString(),
                                            style: TextStyle(
                                              height: 1.08,
                                              fontSize: fontSizeScale(29.w),
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Quicksand",
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ])),
                              underline: true,
                            ),
                            const LJNFunctionItem(
                              title: "银行卡",
                              icon: "images/icon/discovery_icon3.png",
                              link: '',
                              underline: true,
                            ),

                            // 扫一扫、听一听
                            const LJNFunctionItem(
                              title: "亲属卡",
                              icon: "images/icon/discovery_icon4.png",
                              link: '',
                              underline: false,
                            ),

                            SizedBox(height: 16.w),

                            const LJNFunctionItem(
                              title: "支付分",
                              icon: "images/icon/discovery_icon5.png",
                              link: '',
                              underline: false,
                            ),
                            SizedBox(height: 16.w),

                            // 消费者保护
                            const LJNFunctionItem(
                              title: "消费者保护",
                              icon: "images/icon/discovery_icon6.png",
                              link: '',
                              underline: false,
                            ),
                          ])))));
        });
  }
}
