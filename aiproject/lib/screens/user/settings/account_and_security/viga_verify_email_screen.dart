import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';

class VigaVerifyEmailScreen extends StatelessWidget {
  const VigaVerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 直接在Scaffold上设置backgroundColor属性
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const VigaAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  // 使用Expanded让主要内容居中
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 邮箱图标
                        const Icon(
                          Icons.mail_outline,
                          size: 60,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 24),

                        // 标题 "验证邮箱"
                        const Text(
                          '验证邮箱',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 描述文本
                        const Text(
                          '已发送邮件至 1159231996@qq.com，可前往邮箱查收并通过邮件验证。5分钟后验证邮件将失效。',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5, // 调整行高以获得更好的可读性
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 底部操作按钮
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0), // 距离底部的间距
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // 在此处添加"修改邮箱"的逻辑
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                          child: const Text(
                            '修改邮箱',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 16),
                          ),
                        ),
                        // 分隔符
                        const Text(
                          ' | ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            // 在此处添加"重新发送验证邮件"的逻辑
                          },
                          child: const Text(
                            '重新发送验证邮件',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
