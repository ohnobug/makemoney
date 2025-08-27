import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/components/ljn_add_button.dart';
import 'package:spicychat/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';

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
              appBar: const LJNAppBar(
                title: "填写验证码",
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
                                hintText: '请输入验证码',
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
                            title: "下一步",
                            backgroundColor: AppColors.brandGreenVibrant3,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('提示'),
                                    content: const Text('请正确输入验证码'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('确定'),
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
