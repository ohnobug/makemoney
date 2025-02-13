import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class LJNForgotPassword extends StatefulWidget {
  const LJNForgotPassword({super.key});

  @override
  State<LJNForgotPassword> createState() => _LJNForgotPassword();
}

class _LJNForgotPassword extends State<LJNForgotPassword> {
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
          appBar: const LJNAppBar(bgColor: Colors.transparent),
          body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          90.w -
                          systemState.statusHeight),
                  color: Colors.white,
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
    });
  }
}
