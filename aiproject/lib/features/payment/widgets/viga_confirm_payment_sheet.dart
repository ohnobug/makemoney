import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/store/viga_payment_cubit.dart';
import 'viga_payment_primary_button.dart';

class VigaConfirmPaymentSheet extends StatelessWidget {
  const VigaConfirmPaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<VigaPaymentCubit, VigaPaymentState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(32.w, 12.w, 32.w, 0),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.pop())),
              SizedBox(height: 30.h),
              ClipOval(
                  child: Container(
                      width: 120.w,
                      height: 120.w,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.store,
                          size: 60.w, color: Colors.grey.shade600))),
              SizedBox(height: 24.h),
              Text(state.merchantName, style: theme.textTheme.bodyLarge),
              SizedBox(height: 40.h),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: '¥', style: TextStyle(fontSize: 48.sp)),
                    TextSpan(
                        text: state.paymentAmount.toStringAsFixed(2),
                        style: TextStyle(fontSize: 80.sp)),
                  ],
                ),
              ),
              SizedBox(height: 80.h),
              const ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined,
                      color: Colors.blue),
                  title: Text('账户余额'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16)),
              const ListTile(
                  leading: Icon(Icons.energy_savings_leaf, color: Colors.green),
                  title: Text('支付成功得绿色能量5g')),
              SizedBox(height: 40.h),
              VigaPaymentPrimaryButton(
                text: '确认付款',
                backgroundColor: theme.primaryColor,
                borderRadius: 12.r,
                onPressed: () {
                  context.read<VigaPaymentCubit>().moveToPasswordEntry();
                  context.pop();
                },
              ),
              SizedBox(height: 20.h),
              Text("本服务由Vigaviga(中国)网络技术有限公司提供",
                  style:
                      theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20.h),
            ],
          ),
        );
      },
    );
  }
}
