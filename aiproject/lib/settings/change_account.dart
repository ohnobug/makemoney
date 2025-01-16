import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import '../logger.dart';

class LJNChangeAccount extends StatefulWidget {
  const LJNChangeAccount({super.key});

  @override
  State<LJNChangeAccount> createState() => _LJNChangeAccount();
}

class _LJNChangeAccount extends State<LJNChangeAccount> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
          primary: false,
          resizeToAvoidBottomInset: false,
          appBar: const LJNAppBar(
            bgColor: Colors.transparent,
          ),
          body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                  constraints: BoxConstraints(
                      minHeight: systemState.screenSize.height -
                          90.w -
                          systemState.statusHeight),
                  color: Colors.white,
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                          width: systemState.screenSize.width,
                          padding: EdgeInsets.only(left: 70.w, right: 70.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  // color: Colors.red,
                                  height: 110.w,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    '安全验证',
                                    style: TextStyle(
                                        fontSize: 42.w,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: "AlibabaPuHuiTi-Medium"),
                                  )),
                              SizedBox(
                                height: 30.w,
                              ),
                              Text(
                                "填写当前微信登录密码，验证本人身份。",
                                style: TextStyle(
                                    fontSize: 30.w,
                                    fontFamily: "AlibabaPuHuiTi"),
                              ),
                              SizedBox(
                                height: 60.w,
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
                                      style: TextStyle(
                                          fontSize: 30.w, height: 1.08),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: TextField(
                                          controller: _controller,
                                          autofocus: true, // 先尝试关闭自动聚焦
                                          cursorColor: const Color.fromRGBO(
                                              62, 174, 86, 1.0),
                                          cursorWidth: 1.w,
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          decoration: const InputDecoration(
                                            hintText: '请输入密码',
                                            labelText: '',
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide.none, // 无边框
                                            ),
                                            contentPadding:
                                                EdgeInsets.all(0), // 也可调小内边距
                                          ),
                                        )),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 25.w,
                              ),

                              SizedBox(
                                  width: 610.w,
                                  child: GestureDetector(
                                      onTap: () {
                                        // forgot_password
                                        logger.info("忘记密码被点击");
                                        Navigator.pushNamed(
                                            context, '/forgot_password');
                                      },
                                      child: Text(
                                        '忘记密码',
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: const Color.fromARGB(
                                                255, 64, 69, 118)),
                                      ))),

                              SizedBox(
                                height: 780.w,
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
    });
  }
}
