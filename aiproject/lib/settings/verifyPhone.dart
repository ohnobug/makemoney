import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNVerifyPhone extends StatefulWidget {
  const LJNVerifyPhone({super.key});

  @override
  State<LJNVerifyPhone> createState() => _LJNVerifyPhone();
}

class _LJNVerifyPhone extends State<LJNVerifyPhone> {
  double _statusHeight = 0;

  bool isHide = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
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
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
                color: const Color.fromARGB(255, 237, 237, 237),
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
                  title: const Text('验证手机号'),
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
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/bind_new_phone_number');
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 90.w,
                        padding: EdgeInsets.only(right: 40.w),
                        alignment: Alignment.center,
                        child: Text(
                          "下一步",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.w,
                          ),
                        ),
                      ),
                    )
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
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                top: 70.w, left: 40.w, right: 40.w),
                            child: Text(
                              "一个手机号只能绑定一个账号，更换后可使用新手机号登录此账号。对于已绑定其他账号的手机号，本次操作后将与原账号解绑。",
                              style: TextStyle(
                                  fontSize: 26.0.w,
                                  fontFamily: "AlibabaPuHuiTi",
                                  color:
                                      const Color.fromARGB(255, 155, 155, 155)),
                            )),
                        SizedBox(
                          height: 45.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50.w, right: 50.w),
                          height: 95.w,
                          width: screenSize.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 95.w,
                                width: 120.w,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 219, 219, 219),
                                  width: 1.5.w,
                                  style: BorderStyle.solid,
                                ))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "+86",
                                      style: TextStyle(
                                          fontSize: 24.w, color: Colors.black),
                                    ),
                                    Text(
                                      "中国大陆",
                                      style: TextStyle(
                                          fontSize: 15.w, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
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
                                      contentPadding: EdgeInsets.only(
                                          bottom: 20.w), // 也可调小内边距
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )))));
  }
}
