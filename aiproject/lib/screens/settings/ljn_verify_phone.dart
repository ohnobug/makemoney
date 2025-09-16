import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

class LJNVerifyPhone extends StatefulWidget {
  const LJNVerifyPhone({super.key});

  @override
  State<LJNVerifyPhone> createState() => _LJNVerifyPhone();
}

class _LJNVerifyPhone extends State<LJNVerifyPhone> {
  bool isHide = true;

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
        return BlocBuilder<LJNUserCubit, LJNUserState>(
          builder: (context, userState) {
            String phone = userState.userinfoPhone is String
                ? userState.userinfoPhone!
                : "";

            if (isHide) {
              phone =
                  '${phone.substring(0, 6)}${'*' * (phone.length - 10)}${phone.substring(phone.length - 4, phone.length)}';
            }

            return Scaffold(
              primary: false,
              resizeToAvoidBottomInset: false,
              appBar: LJNAppBar(
                title: l10n.verifyPhoneNumber,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/bind_new_phone_number');
                    },
                    child: Container(
                      color: AppColors.transparent,
                      height: 90.w,
                      padding: EdgeInsets.only(right: 40.w),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.nextStep,
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: 32.w,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          90.w -
                          systemState.statusHeight),
                  color: theme.colorScheme.surfaceContainer,
                  child: SingleChildScrollView(
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 70.w,
                            left: 40.w,
                            right: 40.w,
                          ),
                          child: Text(
                            l10n.phoneNumberBindingDescriptionFull,
                            style: TextStyle(
                              fontSize: 26.0.w,
                              fontFamily: "AlibabaPuHuiTi",
                              color: AppColors.neutralGrey58,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45.w,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 50.w,
                            right: 50.w,
                          ),
                          height: 95.w,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 95.w,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: theme.dividerColor,
                                      width: 1.5.w,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "+86",
                                      style: TextStyle(
                                        fontSize: 24.w,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      l10n.mainlandChina,
                                      style: TextStyle(
                                        fontSize: 15.w,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 30.w,
                                  ),
                                  autofocus: true,
                                  cursorColor: AppColors.brandGreenDarker4,
                                  cursorWidth: 1.w,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: l10n.yourPhoneNumber,
                                    hintStyle: TextStyle(
                                      fontSize: 30.w,
                                      color: AppColors.neutralGrey61,
                                    ),
                                    labelText: '',
                                    isDense: true,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: theme.dividerColor,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: theme.dividerColor,
                                      ),
                                    ),
                                    // 获取焦点时的底线样式
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: theme.dividerColor,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      bottom: 20.w,
                                    ), // 也可调小内边距
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
