import 'package:flutter/material.dart';

class LJNTestPage extends StatefulWidget {
  const LJNTestPage({super.key});

  @override
  State<LJNTestPage> createState() => _LJNTestPageState();
}

class _LJNTestPageState extends State<LJNTestPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // 判断用户滑动的方向
    if (details.velocity.pixelsPerSecond.dx < 0) {
      // 向左滑动
      _currentPage = (_currentPage + 1).clamp(0, 2); // 假设有3页
    } else if (details.velocity.pixelsPerSecond.dx > 0) {
      // 向右滑动
      _currentPage = (_currentPage - 1).clamp(0, 2); // 假设有3页
    }
    // 以2/3的位置停靠
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PageView 示例')),
      body: GestureDetector(
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            _buildPage(Colors.red, '页面 1'),
            _buildPage(Colors.green, '页面 2'),
            _buildPage(Colors.blue, '页面 3'),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(Color color, String title) {
    return Container(
      color: color,
      child: Center(
          child:
              Text(title, style: TextStyle(fontSize: 24, color: Colors.white))),
    );
  }
}
