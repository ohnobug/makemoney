
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedVisibility = '公开: 所有人可见'; // 初始选中的可见性

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发布作品'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '当前可见性设置：$_selectedVisibility',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showVisibilityBottomSheet(context);
              },
              child: const Text('打开可见性设置'),
            ),
          ],
        ),
      ),
    );
  }

  void _showVisibilityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 允许内容超出屏幕高度并滚动
      backgroundColor: Colors.transparent, // 背景透明，以便自定义圆角
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white, // 弹窗背景色
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 0), // 留出底部安全区域
          child: Column(
            mainAxisSize: MainAxisSize.min, // 内容决定高度
            children: [
              // 顶部的拖动指示器
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '以下可见权限设置只对发作品生效',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              _buildVisibilityOption(context, '公开: 所有人可见'),
              _buildVisibilityOption(context, '互相关注的人可见'),
              _buildVisibilityOption(context, '私密: 仅自己可见'),
              _buildComplexOption(context, '部分可见', Icons.chevron_right),
              _buildComplexOption(context, '不给谁看', Icons.chevron_right),
              SizedBox(height: MediaQuery.of(context).padding.bottom), // 底部安全区域
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisibilityOption(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedVisibility = title;
        });
        Navigator.pop(context); // 点击后关闭弹窗
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]!, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedVisibility == title ? Colors.red : Colors.black, // 根据选中状态改变颜色
                ),
              ),
            ),
            if (_selectedVisibility == title)
              const Icon(Icons.check, color: Colors.red), // 选中时显示对勾
          ],
        ),
      ),
    );
  }

  Widget _buildComplexOption(BuildContext context, String title, IconData? trailingIcon) {
    return InkWell(
      onTap: () {
        // 在这里处理“部分可见”或“不给谁看”的逻辑，可能导航到新页面或打开新的弹窗
        print('点击了 $title');
        // Navigator.pop(context); // 如果需要，点击后关闭弹窗
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]!, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}