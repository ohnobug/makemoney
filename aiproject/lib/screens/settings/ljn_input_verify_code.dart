import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';

class LJNInputVerifyCode extends StatefulWidget {
  const LJNInputVerifyCode({super.key});

  @override
  State<LJNInputVerifyCode> createState() => _LJNInputVerifyCode();
}

class _LJNInputVerifyCode extends State<LJNInputVerifyCode> {
  bool isHide = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(0);
    });
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
                  bgColor: AppColors.transparent),
              body: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        90.w -
                        systemState.statusHeight,
                  ),
                  color: AppColors.neutralWhite,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 50.w, right: 50.w),
                      height: 95.w,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                                    .yourPhoneNumber,
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
