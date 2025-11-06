import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaVerificationPage extends StatefulWidget {
  const VigaVerificationPage({super.key});

  @override
  State<VigaVerificationPage> createState() => _VigaVerificationPageState();
}

class _VigaVerificationPageState extends State<VigaVerificationPage> {
  // TextEditingController 来控制 TextField 的文本
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 添加监听器，以便在文本变化时重建UI
    // 这对于控制按钮的启用/禁用状态至关重要
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 销毁控制器以释放资源
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VigaAppBar(
        title: '安全验证',
        actions: [
          VigaAppBarActionTextButton(
            onTap: _passwordController.text.isNotEmpty
                ? () {
                    context.push('/change_account');
                    logger.info('验证密码: ${_passwordController.text}');
                  }
                : null,
            title: '验证',
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '填写当前Vigaviga登录密码, 验证本人身份。',
                style: textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 30.h),

              // 密码输入 - 使用浮动标签样式
              _FormInputRow(
                label: 'Vigaviga密码',
                hintText: '请输入密码',
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: 20.h),

              // 忘记密码
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    logger.info('"忘记密码"被点击了');
                    context.push('/user/auth/forgot_password');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('"忘记密码"被点击了')),
                    );
                  },
                  child: Text(
                    '忘记密码',
                    style: TextStyle(
                      color: Color.fromARGB(255, 87, 107, 149),
                      fontSize: 28.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // 按钮区域
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _passwordController.text.isNotEmpty
                      ? () {
                          context.push('/change_account');
                          logger.info('验证密码: ${_passwordController.text}');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    disabledBackgroundColor: const Color(0xFFF5F5F5),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.grey,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    '验证',
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

// 浮动标签输入框
class _FormInputRow extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const _FormInputRow({
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  State<_FormInputRow> createState() => _FormInputRowState();
}

class _FormInputRowState extends State<_FormInputRow> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      style: textTheme.bodyLarge,
      cursorColor: theme.colorScheme.primary,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(102),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 224, 224, 224)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon:
            widget.controller != null && widget.controller!.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      widget.controller!.clear();
                    },
                  )
                : null,
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}
