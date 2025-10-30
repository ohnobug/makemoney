import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaForgotPasswordPage extends StatefulWidget {
  const VigaForgotPasswordPage({super.key});

  @override
  State<VigaForgotPasswordPage> createState() => _VigaForgotPassword();
}

class _VigaForgotPassword extends State<VigaForgotPasswordPage> {
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
        return Theme(
          data: theme.copyWith(
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: Colors.transparent,
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: const VigaAppBar(),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        systemState.appbarHeight -
                        systemState.statusHeight),
                color: AppColors.neutralWhite,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Container(
                    width: 750.w,
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
                            
                          ),
                        ),

                        SizedBox(
                          height: 740.w,
                          child: null,
                        ),

                        // 验证按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 180.w),
                          child: VigaChangeAccountButton(
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
