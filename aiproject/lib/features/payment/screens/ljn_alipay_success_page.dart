import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_payment_cubit.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

class LJNAliPaySuccessPage extends StatelessWidget {
  const LJNAliPaySuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.read<LJNPaymentCubit>().state;

    return Theme(
      data: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: Color.fromARGB(255, 110, 62, 145),
        ),
      ),
      child: Scaffold(
        appBar: LJNAppBar(
          title: "",
          leading: SizedBox(),
          actions: [
            LJNAppBarActionTextButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: '完成',
            ),
          ],
        ),
        body: ColoredBox(
          color: theme.colorScheme.surfaceContainer,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: theme.primaryColor,
                    child: Column(
                      children: [
                        SizedBox(height: 60.w),
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 120.w,
                        ),
                        SizedBox(height: 30.w),
                        Text("支付成功",
                            style: theme.textTheme.headlineMedium
                                ?.copyWith(color: Colors.white)),
                        SizedBox(height: 20.w),
                        Text("¥${state.paymentAmount.toStringAsFixed(2)}",
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(color: Colors.white)),
                        SizedBox(height: 80.w),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFFF5F5F5),
                      padding: EdgeInsets.all(32.w),
                      child: Container(
                        padding: EdgeInsets.all(32.w),
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildInfoRow(context, "收款方", state.merchantName),
                            Divider(height: 40.h),
                            _buildInfoRow(context, "交易方式", "余额"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey)),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
