import 'package:flutter/material.dart';

// 主题数据
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  tabBarTheme: const TabBarTheme(

  ),
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  primaryColor: Colors.black,
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primaryContainer: Colors.black,
    primary: Colors.white,
    secondary: Colors.grey,
  ),
  primaryColor: Colors.white,
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
