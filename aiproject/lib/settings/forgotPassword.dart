import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNForgotPassword extends StatefulWidget {
  const LJNForgotPassword({super.key});

  @override
  State<LJNForgotPassword> createState() => _LJNForgotPassword();
}

class _LJNForgotPassword extends State<LJNForgotPassword> {
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
                  actions: const [],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                            SizedBox(
                              height: 125.w,
                            ),
                            Container(
                              height: 100.w,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 248, 195, 57),
                                shape: BoxShape.circle, // 设置为圆形
                              ),
                              child: Icon(
                                const IconData(
                                  0xe6ce,
                                  fontFamily: 'Iconfont',
                                ),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                size: 46.w,
                              ),
                            ),
                            SizedBox(
                              height: 75.w,
                            ),

                            Text(
                              '忘记密码',
                              style: TextStyle(
                                  fontSize: 42.w,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "AlibabaPuHuiTi"),
                            ),
                            SizedBox(
                              height: 30.w,
                            ),

                            Text(
                              "你需要前往\"设置 > 账号与安全 > 微信密码\"中重新设置微信密码。",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.0.w,
                                  fontFamily: "AlibabaPuHuiTi"),
                            ),

                            SizedBox(
                              height: 740.w,
                              child: null,
                            ),

                            // 验证按钮
                            Container(
                                padding: EdgeInsets.only(bottom: 180.w),
                                child: const LJNChangeAccountButton(
                                  title: '我知道了',
                                  link: "back",
                                  readonly: false,
                                ))
                          ],
                        ))))));
  }
}
