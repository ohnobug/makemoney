import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/ljn_user_cubit.dart';

class LJNPhoneNumber extends StatefulWidget {
  const LJNPhoneNumber({super.key});

  @override
  State<LJNPhoneNumber> createState() => _LJNPhoneNumber();
}

class _LJNPhoneNumber extends State<LJNPhoneNumber> {
  bool isHide = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return BlocBuilder<LJNUserCubit, LJNUserState>(
          builder: (context, userState) {
        String phone =
            userState.userinfoPhone is String ? userState.userinfoPhone! : "";

        if (isHide) {
          phone =
              '${phone.substring(0, 6)}${'*' * (phone.length - 10)}${phone.substring(phone.length - 4, phone.length)}';
        }

        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(title: "手机号", bgColor: Colors.transparent),
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
                  parent: BouncingScrollPhysics(),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                              strutStyle:
                                  StrutStyle(fontSize: 37.w, height: 1.08),
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 25.w,
                                fontFamily: "AlibabaPuHuiTi",
                                color: const Color.fromARGB(255, 64, 69, 118),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Text(
                          "已绑定手机号，轻触下方按钮可了解手机通信录中哪些朋友注册了账号。",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 27.0.w, fontFamily: "AlibabaPuHuiTi"),
                        ),
                      ),
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
                  ),
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}
