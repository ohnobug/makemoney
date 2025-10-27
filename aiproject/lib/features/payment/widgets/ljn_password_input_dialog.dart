import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vigaviga/store/ljn_payment_cubit.dart';
import 'ljn_custom_numpad.dart';
import 'ljn_pincode_field.dart';

class LJNPasswordInputDialog extends StatefulWidget {
  const LJNPasswordInputDialog({super.key});

  @override
  State<LJNPasswordInputDialog> createState() => _LJNPasswordInputDialogState();
}

class _LJNPasswordInputDialogState extends State<LJNPasswordInputDialog> {
  String _pin = '';

  void _onNumpadPress(String value) {
    if (value == 'del') {
      if (_pin.isNotEmpty) {
        setState(() => _pin = _pin.substring(0, _pin.length - 1));
      }
    } else if (_pin.length < 6) {
      setState(() => _pin += value);
      if (_pin.length == 6) {
        context.read<LJNPaymentCubit>().verifyPassword(_pin);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<LJNPaymentCubit, LJNPaymentState>(
      listener: (context, state) {
        if (state.status == LJNPaymentStatus.success) {
          // 先关闭对话框，然后导航到成功页面
          Navigator.of(context).pop();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed('/payment_alipay_success');
          });
        } else if (state.status == LJNPaymentStatus.failed) {
          Fluttertoast.showToast(msg: state.errorMessage ?? "發生未知錯誤");
          setState(() => _pin = '');
        }
      },
      builder: (context, state) {
        return Scaffold(
          primary: false,
          appBar: null,
          backgroundColor: Colors.black.withAlpha(128),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 750.w,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context)),
                          const Spacer(),
                          Text("请输入支付密码", style: theme.textTheme.titleMedium),
                          const Spacer(),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text("金额: ${state.paymentAmount.toStringAsFixed(2)}元",
                        style: theme.textTheme.bodyMedium),
                    SizedBox(height: 40.h),
                    LJNPincodeField(
                      pin: _pin,
                      isVerifying: state.status == LJNPaymentStatus.verifying,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              LJNCustomNumpad(onKeyPressed: _onNumpadPress),
            ],
          ),
        );
      },
    );
  }
}
