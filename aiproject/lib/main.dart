import 'dart:io';
import 'dart:ui';
import 'package:jiaoyishuoflutter3/contract/ljn_contact_group.dart';
import 'package:jiaoyishuoflutter3/contract/ljn_contact_tag_group.dart';
import 'package:jiaoyishuoflutter3/contract/ljn_contact_tags.dart';
import 'package:jiaoyishuoflutter3/contract/ljn_official_accounts.dart';
import 'package:jiaoyishuoflutter3/contract/ljn_search_friend.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_moments_cover_setting.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_set_friend_tags.dart';
import 'package:jiaoyishuoflutter3/user/ljn_camera_view.dart';
import 'package:jiaoyishuoflutter3/components/ljn_image_draggable_box.dart';
import 'package:jiaoyishuoflutter3/components/ljn_video_draggable_box.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_information.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_more_info.dart';
import 'package:jiaoyishuoflutter3/store/ljn_popup_cubit.dart';
import 'package:jiaoyishuoflutter3/user/ljn_user.dart';
import 'package:window_manager/window_manager.dart';
import 'tools/ljn_logger.dart';
import 'dart:isolate';
import 'contract/ljn_contact.dart';
import 'tools/ljn_tools.dart';
import 'settings/ljn_account_info.dart';
import 'components/ljn_custom_physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_add_friends.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_care_mode.dart';
import 'package:jiaoyishuoflutter3/chat/ljn_chat.dart';
import 'package:jiaoyishuoflutter3/user/ljn_collection_and_payment.dart';
import 'package:jiaoyishuoflutter3/chat/ljn_dial.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_discovery.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_data_setting.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_message_record.dart';
import 'package:jiaoyishuoflutter3/user/ljn_user_more_info.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_permissions.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_friend_moments.dart';
import 'package:jiaoyishuoflutter3/contract/ljn_friends_who_only_chat.dart';
import 'package:jiaoyishuoflutter3/group/ljn_group_message_record.dart';
import 'package:jiaoyishuoflutter3/group/ljn_group_chat.dart';
import 'package:jiaoyishuoflutter3/home/ljn_home.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_ins.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_miniprogram_list.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_miniprogram.dart';
import 'package:jiaoyishuoflutter3/contract/ljn_new_friends.dart';
import 'package:jiaoyishuoflutter3/user/ljn_services_manager.dart';
import 'package:jiaoyishuoflutter3/friend/ljn_set_notes_and_labels.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_about.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_bill_details.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_change_details.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_chat_setting.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_common_setting.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_device_detail.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_emergency_contact.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_friend_permission.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_logged_devices.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_more_secure_setting.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_new_message_notification.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_account_and_secure.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_bind_new_phone_number.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_change_account.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_forgot_password.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_input_verify_code.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_personal_info_and_permission.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_personal_info_collection_checklist.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_phone_contact.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_phone_number.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_set_password.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_setting.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_verify_phone.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_sound_lock.dart';
import 'package:jiaoyishuoflutter3/settings/ljn_teenage_mode.dart';
import 'package:jiaoyishuoflutter3/user/ljn_pocketmoney.dart';
import 'package:jiaoyishuoflutter3/chat/ljn_friend_profile.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_qrcode_scanner.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_search.dart';
import 'package:jiaoyishuoflutter3/user/ljn_services.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/ljn_user_cubit.dart';
import 'package:jiaoyishuoflutter3/test.dart';
import 'package:jiaoyishuoflutter3/discovery/ljn_tiktik.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_file_server.dart';
import 'package:jiaoyishuoflutter3/user/ljn_userinfo.dart';
import 'package:jiaoyishuoflutter3/chat/ljn_video_call.dart';
import 'package:jiaoyishuoflutter3/videoplayer.dart';
import 'package:jiaoyishuoflutter3/user/ljn_wallet.dart';

// 定义一个类来封装传递给 Isolate 的多个参数
class FileServerParams {
  final SendPort sendPort;
  // final String directoryPath;
  final RootIsolateToken rootIsolateToken;
  final int port;

