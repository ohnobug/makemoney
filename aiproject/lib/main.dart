import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigaviga/store/viga_popup_cubit.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/app.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/store/viga_payment_cubit.dart';

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

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => VigaSystemCubit()),
    BlocProvider(create: (_) => VigaUserCubit()),
    BlocProvider(create: (_) => VigaPopupCubit()),
    BlocProvider(create: (_) => VigaPaymentCubit()),
  ], child: const App()));
}
