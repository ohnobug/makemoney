import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

class LJNLoginPage extends StatefulWidget {
  const LJNLoginPage({super.key});

  @override
  State<LJNLoginPage> createState() => _LJNLoginPageState();
}

class _LJNLoginPageState extends State<LJNLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = "serena88@gmail.com";
    _passwordController.text = "************";
  }

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      logger.info("邮箱或密码不能为空");
      // You can show a snackbar or dialog here to inform the user
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate login request
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // On successful login, update user state and navigate
    final userCubit = context.read<LJNUserCubit>();
    userCubit.login(
      userId: 'user_${_emailController.text}',
      authToken: 'token_${DateTime.now().millisecondsSinceEpoch}',
      phone: _emailController.text, // Assuming email is used as phone for now
      name: '用户${_emailController.text.trim()}',
    );

    logger.info("登录成功");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      String cdnBase = systemState.cdnBase;
      ThemeData theme = Theme.of(context);

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Container(
            color: theme.colorScheme.surfaceContainer,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    90.w -
                    systemState.statusHeight),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.w),
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 32.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40.w),
                _buildTextField(
                  controller: _emailController,
                  labelText: "Email",
                ),
                SizedBox(height: 20.w),
                _buildTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: Colors.blueAccent,
                        ),
                        Text(
                          "Remember me",
                          style:
                              TextStyle(fontSize: 28.w, color: Colors.black54),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password screen
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 28.w,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.w),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                SizedBox(height: 40.w),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Or Sign In with",
                        style: TextStyle(fontSize: 28.w, color: Colors.grey),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 30.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton('/images/logo.jpeg'),
                    SizedBox(width: 20.w),
                    _buildSocialButton('/images/logo.jpeg'),
                  ],
                ),
                SizedBox(height: 50.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 28.w, color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up screen
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 28.w,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 25.w,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.w),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String assetName) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Image.asset(
        assetPath(assetName),
        height: 80.w,
        width: 80.w,
      ),
    );
  }
}
