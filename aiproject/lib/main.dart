import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
import 'package:spicychat/app.dart';
import 'package:spicychat/tools/ljn_file_server.dart';
import 'package:spicychat/tools/ljn_logger.dart';

Future<void> _windowsInitApp() async {
  await windowManager.ensureInitialized();

  // 设置窗口的大小
  await windowManager.setSize(
    Size(375, 812),
  );

  // 获取窗口的大小
  final windowSize = await windowManager.getSize();

  // 获取屏幕的分辨率
  final screenSize =
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

  // 计算居中的位置
  final centerX = (screenSize.width - windowSize.width) / 2;
  final centerY = (screenSize.height - windowSize.height) / 2;

  // 设置窗口位置
  await windowManager.setPosition(
    Offset(centerX, centerY),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  if (Platform.isWindows) {
    await _windowsInitApp();
  }

  // 禁止横屏
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp, // 竖屏 Portrait 模式
        DeviceOrientation.portraitDown,
        // DeviceOrientation.landscapeLeft, // 横屏 Landscape 模式
        // DeviceOrientation.landscapeRight,
      ],
    );
  }

  setupLogger();

  logger.info('Application is starting...');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ),
  );

  startWebServer();

  runApp(
    const App(),
  );
}
