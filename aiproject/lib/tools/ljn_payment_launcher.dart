import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/store/ljn_payment_cubit.dart';
import 'package:vigaviga/features/payment/widgets/ljn_select_payment_sheet.dart';
import 'package:vigaviga/features/payment/widgets/ljn_confirm_payment_sheet.dart';
import 'package:vigaviga/features/payment/widgets/ljn_password_input_dialog.dart';

class LJNPaymentLauncher {
  /// 啟動完整的支付流程
  ///
  /// 使用示例：
  /// ```dart
  /// LJNPaymentLauncher.startPaymentFlow(context);
  /// ```
  static Future<void> startPaymentFlow(
    BuildContext context, {
    double? amount,
    String? merchantName,
  }) async {
    final paymentCubit = context.read<LJNPaymentCubit>();

    // 更新支付金額和商家名稱（如果提供了參數）
    if (amount != null) {
      paymentCubit.updatePaymentAmount(amount);
    }
    if (merchantName != null) {
      paymentCubit.updateMerchantName(merchantName);
    }

    paymentCubit.startPaymentFlow();

    // 步驟 1: 顯示選擇支付方式頁面
    final confirmedMethod = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: paymentCubit,
        child: const LJNSelectPaymentSheet(),
      ),
    );

    if (confirmedMethod != true) {
      paymentCubit.resetPayment();
      return; // 用戶取消
    }

    if (!context.mounted) return;

    // 步驟 2: 顯示確認付款頁面
    final confirmedPayment = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: paymentCubit,
        child: const LJNConfirmPaymentSheet(),
      ),
    );

    if (confirmedPayment != true) {
      paymentCubit.resetPayment();
      return; // 用戶取消
    }

    // 步驟 3: 顯示密碼輸入對話框
    if (context.mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (_) => BlocProvider.value(
          value: paymentCubit,
          child: const LJNPasswordInputDialog(),
        ),
      );
    }
  }

  /// 快速啟動支付流程（使用默認參數）
  static Future<void> quickStartPayment(BuildContext context) async {
    await startPaymentFlow(context);
  }
}