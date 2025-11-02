import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'dart:async'; // 引入 Timer

// 定义注册方式枚举
enum RegisterMethod { phone, email }

class LJNRegisterPage extends StatefulWidget {
  const LJNRegisterPage({super.key});

  @override
  State<LJNRegisterPage> createState() => _LJNRegisterPage();
}

class _LJNRegisterPage extends State<LJNRegisterPage> with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController(text: "13888888888");
  final TextEditingController _emailController = TextEditingController(text: "test@example.com");
  final TextEditingController _phoneCodeController = TextEditingController();
  final TextEditingController _emailCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(text: "123456");
  final TextEditingController _confirmPasswordController = TextEditingController(text: "123456");

  bool _isLoading = false;
  RegisterMethod _currentMethod = RegisterMethod.phone;
  late TabController _tabController;

  // 【新增】倒计时相关状态
  Timer? _timer;
  int _countdown = 0; // 60秒倒计时
  bool _isCodeSending = false; // 是否正在倒计时

  // 引用 AppColors 中的颜色，保持样式一致性
  final Color _primaryColor = AppColors.brandGreenDarker4;
  final Color _linkColor = AppColors.brandPurpleDark3;
  final Color _textColor = const Color(0xFF212121); // 主文本颜色

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      _currentMethod = _tabController.index == 0 ? RegisterMethod.phone : RegisterMethod.email;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _phoneCodeController.dispose();
    _emailCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel(); // 【新增】释放 Timer 资源
    super.dispose();
  }

  // 【新增】启动倒计时
  void _startCountdown() {
    _countdown = 60;
    _isCodeSending = true;

    // 立即更新 UI
    setState(() {});

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        timer.cancel();
        setState(() {
          _isCodeSending = false;
          _countdown = 0;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }


  void _handleRegister() async {
    String account;
    String code;

    if (_currentMethod == RegisterMethod.phone) {
      account = _phoneController.text;
      code = _phoneCodeController.text;
    } else {
      account = _emailController.text;
      code = _emailCodeController.text;
    }

    // 简化的表单校验
    if (account.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty || code.isEmpty) {
      logger.info("所有字段不能为空");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('手机号/邮箱、验证码或密码不能为空!')),
        );
      }
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      logger.info("两次输入的密码不一致");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('两次输入的密码不一致!')),
        );
      }
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

    // 注册成功，更新用户状态并跳转到主页 (使用 account 作为唯一标识)
    final userCubit = context.read<LJNUserCubit>();
    userCubit.login(
      userId: 'user_$account',
      authToken: 'token_${DateTime.now().millisecondsSinceEpoch}',
      phone: _currentMethod == RegisterMethod.phone ? account : '',
      name: '用户${account.substring(account.length > 4 ? account.length - 4 : 0)}',
    );

    logger.info("注册成功");
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  // 获取验证码的模拟方法，并启动倒计时
  void _sendVerificationCode() {
    if (_isCodeSending) return; // 倒计时进行中，禁止发送

    _startCountdown(); // 启动倒计时

    logger.info("发送验证码到 ${_currentMethod == RegisterMethod.phone ? _phoneController.text : _emailController.text}");
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('验证码已发送到 ${_currentMethod == RegisterMethod.phone ? "手机号" : "邮箱"}！')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final double horizontalPadding = 40.w;

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
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 50.w),
                        // 标题区域
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "创建账号",
                            style: TextStyle(
                              fontSize: 56.w, // 【美化】标题更大
                              fontWeight: FontWeight.bold,
                              color: _textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 50.w),

                        // Tabs 切换区域
                        _buildRegisterTabs(theme),
                        SizedBox(height: 40.w),

                        // TabBarView 包含两个不同的表单
                        SizedBox(
                          height: 600.w, // 保持高度，防止 Tab 切换时闪烁
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildPhoneRegisterForm(theme),
                              _buildEmailRegisterForm(theme),
                            ],
                          ),
                        ),

                        SizedBox(height: 30.w),

                        // 已有账号登录链接
                        SizedBox(
                          width: double.infinity,
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
                                    fontSize: 28.w,
                                    color: _linkColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 100.w),

                        // 注册按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 50.w),
                          child: _isLoading
                              ? Container(
                            width: double.infinity,
                            height: 100.w,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: _primaryColor,
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

  // 辅助方法：Tab 栏设计 (美化)
  Widget _buildRegisterTabs(ThemeData theme) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        indicatorSize: TabBarIndicatorSize.label,
        // 【美化】指示器使用圆角
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 6.w, // 宽度略增
            color: _primaryColor,
          ),
          insets: EdgeInsets.symmetric(horizontal: 10.w),
        ),
        labelColor: _textColor, // 【美化】选中颜色改为深色，指示器才是品牌色
        unselectedLabelColor: Colors.grey.shade500,
        labelStyle: TextStyle(
          fontSize: 38.w, // 【美化】字号略增
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 38.w,
          fontWeight: FontWeight.w500, // 略微加粗
        ),
        tabs: const [
          Tab(text: "手机号注册"),
          Tab(text: "邮箱注册"),
        ],
      ),
    );
  }

  // 辅助方法：手机号注册表单
  Widget _buildPhoneRegisterForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextFieldRow(
          theme,
          labelText: "手机号",
          controller: _phoneController,
          hintText: "请输入手机号",
          keyboardType: TextInputType.phone,
          showTopBorder: true,
        ),
        // 手机验证码输入框 (带按钮)
        _buildTextFieldRow(
          theme,
          labelText: "验证码",
          controller: _phoneCodeController,
          hintText: "请输入验证码",
          keyboardType: TextInputType.number,
          suffixWidget: _buildCodeButton(), // 使用统一的按钮构建器
        ),
        _buildTextFieldRow(
          theme,
          labelText: "密码",
          controller: _passwordController,
          hintText: "请输入密码",
          obscureText: true,
        ),
        _buildTextFieldRow(
          theme,
          labelText: "确认密码",
          controller: _confirmPasswordController,
          hintText: "请再次输入密码",
          obscureText: true,
          showBottomBorder: true,
        ),
      ],
    );
  }

  // 辅助方法：邮箱注册表单
  Widget _buildEmailRegisterForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextFieldRow(
          theme,
          labelText: "邮箱",
          controller: _emailController,
          hintText: "请输入邮箱地址",
          keyboardType: TextInputType.emailAddress,
          showTopBorder: true,
        ),
        // 邮箱验证码输入框 (带按钮)
        _buildTextFieldRow(
          theme,
          labelText: "验证码",
          controller: _emailCodeController,
          hintText: "请输入验证码",
          keyboardType: TextInputType.number,
          suffixWidget: _buildCodeButton(), // 使用统一的按钮构建器
        ),
        _buildTextFieldRow(
          theme,
          labelText: "密码",
          controller: _passwordController,
          hintText: "请输入密码",
          obscureText: true,
        ),
        _buildTextFieldRow(
          theme,
          labelText: "确认密码",
          controller: _confirmPasswordController,
          hintText: "请再次输入密码",
          obscureText: true,
          showBottomBorder: true,
        ),
      ],
    );
  }

  // 【新增】验证码按钮构建器
  Widget _buildCodeButton() {
    bool disabled = _isCodeSending;
    String buttonText = disabled ? '重新发送($_countdown s)' : '获取验证码';

    return TextButton(
      // 倒计时进行时，onPressed 为 null
      onPressed: disabled ? null : _sendVerificationCode,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(150.w, 40.w), // 确保按钮有足够的点击区域，且不会太宽
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 28.w,
          // 倒计时进行时，使用灰色；否则使用品牌色
          color: disabled ? Colors.grey.shade400 : _primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 辅助方法：重构后的简约分割线式输入框
  Widget _buildTextFieldRow(
      ThemeData theme, {
        required String labelText,
        required TextEditingController controller,
        required String hintText,
        TextInputType keyboardType = TextInputType.text,
        bool obscureText = false,
        bool showTopBorder = false,
        bool showBottomBorder = false,
        Widget? suffixWidget,
      }) {
    final double fieldHeight = 120.w;

    return Container(
      height: fieldHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder ? BorderSide(
            color: theme.dividerColor.withOpacity(0.7), // 【美化】边框颜色略微变淡
            width: 1.0.w,
            style: BorderStyle.solid,
          ) : BorderSide.none,
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.7),
            width: 1.0.w,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150.w,
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 32.w,
                fontWeight: FontWeight.w600,
                height: 1.0,
                color: _textColor,
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              cursorColor: _primaryColor,
              cursorWidth: 2.w,
              style: TextStyle(
                fontSize: 32.w,
                color: _textColor,
              ),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 32.w,
                ),
                labelText: '',
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),

                suffixIcon: suffixWidget != null
                    ? Padding(
                  padding: EdgeInsets.only(right: 0.w),
                  child: suffixWidget,
                )
                    : null,
                // 确保 suffixIcon 不会挤压 TextField 太多
                suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 200.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}