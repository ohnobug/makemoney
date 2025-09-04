import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

class LJNSetPassword extends StatefulWidget {
  const LJNSetPassword({super.key});

  @override
  State<LJNSetPassword> createState() => _LJNSetPasswordState();
}

class _LJNSetPasswordState extends State<LJNSetPassword> {
  // 仅需要为需要获取其值的输入框创建 Controller
  final TextEditingController originPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // 记得 dispose 控制器以释放资源
    originPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 使用 aotolocations 的 context extension，让代码更简洁
    final l10n = AppLocalizations.of(context)!;
    final userState = context.read<LJNUserCubit>().state;
    final systemState = context.read<LJNSystemCubit>().state;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.setPassword,
        actions: [
          // 优化点：可以把这个按钮也提取成一个通用组件，比如 LJNAppBarActionButton
          GestureDetector(
            onTap: () {
              // 在这里处理完成逻辑
            },
            child: Container(
              height: 60.w,
              constraints: BoxConstraints(minWidth: 98.w),
              margin: EdgeInsets.only(right: 30.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.brandGreenVibrant3,
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: Text(
                l10n.done,
                style: TextStyle(
                  color: AppColors.neutralWhite,
                  fontSize: 25.w,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          )
        ],
      ),
      // 使用通用的页面布局，避免每次都写复杂的约束和滚动配置
      body: _buildPageBody(context, l10n, userState, systemState),
    );
  }

  Widget _buildPageBody(BuildContext context, AppLocalizations l10n, LJNUserState userState, SystemState systemState) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        // 使用 ListView 代替 SingleChildScrollView + Column，代码更简洁
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.all(30.w),
          children: [
            Text(
              l10n.setWechatPasswordDescription,
              style: TextStyle(
                fontSize: 27.w,
                color: AppColors.neutralGrey60,
              ),
            ),
            SizedBox(height: 30.w),

            // --- 使用提取的公共组件 ---
            _InfoRow(
              label: l10n.wechatID,
              value: userState.userinfoAccount ?? '', // 使用 ?? '' 避免null错误
            ),
            SizedBox(height: 20.w),

            _FormInputRow(
              label: l10n.originalPassword,
              hintText: l10n.enterOriginalPassword,
              controller: originPasswordController,
            ),
            SizedBox(height: 20.w),

            _FormInputRow(
              label: l10n.newPassword,
              hintText: l10n.enterNewPassword,
              controller: newPasswordController,
            ),
            SizedBox(height: 20.w),

            _FormInputRow(
              label: l10n.confirmPassword,
              hintText: l10n.enterToConfirm,
              controller: confirmPasswordController,
            ),
            // --- 公共组件使用结束 ---

            SizedBox(height: 30.w),
            Text(
              l10n.passwordValidationRule(8, 16),
              style: TextStyle(
                fontSize: 26.w,
                height: 1.08,
                color: AppColors.neutralBlack,
              ),
            ),
            SizedBox(height: 10.w),
            Text(
              l10n.forgotOriginalPassword,
              style: TextStyle(
                fontSize: 26.w,
                height: 1.08,
                color: AppColors.neutralDarkGrey8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 提取的公共组件 1: 用于展示 "标签: 信息" 的行
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.w,
            color: const Color.fromARGB(255, 223, 223, 223),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 160.w,
            child: Text(
              label,
              style: TextStyle(
                height: 1.08,
                fontSize: 32.w,
                color: AppColors.neutralGrey59,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            value,
            style: TextStyle(
              height: 1.08,
              fontSize: 32.w,
              color: AppColors.neutralGrey59,
            ),
          ),
        ],
      ),
    );
  }
}


// 提取的公共组件 2: 带标签的输入框行
class _FormInputRow extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller; // Controller是可选的

  const _FormInputRow({
    required this.label,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // 确保垂直居中
        children: [
          SizedBox(
            width: 160.w,
            child: Text(
              label,
              style: TextStyle(
                height: 1.08,
                fontSize: 30.w,
                color: AppColors.neutralBlack,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: false,
              obscureText: true, // 密码输入框应隐藏文本
              style: TextStyle(fontSize: 30.w),
              cursorColor: AppColors.brandGreenDarker4,
              cursorWidth: 1.w,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 30.w,
                  color: AppColors.neutralGrey61,
                ),
                isDense: true,
                border: UnderlineInputBorder( // 统一样式
                  borderSide: BorderSide(width: 1.5.w, color: AppColors.neutralGrey21),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.5.w, color: AppColors.neutralGrey21),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.5.w, color: AppColors.brandGreenSlightlyLighter),
                ),
                // 调整 contentPadding 使文本和下划线对齐更佳
                contentPadding: EdgeInsets.only(bottom: 15.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}