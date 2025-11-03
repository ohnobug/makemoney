import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';

class VigaModifyEmailPage extends StatefulWidget {
  const VigaModifyEmailPage({super.key});

  @override
  State<VigaModifyEmailPage> createState() => _ModifyEmailPageState();
}

class _ModifyEmailPageState extends State<VigaModifyEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  // 新增一个状态变量，用于跟踪邮箱格式是否有效
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    // 添加监听器，以便在文本变化时执行校验
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    // 页面销毁时，移除监听器并释放控制器资源
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }

  // 邮箱校验逻辑
  void _validateEmail() {
    final email = _emailController.text;
    // 使用正则表达式判断邮箱格式是否正确
    // 这是一个常用的邮箱格式正则表达式
    final bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    // 如果校验结果与当前状态不同，则更新状态以触发UI刷新
    if (isValid != _isEmailValid) {
      setState(() {
        _isEmailValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const VigaAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Center(
              child: Text(
                '修改邮箱',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                const Text(
                  '邮箱',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    autofocus: true,
                    cursorColor: Colors.green,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '请输入邮箱地址',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE0E0E0),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50, // 新增此行
              child: ElevatedButton(
                // 核心改动：根据 _isEmailValid 的值来决定按钮是否可点击
                // 如果为 true，onPressed 是一个函数，按钮激活
                // 如果为 false，onPressed 是 null，按钮禁用
                onPressed: _isEmailValid
                    ? () {
                        // 在这里处理点击事件，例如提交数据
                        logger.info('下一步，邮箱是: ${_emailController.text}');
                        context.push('/settings/verify_email_screen');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  // 设置激活状态下的背景色
                  backgroundColor: Colors.blue,
                  // 设置禁用状态下的背景色
                  disabledBackgroundColor: const Color(0xFFF5F5F5),
                  // 设置激活状态下的文字颜色
                  foregroundColor: Colors.white,
                  // 设置禁用状态下的文字颜色
                  disabledForegroundColor: Colors.grey,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '下一步',
                  style: TextStyle(
                    fontSize: 18,
                    // 文字颜色会根据按钮状态自动从 foregroundColor 和 disabledForegroundColor 中选择
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
