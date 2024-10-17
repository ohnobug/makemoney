import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNFunctionItem.dart';

class LJNProfilePage extends StatefulWidget {
  const LJNProfilePage({super.key});

  @override
  State<LJNProfilePage> createState() => _LJNProfilePage();
}

class _LJNProfilePage extends State<LJNProfilePage> {
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
                        title: const Text(''),
                        toolbarHeight: 90.w,
                        titleTextStyle: TextStyle(
                            fontSize: 32.w,
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
                                      width: 1.w,
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
                                        Container(
                                          width: 120.w,
                                          height: 120.w,
                                          margin: EdgeInsets.only(
                                              left: 30.w, right: 45.w),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            child: Image(
                                              width: 120.w,
                                              height: 120.w,
                                              image: ResizeImage(
                                                AssetImage(vm.userinfoAvatar!),
                                                width: 240.w.toInt(),
                                                height: 240.w.toInt(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '如来佛祖',
                                                style: TextStyle(
                                                  fontSize: 40.w,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      "AlibabaPuHuiTi-Medium",
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16.w,
                                              ),
                                              Text('昵称: 如来佛祖',
                                                  style: TextStyle(
                                                    fontSize: 25.w,
                                                    color: const Color.fromARGB(
                                                        255, 99, 99, 99),
                                                  )),
                                              SizedBox(
                                                height: 16.w,
                                              ),
                                              Text('微信号: RulaiLoveYou',
                                                  style: TextStyle(
                                                    fontSize: 25.w,
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
                              link: '',
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
                                          vm.userinfoAvatar!,
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Image.asset(
                                          vm.userinfoAvatar!,
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Image.asset(
                                          vm.userinfoAvatar!,
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Image.asset(
                                          vm.userinfoAvatar!,
                                          width: 90.w,
                                          height: 90.w,
                                          fit: BoxFit.cover,
                                        )
                                      ])),
                              underline: true,
                            ),

                            // 视频号
                            LJNFunctionItem(
                              id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                              title: "视频号",
                              link: '',
                              height: 216.w,
                              showStyle: Container(
                                  height: 215.w,
                                  margin: EdgeInsets.only(left: 68.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // 标题
                                      Expanded(
                                        flex: 0,
                                        // width: 100.w,
                                        child: Text(
                                          '如来佛祖',
                                          style: TextStyle(
                                              fontSize: 32.0.w,
                                              fontFamily: "AlibabaPuHuiTi",
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 28.w,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              vm.userinfoAvatar!,
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              vm.userinfoAvatar!,
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              vm.userinfoAvatar!,
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              vm.userinfoAvatar!,
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            )
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
                          ])))));
        });
  }
}
