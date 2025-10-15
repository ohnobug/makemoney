import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/ljn_payment_launcher.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';

class LJNPaymentDemoPage extends StatelessWidget {
  const LJNPaymentDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LJNAppBar(
        title: '支付模块演示',
      ),
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '支付模块演示',
              style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.w),
            Text(
              '这是一个完整的支付流程演示页面，展示了如何集成和使用支付模块。',
              style: TextStyle(fontSize: 28.sp, color: Colors.grey),
            ),
            SizedBox(height: 120.w),
            _buildPaymentCard(
              context,
              title: '默认支付流程',
              description: '使用默认金额(¥24.80)和商家名称',
              onTap: () => LJNPaymentLauncher.quickStartPayment(context),
            ),
            SizedBox(height: 32.w),
            _buildPaymentCard(
              context,
              title: '自定义金额支付',
              description: '支付金额: ¥99.99',
              onTap: () => LJNPaymentLauncher.startPaymentFlow(
                context,
                amount: 99.99,
                merchantName: '高级会员服务',
              ),
            ),
            SizedBox(height: 32.w),
            _buildPaymentCard(
              context,
              title: '大额支付测试',
              description: '支付金额: ¥888.88',
              onTap: () => LJNPaymentLauncher.startPaymentFlow(
                context,
                amount: 888.88,
                merchantName: '奢侈品专柜',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.payment, color: Colors.blue, size: 40.w),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.w),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 24.w,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 24.w, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
