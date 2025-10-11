import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNPersonalinfoAndPermission extends StatefulWidget {
  const LJNPersonalinfoAndPermission({super.key});

  @override
  State<LJNPersonalinfoAndPermission> createState() =>
      _LJNPersonalinfoAndPermission();
}

class _LJNPersonalinfoAndPermission
    extends State<LJNPersonalinfoAndPermission> {
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
            title: l10n.personalInfoAndPermissions,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      systemState.appbarHeight -
                      systemState.statusHeight),
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    LJNFunctionList(
                      children: [
                        // 系统权限管理
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.systemPermissionManagement,
                          link: '',
                          underline: true,
                          tapEffect: true,
                        ),
                        // 授权管理
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.authorizationManagement,
                          link: '',
                          underline: false,
                          tapEffect: true,
                        ),
                      ],
                    ),

                    // 个性化广告管理
                    LJNFunctionList(children: [
                      // 个性化广告管理
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.personalizedAdManagement,
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                    ]),

                    // 浏览和导出个人信息
                    LJNFunctionList(children: [
                      // 浏览和导出个人信息
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.browseAndExportPersonalInfo,
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                    ]),

                    SizedBox(height: 920.w),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.privacyPolicySummaryTitle,
                          style: TextStyle(
                            fontSize: 26.w,
                            height: 1.08,
                            color: AppColors.brandPurpleDark1,
                          ),
                        ),
                        Text(
                          l10n.privacyPolicyTitle,
                          style: TextStyle(
                            fontSize: 26.w,
                            height: 1.08,
                            color: AppColors.brandPurpleDark1,
                          ),
                        )
                      ],
                    )
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
