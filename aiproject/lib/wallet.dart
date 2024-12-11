import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage();
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
              appBar: LJNAppBar(
                title: "钱包",
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/bill_details');
                      },
                      child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(right: 40.w),
                          alignment: Alignment.center,
                          child: Text("账单",
                              style: TextStyle(
                                  height: 1.08,
                                  color: Colors.black,
                                  fontSize: fontSizeScale(32.w),
                                  fontWeight: FontWeight.w500))))
                ],
              ),
              body: Container(
                  constraints: BoxConstraints(
                    minHeight: screenSize.height - (90.0.w + vm.statusHeight!),
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
                              showStyle: SizedBox(
                                  width: 480.w,
                                  // color: Colors.red,
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
