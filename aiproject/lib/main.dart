import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/store/ljn_popup_cubit.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:window_manager/window_manager.dart';
import 'package:vigaviga/app.dart';
import 'package:vigaviga/tools/ljn_file_server.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';

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

  // 禁止横屏
  if (!kIsWeb) {
    if (Platform.isWindows) {
      await _windowsInitApp();
    }

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
      statusBarColor: AppColors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ),
  );

  startWebServer();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => LJNSystemCubit()),
    BlocProvider(create: (_) => LJNUserCubit()),
    BlocProvider(create: (_) => LJNPopupCubit()),
  ], child: const App()));
}
