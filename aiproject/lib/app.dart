import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_image_draggable_box.dart';
import 'package:vigaviga/screens/contract/chat/widgets/viga_video_draggable_box.dart';
// 确保导入的是您新创建的、包含 go_router 实例的文件
import 'package:vigaviga/routing/app_router.dart';
import 'package:vigaviga/store/viga_popup_cubit.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();

    var systemCubit = context.read<VigaSystemCubit>();
    systemCubit.updateCdnBase('https://cdn.vigaviga.com');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final size = MediaQuery.of(context).size;
        systemCubit.updateScreenSize(size);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1624),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<VigaSystemCubit, SystemState>(
            builder: (context, systemState) {
          //
          // ======================[ 代码修改区域 ]======================
          //
          return MaterialApp.router(
            // 1. 构造函数已从 MaterialApp() 更改为 MaterialApp.router()

            // --- 以下是您原有的、保持不变的配置 ---
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: systemState.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: systemState.currentLocale,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
              },
            ),

            // 2. 核心改动：使用 routerConfig 传入 go_router 实例
            routerConfig: appRouter,

            // 您的 builder 逻辑保持不变，用于实现全局浮层
            builder: (context, child) {
              return Builder(
                builder: (context) {
                  return Stack(
                    children: [
                      child!,
                      // Video/Image viewer
                      BlocBuilder<VigaPopupCubit, PopupState>(
                        builder: (context, popupState) {
                          if (popupState.showFullScreenVideo) {
                            return VigaVideoDraggableBox(
                              openBoxSize: popupState.openBoxSize,
                              openPosition: popupState.openPosition,
                              videoPath: popupState.sourcePath!,
                              onClose: () {
                                context
                                    .read<VigaPopupCubit>()
                                    .updateShowFullScreenVideo(false);
                              },
                            );
                          }
                          if (popupState.showFullScreenImage) {
                            return VigaImaeDraggableBox(
                              openBoxSize: popupState.openBoxSize,
                              openPosition: popupState.openPosition,
                              imagePath: popupState.sourcePath!,
                              onClose: () {
                                context
                                    .read<VigaPopupCubit>()
                                    .updateShowFullScreenImage(false);
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
          // ==========================================================
        });
      },
    );
  }
}
