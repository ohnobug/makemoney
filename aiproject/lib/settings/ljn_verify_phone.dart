import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';

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
                title: "验证手机号",
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
                        "下一步",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
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
                  color: AppColors.neutralGrey11,
                  child: SingleChildScrollView(
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 70.w, left: 40.w, right: 40.w),
                          child: Text(
                            "一个手机号只能绑定一个账号，更换后可使用新手机号登录此账号。对于已绑定其他账号的手机号，本次操作后将与原账号解绑。",
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
                          padding: EdgeInsets.only(left: 50.w, right: 50.w),
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
                                      color: AppColors.neutralGrey26,
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
                                          fontSize: 24.w, color: Colors.black),
                                    ),
                                    Text(
                                      "中国大陆",
                                      style: TextStyle(
                                          fontSize: 15.w, color: Colors.black),
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
                                    hintText: '你本人的手机号',
                                    hintStyle: TextStyle(
                                      fontSize: 30.w,
                                      color: AppColors.neutralGrey61,
                                    ),
                                    labelText: '',
                                    isDense: true,
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5.w,
                                        color:
                                            AppColors.brandGreenSlightlyLighter,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5.w,
                                        color:
                                            AppColors.brandGreenSlightlyLighter,
                                      ),
                                    ),
                                    // 获取焦点时的底线样式
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5.w,
                                        color:
                                            AppColors.brandGreenSlightlyLighter,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        bottom: 20.w), // 也可调小内边距
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
