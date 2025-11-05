import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/store/viga_payment_cubit.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'viga_custom_numpad.dart';
import 'viga_pincode_field.dart';

class VigaPasswordInputDialog extends StatefulWidget {
  const VigaPasswordInputDialog({super.key});

  @override
  State<VigaPasswordInputDialog> createState() =>
      _VigaPasswordInputDialogState();
}

class _VigaPasswordInputDialogState extends State<VigaPasswordInputDialog> {
  String _pin = '';

  void _onNumpadPress(String value) {
    try {
      if (value == 'del') {
        if (_pin.isNotEmpty) {
          setState(() => _pin = _pin.substring(0, _pin.length - 1));
        }
      } else if (_pin.length < 6) {
        setState(() => _pin += value);
        if (_pin.length == 6) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.read<VigaPaymentCubit>().verifyPassword(_pin);
            }
          });
        }
      }
    } catch (e) {
      logger.info('密码输入异常: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<VigaPaymentCubit, VigaPaymentState>(
      listener: (context, state) {
        try {
          if (state.status == VigaPaymentStatus.success) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.go('/payment_alipay_success');
              }
            });
          } else if (state.status == VigaPaymentStatus.failed) {
            Fluttertoast.showToast(msg: state.errorMessage ?? "發生未知錯誤");
            setState(() => _pin = '');
          }
        } catch (e) {
          logger.info('密码验证监听器异常: $e');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            ),
            child: Container(
              color: Colors.black.withAlpha(128),
              child: Column(
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
                                  onPressed: () => Navigator.of(context).pop()),
                              const Spacer(),
                              Text("请输入支付密码",
                                  style: theme.textTheme.titleMedium),
                              const Spacer(),
                              const SizedBox(width: 48),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text("金额: ${state.paymentAmount.toStringAsFixed(2)}元",
                            style: theme.textTheme.bodyMedium),
                        SizedBox(height: 40.h),
                        VigaPincodeField(
                          pin: _pin,
                          isVerifying:
                              state.status == VigaPaymentStatus.verifying,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                  VigaCustomNumpad(onKeyPressed: _onNumpadPress),
                  Container(
                    color: theme.cardColor,
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
