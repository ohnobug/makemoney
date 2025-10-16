import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

class LJNForgotPasswordPage extends StatefulWidget {
  const LJNForgotPasswordPage({super.key});

  @override
  State<LJNForgotPasswordPage> createState() => _LJNForgotPasswordPage();
}

class _LJNForgotPasswordPage extends State<LJNForgotPasswordPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _showCodeInput = false;
  bool _showPasswordInput = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleSendCode() async {
    if (_phoneController.text.isEmpty) {
      logger.info("请输入手机号");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟发送验证码请求
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _showCodeInput = true;
    });

    logger.info("验证码已发送");
  }

  void _handleVerifyCode() async {
    if (_codeController.text.isEmpty) {
      logger.info("请输入验证码");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟验证码验证请求
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _showPasswordInput = true;
    });

    logger.info("验证码验证成功");
  }

  void _handleResetPassword() async {
    if (_newPasswordController.text.isEmpty) {
      logger.info("请输入新密码");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟重置密码请求
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // 重置成功，更新用户状态并返回登录页面
    final userCubit = context.read<LJNUserCubit>();
    userCubit.updateAuthToken('token_${DateTime.now().millisecondsSinceEpoch}');

    logger.info("密码重置成功");
    Navigator.pop(context);
  }

  Widget _buildCurrentStep() {
    if (_showPasswordInput) {
      return _buildPasswordStep();
    } else if (_showCodeInput) {
      return _buildCodeStep();
    } else {
      return _buildPhoneStep();
    }
  }

  Widget _buildPhoneStep() {
    return Column(
      children: [
        Container(
          height: 110.w,
          alignment: Alignment.bottomCenter,
          child: Text(
            "找回密码",
            style: TextStyle(
                fontSize: 42.w,
                fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 30.w),
        Text(
          "请输入您的手机号以接收验证码",
          style: TextStyle(
            fontSize: 30.w,
            
          ),
        ),
        SizedBox(height: 60.w),

        // 手机号输入框
        Container(
          height: 110.w,
          width: 610.w,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1.0.w,
                style: BorderStyle.solid,
              ),
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
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
              SizedBox(width: 50.w),
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
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      children: [
        Container(
          height: 110.w,
          alignment: Alignment.bottomCenter,
          child: Text(
            "验证手机号",
            style: TextStyle(
                fontSize: 42.w,
                fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 30.w),
        Text(
          "请输入发送到 ${_phoneController.text} 的验证码",
          style: TextStyle(
            fontSize: 30.w,
            
          ),
        ),
        SizedBox(height: 60.w),

        // 验证码输入框
        Container(
          height: 110.w,
          width: 610.w,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1.0.w,
                style: BorderStyle.solid,
              ),
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
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
                "验证码",
                style: TextStyle(
                  fontSize: 30.w,
                  height: 1.08,
                ),
              ),
              SizedBox(width: 50.w),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.brandGreenDarker4,
                  cursorWidth: 1.w,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "请输入验证码",
                    labelText: '',
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      children: [
        Container(
          height: 110.w,
          alignment: Alignment.bottomCenter,
          child: Text(
            "设置新密码",
            style: TextStyle(
                fontSize: 42.w,
                fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 30.w),
        Text(
          "请设置您的新密码",
          style: TextStyle(
            fontSize: 30.w,
            
          ),
        ),
        SizedBox(height: 60.w),

        // 新密码输入框
        Container(
          height: 110.w,
          width: 610.w,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1.0.w,
                style: BorderStyle.solid,
              ),
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
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
                "新密码",
                style: TextStyle(
                  fontSize: 30.w,
                  height: 1.08,
                ),
              ),
              SizedBox(width: 50.w),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  cursorColor: AppColors.brandGreenDarker4,
                  cursorWidth: 1.w,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: "请输入新密码",
                    labelText: '',
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentButton() {
    if (_isLoading) {
      return Container(
        width: 610.w,
        height: 100.w,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: AppColors.brandGreenDarker4,
        ),
      );
    }

    String buttonText;
    VoidCallback? onTap;

    if (_showPasswordInput) {
      buttonText = "重置密码";
      onTap = _handleResetPassword;
    } else if (_showCodeInput) {
      buttonText = "验证";
      onTap = _handleVerifyCode;
    } else {
      buttonText = "发送验证码";
      onTap = _handleSendCode;
    }

    return GestureDetector(
      onTap: onTap,
      child: LJNChangeAccountButton(
        title: buttonText,
        link: "",
        readonly: false,
      ),
    );
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
                        _buildCurrentStep(),
                        SizedBox(height: 25.w),

                        // 返回登录链接（仅在第一步显示）
                        if (!_showCodeInput && !_showPasswordInput)
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
                                    "返回登录",
                                    style: TextStyle(
                                      fontSize: 24.w,
                                      color: AppColors.brandPurpleDark3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: 780.w),

                        // 按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 180.w),
                          child: _buildCurrentButton(),
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