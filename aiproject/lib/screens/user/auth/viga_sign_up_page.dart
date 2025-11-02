import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/tools/viga_logger.dart';

class VigaSignUpPage extends StatefulWidget {
  const VigaSignUpPage({super.key});

  @override
  State<VigaSignUpPage> createState() => _VigaSignUpState();
}

class _VigaSignUpState extends State<VigaSignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      return;
    }

    if (!_agreeToTerms) {
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

    // 注册成功，更新用户状态并跳转
    final userCubit = context.read<VigaUserCubit>();
    userCubit.login(
      userId: 'user_${_emailController.text}',
      authToken: 'token_${DateTime.now().millisecondsSinceEpoch}',
      phone: _emailController.text,
      name: '用户${_emailController.text}',
    );

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
                  _buildHeader(),
                  SizedBox(height: 80.w),
                  _buildEmailField(),
                  SizedBox(height: 40.w),
                  _buildPasswordField(),
                  SizedBox(height: 40.w),
                  _buildConfirmPasswordField(),
                  SizedBox(height: 32.w),
                  _buildTermsAgreement(),
                  SizedBox(height: 60.w),
                  _buildSignUpButton(),
                  SizedBox(height: 40.w),
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

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '注册',
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
              Navigator.of(context).pop();
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

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '密码',
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
        ),
        SizedBox(height: 16.w),
        TextFormField(
          controller: _passwordController,
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

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '确认密码',
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
        ),
        SizedBox(height: 16.w),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          style: TextStyle(color: AppColors.fontPrimary, fontSize: 32.w),
          decoration: _buildInputDecoration().copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.fontSecondary,
                size: 44.w,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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

  Widget _buildTermsAgreement() {
    return Row(
      children: [
        SizedBox(
          width: 48.w,
          height: 48.w,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (bool? value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            activeColor: AppColors.accentGradientStart,
            checkColor: AppColors.darkBackground,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w)),
            side: const BorderSide(
                color: AppColors.fontSecondary, width: 2),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '我已阅读并同意',
                style: TextStyle(color: AppColors.fontPrimary, fontSize: 28.w),
              ),
              GestureDetector(
                onTap: () {
                  // 打开用户协议页面
                  logger.info("打开用户协议");
                },
                child: Text(
                  '用户协议',
                  style: TextStyle(
                    color: AppColors.accentLink,
                    fontSize: 28.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '和',
                style: TextStyle(color: AppColors.fontPrimary, fontSize: 28.w),
              ),
              GestureDetector(
                onTap: () {
                  // 打开隐私政策页面
                  logger.info("打开隐私政策");
                },
                child: Text(
                  '隐私政策',
                  style: TextStyle(
                    color: AppColors.accentLink,
                    fontSize: 28.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _handleRegister,
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
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                '注册',
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
          "已有账号？",
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 28.w),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/user/auth/login');
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
}
