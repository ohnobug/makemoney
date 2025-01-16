import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_add_button.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';

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
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
        String phone =
            userState.userinfoPhone is String ? userState.userinfoPhone! : "";

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
                        minHeight: systemState.screenSize.height -
                            90.w -
                            systemState.statusHeight),
                    color: const Color.fromARGB(255, 237, 237, 237),
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: Container(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          height: 100.w,
                          width: systemState.screenSize.width,
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
                                    cursorColor:
                                        const Color.fromRGBO(62, 174, 86, 1.0),
                                    cursorWidth: 1.w,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                      hintText: '请输入验证码',
                                      hintStyle: TextStyle(
                                          fontSize: 30.w,
                                          color: const Color.fromARGB(
                                              255, 147, 147, 147)),
                                      labelText: '',
                                      isDense: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5.w,
                                            color: const Color.fromARGB(
                                                255, 104, 199, 145)),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5.w,
                                            color: const Color.fromARGB(
                                                255, 104, 199, 145)),
                                      ),
                                      // 获取焦点时的底线样式
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5.w,
                                            color: const Color.fromARGB(
                                                255, 104, 199, 145)),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          bottom: 20.w), // 也可调小内边距
                                    ),
                                  )),
                              SizedBox(
                                width: 20.w,
                              ),
                              LJNAddButton(
                                  title: "下一步",
                                  backgroundColor:
                                      const Color.fromARGB(255, 74, 193, 99),
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
                                  })
                            ],
                          ),
                        )))));
      });
    });
  }
}
