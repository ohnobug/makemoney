import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';

class LJNSetPassword extends StatefulWidget {
  const LJNSetPassword({super.key});

  @override
  State<LJNSetPassword> createState() => _LJNSetPassword();
}

class _LJNSetPassword extends State<LJNSetPassword> {
  TextEditingController originPassworldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
        primary: false,
        appBar: LJNAppBar(
          title: "设置密码",
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/bind_new_phone_number');
                },
                child: Container(
                    height: 60.w,
                    constraints: BoxConstraints(minWidth: 98.w),
                    margin: EdgeInsets.only(right: 30.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 74, 193, 99),
                        borderRadius: BorderRadius.all(Radius.circular(8.w))),
                    child: Text(
                      "完成",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.w,
                          fontWeight: FontWeight.w100),
                    )))
          ],
        ),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: systemState.screenSize.height -
                        90.w -
                        systemState.statusHeight),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Container(
                        padding: EdgeInsets.all(30.w),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "请设置微信密码。你可以用微信绑定的账号+微信密码登录，比如使用手机号+微信密码登录微信，更快捷。",
                                style: TextStyle(
                                    fontSize: 27.w,
                                    color: const Color.fromARGB(
                                        255, 149, 149, 149)),
                              ),

                              SizedBox(
                                height: 30.w,
                              ),

                              // 微信号
                              Container(
                                height: 100.w,
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.w,
                                            color: const Color.fromARGB(
                                                255, 223, 223, 223)))),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 120.w,
                                        child: Text(
                                          "微信号",
                                          style: TextStyle(
                                              height: 1.08,
                                              fontSize: 32.w,
                                              color: const Color.fromARGB(
                                                  255, 150, 150, 150)),
                                        )),
                                    SizedBox(
                                      width: 63.w,
                                    ),
                                    Text(
                                      context
                                          .read<UserCubit>()
                                          .state
                                          .userinfoAccount!,
                                      style: TextStyle(
                                          height: 1.08,
                                          fontSize: 32.w,
                                          color: const Color.fromARGB(
                                              255, 150, 150, 150)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.w,
                              ),

                              // 原密码
                              SizedBox(
                                  // color: Colors.red,
                                  // alignment: Alignment.centerLeft,
                                  height: 75.w,
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 120.w,
                                          child: Text(
                                            "原密码",
                                            style: TextStyle(
                                                height: 1.08,
                                                fontSize: 30.w,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        width: 63.w,
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: TextField(
                                            controller:
                                                originPassworldController,
                                            autofocus: false,
                                            style: TextStyle(
                                              fontSize: 30.w,
                                            ),
                                            cursorColor: const Color.fromRGBO(
                                                62, 174, 86, 1.0),
                                            cursorWidth: 1.w,
                                            onTapOutside: (event) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            decoration: InputDecoration(
                                              hintText: '填写原密码',
                                              hintStyle: TextStyle(
                                                  fontSize: 30.w,
                                                  color: const Color.fromARGB(
                                                      255, 147, 147, 147)),
                                              // labelText: '',
                                              isDense: true,
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5.w,
                                                    color: const Color.fromARGB(
                                                        255, 226, 226, 226)),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5.w,
                                                    color: const Color.fromARGB(
                                                        255, 226, 226, 226)),
                                              ),
                                              // 获取焦点时的底线样式
                                              focusedBorder:
                                                  UnderlineInputBorder(
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
                                  )),

                              SizedBox(
                                height: 20.w,
                              ),

                              // 新密码
                              SizedBox(
                                  // color: Colors.red,
                                  // alignment: Alignment.centerLeft,
                                  height: 75.w,
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 120.w,
                                          child: Text(
                                            "新密码",
                                            style: TextStyle(
                                                height: 1.08,
                                                fontSize: 30.w,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        width: 63.w,
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: TextField(
                                            autofocus: false,
                                            style: TextStyle(
                                              fontSize: 30.w,
                                            ),
                                            cursorColor: const Color.fromRGBO(
                                                62, 174, 86, 1.0),
                                            cursorWidth: 1.w,
                                            onTapOutside: (event) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            decoration: InputDecoration(
                                              hintText: '填写新密码',
                                              hintStyle: TextStyle(
                                                  fontSize: 30.w,
                                                  color: const Color.fromARGB(
                                                      255, 147, 147, 147)),
                                              // labelText: '',
                                              isDense: true,
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5.w,
                                                    color: const Color.fromARGB(
                                                        255, 226, 226, 226)),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5.w,
                                                    color: const Color.fromARGB(
                                                        255, 226, 226, 226)),
                                              ),
                                              // 获取焦点时的底线样式
                                              focusedBorder:
                                                  UnderlineInputBorder(
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
                                  )),

                              SizedBox(
                                height: 20.w,
                              ),

                              // 确认密码
                              SizedBox(
                                  // color: Colors.red,
                                  // alignment: Alignment.centerLeft,
                                  height: 75.w,
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 120.w,
                                          child: Text(
                                            "确认密码",
                                            style: TextStyle(
                                                height: 1.08,
                                                fontSize: 30.w,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        width: 63.w,
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: TextField(
                                            autofocus: false,
                                            style: TextStyle(
                                              fontSize: 30.w,
                                            ),
                                            cursorColor: const Color.fromRGBO(
                                                62, 174, 86, 1.0),
                                            cursorWidth: 1.w,
                                            onTapOutside: (event) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            decoration: InputDecoration(
                                              hintText: '再次填写确认',
                                              hintStyle: TextStyle(
                                                  fontSize: 30.w,
                                                  color: const Color.fromARGB(
                                                      255, 147, 147, 147)),
                                              // labelText: '',
                                              isDense: true,
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5.w,
                                                    color: const Color.fromARGB(
                                                        255, 226, 226, 226)),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5.w,
                                                    color: const Color.fromARGB(
                                                        255, 226, 226, 226)),
                                              ),
                                              // 获取焦点时的底线样式
                                              focusedBorder:
                                                  UnderlineInputBorder(
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
                                  )),

                              SizedBox(
                                height: 30.w,
                              ),

                              Text(
                                "密码必须是8-16位的英文字母、数字、字符组合(不能是纯数字)",
                                style: TextStyle(
                                    fontSize: 26.w,
                                    height: 1.08,
                                    color: Colors.black),
                              ),

                              SizedBox(
                                height: 10.w,
                              ),

                              Text(
                                "忘记原密码 ?",
                                style: TextStyle(
                                    fontSize: 26.w,
                                    height: 1.08,
                                    color:
                                        const Color.fromARGB(255, 82, 83, 108)),
                              )
                            ]))))));
  }
}
