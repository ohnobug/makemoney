import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_add_button.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

class LJNBindNewPhoneNumber extends StatefulWidget {
  const LJNBindNewPhoneNumber({super.key});

  @override
  State<LJNBindNewPhoneNumber> createState() => _LJNBindNewPhoneNumber();
}

class _LJNBindNewPhoneNumber extends State<LJNBindNewPhoneNumber> {
  bool isHide = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                title: AppLocalizations.of(context)!.enterVerificationCode,
              ),
              body: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          90.w -
                          systemState.statusHeight),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      height: 100.w,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                                hintText: AppLocalizations.of(context)!
                                    .pleaseEnterVerificationCode,
                                hintStyle: TextStyle(
                                  fontSize: 30.w,
                                  color: AppColors.neutralGrey61,
                                ),
                                labelText: '',
                                isDense: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.brandGreenSlightlyLighter,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.brandGreenSlightlyLighter,
                                  ),
                                ),
                                // 获取焦点时的底线样式
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.brandGreenSlightlyLighter,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.only(bottom: 20.w), // 也可调小内边距
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          LJNAddButton(
                            title: AppLocalizations.of(context)!.nextStep,
                            backgroundColor: AppColors.brandGreenVibrant3,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        AppLocalizations.of(context)!.prompt),
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .pleaseEnterCorrectVerificationCode,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.confirm,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
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
