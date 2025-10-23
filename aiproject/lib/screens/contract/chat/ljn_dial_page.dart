import 'dart:async';
import 'dart:io';
import 'package:vigaviga/widgets/ljn_app_network_image.dart';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_dial_floating_widget.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_dot_loading_text.dart';
import 'package:vigaviga/themes.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNDialPage extends StatefulWidget {
  const LJNDialPage({
    super.key,
  });

  @override
  State<LJNDialPage> createState() => _LJNDial();
}

class _LJNDial extends State<LJNDialPage> {
  // 音频播放器
  late dynamic _voiceController;

  // 画中画
  late dynamic floating;

  // 用于保存原来的状态栏样式
  SystemUiOverlayStyle? originalStatusBarStyle;

  @override
  void initState() {
    super.initState();

    // 实例化播放器
    // if (!Platform.isWindows) {
    floating = Floating();

    _voiceController =
        VideoPlayerController.asset(assetPath("sounds/scan_success.mp3"))
          ..initialize().then((_) {
            setState(() {});
          });

    PictureInPicture.updatePiPParams(
      pipParams: PiPParams(
        pipWindowHeight: 400.w,
        pipWindowWidth: 400.w,
        bottomSpace: 5,
        leftSpace: 5,
        rightSpace: 5,
        topSpace: 5,
        maxSize: Size(400, 400),
        minSize: Size(200, 200),
        movable: true,
        resizable: false,
        initialCorner: PIPViewCorner.bottomRight,
      ),
    );
    // }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
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

    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      Widget mainWidget = Scaffold(
        primary: false,
        appBar: null,
        body: Container(
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
                child: LJNAppBar(
                  title: "",
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();

                      // if (!Platform.isWindows) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        // 应用级画中画
                        PictureInPicture.startPiP(
                          pipWidget: PiPWidget(
                            pipBorderRadius: 5,
                            elevation: 10,
                            onPiPClose: () {},
                            child: LJNDialFloatingWidget(
                              systemState: systemState,
                            ),
                          ),
                        );
                      });
                      // }

                      // 进入系统级画中画
                      // _enablePip(context);
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
                      child: LJNAppNetworkImage(
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
              LJNDotLoadingText(),

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
                                Navigator.of(context).pop();
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
      );

      return Platform.isWindows
          ? mainWidget
          : PiPSwitcher(
              childWhenEnabled: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
                child: Text("hello world"),
              ),
              childWhenDisabled: mainWidget,
            );
    });
  }
}
