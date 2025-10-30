import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/features/payment/widgets/viga_payment_primary_button.dart';
import 'package:vigaviga/store/viga_payment_cubit.dart';

class VigaMerchantSuccessPage extends StatelessWidget {
  const VigaMerchantSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.read<VigaPaymentCubit>().state;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('支付详情'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text('交易剩余时间 29:43', style: theme.textTheme.bodySmall),
          SizedBox(height: 20.h),
          Text("¥${state.paymentAmount.toStringAsFixed(2)}", style: theme.textTheme.displaySmall),
          const Spacer(),
          Container(
            padding: EdgeInsets.fromLTRB(32.w, 60.h, 32.w, MediaQuery.of(context).padding.bottom + 20.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              children: [
                Text("支付成功 ¥${state.paymentAmount.toStringAsFixed(2)}", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),
                Text("支付宝", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                SizedBox(height: 60.h),
                VigaPaymentPrimaryButton(
                  text: '完成',
                  backgroundColor: const Color(0xFFE54335),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}