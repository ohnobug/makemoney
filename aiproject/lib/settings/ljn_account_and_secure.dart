import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/components/ljn_appbar.dart';
import 'package:spicychat/components/ljn_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNAccountAndSecure extends StatefulWidget {
  const LJNAccountAndSecure({super.key});

  @override
  State<LJNAccountAndSecure> createState() => _LJNAaccountAndSecure();
}

class _LJNAaccountAndSecure extends State<LJNAccountAndSecure> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            title: "账号与安全",
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    90.w -
                    systemState.statusHeight,
              ),
              color: AppColors.neutralGrey11,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    BlocBuilder<LJNUserCubit, LJNUserState>(
                      builder: (context, userState) {
                        // 账户与安全
                        return LJNFunctionItem(
                          title: "微信号",
                          link: '/accountinfo',
                          showStyle: userState.userinfoAccount,
                          underline: true,
                        );
                      },
                    ),

                    BlocBuilder<LJNUserCubit, LJNUserState>(
                      builder: (context, userState) {
                        // 手机号
                        return LJNFunctionItem(
                          title: "手机号",
                          link: '/phone_number',
                          showStyle: userState.userinfoPhone,
                          underline: false,
                        );
                      },
                    ),

                    SizedBox(height: 16.w),

                    // 微信密码
                    const LJNFunctionItem(
                      title: "微信密码",
                      link: '/set_password',
                      underline: true,
                    ),
                    // 声音锁
                    const LJNFunctionItem(
                      title: "声音锁",
                      link: '/sound_lock',
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    // 应急联系人
                    const LJNFunctionItem(
                      title: "应急联系人",
                      link: '/emergency_contact',
                      underline: true,
                    ),
                    // 登录过的设备
                    const LJNFunctionItem(
                      title: "登录过的设备",
                      link: '/logged_devices',
                      underline: true,
                    ),
                    // 更多安全设置
                    const LJNFunctionItem(
                      title: "更多安全设置",
                      link: '/more_secure_setting',
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    // 微信安全中心
                    LJNSpecialFunctionItem(
                      title: "微信安全中心",
                      height: 178.w,
                      link: '',
                      subTitle: Text(
                        "如果你遇到账号被盗，无法登录等问题，可以前往安全中心",
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.neutralGrey35,
                          fontSize: 24.w,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "AlibabaPuHuiTi",
                        ),
                      ),
                      underline: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
