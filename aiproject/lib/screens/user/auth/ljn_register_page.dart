import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

class LJNRegisterPage extends StatefulWidget {
  const LJNRegisterPage({super.key});

  @override
  State<LJNRegisterPage> createState() => _LJNRegisterPage();
}

class _LJNRegisterPage extends State<LJNRegisterPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleRegister() async {
    if (_phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      logger.info("手机号或密码不能为空");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      logger.info("两次输入的密码不一致");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟注册请求
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // 注册成功，更新用户状态并跳转到主页
    final userCubit = context.read<LJNUserCubit>();
    userCubit.login(
      userId: 'user_${_phoneController.text}', // 模拟用户ID
      authToken: 'token_${DateTime.now().millisecondsSinceEpoch}', // 模拟认证令牌
      phone: _phoneController.text,
      name: '用户${_phoneController.text.substring(7)}', // 模拟用户名
    );

    logger.info("注册成功");
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
                          height: 110.w,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "注册",
                            style: TextStyle(
                                fontSize: 42.w,
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 60.w,
                        ),

                        // 手机号输入框
                        Container(
                          height: 110.w,
                          width: 610.w,
                          decoration: BoxDecoration(
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
                                "手机号",
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
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: AppColors.brandGreenDarker4,
                                  cursorWidth: 1.w,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "请输入手机号",
                                    labelText: '',
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.all(0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 密码输入框
                        Container(
                          height: 110.w,
                          width: 610.w,
                          decoration: BoxDecoration(
                            border: Border(
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
                                "密码",
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
                                  controller: _passwordController,
                                  obscureText: true,
                                  cursorColor: AppColors.brandGreenDarker4,
                                  cursorWidth: 1.w,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "请输入密码",
                                    labelText: '',
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.all(0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 确认密码输入框
                        Container(
                          height: 110.w,
                          width: 610.w,
                          decoration: BoxDecoration(
                            border: Border(
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
                                "确认密码",
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
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  cursorColor: AppColors.brandGreenDarker4,
                                  cursorWidth: 1.w,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "请再次输入密码",
                                    labelText: '',
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding:
                                        const EdgeInsets.all(0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 25.w,
                        ),

                        // 已有账号登录链接
                        SizedBox(
                          width: 610.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/user/auth/login');
                                },
                                child: Text(
                                  "已有账号？去登录",
                                  style: TextStyle(
                                    fontSize: 24.w,
                                    color: AppColors.brandPurpleDark3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 780.w,
                          child: null,
                        ),

                        // 注册按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 180.w),
                          child: _isLoading
                              ? Container(
                                  width: 610.w,
                                  height: 100.w,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color: AppColors.brandGreenDarker4,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: _handleRegister,
                                  child: LJNChangeAccountButton(
                                    title: "注册",
                                    link: "",
                                    readonly: false,
                                  ),
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