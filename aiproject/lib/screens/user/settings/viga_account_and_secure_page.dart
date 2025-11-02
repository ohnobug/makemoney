import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaAccountAndSecurePage extends StatefulWidget {
  const VigaAccountAndSecurePage({super.key});

  @override
  State<VigaAccountAndSecurePage> createState() => _VigaAaccountAndSecure();
}

class _VigaAaccountAndSecure extends State<VigaAccountAndSecurePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        String cdnBase = systemState.cdnBase;

        return Scaffold(
          primary: false,
          appBar: VigaAppBar(
            title: l10n.accountAndSecurity,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    systemState.appbarHeight -
                    systemState.statusHeight,
              ),
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: BlocBuilder<VigaUserCubit, UserState>(
                  builder: (context, userState) {
                    return Column(
                      children: [
                        // 账户与安全
                        VigaFunctionList(
                          children: [
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.vigavigaID,
                              link: '/settings/account_info',
                              showStyle: userState.userinfoAccount,
                              underline: true,
                            ),

                            // 手机号
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.phoneNumber,
                              link: '/settings/phone_number',
                              showStyle: userState.userinfoPhone,
                              underline: false,
                            ),
                          ],
                        ),

                        // Vigaviga密码
                        VigaFunctionList(
                          children: [
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.vigavigaPassword,
                              link: '/settings/set_password',
                              underline: true,
                            ),
                            // 声音锁
                            /* VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.voiceprint,
                              link: '/settings/sound_lock',
                              underline: false,
                            ), */
                          ],
                        ),

                        // 应急联系人
                        VigaFunctionList(
                          children: [
                            /* VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.emergencyContacts,
                              link: '/settings/emergency_contact',
                              underline: true,
                            ), */
                            // 登录过的设备
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.loggedInDevices,
                              link: '/settings/logged_devices',
                              underline: true,
                            ),
                            // 更多安全设置
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.moreSecuritySettings,
                              link: '/settings/more_secure_setting',
                              underline: false,
                            ),
                          ],
                        ),

                        // Vigaviga安全中心
                        /* VigaFunctionList(children: [
                          VigaSpecialFunctionItem(
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
                                
                              ),
                            ),
                            underline: false,
                          ),
                        ]), */

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
