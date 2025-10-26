import 'package:flutter/material.dart';
// *** 核心改动 1: 导入 dlibphonenumber 包 ***
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _countryName = '中国';
  String _countryCode = '+86';
  String _isoCode = 'CN';
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
      PhoneNumber number = await phoneUtil.parse(phoneNumber, _isoCode);
      // 3. 验证解析后的号码
      isValid = await phoneUtil.isValidNumber(number);
    } catch (e) {
      // 如果解析失败 (例如，号码格式不正确)，则认为号码无效
      print("Error validating phone number: $e");
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
    // 定义颜色方案
    const Color kPrimaryTextColor = Color(0xFF000000);
    final Color kSecondaryTextColor = Colors.grey.shade600;
    final Color kHintTextColor = Colors.grey.shade400;
    final Color kCountryCodeColor = const Color(0xFF333333);
    final Color kDividerColor = Colors.grey.shade200;
    final Color kCursorColor = const Color(0xFF00BAA2);
    ThemeData theme = Theme.of(context);
    // 定义统一的标签宽度
    double kLabelWidth = 176.0.w;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: kPrimaryTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 120.h),
            Center(
              child: Text(
                '更换手机号',
                style: TextStyle(
                    fontSize: 56.w,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryTextColor),
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              '一个手机号只能绑定一个账号，更换后可使用新手机号登录此账号。对于已绑定其他账号的手机号，本次操作后将与原账号解绑。',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28.w, color: kSecondaryTextColor),
            ),
            SizedBox(height: 80.h),

            // 国家/地区选择
            GestureDetector(
              onTap: () {
                print('Navigate to country selection page');
                Navigator.pushNamed(context, '/country');
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 32.0.w),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: kLabelWidth,
                      child: Text(
                        '国家/地区',
                        style:
                            TextStyle(fontSize: 32.w, color: kPrimaryTextColor),
                      ),
                    ),
                    Text(
                      _countryName,
                      style:
                          TextStyle(fontSize: 32.w, color: kPrimaryTextColor),
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(Icons.arrow_forward_ios,
                        size: 32.w, color: Colors.grey.shade400),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: kDividerColor),

            // 手机号输入
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: kLabelWidth,
                    child: Text(
                      '手机号',
                      style:
                          TextStyle(fontSize: 32.w, color: kPrimaryTextColor),
                    ),
                  ),
                  Text(
                    _countryCode,
                    style: TextStyle(fontSize: 36.w, color: kCountryCodeColor),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      cursorColor: kCursorColor,
                      decoration: InputDecoration(
                        hintText: '请填写手机号码',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: kHintTextColor, fontSize: 32.w),
                      ),
                      style:
                          TextStyle(fontSize: 36.w, color: kPrimaryTextColor),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: kDividerColor),
            SizedBox(height: 80.h),

            // 下一步按钮
            SizedBox(
              width: double.infinity,
              height: 80.h,
              child: ElevatedButton(
                onPressed: _isPhoneNumberValid
                    ? () {
                        print(
                            'Phone number is valid: ${_countryCode}${_phoneController.text}');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  backgroundColor: theme.colorScheme.primary,
                  // 按钮禁用状态下的背景颜色
                  disabledBackgroundColor: theme.colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  '下一步',
                  style: TextStyle(
                    fontSize: 36.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
