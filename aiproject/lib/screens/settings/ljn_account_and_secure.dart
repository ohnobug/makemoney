import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import '../../widgets/ljn_function_item.dart';

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
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.accountAndSecurity,
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
              color: Theme.of(context).colorScheme.surfaceContainer,
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
                          title: AppLocalizations.of(context)!.wechatID,
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
                          title: AppLocalizations.of(context)!.phoneNumber,
                          link: '/phone_number',
                          showStyle: userState.userinfoPhone,
                          underline: false,
                        );
                      },
                    ),

                    SizedBox(height: 16.w),

                    // 微信密码
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.wechatPassword,
                      link: '/set_password',
                      underline: true,
                    ),
                    // 声音锁
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.voiceprint,
                      link: '/sound_lock',
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    // 应急联系人
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.emergencyContacts,
                      link: '/emergency_contact',
                      underline: true,
                    ),
                    // 登录过的设备
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.loggedInDevices,
                      link: '/logged_devices',
                      underline: true,
                    ),
                    // 更多安全设置
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.moreSecuritySettings,
                      link: '/more_secure_setting',
                      underline: false,
                    ),

                    SizedBox(height: 16.w),

                    // 微信安全中心
                    LJNSpecialFunctionItem(
                      title: AppLocalizations.of(context)!.wechatSecurityCenter,
                      height: null,
                      link: '',
                      subTitle: Text(
                        AppLocalizations.of(context)!.securityGuidanceFull,
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
