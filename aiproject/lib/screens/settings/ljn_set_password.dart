import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';

class LJNSetPassword extends StatefulWidget {
  const LJNSetPassword({super.key});

  @override
  State<LJNSetPassword> createState() => _LJNSetPassword();
}

class _LJNSetPassword extends State<LJNSetPassword> {
  TextEditingController originPassworldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: AppLocalizations.of(context)!.setPassword,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/bind_new_phone_number');
            },
            child: Container(
              height: 60.w,
              constraints: BoxConstraints(minWidth: 98.w),
              margin: EdgeInsets.only(right: 30.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.brandGreenVibrant3,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.w),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.done,
                // textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.neutralWhite,
                    fontSize: 25.w,
                    fontWeight: FontWeight.w100),
              ),
            ),
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  90.w -
                  systemState.statusHeight),
          color: AppColors.neutralGrey11,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Container(
              padding: EdgeInsets.all(30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.setWechatPasswordDescription,
                    style: TextStyle(
                      fontSize: 27.w,
                      color: AppColors.neutralGrey60,
                    ),
                  ),

                  SizedBox(
                    height: 30.w,
                  ),

                  // 微信号
                  Container(
                    height: 100.w,
                    decoration: BoxDecoration(
                      // color: AppColors.accentRedPure,
                      border: Border(
                        bottom: BorderSide(
                          width: 1.w,
                          color: const Color.fromARGB(255, 223, 223, 223),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            AppLocalizations.of(context)!.wechatID,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 32.w,
                              color: AppColors.neutralGrey59,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 63.w,
                        ),
                        Text(
                          context.read<LJNUserCubit>().state.userinfoAccount!,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: 32.w,
                            color: AppColors.neutralGrey59,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),

                  // 原密码
                  SizedBox(
                    // color: AppColors.accentRedPure,
                    // alignment: Alignment.centerLeft,
                    height: 75.w,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            AppLocalizations.of(context)!.originalPassword,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 30.w,
                              color: AppColors.neutralBlack,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 63.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: originPassworldController,
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 30.w,
                            ),
                            cursorColor: AppColors.brandGreenDarker4,
                            cursorWidth: 1.w,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .enterOriginalPassword,
                              hintStyle: TextStyle(
                                fontSize: 30.w,
                                color: AppColors.neutralGrey61,
                              ),
                              // labelText: '',
                              isDense: true,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5.w,
                                  color: AppColors.neutralGrey21,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.5.w,
                                  color: AppColors.neutralGrey21,
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
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.w,
                  ),

                  // 新密码
                  SizedBox(
                    // color: AppColors.accentRedPure,
                    // alignment: Alignment.centerLeft,
                    height: 75.w,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            AppLocalizations.of(context)!.newPassword,
                            style: TextStyle(
                                height: 1.08,
                                fontSize: 30.w,
                                color: AppColors.neutralBlack),
                          ),
                        ),
                        SizedBox(
                          width: 63.w,
                        ),
                        Expanded(
                            flex: 1,
                            child: TextField(
                              autofocus: false,
                              style: TextStyle(
                                fontSize: 30.w,
                              ),
                              cursorColor: AppColors.brandGreenDarker4,
                              cursorWidth: 1.w,
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .enterNewPassword,
                                hintStyle: TextStyle(
                                  fontSize: 30.w,
                                  color: AppColors.neutralGrey61,
                                ),
                                // labelText: '',
                                isDense: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.neutralGrey21,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.neutralGrey21,
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
                            ))
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.w,
                  ),

                  // 确认密码
                  SizedBox(
                    // color: AppColors.accentRedPure,
                    // alignment: Alignment.centerLeft,
                    height: 75.w,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Text(
                            AppLocalizations.of(context)!.confirmPassword,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 30.w,
                              color: AppColors.neutralBlack,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 63.w,
                        ),
                        Expanded(
                            flex: 1,
                            child: TextField(
                              autofocus: false,
                              style: TextStyle(
                                fontSize: 30.w,
                              ),
                              cursorColor: AppColors.brandGreenDarker4,
                              cursorWidth: 1.w,
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .enterToConfirm,
                                hintStyle: TextStyle(
                                  fontSize: 30.w,
                                  color: AppColors.neutralGrey61,
                                ),
                                // labelText: '',
                                isDense: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.neutralGrey21,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.5.w,
                                    color: AppColors.neutralGrey21,
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
                            ))
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30.w,
                  ),

                  Text(
                    AppLocalizations.of(context)!.passwordValidationRule(8, 16),
                    style: TextStyle(
                      fontSize: 26.w,
                      height: 1.08,
                      color: AppColors.neutralBlack,
                    ),
                  ),

                  SizedBox(
                    height: 10.w,
                  ),

                  Text(
                    AppLocalizations.of(context)!.forgotOriginalPassword,
                    style: TextStyle(
                      fontSize: 26.w,
                      height: 1.08,
                      color: AppColors.neutralDarkGrey8,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
