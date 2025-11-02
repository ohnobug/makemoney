import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaPersonalinfoAndPermissionPage extends StatefulWidget {
  const VigaPersonalinfoAndPermissionPage({super.key});

  @override
  State<VigaPersonalinfoAndPermissionPage> createState() =>
      _VigaPersonalinfoAndPermissionPage();
}

class _VigaPersonalinfoAndPermissionPage
    extends State<VigaPersonalinfoAndPermissionPage> {
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
                    VigaFunctionList(
                      children: [
                        // 系统权限管理
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.systemPermissionManagement,
                          link: '',
                          underline: true,
                          tapEffect: true,
                        ),
                        // 授权管理
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.authorizationManagement,
                          link: '',
                          underline: false,
                          tapEffect: true,
                        ),
                      ],
                    ),

                    // 个性化广告管理
                    VigaFunctionList(children: [
                      // 个性化广告管理
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
                        title: l10n.personalizedAdManagement,
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                    ]),

                    // 浏览和导出个人信息
                    VigaFunctionList(children: [
                      // 浏览和导出个人信息
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
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
