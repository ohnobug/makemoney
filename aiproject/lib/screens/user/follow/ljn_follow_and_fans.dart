import 'package:flutter/material.dart';
import 'ljn_follow_page.dart';

/* void main() {
  runApp(const MyApp());
} */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 设置全局背景色为白色，以匹配UI设计
        scaffoldBackgroundColor: Colors.white,
        // 设置AppBar的默认背景色为白色，并移除阴影
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const LJNFollowPage(),
    );
  }
}