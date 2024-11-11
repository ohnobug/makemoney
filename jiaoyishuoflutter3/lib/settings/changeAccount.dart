import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

import '../logger.dart';

class LJNChangeAccount extends StatefulWidget {
  const LJNChangeAccount({super.key});

  @override
  State<LJNChangeAccount> createState() => _LJNChangeAccount();
}

class _LJNChangeAccount extends State<LJNChangeAccount> {
  double _statusHeight = 0;

  final TextEditingController _controller = TextEditingController();

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
                        padding: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                // color: Colors.red,
                                height: 164.w,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '安全验证',
                                  style: TextStyle(
                                      fontSize: 42.w,
                                      fontFamily: "AlibabaPuHuiTi-Medium"),
                                )),
                            SizedBox(
                              height: 45.w,
                            ),
                            Text(
                              "填写当前微信登录密码，验证本人身份。",
                              style: TextStyle(
                                  fontSize: 30.w, fontFamily: "AlibabaPuHuiTi"),
                            ),
                            SizedBox(
                              height: 70.w,
                            ),

                            // 填写密码字段
                            Container(
                              height: 110.w,
                              width: 610.w,
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  border: Border(
                                      top: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 229, 229, 229),
                                        width: 1.5.w,
                                        style: BorderStyle.solid,
                                      ),
                                      bottom: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 229, 229, 229),
                                        width: 1.5.w,
                                        style: BorderStyle.solid,
                                      ))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "填写密码",
                                    style:
                                        TextStyle(fontSize: 30.w, height: 1.08),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: TextField(
                                        controller: _controller,
                                        autofocus: false, // 先尝试关闭自动聚焦
                                        cursorColor: const Color.fromRGBO(
                                            62, 174, 86, 1.0),
                                        cursorWidth: 3.w,
                                        decoration: const InputDecoration(
                                          hintText: '请输入密码',
                                          labelText: '',
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none, // 无边框
                                          ),
                                          contentPadding:
                                              EdgeInsets.all(0), // 也可调小内边距
                                        ),
                                      )),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 38.w,
                            ),

                            SizedBox(
                                width: 610.w,
                                child: GestureDetector(
                                    onTap: () {
                                      logger.info("忘记密码被点击");
                                    },
                                    child: Text(
                                      '忘记密码',
                                      style: TextStyle(
                                          fontSize: 24.w,
                                          color: const Color.fromARGB(
                                              255, 61, 56, 87)),
                                    ))),

                            SizedBox(
                              height: 620.w,
                              child: null,
                            ),

                            // 验证按钮
                            Container(
                                padding: EdgeInsets.only(bottom: 180.w),
                                child: const LJNChangeAccountButton(
                                  title: '验证',
                                  link: "",
                                  readonly: true,
                                ))
                          ],
                        ))))));
  }
}
