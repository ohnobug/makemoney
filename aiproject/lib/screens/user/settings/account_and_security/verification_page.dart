import 'package:flutter/material.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  // TextEditingController 来控制 TextField 的文本
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 添加监听器，以便在文本变化时重建UI
    // 这对于控制按钮的启用/禁用状态至关重要
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 销毁控制器以释放资源
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const LJNAppBar(),
      body: SafeArea(
        // 使用 Stack 布局来叠加后退按钮
        child: Stack(
          children: [
            // 主要内容区域
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0.w),
              child: Column(
                // 主轴（垂直）居中
                mainAxisAlignment: MainAxisAlignment.center,
                // 交叉轴（水平）拉伸，使子组件可以撑满宽度
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 安全验证标题
                  Text(
                    '安全验证',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 48.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32.w), // 增加垂直间距

                  // 提示文字
                  Text(
                    '填写当前Vigaviga登录密码, 验证本人身份。',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 32.w,
                    ),
                  ),
                  SizedBox(height: 60.w), // 增加垂直间距

                  // Vigaviga密码输入框
                  TextField(
                    controller: _passwordController,
                    // autofocus: true 使其默认获取焦点并弹出键盘
                    autofocus: true,
                    // obscureText: true 使输入的文本显示为点（密码模式）
                    obscureText: true,
                    decoration: InputDecoration(
                      // 标签文字
                      labelText: 'Vigaviga密码',
                      // 标签文字样式
                      labelStyle: const TextStyle(color: Colors.grey),
                      // 底部边框
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 224, 224, 224)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      // 后缀图标（清除按钮）
                      suffixIcon: _passwordController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // 点击时清空文本
                                _passwordController.clear();
                              },
                            )
                          : null, // 如果没有文本则不显示图标
                    ),
                  ),
                  SizedBox(height: 20.w), // 增加垂直间距

                  // 忘记密码 - 点击范围仅限文字
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        // 在这里处理“忘记密码”的点击事件
                        print('“忘记密码”被点击了');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('“忘记密码”被点击了')),
                        );
                      },
                      child: Text(
                        '忘记密码',
                        style: TextStyle(
                          color: Color.fromARGB(255, 87, 107, 149),
                          fontSize: 28.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60.w), // 与按钮之间的间距

                  // 验证按钮
                  SizedBox(
                    height: 100.w, // 设置按钮高度
                    child: ElevatedButton(
                      // 根据输入框是否有内容来决定 onPressed 的值
                      // 为 null 时按钮会自动禁用
                      onPressed: _passwordController.text.isNotEmpty
                          ? () {
                              Navigator.pushNamed(context, '/change_account');
                              // 在这里处理验证逻辑
                              print('验证密码: ${_passwordController.text}');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        // 按钮正常状态下的背景颜色
                        backgroundColor: theme.colorScheme.primary,
                        // 按钮禁用状态下的背景颜色
                        disabledBackgroundColor:
                            theme.colorScheme.primaryContainer,
                        // 禁用按钮阴影
                        elevation: 0,
                        // 按钮形状
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r), // 圆角
                        ),
                      ),
                      child: Text(
                        '验证',
                        style: TextStyle(
                          fontSize: 36.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // 为键盘弹出预留一些空间，避免遮挡
                  SizedBox(height: 80.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
