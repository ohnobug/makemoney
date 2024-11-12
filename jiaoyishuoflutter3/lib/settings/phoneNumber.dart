import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNPhoneNumber extends StatefulWidget {
  const LJNPhoneNumber({super.key});

  @override
  State<LJNPhoneNumber> createState() => _LJNPhoneNumber();
}

class _LJNPhoneNumber extends State<LJNPhoneNumber> {
  double _statusHeight = 0;

  bool isHide = true;

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

    String phone = vm.userinfoPhone is String ? vm.userinfoPhone! : "";

    if (isHide) {
      phone =
          '${phone.substring(0, 6)}${'*' * (phone.length - 10)}${phone.substring(phone.length - 4, phone.length)}';
    }

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
                  title: const Text('手机号'),
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
                    child: SizedBox(
                        width: screenSize.width,
                        // padding: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 160.w,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '已绑定手机号：',
                                  strutStyle:
                                      StrutStyle(fontSize: 37.w, height: 1.08),
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 37.w,
                                    fontFamily: "AlibabaPuHuiTi-Medium",
                                  ),
                                ),

                                // 手机号
                                Text(
                                  phone,
                                  strutStyle:
                                      StrutStyle(fontSize: 37.w, height: 1.08),
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 37.w,
                                    fontFamily: "AlibabaPuHuiTi-Medium",
                                  ),
                                ),
                                SizedBox(width: 13.w), // 间隔

                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isHide = !isHide;
                                      });
                                    },
                                    child: Text(
                                      isHide ? '隐藏' : "显示",
                                      strutStyle: StrutStyle(
                                          fontSize: 37.w, height: 1.08),
                                      style: TextStyle(
                                          height: 1.08,
                                          fontSize: 25.w,
                                          fontFamily: "AlibabaPuHuiTi",
                                          color: const Color.fromARGB(
                                              255, 64, 69, 118)),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 30.w,
                            ),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 70.w, right: 70.w),
                                child: Text(
                                  "已绑定手机号，轻触下方按钮可了解手机通信录中哪些朋友注册了账号。",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 27.0.w,
                                      fontFamily: "AlibabaPuHuiTi"),
                                )),
                            SizedBox(
                              height: 720.w,
                              child: null,
                            ),
                            const LJNChangeAccountButton(
                              title: '查看手机通讯录',
                              color: Colors.white,
                              backgroundColor: Color.fromARGB(255, 52, 192, 95),
                              link: "/phone_contact",
                              readonly: false,
                            ),
                            SizedBox(
                              height: 33.w,
                            ),
                            const LJNChangeAccountButton(
                              title: '更换手机号',
                              // color: Colors.white,
                              // backgroundColor: Color.fromARGB(255, 52, 192, 95),
                              link: "/verify_phone",
                              readonly: false,
                            ),
                          ],
                        ))))));
  }
}
