import 'package:flutter/material.dart';
// *** 核心改动 1: 导入 dlibphonenumber 包 ***
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/l10n/app_localizations.dart';

class VigaChangePhonePage extends StatefulWidget {
  const VigaChangePhonePage({super.key});

  @override
  State<VigaChangePhonePage> createState() =>
      _VigaChangePhonePageState();
}

class _VigaChangePhonePageState
    extends State<VigaChangePhonePage> {
  final TextEditingController _phoneController = TextEditingController();
  final String _countryName = '中国';
  final String _countryCode = '+86';
  final String _isoCode = 'CN';
  bool _isPhoneNumberValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_validatePhoneNumber);
    _phoneController.dispose();
    super.dispose();
  }

  // *** 核心改动 2: 使用 dlibphonenumber 重写验证方法 ***
  void _validatePhoneNumber() async {
    String phoneNumber = _phoneController.text;

    // 如果输入为空，则直接判断为无效
    if (phoneNumber.isEmpty) {
      if (_isPhoneNumberValid) {
        setState(() {
          _isPhoneNumberValid = false;
        });
      }
      return;
    }

    bool isValid = false;
    try {
      // 1. 获取 PhoneNumberUtil 实例
      PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
      // 2. 解析号码，需要提供国家/地区代码 (isoCode)
      PhoneNumber number = phoneUtil.parse(phoneNumber, _isoCode);
      // 3. 验证解析后的号码
      isValid = phoneUtil.isValidNumber(number);
    } catch (e) {
      // 如果解析失败 (例如，号码格式不正确)，则认为号码无效
      logger.info("Error validating phone number: $e");
      isValid = false;
    }

    // 仅在验证状态发生变化时才更新UI
    if (isValid != _isPhoneNumberValid) {
      setState(() {
        _isPhoneNumberValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VigaAppBar(
        title: l10n.changePhoneNumber,
        actions: [
          VigaAppBarActionTextButton(
            onTap: _isPhoneNumberValid
                ? () {
                    logger.info(
                        'Phone number is valid: $_countryCode${_phoneController.text}');
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
                '一个手机号只能绑定一个账号，更换后可使用新手机号登录此账号。对于已绑定其他账号的手机号，本次操作后将与原账号解绑。',
                style: textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 30.h),

              // 国家/地区选择
              GestureDetector(
                onTap: () {
                  logger.info('Navigate to country selection page');
                  context.push('/country');
                },
                child: _InfoRow(
                  label: '国家/地区',
                  value: _countryName,
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 32.w, color: Colors.grey.shade400),
                ),
              ),
              SizedBox(height: 20.h),

              // 手机号输入 - 使用浮动标签样式
              _FormInputRow(
                label: '手机号',
                hintText: '请填写手机号码',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                obscureText: false,
                prefix: Text(
                  _countryCode,
                  style: TextStyle(
                    fontSize: 36.w,
                    color: const Color(0xFF333333),
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // 按钮区域
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _isPhoneNumberValid
                      ? () {
                          logger.info(
                              'Phone number is valid: $_countryCode${_phoneController.text}');
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
  final Widget? trailing;

  const _InfoRow({required this.label, required this.value, this.trailing});

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
          if (trailing != null) trailing!,
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
  final Widget? prefix;

  const _FormInputRow({
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
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
        prefix: widget.prefix,
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
