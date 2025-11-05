import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/store/viga_payment_cubit.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';

class VigaAliPaySuccessPage extends StatelessWidget {
  const VigaAliPaySuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.read<VigaPaymentCubit>().state;

    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          onSurface: Colors.white,
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: Color.fromARGB(255, 110, 62, 145),
        ),
      ),
      child: Scaffold(
        appBar: VigaAppBar(
          title: "",
          leading: SizedBox(),
          actions: [
            VigaAppBarActionTextButton(
              onTap: () {
                context.go('/payment_demo');
              },
              title: '完成',
            ),
          ],
        ),
        body: BlocBuilder<VigaSystemCubit, SystemState>(
          builder: (context, systemState) {
            // 建议只使用一个 SingleChildScrollView
            return SingleChildScrollView(
              // 保留一个 SingleChildScrollView
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Container(
                // 移除 minHeight 约束，让 SingleChildScrollView 决定高度
                // constraints: BoxConstraints(
                //   minHeight: MediaQuery.of(context).size.height -
                //       systemState.appbarHeight -
                //       systemState.statusHeight,
                // ),
                color: theme.colorScheme.surfaceContainer,
                child: Column(
                  // <--- 这个 Column
                  children: [
                    Container(
                      // 顶部成功的蓝色区域
                      width: double.infinity,
                      color: theme.primaryColor, // 统一使用主题的 primaryColor
                      child: Column(
                        children: [
                          SizedBox(height: 60.w),
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 120.w,
                          ),
                          SizedBox(height: 30.w),
                          Text(
                            "支付成功",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.w),
                          Text(
                            "¥${state.paymentAmount.toStringAsFixed(2)}",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 80.w),
                        ],
                      ),
                    ),
                    // <--- 移除 Expanded
                    Container(
                      // 之前 Expanded 包裹的 Container
                      color: const Color(0xFFF5F5F5), // 使用固定颜色或者主题颜色
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
