import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNInputVerifyCode extends StatefulWidget {
  const LJNInputVerifyCode({super.key});

  @override
  State<LJNInputVerifyCode> createState() => _LJNInputVerifyCode();
}

class _LJNInputVerifyCode extends State<LJNInputVerifyCode> {
  double _statusHeight = 0;

  bool isHide = true;

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
                  title: const Text('填写验证码'),
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
                  // actions: [],
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
                      padding: EdgeInsets.only(left: 50.w, right: 50.w),
                      height: 95.w,
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 30.w,
                                ),
                                autofocus: true,
                                cursorColor:
                                    const Color.fromRGBO(62, 174, 86, 1.0),
                                cursorWidth: 1.w,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: '你本人的手机号',
                                  hintStyle: TextStyle(
                                      fontSize: 30.w,
                                      color: const Color.fromARGB(
                                          255, 147, 147, 147)),
                                  labelText: '',
                                  isDense: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: const Color.fromARGB(
                                            255, 104, 199, 145)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: const Color.fromARGB(
                                            255, 104, 199, 145)),
                                  ),
                                  // 获取焦点时的底线样式
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: const Color.fromARGB(
                                            255, 104, 199, 145)),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 20.w), // 也可调小内边距
                                ),
                              )),
                        ],
                      ),
                    )))));
  }
}
