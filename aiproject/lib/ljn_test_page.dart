import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LJNTestPage extends StatefulWidget {
  const LJNTestPage({super.key});

  @override
  State<LJNTestPage> createState() => _LJNTestPageState();
}

class _LJNTestPageState extends State<LJNTestPage> {
  // 为每个输入框创建一个 FocusNode
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  @override
  void dispose() {
    // 记得在页面销毁时释放 FocusNode
    _nodeText1.dispose();
    _nodeText2.dispose();
    _nodeText3.dispose();
    super.dispose();
  }

  // 配置 keyboard_actions
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      // 键盘操作的平台
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      // 工具栏颜色
      keyboardBarColor: Colors.grey[200],
      // 是否显示“下一个”按钮
      nextFocus: true,
      // 操作列表
      actions: [
        // 第一个输入框的配置
        KeyboardActionsItem(
          focusNode: _nodeText1,
          // 你可以在这里添加自定义的工具栏按钮
        ),
        // 第二个输入框的配置
        KeyboardActionsItem(
          focusNode: _nodeText2,
          // 自定义关闭按钮
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close),
                ),
              );
            }
          ],
        ),
        // 第三个输入框的配置
        KeyboardActionsItem(
          focusNode: _nodeText3,
          // 点击“完成”按钮时的自定义操作
          onTapAction: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("自定义操作"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("好的"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keyboard Actions Demo'),
      ),
      // 使用 KeyboardActions 组件包裹你的表单
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.number,
                  focusNode: _nodeText1,
                  decoration: const InputDecoration(
                    hintText: "数字输入框",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.text,
                  focusNode: _nodeText2,
                  decoration: const InputDecoration(
                    hintText: "带自定义关闭按钮的输入框",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  focusNode: _nodeText3,
                  decoration: const InputDecoration(
                    hintText: "带自定义操作的数字输入框",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
