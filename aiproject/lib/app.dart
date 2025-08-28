import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_image_draggable_box.dart';
import 'package:spicychat/screens/components/ljn_video_draggable_box.dart';
import 'package:spicychat/routing/app_router.dart';
import 'package:spicychat/store/ljn_popup_cubit.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LJNSystemCubit()),
        BlocProvider(create: (_) => LJNUserCubit()),
        BlocProvider(create: (_) => LJNPopupCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(750, 1624),
        ensureScreenSize: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return PiPMaterialApp(
            navigatorKey: context.read<LJNSystemCubit>().state.navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return Localizations.override(
                context: context,
                locale: const Locale('en'),
                child: Builder(
                  builder: (context) {
                    return Stack(
                      children: [
                        child!,
                        // Video/Image viewer
                        BlocBuilder<LJNPopupCubit, PopupState>(
                          builder: (context, popupState) {
                            if (popupState.showFullScreenVideo) {
                              return LJNVideoDraggableBox(
                                openBoxSize: popupState.openBoxSize,
                                openPosition: popupState.openPosition,
                                videoPath: popupState.sourcePath,
                                onClose: () {},
                              );
                            }
                            if (popupState.showFullScreenImage) {
                              return LJNImaeDraggableBox(
                                openBoxSize: popupState.openBoxSize,
                                openPosition: popupState.openPosition,
                                imagePath: popupState.sourcePath,
                                onClose: () {},
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            },
            // 使用优化后的路由管理器
            onGenerateRoute: AppRouter.onGenerateRoute,
            theme: context.read<LJNSystemCubit>().state.themeData,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
              },
            ),
          );
        },
      ),
    );
  }
}
