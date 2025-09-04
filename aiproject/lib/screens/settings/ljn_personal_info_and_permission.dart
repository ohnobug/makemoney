import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import '../../widgets/ljn_function_item.dart';

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
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.personalInfoAndPermissions,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: Theme.of(context).colorScheme.surface,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .systemPermissionManagement,
                      link: '',
                      underline: true,
                      tapEffect: true,
                    ),
                    LJNFunctionItem(
                      title:
                          AppLocalizations.of(context)!.authorizationManagement,
                      link: '',
                      underline: false,
                      tapEffect: true,
                    ),
                    SizedBox(height: 16.w),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .personalizedAdManagement,
                      link: '',
                      underline: false,
                      tapEffect: true,
                    ),
                    SizedBox(height: 16.w),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!
                          .browseAndExportPersonalInfo,
                      link: '',
                      underline: false,
                      tapEffect: true,
                    ),
                    SizedBox(height: 920.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .privacyPolicySummaryTitle,
                          style: TextStyle(
                            fontSize: 26.w,
                            height: 1.08,
                            color: AppColors.brandPurpleDark1,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.privacyPolicyTitle,
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
