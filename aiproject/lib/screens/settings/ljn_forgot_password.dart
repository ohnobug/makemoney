import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNForgotPassword extends StatefulWidget {
  const LJNForgotPassword({super.key});

  @override
  State<LJNForgotPassword> createState() => _LJNForgotPassword();
}

class _LJNForgotPassword extends State<LJNForgotPassword> {
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
        return Theme(
          data: theme.copyWith(
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: AppColors.transparent,
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: const LJNAppBar(),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        90.w -
                        systemState.statusHeight),
                color: AppColors.neutralWhite,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: 70.w,
                      right: 70.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 125.w,
                        ),
                        Container(
                          height: 100.w,
                          width: 100.w,
                          decoration: const BoxDecoration(
                            color: AppColors.accentYellowDark1,
                            shape: BoxShape.circle, // 设置为圆形
                          ),
                          child: Icon(
                            const IconData(
                              0xe6ce,
                              fontFamily: 'Iconfont',
                            ),
                            color: AppColors.neutralWhite,
                            size: 46.w,
                          ),
                        ),
                        SizedBox(
                          height: 75.w,
                        ),

                        Text(
                          l10n.forgotPassword,
                          style: TextStyle(
                            fontSize: 42.w,
                            fontWeight: FontWeight.bold,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                        SizedBox(
                          height: 30.w,
                        ),

                        Text(
                          l10n.navigateToResetPasswordGuidanceFull,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0.w,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),

                        SizedBox(
                          height: 740.w,
                          child: null,
                        ),

                        // 验证按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 180.w),
                          child: LJNChangeAccountButton(
                            title: l10n.iKnow,
                            link: "back",
                            readonly: false,
                          ),
                        )
                      ],
                    ),
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
