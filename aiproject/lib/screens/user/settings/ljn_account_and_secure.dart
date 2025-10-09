import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.accountAndSecurity,
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
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: BlocBuilder<LJNUserCubit, LJNUserState>(
                  builder: (context, userState) {
                    return Column(
                      children: [
                        // 账户与安全
                        LJNFunctionList(
                          children: [
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.vigavigaID,
                              link: '/accountinfo',
                              showStyle: userState.userinfoAccount,
                              underline: true,
                            ),

                            // 手机号
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.phoneNumber,
                              link: '/phone_number',
                              showStyle: userState.userinfoPhone,
                              underline: false,
                            ),
                          ],
                        ),

                        // Vigaviga密码
                        LJNFunctionList(
                          children: [
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.vigavigaPassword,
                              link: '/set_password',
                              underline: true,
                            ),
                            // 声音锁
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.voiceprint,
                              link: '/sound_lock',
                              underline: false,
                            ),
                          ],
                        ),

                        // 应急联系人
                        LJNFunctionList(
                          children: [
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.emergencyContacts,
                              link: '/emergency_contact',
                              underline: true,
                            ),
                            // 登录过的设备
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.loggedInDevices,
                              link: '/logged_devices',
                              underline: true,
                            ),
                            // 更多安全设置
                            LJNFunctionItem(
                              icon: "images/avatar/02.png",
                              title: l10n.moreSecuritySettings,
                              link: '/more_secure_setting',
                              underline: false,
                            ),
                          ],
                        ),

                        // Vigaviga安全中心
                        LJNFunctionList(children: [
                          LJNSpecialFunctionItem(
                            title: l10n.vigavigaSecurityCenter,
                            height: null,
                            link: '',
                            subTitle: Text(
                              l10n.securityGuidanceFull,
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
                        ]),

                        SizedBox(height: 100.w)
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
