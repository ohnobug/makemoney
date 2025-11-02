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

// 定义步骤枚举
enum ResetStep { phone, code, password }

class LJNForgotPasswordPage extends StatefulWidget {
  const LJNForgotPasswordPage({super.key});

  @override
  State<LJNForgotPasswordPage> createState() => _LJNForgotPasswordPage();
}

class _LJNForgotPasswordPage extends State<LJNForgotPasswordPage> with SingleTickerProviderStateMixin {
  // 保持与原代码的控制器
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  // 【新增】确认密码控制器
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  // 状态变量
  ResetStep _currentStep = ResetStep.phone;
  bool _isLoading = false;

  // 倒计时相关状态
  Timer? _timer;
  int _countdown = 0; // 60秒倒计时
  bool _isCodeSending = false; // 是否正在倒计时

  // 引用 AppColors 中的颜色
  final Color _primaryColor = AppColors.brandGreenDarker4;
  final Color _linkColor = AppColors.brandPurpleDark3;
  final Color _textColor = const Color(0xFF212121);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _timer?.cancel();
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
        if (mounted) {
          setState(() {
            _isCodeSending = false;
            _countdown = 0;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _countdown--;
          });
        }
      }
    });
  }

  void _handleSendCode() async {
    if (_phoneController.text.isEmpty) {
      _showSnackBar("请输入手机号");
      return;
    }
    if (_isCodeSending) return; // 倒计时进行中，禁止发送

    setState(() {
      _isLoading = true;
    });

    // 模拟发送验证码请求
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _currentStep = ResetStep.code; // 进入验证码步骤
    });

    _startCountdown(); // 【新增】启动倒计时

    logger.info("验证码已发送");
    _showSnackBar("验证码已发送");
  }

  void _handleVerifyCode() async {
    if (_codeController.text.isEmpty) {
      _showSnackBar("请输入验证码");
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
      _currentStep = ResetStep.password; // 进入密码设置步骤
    });

    logger.info("验证码验证成功");
    _showSnackBar("验证成功，请设置新密码");
  }

  void _handleResetPassword() async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmNewPasswordController.text;

    if (newPassword.isEmpty) {
      _showSnackBar("请输入新密码");
      return;
    }

    // 【新增】校验两次密码一致性
    if (newPassword != confirmPassword) {
      _showSnackBar("两次输入的密码不一致");
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
    userCubit.updateAuthToken('token_${DateTime.now().millisecondsSinceEpoch}'); // 模拟更新 token

    logger.info("密码重置成功");
    _showSnackBar("密码重置成功");
    Navigator.pop(context);
  }

  // 辅助方法：显示 SnackBar 提示
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  // 辅助方法：返回上一步
  void _goBack() {
    setState(() {
      if (_currentStep == ResetStep.code) {
        _currentStep = ResetStep.phone;
        _timer?.cancel();
        _isCodeSending = false;
        _countdown = 0;
      } else if (_currentStep == ResetStep.password) {
        _currentStep = ResetStep.code;
      }
    });
  }

  // --- 步骤构建器 ---

  Widget _buildStepContent() {
    switch (_currentStep) {
      case ResetStep.phone:
        return _buildPhoneStep();
      case ResetStep.code:
        return _buildCodeStep();
      case ResetStep.password:
        return _buildPasswordStep();
    }
  }

  Widget _buildPhoneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.w),
        Text(
          "找回密码",
          style: TextStyle(
            fontSize: 48.w,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
        SizedBox(height: 10.w),
        Text(
          "请输入您的手机号以接收验证码",
          style: TextStyle(
            fontSize: 30.w,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 60.w),

        // 手机号输入框
        _buildTextFieldRow(
          labelText: "手机号",
          controller: _phoneController,
          hintText: "请输入手机号",
          keyboardType: TextInputType.phone,
          showTopBorder: true,
          showBottomBorder: true,
        ),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.w),
        Text(
          "验证手机号",
          style: TextStyle(
            fontSize: 48.w,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
        SizedBox(height: 10.w),
        Text(
          "验证码已发送至 ${_phoneController.text}",
          style: TextStyle(
            fontSize: 30.w,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 60.w),

        // 验证码输入框 (带倒计时按钮)
        _buildTextFieldRow(
          labelText: "验证码",
          controller: _codeController,
          hintText: "请输入验证码",
          keyboardType: TextInputType.number,
          showTopBorder: true,
          showBottomBorder: true,
          suffixWidget: _buildCodeButton(),
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.w),
        Text(
          "设置新密码",
          style: TextStyle(
            fontSize: 48.w,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
        SizedBox(height: 10.w),
        Text(
          "请设置您的新密码",
          style: TextStyle(
            fontSize: 30.w,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 60.w),

        // 新密码输入框
        _buildTextFieldRow(
          labelText: "新密码",
          controller: _newPasswordController,
          hintText: "请输入新密码",
          obscureText: true,
          showTopBorder: true,
        ),

        // 确认新密码输入框
        _buildTextFieldRow(
          labelText: "确认密码",
          controller: _confirmNewPasswordController,
          hintText: "请再次输入新密码",
          obscureText: true,
          showBottomBorder: true,
        ),
      ],
    );
  }

  // --- 组件构建器 ---

  Widget _buildCodeButton() {
    bool disabled = _isCodeSending;
    String buttonText = disabled ? '重新发送($_countdown s)' : '获取验证码';

    return TextButton(
      onPressed: disabled ? null : _handleSendCode,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(150.w, 40.w),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 28.w,
          color: disabled ? Colors.grey.shade400 : _primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextFieldRow({
    required String labelText,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool showTopBorder = false,
    bool showBottomBorder = false,
    Widget? suffixWidget,
  }) {
    final theme = Theme.of(context);
    final double fieldHeight = 120.w;

    return Container(
      height: fieldHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: showTopBorder ? BorderSide(
            color: theme.dividerColor.withOpacity(0.7),
            width: 1.0.w,
            style: BorderStyle.solid,
          ) : BorderSide.none,
          bottom: showBottomBorder ? BorderSide(
            color: theme.dividerColor.withOpacity(0.7),
            width: 1.0.w,
            style: BorderStyle.solid,
          ) : BorderSide.none,
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
                suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 200.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentButton() {
    if (_isLoading) {
      return Container(
        width: 670.w, // 调整宽度以适应新布局
        height: 100.w,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: _primaryColor,
        ),
      );
    }

    String buttonText;
    VoidCallback? onTap;

    switch (_currentStep) {
      case ResetStep.phone:
        buttonText = "发送验证码";
        onTap = _handleSendCode;
        break;
      case ResetStep.code:
        buttonText = "验证";
        onTap = _handleVerifyCode;
        break;
      case ResetStep.password:
        buttonText = "重置密码";
        onTap = _handleResetPassword;
        break;
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

  Widget _buildBottomLinks() {
    // 统一使用 Row 包裹按钮和链接
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 返回上一步按钮 (Code 和 Password 步骤显示)
        if (_currentStep != ResetStep.phone)
          GestureDetector(
            onTap: _goBack,
            child: Text(
              _currentStep == ResetStep.code ? "修改手机号" : "返回上一步",
              style: TextStyle(
                fontSize: 28.w,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
        // 占位，确保返回登录链接右对齐
          Container(),

        // 返回登录链接 (所有步骤都显示)
        GestureDetector(
          onTap: () {
            // 使用 pop 返回登录页，如果当前页面是 pushNamed 出来的
            Navigator.pop(context);
          },
          child: Text(
            "返回登录",
            style: TextStyle(
              fontSize: 28.w,
              color: _linkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final double horizontalPadding = 40.w; // 统一内边距

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
            // 允许键盘弹出时页面滚动
            // resizeToAvoidBottomInset: false,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch, // 填充宽度
                      children: [
                        // 步骤内容
                        _buildStepContent(),

                        SizedBox(height: 40.w),

                        // 底部链接区域
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.w),
                          child: _buildBottomLinks(),
                        ),

                        // 填补空间 (取代 780.w)
                        SizedBox(height: 200.w),

                        // 按钮
                        Container(
                          padding: EdgeInsets.only(bottom: 50.w), // 调整底部填充
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