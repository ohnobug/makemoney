import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/store/viga_payment_cubit.dart';
import 'viga_payment_primary_button.dart';

class VigaSelectPaymentSheet extends StatelessWidget {
  const VigaSelectPaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<VigaPaymentCubit, VigaPaymentState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  Text("选择支付方式",
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.pop()),
                ],
              ),
              SizedBox(height: 40.h),
              _buildMethodTile(
                context,
                icon: Icons.payment,
                title: 'Vigaviga',
                isSelected: state.selectedMethod == VigaPaymentMethod.alipay,
                onTap: () => context
                    .read<VigaPaymentCubit>()
                    .selectMethod(VigaPaymentMethod.alipay),
              ),
              Divider(height: 1.h, color: theme.dividerColor),
              _buildMethodTile(
                context,
                icon: Icons.credit_card,
                title: '花呗分期',
                isSelected: state.selectedMethod == VigaPaymentMethod.huabei,
                onTap: () => context
                    .read<VigaPaymentCubit>()
                    .selectMethod(VigaPaymentMethod.huabei),
              ),
              SizedBox(height: 60.h),
              VigaPaymentPrimaryButton(
                text: '确认',
                backgroundColor: const Color(0xFFE54335),
                onPressed: () {
                  context.read<VigaPaymentCubit>().moveToConfirm();
                  context.pop();
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMethodTile(BuildContext context,
      {required IconData icon,
      required String title,
      required bool isSelected,
      required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Row(
          children: [
            Icon(icon, color: theme.primaryColor, size: 48.w),
            SizedBox(width: 20.w),
            Expanded(child: Text(title, style: theme.textTheme.bodyLarge)),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? theme.primaryColor : Colors.grey,
              size: 40.w,
            ),
          ],
        ),
      ),
    );
  }
}