  FileServerParams({
    required this.sendPort,
    required this.rootIsolateToken,
    required this.port,
  });
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

  // bool _defaultOnNavigationNotification(NavigationNotification _) {
  //   switch (WidgetsBinding.instance.lifecycleState) {
  //     case null:
  //     case AppLifecycleState.detached:
  //     case AppLifecycleState.inactive:
  //       return true;
  //     case AppLifecycleState.resumed:
  //     case AppLifecycleState.hidden:
  //     case AppLifecycleState.paused:
  //       SystemNavigator.setFrameworkHandlesBack(true);
  //       return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LJNSystemCubit(),
        ),
        BlocProvider(
          create: (_) => LJNUserCubit(),
        ),
        BlocProvider(
          create: (_) => LJNPopupCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(750, 1624),
        ensureScreenSize: true,
        minTextAdapt: true,
        splitScreenMode: true,
        enableScaleWH: () => true,
        enableScaleText: () => true,
        builder: (context, child) {
          return PiPMaterialApp(
            navigatorKey: context.read<LJNSystemCubit>().state.navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            // onNavigationNotification: _defaultOnNavigationNotification,
            // home: ,
            builder: (context, child) {
              return Stack(
                children: [
                  child!,
                  // 视频放大
                  BlocBuilder<LJNPopupCubit, PopupState>(
                    builder: (context, popupState) {
                      logger.info(
                          "qqqqqqqqq444444 ${popupState.showFullScreenVideo}");
                      return popupState.showFullScreenVideo == true
                          ? LJNVideoDraggableBox(
                              openBoxSize: popupState.openBoxSize,
                              openPosition: popupState.openPosition,
                              videoPath: popupState.sourcePath,
                              onClose: () {},
                            )
                          : popupState.showFullScreenImage == true
                              ? LJNImaeDraggableBox(
                                  imageUrl: popupState.sourcePath,
                                  // openBoxSize: popupState.openBoxSize,
                                  // openPosition: popupState.openPosition,
                                  // imagePath: popupState.sourcePath,
                                  // onClose: () {},
                                )
                              : Container();
                    },
                  )
                ],
              );
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/') {
                return pageRouteBuilderNotAnimation(
                  const CustomTabbar(),
                );
              } else if (settings.name == '/miniprogram_list') {
                return pageRouteBuilderAnimation(
                  const LJNMiniProgramList(),
                );
              } else if (settings.name == '/miniprogram' ||
                  settings.name!.startsWith('/miniprogram')) {
                logger.info("settings.name: ${settings.name}");

                Uri uri = Uri.parse(settings.name!);

                late String linkValue;
                linkValue = uri.queryParameters['link'] ?? "";

                return pageRouteBuilderAnimation(
                  LJNMiniProgram(link: linkValue),
                );
              } else if (settings.name == '/services') {
                return pageRouteBuilderAnimation(
                  const LJNServices(),
                );
              } else if (settings.name == '/chat') {
                var arguments = settings.arguments as Map<String, String>;
                String title = arguments['title'] as String;
                String icon = arguments['icon'] as String;
                return pageRouteBuilderAnimation(
                  LJNChat(title: title, icon: icon),
                );
              } else if (settings.name == '/group_chat') {
                var arguments = settings.arguments as Map<String, String>;
                String title = arguments['title'] as String;
                String icon = arguments['icon'] as String;
                return pageRouteBuilderAnimation(
                  LJNGroupChat(title: title, icon: icon),
                );
              } else if (settings.name == '/qrcode_scanner') {
                return pageRouteBuilderNotAnimation(
                  const LJNQRCodeScanner(),
                );
              } else if (settings.name == '/video_player') {
                return pageRouteBuilderAnimation(
                  const LJNVideoPage(),
                );
              } else if (settings.name == '/wallet') {
                return pageRouteBuilderAnimation(
                  const LJNWallet(),
                );
              } else if (settings.name == '/userinfo') {
                return pageRouteBuilderAnimation(
                  const LJNUserinfo(),
                );
              } else if (settings.name == '/friendmoments') {
                return pageRouteBuilderAnimation(
                  const LJNFriendmoments(),
                );
              } else if (settings.name == '/pocketmoney') {
                return pageRouteBuilderAnimation(
                  const LJNPocketMoney(),
                );
              } else if (settings.name == '/friendprofile') {
                var arguments =
                    settings.arguments as Map<String, String>? ?? {};

                String avatar = arguments['avatar'] ?? "";
                String name = arguments['name'] ?? "";
                String nickname = arguments['nickname'] ?? "";
                String account = arguments['account'] ?? "";

                return pageRouteBuilderAnimation(
                  LJNFriendProfile(
                    name: name,
                    nickname: nickname,
                    account: account,
                    avatar: avatar,
                  ),
                );
              } else if (settings.name == '/ins') {
                return pageRouteBuilderAnimation(
                  const LJNIns(),
                );
              } else if (settings.name == '/tiktik') {
                return pageRouteBuilderAnimation(
                  const LJNTiktik(),
                );
              } else if (settings.name == '/search') {
                return pageRouteBuilderAnimation(
                  const LJNSearch(),
                );
              } else if (settings.name == '/setting') {
                return pageRouteBuilderAnimation(
                  const LJNSettingPage(),
                );
              } else if (settings.name == '/account_and_secure') {
                return pageRouteBuilderAnimation(
                  const LJNAccountAndSecure(),
                );
              } else if (settings.name == '/accountinfo') {
                return pageRouteBuilderAnimation(
                  const LJNAccountInfo(),
                );
              } else if (settings.name == '/change_account') {
                return pageRouteBuilderAnimation(
                  const LJNChangeAccount(),
                );
              } else if (settings.name == '/forgot_password') {
                return pageRouteBuilderAnimation(
                  const LJNForgotPassword(),
                );
              } else if (settings.name == '/phone_number') {
                return pageRouteBuilderAnimation(
                  const LJNPhoneNumber(),
                );
              } else if (settings.name == '/phone_contact') {
                return pageRouteBuilderAnimation(
                  const LJNPhoneContact(),
                );
              } else if (settings.name == '/verify_phone') {
                return pageRouteBuilderAnimation(
                  const LJNVerifyPhone(),
                );
              } else if (settings.name == '/bind_new_phone_number') {
                return pageRouteBuilderAnimation(
                  const LJNBindNewPhoneNumber(),
                );
              } else if (settings.name == '/input_verify_code') {
                return pageRouteBuilderAnimation(
                  const LJNInputVerifyCode(),
                );
              } else if (settings.name == '/teenage_mode') {
                return pageRouteBuilderAnimation(
                  const LJNTeenageMode(),
                );
              } else if (settings.name == '/care_mode') {
                return pageRouteBuilderAnimation(
                  const LJNCareMode(),
                );
              } else if (settings.name == '/new_message_notification') {
                return pageRouteBuilderAnimation(
                  const LJNNewMessageNotification(),
                );
              } else if (settings.name == "/collection_and_payment") {
                return pageRouteBuilderAnimation(
                  const LJNCollectionAndPayment(),
                );
              } else if (settings.name == "/chat_setting") {
                return pageRouteBuilderAnimation(
                  const LJNChatSetting(),
                );
              } else if (settings.name == "/common_setting") {
                return pageRouteBuilderAnimation(
                  const LJNCommonSetting(),
                );
              } else if (settings.name == "/set_password") {
                return pageRouteBuilderAnimation(
                  const LJNSetPassword(),
                );
              } else if (settings.name == "/logged_devices") {
                return pageRouteBuilderAnimation(
                  const LJNLoggedDevices(),
                );
              } else if (settings.name == "/device_detail") {
                return pageRouteBuilderAnimation(
                  const LJNDeviceDetail(),
                );
              } else if (settings.name == "/emergency_contact") {
                return pageRouteBuilderAnimation(
                  const LJNEmergencyContact(),
                );
              } else if (settings.name == "/more_secure_setting") {
                return pageRouteBuilderAnimation(
                  const LJNMoreSecureSetting(),
                );
              } else if (settings.name == "/sound_lock") {
                return pageRouteBuilderAnimation(
                  const LJNSoundLock(),
                );
              } else if (settings.name == "/personinfo_and_permission") {
                return pageRouteBuilderAnimation(
                  const LJNPersonalinfoAndPermission(),
                );
              } else if (settings.name ==
                  "/personalinfo_collection_checklist") {
                return pageRouteBuilderAnimation(
                  const LJNPersonalInfoCollectionChecklist(),
                );
              } else if (settings.name == "/about") {
                return pageRouteBuilderAnimation(
                  const LJNAbout(),
                );
              } else if (settings.name == "/friend_permission") {
                return pageRouteBuilderAnimation(
                  const LJNFriendPermission(),
                );
              } else if (settings.name == "/change_details") {
                return pageRouteBuilderAnimation(
                  const LJNChangeDetails(),
                );
              } else if (settings.name == "/bill_details") {
                return pageRouteBuilderAnimation(
                  const LJNBillDetails(),
                );
              } else if (settings.name == "/friend_message_record") {
                return pageRouteBuilderAnimation(
                  const LJNFriendMessageRecord(),
                );
              } else if (settings.name == "/friend_data_setting") {
                return pageRouteBuilderAnimation(
                  const LJNFriendDataSetting(),
                );
              } else if (settings.name == "/user_more_info") {
                return pageRouteBuilderAnimation(
                  const LJNUserMoreInfo(),
                );
              } else if (settings.name == "/friend_more_info") {
                return pageRouteBuilderAnimation(
                  const LJNFriendMoreInfo(),
                );
              } else if (settings.name == "/add_friends") {
                return pageRouteBuilderAnimation(
                  const LJNAddFriends(),
                );
              } else if (settings.name == "/search_friend") {
                return pageRouteBuilderAnimation(
                  const LJNSearchFriend(),
                );
              } else if (settings.name == "/group_message_record") {
                return pageRouteBuilderAnimation(
                  const LJNGroupMessageRecord(),
                );
              } else if (settings.name == "/dial") {
                return pageRouteBuilderNotAnimation(
                  const LJNDial(),
                );
              } else if (settings.name == "/services_manager") {
                return pageRouteBuilderAnimation(
                  const LJNServicesManager(),
                );
              } else if (settings.name == "/friend_data_setting") {
                return pageRouteBuilderAnimation(
                  const LJNFriendDataSetting(),
                );
              } else if (settings.name == "/set_notes_and_labels") {
                return pageRouteBuilderAnimation(
                  const LJNSetNotesAndLabels(),
                );
              } else if (settings.name == "/friend_permissions") {
                return pageRouteBuilderAnimation(
                  const LJNFriendPermissions(),
                );
              } else if (settings.name == "/test") {
                return pageRouteBuilderAnimation(
                  const LJNTest(),
                );
              } else if (settings.name == "/video_call") {
                return pageRouteBuilderAnimation(
                  const LJNVideoCall(),
                );
              } else if (settings.name == "/friends_who_only_chat") {
                return pageRouteBuilderAnimation(
                  const LJNFriendsWhoOnlyChat(),
                );
              } else if (settings.name == "/new_friends") {
                return pageRouteBuilderAnimation(
                  const LJNNewFriends(),
                );
              } else if (settings.name == "/camera") {
                return pageRouteBuilderAnimation(
                  const LJNCameraView(),
                );
              } else if (settings.name == "/friend_information") {
                return pageRouteBuilderAnimation(
                  const LJNFriendInformation(),
                );
              } else if (settings.name == "/set_friend_tags") {
                return pageRouteBuilderAnimation(
                  const LJNSetFriendTags(),
                );
              } else if (settings.name == "/contact_tags") {
                return pageRouteBuilderAnimation(
                  const LJNContactTags(),
                );
              } else if (settings.name == "/contact_tag_group") {
                return pageRouteBuilderAnimation(
                  const LJNContactTagGroup(),
                );
              } else if (settings.name == "/official_accounts") {
                return pageRouteBuilderAnimation(
                  const LJNOfficialAccounts(),
                );
              } else if (settings.name == "/contact_group") {
                return pageRouteBuilderAnimation(
                  const LJNContactGroup(),
                );
              } else if (settings.name == "/friend_moments_cover_setting") {
                return pageRouteBuilderAnimation(
                  const LJNFriendMomentsCoverSetting(),
                );
              }

              return null;
            },
            theme: context.read<LJNSystemCubit>().state.themeData,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            ),
          );
        },
      ),
    );
  }

  // 带动效进入页面
  PageRouteBuilder pageRouteBuilderAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // 带动效进入页面
  PageRouteBuilder pageRouteBuilderNotAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

