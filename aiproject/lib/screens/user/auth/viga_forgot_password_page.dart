import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/tools/viga_logger.dart';

class VigaForgotPasswordPage extends StatefulWidget {
  const VigaForgotPasswordPage({super.key});

  @override
  State<VigaForgotPasswordPage> createState() => _VigaForgotPasswordPageState();
}

class _VigaForgotPasswordPageState extends State<VigaForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _showCodeInput = false;
  bool _showPasswordInput = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleSendCode() async {
    if (_emailController.text.isEmpty) {
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
    final userCubit = context.read<VigaUserCubit>();
    userCubit.updateAuthToken('token_${DateTime.now().millisecondsSinceEpoch}');

    logger.info("密码重置成功");
    context.pop();
  }

  Widget _buildCurrentStep() {
    if (_showPasswordInput) {
      return _buildPasswordStep();
    } else if (_showCodeInput) {
      return _buildCodeStep();
    } else {
      return _buildEmailStep();
    }
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('忘记密码'),
        SizedBox(height: 80.w),
        Text(
          '请输入您的邮箱以接收验证码',
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 28.w),
        ),
        SizedBox(height: 60.w),
        _buildEmailField(),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('验证邮箱'),
        SizedBox(height: 80.w),
        Text(
          '请输入发送到 ${_emailController.text} 的验证码',
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 28.w),
        ),
        SizedBox(height: 60.w),
        _buildCodeField(),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('设置新密码'),
        SizedBox(height: 80.w),
        Text(
          'Set your new password',
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 28.w),
        ),
        SizedBox(height: 60.w),
        _buildPasswordField(),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.fontPrimary,
            fontSize: 68.w, // 对应 34.sp
            fontWeight: FontWeight.bold,
          ),
        ),
        Positioned(
          left: 0,
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: 80.w,
              height: 80.w,
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                size: 40.w,
                color: AppColors.fontSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '邮箱',
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
        ),
        SizedBox(height: 16.w),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
          decoration: _buildInputDecoration(),
        ),
      ],
    );
  }

  Widget _buildCodeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '验证码',
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
        ),
        SizedBox(height: 16.w),
        TextFormField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
          decoration: _buildInputDecoration(),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '新密码',
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
        ),
        SizedBox(height: 16.w),
        TextFormField(
          controller: _newPasswordController,
          obscureText: !_isPasswordVisible,
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
          decoration: _buildInputDecoration().copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.fontSecondary,
                size: 44.w,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28.w), // 对应 14.r
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 36.w, horizontal: 32.w),
    );
  }

  Widget _buildCurrentButton() {
    if (_isLoading) {
      return Container(
        width: double.infinity,
        height: 112.w, // 对应 56.h
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      );
    }

    String buttonText;
    VoidCallback? onTap;

    if (_showPasswordInput) {
      buttonText = "重置密码";
      onTap = _handleResetPassword;
    } else if (_showCodeInput) {
      buttonText = "验证验证码";
      onTap = _handleVerifyCode;
    } else {
      buttonText = "发送验证码";
      onTap = _handleSendCode;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 112.w, // 对应 56.h
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.w), // 对应 14.r
          gradient: const LinearGradient(
            colors: [
              AppColors.accentGradientStart,
              AppColors.accentGradientEnd
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: AppColors.fontPrimary,
            fontSize: 36.w, // 对应 18.sp
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "记得密码？",
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 28.w),
        ),
        TextButton(
          onPressed: () {
            context.push('/user/auth/login');
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            '登录',
            style: TextStyle(
                color: AppColors.accentLink,
                fontSize: 28.w,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 48.w), // 调整了边距以适配750宽度
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.w),
                  _buildCurrentStep(),
                  SizedBox(height: 60.w),
                  _buildCurrentButton(),
                  SizedBox(height: 40.w),
                  // 仅在第一步显示返回登录链接
                  if (!_showCodeInput && !_showPasswordInput)
                    _buildSignInLink(),
                  SizedBox(height: 40.w),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
