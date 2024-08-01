import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FunctionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  FunctionButtonState createState() => FunctionButtonState();
}

class FunctionButtonState extends State<FunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isPressed ? Colors.grey[200] : Colors.transparent, // 按下时背景色
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
          // border: Border.all(
          //   color: Colors.blue, // 边框颜色
          //   width: 1.5,
          // ),
        ),
        // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 使按钮大小适应内容
            children: [
              Icon(widget.icon, size: 30, color: Colors.blue), // 图标颜色
              const SizedBox(height: 4), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 9,
                    overflow: TextOverflow.ellipsis), // 标题颜色
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FunctionButtonsSection 组件
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;

  const FunctionButtonsSection({
    super.key,
    required this.title,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8).w,
        decoration: BoxDecoration(
        color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
        ),
        padding: const EdgeInsets.all(8).w,
        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),

            // 使用 SizedBox 控制 GridView 的大小
            SizedBox(
              // height: 200, // 根据实际需要调整高度
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 每行显示4个子组件
                  crossAxisSpacing: 10, // 列间距
                  mainAxisSpacing: 5, // 行间距
                  childAspectRatio: (1 / 0.8),
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return Center(child: buttons[index]);
                },
                shrinkWrap: true, // 根据内容调整 GridView 大小
                physics: const NeverScrollableScrollPhysics(), // 禁用滚动
              ),
            ),
          ],
        ));
  }
}
