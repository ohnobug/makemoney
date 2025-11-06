import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';

class VigaSetPasswordPage extends StatefulWidget {
  const VigaSetPasswordPage({super.key});

  @override
  State<VigaSetPasswordPage> createState() => _VigaSetPasswordPageState();
}

class _VigaSetPasswordPageState extends State<VigaSetPasswordPage> {
  // 为需要获取其值的输入框创建 Controller
  final TextEditingController originPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // 释放资源，防止内存泄漏
    originPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userState = context.read<VigaUserCubit>().state;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // 1. 设置页面背景为白色
        backgroundColor: Colors.white,
        appBar: VigaAppBar(
          title: l10n.setPassword,
          actions: [
            VigaAppBarActionTextButton(
              onTap: () {
                // TODO: 实现 "完成" 按钮的逻辑
              },
              title: l10n.done,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            // 2. 容器颜色也设置为白色，确保一致性
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.setVigavigaPasswordDescription,
                  style: textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 30.h),

                // --- 表单内容 ---
                _InfoRow(
                  label: l10n.vigavigaID,
                  value: userState.userinfoAccount ?? '',
                ),
                SizedBox(height: 20.h),

                // 3. 使用新的 _FormInputRow 组件
                _FormInputRow(
                  label: l10n.originalPassword,
                  hintText: l10n.enterOriginalPassword,
                  controller: originPasswordController,
                ),
                SizedBox(height: 20.h),

                _FormInputRow(
                  label: l10n.newPassword,
                  hintText: l10n.enterNewPassword,
                  controller: newPasswordController,
                ),
                SizedBox(height: 20.h),

                _FormInputRow(
                  label: l10n.confirmPassword,
                  hintText: l10n.enterToConfirm,
                  controller: confirmPasswordController,
                ),
                // --- 表单内容结束 ---

                SizedBox(height: 30.h),
                Text(
                  l10n.passwordValidationRule(8, 16),
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    context.push('/user/auth/forgot_password');
                  },
                  child: Text(
                    l10n.forgotOriginalPassword,
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
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
      // 调整背景色和边框色以适应白色主题
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7), // 使用一个非常浅的灰色作为背景
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

// 公共组件 2: 已重构为 StatefulWidget 以实现清除按钮的动态显示
class _FormInputRow extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;

  const _FormInputRow({
    required this.label,
    required this.hintText,
    this.controller,
  });

  @override
  State<_FormInputRow> createState() => _FormInputRowState();
}

class _FormInputRowState extends State<_FormInputRow> {
  @override
  void initState() {
    super.initState();
    // 添加监听器，当文本内容变化时，调用 setState 刷新 UI
    widget.controller?.addListener(() {
      setState(() {});
    });
  }

  // 注意：由于 controller 是在父组件中创建和销毁的，
  // 这里可以不移除监听器，但最佳实践是移除。
  // 但如果在这里移除，父组件的 controller dispose 时会出问题。
  // 所以让父组件管理 controller 的生命周期即可。

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return TextField(
      controller: widget.controller,
      obscureText: true, // 密码设为隐藏
      style: textTheme.bodyLarge,
      cursorColor: theme.colorScheme.primary,
      decoration: InputDecoration(
        // 使用 labelText 作为浮动标签
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(102),
        ),
        // 设置下划线边框
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 224, 224, 224)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // 根据输入框是否有内容，动态显示或隐藏清除按钮
        suffixIcon:
            widget.controller != null && widget.controller!.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 20, // 调整图标大小
                    ),
                    onPressed: () {
                      // 点击时清空文本
                      widget.controller!.clear();
                    },
                  )
                : null, // 如果没有文本则不显示图标
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}
