import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaSignInPage extends StatefulWidget {
  const VigaSignInPage({super.key});

  @override
  State<VigaSignInPage> createState() => _VigaSignInPageState();
}

class _VigaSignInPageState extends State<VigaSignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();
    _emailController.text = "serena88@gmail.com";
    _passwordController.text = "************";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // 可以添加错误提示
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟登录请求
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // 登录成功，更新用户状态并跳转
    final userCubit = context.read<VigaUserCubit>();
    userCubit.login(
      userId: 'user_${_emailController.text}',
      authToken: 'token_${DateTime.now().millisecondsSinceEpoch}',
      phone: _emailController.text,
      name: '用户${_emailController.text.trim()}',
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 48.w), // 调整了边距以适配750宽度
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100.w),
                    _buildHeader(),
                    SizedBox(height: 80.w),
                    _buildEmailField(),
                    SizedBox(height: 40.w),
                    _buildPasswordField(),
                    SizedBox(height: 32.w),
                    _buildOptionsRow(),
                    SizedBox(height: 60.w),
                    _buildSignInButton(),
                    SizedBox(height: 100.w),
                    _buildSignUpLink(),
                    SizedBox(height: 40.w),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Text(
      '登录',
      style: TextStyle(
        color: AppColors.fontPrimary,
        fontSize: 68.w, // 对应 34.sp
        fontWeight: FontWeight.bold,
      ),
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

  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberMe = !_rememberMe;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 48.w,
                height: 48.w,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      _rememberMe = value ?? false;
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
              Text('记住我',
                  style:
                      TextStyle(color: AppColors.fontPrimary, fontSize: 28.w)),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            context.push('/user/auth/forgot_password');
          },
          child: Text(
            '忘记密码？',
            style: TextStyle(color: AppColors.accentLink, fontSize: 28.w),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _handleLogin,
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
                '登录',
                style: TextStyle(
                  color: AppColors.fontPrimary,
                  fontSize: 36.w, // 对应 18.sp
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "还没有账号？",
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 28.w),
        ),
        TextButton(
          onPressed: () {
            context.push('/user/auth/register');
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            '注册',
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
