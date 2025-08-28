import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';

class LJNPhoneNumber extends StatefulWidget {
  const LJNPhoneNumber({super.key});

  @override
  State<LJNPhoneNumber> createState() => _LJNPhoneNumber();
}

class _LJNPhoneNumber extends State<LJNPhoneNumber> {
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
              appBar: LJNAppBar(
                  title: AppLocalizations.of(context)!.phoneNumber,
                  bgColor: AppColors.transparent),
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // padding: EdgeInsets.only(left: 70.w, right: 70.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 160.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '已绑定手机号：',
                                strutStyle:
                                    StrutStyle(fontSize: 37.w, height: 1.08),
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: 37.w,
                                  fontFamily: "AlibabaPuHuiTi-Medium",
                                ),
                              ),

                              // 手机号
                              Text(
                                phone,
                                strutStyle:
                                    StrutStyle(fontSize: 37.w, height: 1.08),
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: 37.w,
                                  fontFamily: "AlibabaPuHuiTi-Medium",
                                ),
                              ),
                              SizedBox(width: 13.w), // 间隔

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isHide = !isHide;
                                  });
                                },
                                child: Text(
                                  isHide
                                      ? AppLocalizations.of(context)!.hide
                                      : AppLocalizations.of(context)!.show,
                                  strutStyle:
                                      StrutStyle(fontSize: 37.w, height: 1.08),
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: 25.w,
                                    fontFamily: "AlibabaPuHuiTi",
                                    color: AppColors.brandPurpleDark3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 70.w, right: 70.w),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .phoneBoundAndDiscoverPrompt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 27.0.w,
                                  fontFamily: "AlibabaPuHuiTi"),
                            ),
                          ),
                          SizedBox(
                            height: 720.w,
                            child: null,
                          ),
                          LJNChangeAccountButton(
                            title:
                                AppLocalizations.of(context)!.viewPhoneContacts,
                            color: AppColors.neutralWhite,
                            backgroundColor: AppColors.brandGreenVibrant5,
                            link: "/phone_contact",
                            readonly: false,
                          ),
                          SizedBox(
                            height: 33.w,
                          ),
                          LJNChangeAccountButton(
                            title:
                                AppLocalizations.of(context)!.changePhoneNumber,
                            // color: AppColors.neutralWhite,
                            // backgroundColor: AppColors.brandGreenVibrant5,
                            link: "/verify_phone",
                            readonly: false,
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
