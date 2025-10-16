import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigaviga/store/ljn_popup_cubit.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/app.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/store/ljn_payment_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await ScreenUtil.ensureScreenSize();

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

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => LJNSystemCubit()),
    BlocProvider(create: (_) => LJNUserCubit()),
    BlocProvider(create: (_) => LJNPopupCubit()),
    BlocProvider(create: (_) => LJNPaymentCubit()),
  ], child: const App()));
}
