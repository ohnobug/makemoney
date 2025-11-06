import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/tools/viga_logger.dart';

class VigaChangeEmailPage extends StatefulWidget {
  const VigaChangeEmailPage({super.key});

  @override
  State<VigaChangeEmailPage> createState() => _VigaChangeEmailPageState();
}

class _VigaChangeEmailPageState extends State<VigaChangeEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  // 新增一个状态变量，用于跟踪邮箱格式是否有效
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    // 添加监听器，以便在文本变化时执行校验
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    // 页面销毁时，移除监听器并释放控制器资源
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }

  // 邮箱校验逻辑
  void _validateEmail() {
    final email = _emailController.text;
    // 使用正则表达式判断邮箱格式是否正确
    // 这是一个常用的邮箱格式正则表达式
    final bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    // 如果校验结果与当前状态不同，则更新状态以触发UI刷新
    if (isValid != _isEmailValid) {
      setState(() {
        _isEmailValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userState = context.read<VigaUserCubit>().state;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VigaAppBar(
        title: '更换邮箱',
        actions: [
          VigaAppBarActionTextButton(
            onTap: _isEmailValid
                ? () {
                    // 在这里处理点击事件，例如提交数据
                    logger.info('下一步，邮箱是: ${_emailController.text}');
                    context.push('/settings/verify_email_screen');
                  }
                : null,
            title: l10n.nextStep,
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
                '更换邮箱后，您可以使用新邮箱登录此账号。一个邮箱只能绑定一个账号。',
                style: textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 30.h),

              // 用户ID信息
              _InfoRow(
                label: l10n.vigavigaID,
                value: userState.userinfoAccount ?? '',
              ),
              SizedBox(height: 20.h),

              // 邮箱输入框 - 使用浮动标签样式
              _FormInputRow(
                label: l10n.emailAddress,
                hintText: '请输入邮箱地址',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              SizedBox(height: 30.h),

              // 按钮区域
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _isEmailValid
                      ? () {
                          logger.info('下一步，邮箱是: ${_emailController.text}');
                          context.push('/settings/verify_email_screen');
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
                    l10n.nextStep,
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

// 公共组件 1: 用于展示 "标签: 信息" 的行 (样式微调)
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 160.w,
            child: Text(label, style: textTheme.titleMedium),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// 公共组件 2: 浮动标签输入框
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