// 自定义Tabbar
class CustomTabbar extends StatefulWidget {
  const CustomTabbar({super.key});

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  int changeIcon = 0;
  late AppBar? appbar;
  double _appbarLeft = 0;
  bool setStatusHeight = false;
  bool showpopup = false;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: 4, vsync: this, animationDuration: Duration.zero);

    _tabController.animation!.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _appbarLeft = 0;
        });
      }

      if ((_tabController.animation!.value - 1).abs() < 0.2) {
        context.read<LJNSystemCubit>().updateContactazshow(true);
      } else {
        context.read<LJNSystemCubit>().updateContactazshow(false);
      }

      if (_tabController.animation!.value >= 2 &&
          _tabController.animation!.value <= 3) {
        setState(() {
          _appbarLeft = 750.w * (2 - _tabController.animation!.value);
        });
      }

      if (_tabController.animation!.value >= 0 &&
          _tabController.animation!.value <= 0.5) {
        setState(() {
          changeIcon = 0;
        });
      }

      if (_tabController.animation!.value > 0.5 &&
          _tabController.animation!.value <= 1.5) {
        setState(() {
          changeIcon = 1;
        });
      }

      if (_tabController.animation!.value > 1.5 &&
          _tabController.animation!.value <= 2.5) {
        setState(() {
          changeIcon = 2;
        });
      }

      if (_tabController.animation!.value > 2.5 &&
          _tabController.animation!.value <= 3) {
        setState(() {
          changeIcon = 3;
        });
      }

      // logger.info(_tabController.animation!.value);
    });

    // 移除开屏动画
    // FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      if (setStatusHeight == false) {
        if (kIsWeb) {
          context.read<LJNSystemCubit>().updateStatusHeight(0);
        } else {
          context
              .read<LJNSystemCubit>()
              .updateStatusHeight(MediaQuery.of(context).padding.top);
        }

        setStatusHeight = true;
      }

      Icon icon1 = Icon(
        const IconData(
          0xe7b3,
          fontFamily: 'Iconfont',
        ),
        size: 45.w,
      );
      Icon icon2 = Icon(
        const IconData(
          0xe608,
          fontFamily: 'Iconfont',
        ),
        size: 48.w,
      );
      Icon icon3 = Icon(
        const IconData(
          0xe61c,
          fontFamily: 'Iconfont',
        ),
        size: 43.w,
      );
      Icon icon4 = Icon(
        const IconData(
          0xe63f,
          fontFamily: 'Iconfont',
        ),
        size: 45.w,
      );

      // 新appbar透明度
      double percent75Position =
          MediaQuery.of(context).size.height * 0.25; // 开始显示新appbar的位置

      // appbar标题
      Text appBarTitle = const Text("");
      if (changeIcon == 0) {
        icon1 = Icon(
          const IconData(
            0xe676,
            fontFamily: 'Iconfont',
          ),
          size: 45.w,
        );

        appBarTitle = const Text("微信");
      } else if (changeIcon == 1) {
        icon2 = Icon(
          const IconData(
            0xe609,
            fontFamily: 'Iconfont',
          ),
          size: 48.w,
        );

        appBarTitle = const Text("通信录");
      } else if (changeIcon == 2) {
        icon3 = Icon(
          const IconData(
            0xe638,
            fontFamily: 'Iconfont',
          ),
          size: 43.w,
        );

        appBarTitle = const Text("发现");
      } else if (changeIcon == 3) {
        icon4 = Icon(
          const IconData(
            0xe62b,
            fontFamily: 'Iconfont',
          ),
          size: 48.w,
        );

        appBarTitle = const Text("我的");
      }

      return Stack(
        children: [
          // 主界面
          Scaffold(
            primary: false,
            bottomNavigationBar: Visibility(
              visible: systemState.showMiniProgramDrawer == false,
              child: Container(
                height: 106.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  border: Border(
                    top: BorderSide(
                      color: const Color.fromARGB(255, 220, 220, 220),
                      width: 1.5.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: TabBar(
                  dividerColor: const Color.fromARGB(255, 218, 218, 218),
                  labelColor: const Color.fromARGB(255, 7, 192, 103),
                  labelStyle: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(22.w),
                  ),
                  unselectedLabelColor: const Color.fromARGB(222, 0, 0, 0),
                  indicator: const BoxDecoration(),
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  overlayColor: WidgetStateProperty.all(
                    const Color(0x00000000),
                  ),
                  tabs: <Widget>[
                    Tab(
                      height: 105.w,
                      iconMargin: EdgeInsets.only(bottom: 8.w),
                      icon: SizedBox(
                        height: 50.w,
                        width: 50.w,
                        // color: Colors.red,
                        child: Center(child: icon1),
                      ),
                      text: "微信",
                    ),
                    Tab(
                      height: 105.w,
                      iconMargin: EdgeInsets.only(bottom: 8.w),
                      icon: SizedBox(
                        height: 50.w,
                        width: 50.w,
                        // color: Colors.red,
                        child: Center(child: icon2),
                      ),
                      text: "通信录",
                    ),
                    Tab(
                      height: 105.w,
                      iconMargin: EdgeInsets.only(bottom: 8.w),
                      icon: SizedBox(
                        height: 50.w,
                        width: 50.w,
                        // color: Colors.red,
                        child: Center(child: icon3),
                      ),
                      text: "发现",
                    ),
                    Tab(
                      height: 105.w,
                      iconMargin: EdgeInsets.only(bottom: 8.w),
                      icon: SizedBox(
                        height: 50.w,
                        width: 50.w,
                        // color: Colors.red,
                        child: Center(child: icon4),
                      ),
                      text: "我",
                    ),
                  ],
                ),
              ),
            ),
            appBar: null,
            body: TabBarView(
              physics: systemState.showMiniProgramDrawer == true
                  ? const NeverScrollableScrollPhysics()
                  : const CustomTabBarViewScrollPhysics(),
              controller: _tabController,
              children: const <Widget>[
                // LJNTestPage(),
                LJNHome(),
                LJNContact(),
                LJNDiscovery(),
                LJNUser(),
              ],
            ),
          ),

          // 浮动在顶部的appbar
          Visibility(
            visible:
                (systemState.homescrollpixels + systemState.statusHeight) <=
                    percent75Position,
            child: Positioned(
              top: systemState.homescrollpixels,
              left: _appbarLeft,
              child: Container(
                width: 750.0.w,
                height: systemState.statusHeight + 90.w,
                color: systemState.homescrollpixels == 0
                    ? const Color.fromARGB(255, 237, 237, 237)
                    : Colors.transparent,
                // color: systemState.homescrollpixels == 0
                //     ? const Color.fromARGB(255, 237, 237, 237)
                //     : Colors.red,
                child: Listener(
                  onPointerUp: (event) {
                    context
                        .read<LJNSystemCubit>()
                        .updateShowMiniProgramDrawer(false);
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBar(
                          // App标题栏
                          primary: false,
                          title: appBarTitle,
                          centerTitle: true,
                          titleTextStyle: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.w),
                              color: Colors.black,
                              fontFamily: "AlibabaPuHuiTi-Medium"),
                          toolbarHeight: 90.w,
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          backgroundColor:
                              const Color.fromARGB(255, 237, 237, 237),
                          foregroundColor:
                              const Color.fromARGB(255, 237, 237, 237),
                          actions: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                color: Colors.transparent,
                                height: 90.w,
                                padding:
                                    EdgeInsets.only(right: 33.w), // 设置右侧内边距
                                child: Icon(
                                  const IconData(
                                    0xe612,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 40.w, // 图标大小
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (systemState.homescrollpixels == 0) {
                                  setState(() {
                                    showpopup = !showpopup;
                                  });
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                height: 90.w,
                                padding:
                                    EdgeInsets.only(right: 40.w), // 设置右侧内边距
                                alignment: Alignment.center,
                                child: Icon(
                                  const IconData(
                                    0xe726,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 42.w, // 图标大小
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),

          // 背景
          if (showpopup) ...[
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  showpopup = !showpopup;
                });
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent),
            ),

            // 弹出扫码菜单
            Positioned(
              right: 15.w,
              top: systemState.statusHeight + 80.w,
              child: SizedBox(
                width: 320.w,
                child: Column(
                  children: [
                    Container(
                      width: 320.w,
                      padding: EdgeInsets.only(right: 32.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 36.w,
                            height: 20.w,
                            child: Icon(
                              color: const Color.fromARGB(255, 76, 76, 76),
                              const IconData(
                                0xe62c,
                                fontFamily: 'Iconfont',
                              ),
                              size: 42.w,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0).w,
                        color: const Color.fromARGB(255, 76, 76, 76),
                      ),
                      width: 320.w,
                      height: 425.w,
                      child: Column(
                        children: [
                          // 发起群聊
                          LJNPopupMenuItem(
                            title: "发起群聊",
                            icon: 0xe676,
                            onTap: () {
                              setState(() {
                                showpopup = false;
                              });
                            },
                          ),

                          LJNPopupMenuItem(
                            title: "添加朋友",
                            icon: 0xe61f,
                            onTap: () {
                              setState(() {
                                showpopup = false;
                              });
                              Navigator.pushNamed(context, '/add_friends');
                            },
                          ),

                          LJNPopupMenuItem(
                            title: "扫一扫",
                            icon: 0xe69a,
                            onTap: () {
                              setState(() {
                                showpopup = false;
                              });
                              Navigator.pushNamed(context, '/qrcode_scanner');
                            },
                          ),

                          LJNPopupMenuItem(
                            title: "收付款",
                            icon: 0xe611,
                            onTap: () {
                              setState(() {
                                showpopup = false;
                              });
                              Navigator.pushNamed(
                                  context, '/collection_and_payment');
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ],
      );
    });
  }
}

// 弹窗
class LJNPopupMenuItem extends StatefulWidget {
  final String title;
  final int icon;
  final Function()? onTap;

  const LJNPopupMenuItem(
      {super.key, required this.title, this.onTap, required this.icon});

  @override
  State<LJNPopupMenuItem> createState() => _LJNPopupMenuItem();
}

class _LJNPopupMenuItem extends State<LJNPopupMenuItem> {
  Color bgColor = const Color.fromARGB(255, 68, 68, 68);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          bgColor = const Color.fromARGB(255, 68, 68, 68);
        });
      },
      onTapCancel: () {
        setState(() {
          bgColor = const Color.fromARGB(255, 76, 76, 76);
        });
      },
      onTapUp: (tapDownDetails) {
        setState(() {
          bgColor = const Color.fromARGB(255, 76, 76, 76);
        });

        Future.delayed(const Duration(milliseconds: 50), () {
          if (widget.onTap != null) widget.onTap!();
        });
      },
      child: Container(
        height: 105.w,
        color: bgColor,
        child: Row(
          children: [
            SizedBox(
              height: 105.w,
              width: 105.w,
              child: Center(
                child: Icon(
                  color: Colors.white,
                  IconData(
                    widget.icon,
                    fontFamily: 'Iconfont',
                  ),
                  size: 41.w,
                ),
              ),
            ),
            SizedBox(
              width: 0.w,
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 85, 85, 85),
                      width: 1.5.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(33.w),
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
