import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

class LJNChangeAccount extends StatefulWidget {
  const LJNChangeAccount({super.key});

  @override
  State<LJNChangeAccount> createState() => _LJNChangeAccount();
}

class _LJNChangeAccount extends State<LJNChangeAccount> {
  final TextEditingController _controller = TextEditingController();

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
              backgroundColor: Colors.transparent,
            ),
          ),
          child: Scaffold(
            primary: false,
            resizeToAvoidBottomInset: false,
            appBar: const LJNAppBar(),
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
                    padding: EdgeInsets.only(left: 70.w, right: 70.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // color: AppColors.accentRedPure,
                          height: 110.w,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            l10n.securityVerification,
                            style: TextStyle(
                                fontSize: 42.w,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "AlibabaPuHuiTi-Medium"),
                          ),
                        ),
                        SizedBox(
                          height: 30.w,
                        ),
                        Text(
                          l10n.verifyIdentityWithPasswordFull,
                          style: TextStyle(
                              fontSize: 30.w, fontFamily: "AlibabaPuHuiTi"),
                        ),
                        SizedBox(
                          height: 60.w,
                        ),

                        // 填写密码字段
                        Container(
                          height: 110.w,
                          width: 610.w,
                          decoration: BoxDecoration(
                            // color: AppColors.accentRedPure,
                            border: Border(
                              top: BorderSide(
                                color: theme.dividerColor,
                                width: 1.0.w,
                                style: BorderStyle.solid,
                              ),
                              bottom: BorderSide(
                                color: theme.dividerColor,
                                width: 1.0.w,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                l10n.enterPassword,
                                style: TextStyle(
                                  fontSize: 30.w,
                                  height: 1.08,
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: _controller,
                                  autofocus: true, // 先尝试关闭自动聚焦
                                  cursorColor: AppColors.brandGreenDarker4,
                                  cursorWidth: 1.w,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: l10n.pleaseEnterPassword,
                                    labelText: '',
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none, // 无边框
                                    ),
                                    contentPadding:
                                        const EdgeInsets.all(0), // 也可调小内边距
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 25.w,
                        ),

                        SizedBox(
                          width: 610.w,
                          child: GestureDetector(
                            onTap: () {
                              // forgot_password
                              logger.info("忘记密码被点击");
                              Navigator.pushNamed(context, '/forgot_password');
                            },
                            child: Text(
                              l10n.forgotPassword,
                              style: TextStyle(
                                fontSize: 24.w,
                                color: AppColors.brandPurpleDark3,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 780.w,
                          child: null,
                        ),

                        // 验证按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 180.w),
                          child: LJNChangeAccountButton(
                            title: l10n.verify,
                            link: "",
                            readonly: true,
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
