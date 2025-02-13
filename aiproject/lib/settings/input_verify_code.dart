import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';

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
      context.read<SystemCubit>().updateHomescrollpixels(0);
    });
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
            appBar:
                const LJNAppBar(title: "填写验证码", bgColor: Colors.transparent),
            body: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            90.w -
                            systemState.statusHeight),
                    color: Colors.white,
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
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
                                    cursorColor:
                                        const Color.fromRGBO(62, 174, 86, 1.0),
                                    cursorWidth: 1.w,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                      hintText: '你本人的手机号',
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
                            ],
                          ),
                        )))));
      });
    });
  }
}
