import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';

class LJNAccountInfo extends StatefulWidget {
  const LJNAccountInfo({super.key});

  @override
  State<LJNAccountInfo> createState() => _LJNAccountInfo();
}

class _LJNAccountInfo extends State<LJNAccountInfo> {
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
        appBar: const LJNAppBar(bgColor: Colors.transparent),
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
                                height: 300.w,
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  color:
                                      const Color.fromARGB(255, 212, 212, 212),
                                  const IconData(
                                    0xe883,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 140.w, // 图标大小
                                )),
                            SizedBox(
                              height: 50.w,
                            ),

                            BlocBuilder<UserCubit, UserState>(
                                builder: (context, userState) {
                              return Text(
                                "微信号：${userState.userinfoAccount}",
                                style: TextStyle(
                                    fontSize: 40.w,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "AlibabaPuHuiTi"),
                              );
                            }),

                            SizedBox(
                              height: 45.w,
                            ),
                            Text(
                              "微信号是账号的唯一凭证，一年只能修改一次。",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.w, fontFamily: "AlibabaPuHuiTi"),
                            ),

                            SizedBox(
                              height: 620.w,
                              child: null,
                            ),

                            // 修改微信号
                            Container(
                                padding: EdgeInsets.only(bottom: 180.w),
                                child: const LJNChangeAccountButton(
                                  title: '修改微信号',
                                  link: "/change_account",
                                ))
                          ],
                        ))))));
  }
}
