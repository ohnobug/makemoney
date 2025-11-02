import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TextEditingController _emailContr oller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  // 统一的品牌色
  static const Color _primaryColor = Color(0xFF1E88E5); // 深一点的蓝色
  static const Color _surfaceColor = Color(0xFFF7F7F7); // 浅灰色背景
  static const Color _textColor = Color(0xFF212121); // 主文本颜色

  @override
  void initState() {
    super.initState();
    _emailController.text = "serena88@gmail.com";
    // 密码预填充使用星号是为了保护隐私，这里维持原样
    _passwordController.text = "************";
  }

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      logger.info("邮箱或密码不能为空");
      // 优化：使用 SnackBar 提供反馈
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('邮箱或密码不能为空!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
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
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          // ThemeData theme = Theme.of(context); // 保持原有的 theme 引用，但颜色使用自定义变量

          return Scaffold(
            primary: false,
            appBar: LJNAppBar(
              title: "登录",
            ),
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        systemState.appbarHeight -
                        systemState.statusHeight),
                // 【样式优化】使用统一的浅色背景，增强层次感
                color: _surfaceColor,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  // 【样式优化】增加整体内边距，增加留白
                  child: Padding(
                    padding: EdgeInsets.all(40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 40.w), // 增加顶部空间
                        // 【样式优化】更大的标题，更粗的字体，创建视觉焦点
                        Text(
                          "欢迎回来",
                          style: TextStyle(
                            fontSize: 48.w,
                            fontWeight: FontWeight.w800,
                            color: _textColor,
                          ),
                        ),
                        SizedBox(height: 10.w),
                        Text(
                          "登入你的账号", // 增加副标题
                          style: TextStyle(
                            fontSize: 32.w,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 80.w), // 增加表单区域间距

                        // 表单域
                        _buildTextField(
                          controller: _emailController,
                          labelText: "电话号码、邮箱、账号",
                        ),
                        SizedBox(height: 30.w), // 增加表单域间距
                        _buildTextField(
                          controller: _passwordController,
                          labelText: "密码",
                          obscureText: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              size: 35.w,
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              // 【样式优化】图标使用柔和的灰色
                              color: Colors.grey.shade600,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30.w), // 增加行间距

                        // 记住我 和 忘记密码
                        Row(
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
                                  // 【样式优化】调整 Checkbox 的尺寸和间距
                                  SizedBox(
                                    width: 30.w,
                                    height: 30.w,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                      },
                                      activeColor: _primaryColor, // 使用统一品牌色
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "记住我",
                                    style: TextStyle(
                                      fontSize: 30.w, // 字体略微放大
                                      color: _textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/user/auth/forgot_password');
                              },
                              child: Text(
                                "忘记密码?",
                                style: TextStyle(
                                  fontSize: 30.w,
                                  color: _primaryColor, // 使用统一品牌色
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.w), // 增加按钮上方的间距

                        // 登录按钮
                        _isLoading
                            ? Center(
                          child: CircularProgressIndicator(color: _primaryColor),
                        )
                            : ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor, // 使用统一品牌色
                            // 【样式优化】增加垂直填充，按钮更厚实
                            padding: EdgeInsets.symmetric(vertical: 20.w),
                            shape: RoundedRectangleBorder(
                              // 【样式优化】更大的圆角
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            elevation: 6, // 增加轻微阴影
                          ),
                          child: Text(
                            "登录",
                            style: TextStyle(
                              // 【样式优化】按钮文字更大，更粗
                              fontSize: 36.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 100.w), // 增加底部空间

                        // 注册链接
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "没有注册? ",
                              style: TextStyle(
                                fontSize: 30.w,
                                color: Colors.grey.shade600, // 柔和的提示色
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/user/auth/register');
                              },
                              child: Text(
                                "前往注册",
                                style: TextStyle(
                                  fontSize: 30.w,
                                  color: _primaryColor, // 使用统一品牌色
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  // 【核心样式优化】重构的输入框样式
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
            fontSize: 30.w, // 标签文字略微放大
            fontWeight: FontWeight.w600,
            color: _textColor, // 标签颜色更深
          ),
        ),
        SizedBox(height: 10.w), // 增加标签和输入框的间距
        TextField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: _primaryColor, // 光标颜色使用品牌色
          style: TextStyle(
            fontSize: 32.w, // 输入文本大小
            color: _textColor,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            // 【样式优化】使用填充样式，更现代
            filled: true,
            fillColor: Colors.white, // 输入框内部使用白色填充，与背景区分
            contentPadding:
            EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w), // 增加内部填充

            // 默认边框样式：无边或极浅
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r), // 大圆角
              borderSide: BorderSide.none, // 移除默认边框
            ),

            // 【样式优化】启用时的边框：浅灰色，有轻微的视觉分隔
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),

            // 【样式优化】焦点边框：使用品牌色，更粗，提供强烈的视觉反馈
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: _primaryColor, width: 2.5),
            ),
          ),
        ),
      ],
    );
  }
}