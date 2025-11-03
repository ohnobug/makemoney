import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_image_draggable_box.dart';
import 'package:vigaviga/screens/contract/chat/widgets/viga_video_draggable_box.dart';
import 'package:vigaviga/routing/app_router.dart';
import 'package:vigaviga/store/viga_popup_cubit.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState(); // 遵循命名约定：_AppState
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

    var userCubit = context.read<VigaUserCubit>();
    userCubit.updateName('李俊杰');
    userCubit.updateAccount('TheMonsterClub');
    userCubit.updatePhone('+8618825130917');
    userCubit.updateWalletBalance(2056.98);
    userCubit.updateWalletFoundationBalance(100.85);
    userCubit.updateAvatar("https://cdn.vigaviga.com/avatar/my.jpg");
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
          return MaterialApp(
            // 1. 设置浅色主题
            // 将您定义好的 lightTheme 赋值给 theme 属性
            theme: lightTheme,

            // 2. 设置深色主题
            // 将您定义好的 darkTheme 赋值给 darkTheme 属性
            darkTheme: darkTheme,

            // 3. 设置主题模式
            // ThemeMode.system 会根据用户手机的系统设置自动切换浅色或深色模式
            // 您也可以设置为 ThemeMode.light 或 ThemeMode.dark 来强制使用特定主题
            themeMode: systemState.themeMode,

            // navigatorKey 仍然使用 read，因为它通常是初始化后不变的
            navigatorKey: systemState.navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: systemState.currentLocale,
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
                              // 当关闭时，通知 Cubit 隐藏视频
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
            onGenerateRoute: AppRouter.onGenerateRoute,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
              },
            ),
          );
        });
      },
    );
  }
}
