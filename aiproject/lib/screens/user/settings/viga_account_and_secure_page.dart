import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
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
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
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
                                icon: null,
                                title: l10n.vigavigaID,
                                link: '/settings/account_info',
                                showStyle: userState.userinfoAccount,
                                underline: true,
                              ),

                              // 手机号
                              VigaFunctionItem(
                                icon: null,
                                title: l10n.phoneNumber,
                                link: '/settings/phone_number',
                                showStyle: userState.userinfoPhone,
                                underline: false,
                              ),

                              // 邮箱地址
                              VigaFunctionItem(
                                title: l10n.emailAddress,
                                link: '/settings/change_email',
                                showStyle: l10n.notBound,
                                underline: false,
                              ),
                            ],
                          ),

                          // Vigaviga密码
                          VigaFunctionList(
                            children: [
                              VigaFunctionItem(
                                icon: null,
                                title: "密码修改",
                                link: '/settings/set_password',
                                underline: true,
                              ),
                            ],
                          ),

                          VigaFunctionList(
                            children: [
                              // 登录过的设备
                              VigaFunctionItem(
                                icon: null,
                                title: l10n.loggedInDevices,
                                link: '/settings/logged_devices',
                                underline: false,
                              ),
                            ],
                          ),

                          SizedBox(height: 100.w)
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
