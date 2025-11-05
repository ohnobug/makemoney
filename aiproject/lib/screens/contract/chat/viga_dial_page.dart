import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/contract/chat/widgets/viga_dot_loading_text.dart';
import 'package:vigaviga/themes.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaDialPage extends StatefulWidget {
  const VigaDialPage({
    super.key,
  });

  @override
  State<VigaDialPage> createState() => _VigaDial();
}

class _VigaDial extends State<VigaDialPage> {
  // 音频播放器
  late dynamic _voiceController;

  // 画中画
  late dynamic floating;

  // 用于保存原来的状态栏样式
  SystemUiOverlayStyle? originalStatusBarStyle;

  @override
  void initState() {
    super.initState();

    _voiceController =
        VideoPlayerController.asset(assetPath("sounds/scan_success.mp3"))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _voiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
        primary: false,
        appBar: null,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Container(
            width: 750.w,
            color: AppColors.neutralNearBlack2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Theme(
                  data: theme.copyWith(
                    appBarTheme: theme.appBarTheme.copyWith(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  child: VigaAppBar(
                    title: "",
                    leading: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Icon(
                          const IconData(0xe68f, fontFamily: 'Iconfont'),
                          color: AppColors.neutralWhite,
                          size: 36.w,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 297.w,
                ),

                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            16.0.w), // Adjust the radius as needed
                        child: VigaAppNetworkImage(
                          imageUrl: "${systemState.cdnBase}/avatar/chat_55.jpg",
                          width: 183.0.w,
                          height: 183.0.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      Text(
                        "罗绮娴",
                        style: TextStyle(
                            color: AppColors.neutralWhite, fontSize: 40.w),
                      ),
                    ],
                  ),
                ),

                // 含Loading的文字
                VigaDotLoadingText(),

                SizedBox(
                  height: 115.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 140.w,
                      height: 242.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 麦克风开关按钮
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(140.w),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              const IconData(
                                0xec8c,
                                fontFamily: 'Iconfont',
                              ),
                              color: theme.colorScheme.onSurface,
                              size: 64.w,
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            l10n.microphoneOn,
                            style: TextStyle(
                                color: AppColors.neutralWhite, fontSize: 25.w),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 77.w,
                    ),

                    // 取消按钮
                    SizedBox(
                      width: 140.w,
                      height: 242.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // 播放音乐
                              // if (!Platform.isWindows) {
                              await _voiceController.play();
                              // }

                              // 等待一会再跳转
                              await Future.delayed(Duration(milliseconds: 600),
                                  () {
                                if (context.mounted) {
                                  context.pop();
                                }
                              });
                            },
                            child: Container(
                              width: 140.w,
                              height: 140.w,
                              decoration: BoxDecoration(
                                color: AppColors.accentRedDark4,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(140.w),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe781,
                                  fontFamily: 'Iconfont',
                                ),
                                color: AppColors.neutralWhite,
                                size: 64.w,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            l10n.cancel,
                            style: TextStyle(
                                color: AppColors.neutralWhite, fontSize: 25.w),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 77.w,
                    ),

                    // 扬声器开关按钮
                    SizedBox(
                      width: 140.w,
                      height: 242.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              color: AppColors.neutralNearBlack5,
                              borderRadius: BorderRadius.all(
                                Radius.circular(140.w),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              const IconData(
                                0xe69c,
                                fontFamily: 'Iconfont',
                              ),
                              color: AppColors.neutralWhite,
                              size: 64.w,
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            l10n.speakerOff,
                            style: TextStyle(
                                color: AppColors.neutralWhite, fontSize: 25.w),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
