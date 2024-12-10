import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/careMode.dart';
import 'package:jiaoyishuoflutter3/chat.dart';
import 'package:jiaoyishuoflutter3/collectionAndPayment.dart';
import 'package:jiaoyishuoflutter3/discovery.dart';
import 'package:jiaoyishuoflutter3/friendDataSetting.dart';
import 'package:jiaoyishuoflutter3/friendMessageRecord.dart';
import 'package:jiaoyishuoflutter3/friendmoments.dart';
import 'package:jiaoyishuoflutter3/home22.dart';
import 'package:jiaoyishuoflutter3/ins.dart';
import 'package:jiaoyishuoflutter3/miniprogram.dart';
import 'package:jiaoyishuoflutter3/mywebview.dart';
import 'package:jiaoyishuoflutter3/settings/about.dart';
import 'package:jiaoyishuoflutter3/settings/billDetails.dart';
import 'package:jiaoyishuoflutter3/settings/changeDetails.dart';
import 'package:jiaoyishuoflutter3/settings/chatSetting.dart';
import 'package:jiaoyishuoflutter3/settings/commonSetting.dart';
import 'package:jiaoyishuoflutter3/settings/deviceDetail.dart';
import 'package:jiaoyishuoflutter3/settings/emergencyContact.dart';
import 'package:jiaoyishuoflutter3/settings/friendPermission.dart';
import 'package:jiaoyishuoflutter3/settings/loggedDevices.dart';
import 'package:jiaoyishuoflutter3/settings/moreSecureSetting.dart';
import 'package:jiaoyishuoflutter3/settings/newMessageNotification.dart';
import 'package:jiaoyishuoflutter3/pocketmoney.dart';
import 'package:jiaoyishuoflutter3/friendprofile.dart';
import 'package:jiaoyishuoflutter3/qrcodescanner.dart';
import 'package:jiaoyishuoflutter3/search.dart';
import 'package:jiaoyishuoflutter3/services.dart';
import 'package:jiaoyishuoflutter3/settings/accountAndSecure.dart';
import 'package:jiaoyishuoflutter3/settings/bindNewPhoneNumber.dart';
import 'package:jiaoyishuoflutter3/settings/changeAccount.dart';
import 'package:jiaoyishuoflutter3/settings/forgotPassword.dart';
import 'package:jiaoyishuoflutter3/settings/inputVerifyCode.dart';
import 'package:jiaoyishuoflutter3/settings/personalInfoAndPermission.dart';
import 'package:jiaoyishuoflutter3/settings/personalInfoCollectionChecklist.dart';
import 'package:jiaoyishuoflutter3/settings/phoneContact.dart';
import 'package:jiaoyishuoflutter3/settings/phoneNumber.dart';
import 'package:jiaoyishuoflutter3/settings/setPassword.dart';
import 'package:jiaoyishuoflutter3/settings/setting.dart';
import 'package:jiaoyishuoflutter3/settings/verifyPhone.dart';
import 'package:jiaoyishuoflutter3/settings/soundLock.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:jiaoyishuoflutter3/teenageMode.dart';
import 'package:jiaoyishuoflutter3/tiktik.dart';
import 'package:jiaoyishuoflutter3/tools/fileServer.dart';
import 'package:jiaoyishuoflutter3/userinfo.dart';
import 'package:jiaoyishuoflutter3/videoplayer.dart';
import 'package:jiaoyishuoflutter3/wallet.dart';
import 'package:path_provider/path_provider.dart';
import 'components/CustomPhysics.dart';
import 'contact.dart';
import 'logger.dart';
import 'settings/accountInfo.dart';
import 'tools/tools.dart';
import 'user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

// import 'package:jiaoyishuoflutter3/provider.dart';
// import 'package:provider/provider.dart';
// import 'provider.dart' as provider;

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
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 设置状态栏透明
    statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
  ));
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  myStore.dispatch({"type": "userinfoName", "payload": "李俊杰"});
  myStore.dispatch({"type": "userinfoAccount", "payload": "TheMonsterClub"});
  myStore.dispatch({"type": "userinfoPhone", "payload": "+8618825130917"});
  myStore.dispatch({"type": "walletBalance", "payload": 123.98});
  // myStore.dispatch({"type": "walletBalance", "payload": 149.36});
  myStore.dispatch({"type": "walletFoundationBalance", "payload": 0.0});
  myStore
      .dispatch({"type": "userinfoAvatar", "payload": "images/avatar/my.jpg"});

  startWebServer();

  runApp(
    const TabBarApp(),
  );
}

void startWebServer() async {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

  ByteData byteData = await rootBundle.load("assets/web/pages.html");
  List<int> bytes = byteData.buffer.asUint8List();
  String fileContent = utf8.decode(bytes);

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/shapages.html';
  final file = File(filePath);
  await file.writeAsString(fileContent);

  // 启动web服务器
  final receivePort = ReceivePort();

  // 创建参数对象
  var params = FileServerParams(
    sendPort: receivePort.sendPort,
    rootIsolateToken: rootIsolateToken,
    port: 9413,
  );

  await Isolate.spawn(startFileServer, params);
  receivePort.listen((message) {
    logger.info(message); // 打印服务器启动消息
  });
}

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});

  @override
  State<TabBarApp> createState() => _TabBarApp();
}

class _TabBarApp extends State<TabBarApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: myStore,
        child: ScreenUtilInit(
            designSize: const Size(750, 1624),
            ensureScreenSize: true,
            minTextAdapt: true,
            splitScreenMode: true,
            enableScaleWH: () => true,
            enableScaleText: () => true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  if (settings.name == '/') {
                    return pageRouteBuilderNotAnimation(const CustomTabbar());
                  } else if (settings.name == '/mywebview' ||
                      settings.name!.startsWith('/mywebview')) {
                    logger.info("settings.name: ${settings.name}");

                    Uri uri = Uri.parse(settings.name!);

                    late String linkValue;
                    linkValue = uri.queryParameters['link'] ?? "";

                    return pageRouteBuilderAnimation(
                        LJNWebview(link: linkValue));
                  } else if (settings.name == '/services') {
                    return pageRouteBuilderAnimation(const LJNServicesPage());
                  } else if (settings.name == '/chat') {
                    var arguments = settings.arguments as Map<String, String>;
                    String title = arguments['title'] as String;
                    String icon = arguments['icon'] as String;
                    return pageRouteBuilderAnimation(
                        LJNChatPage(title: title, icon: icon));
                  } else if (settings.name == '/qrcode_scanner') {
                    return pageRouteBuilderNotAnimation(
                        const LJNQRCodeScanner());
                  } else if (settings.name == '/video_player') {
                    return pageRouteBuilderAnimation(const LJNVideoPage());
                  } else if (settings.name == '/wallet') {
                    return pageRouteBuilderAnimation(const LJNWalletPage());
                  } else if (settings.name == '/userinfo') {
                    return pageRouteBuilderAnimation(const LJNUserinfoPage());
                  } else if (settings.name == '/friendmoments') {
                    return pageRouteBuilderAnimation(
                        const LJNFriendmomentsPage());
                  } else if (settings.name == '/pocketmoney') {
                    return pageRouteBuilderAnimation(
                        const LJNPocketMoneyPage());
                  } else if (settings.name == '/friendprofile') {
                    var arguments =
                        settings.arguments as Map<String, String>? ?? {};

                    String avatar = arguments['avatar'] ?? "";
                    String name = arguments['name'] ?? "";
                    String nickname = arguments['nickname'] ?? "";
                    String account = arguments['account'] ?? "";

                    return pageRouteBuilderAnimation(LJNFriendProfilePage(
                        name: name,
                        nickname: nickname,
                        account: account,
                        avatar: avatar));
                  } else if (settings.name == '/ins') {
                    return pageRouteBuilderAnimation(const LJNInsPage());
                  } else if (settings.name == '/tiktik') {
                    return pageRouteBuilderAnimation(const LJNTiktikPage());
                  } else if (settings.name == '/miniprogram') {
                    return pageRouteBuilderAnimation(
                        const LJNMiniProgramPage());
                  } else if (settings.name == '/search') {
                    return pageRouteBuilderAnimation(const LJNSearchPage());
                  } else if (settings.name == '/setting') {
                    return pageRouteBuilderAnimation(const LJNSettingPage());
                  } else if (settings.name == '/account_and_secure') {
                    return pageRouteBuilderAnimation(
                        const LJNAccountAndSecure());
                  } else if (settings.name == '/accountinfo') {
                    return pageRouteBuilderAnimation(const LJNAccountInfo());
                  } else if (settings.name == '/change_account') {
                    return pageRouteBuilderAnimation(const LJNChangeAccount());
                  } else if (settings.name == '/forgot_password') {
                    return pageRouteBuilderAnimation(const LJNForgotPassword());
                  } else if (settings.name == '/phone_number') {
                    return pageRouteBuilderAnimation(const LJNPhoneNumber());
                  } else if (settings.name == '/phone_contact') {
                    return pageRouteBuilderAnimation(const LJNPhoneContact());
                  } else if (settings.name == '/verify_phone') {
                    return pageRouteBuilderAnimation(const LJNVerifyPhone());
                  } else if (settings.name == '/bind_new_phone_number') {
                    return pageRouteBuilderAnimation(
                        const LJNBindNewPhoneNumber());
                  } else if (settings.name == '/input_verify_code') {
                    return pageRouteBuilderAnimation(
                        const LJNInputVerifyCode());
                  } else if (settings.name == '/teenage_mode') {
                    return pageRouteBuilderAnimation(const LJNTeenageMode());
                  } else if (settings.name == '/care_mode') {
                    return pageRouteBuilderAnimation(const LJNCareMode());
                  } else if (settings.name == '/new_message_notification') {
                    return pageRouteBuilderAnimation(
                        const LJNNewMessageNotification());
                  } else if (settings.name == "/collection_and_payment") {
                    return pageRouteBuilderAnimation(
                        const LJNCollectionAndPayment());
                  } else if (settings.name == "/chat_setting") {
                    return pageRouteBuilderAnimation(const LJNChatSetting());
                  } else if (settings.name == "/common_setting") {
                    return pageRouteBuilderAnimation(const LJNCommonSetting());
                  } else if (settings.name == "/set_password") {
                    return pageRouteBuilderAnimation(const LJNSetPassword());
                  } else if (settings.name == "/logged_devices") {
                    return pageRouteBuilderAnimation(const LJNLoggedDevices());
                  } else if (settings.name == "/device_detail") {
                    return pageRouteBuilderAnimation(const LJNDeviceDetail());
                  } else if (settings.name == "/emergency_contact") {
                    return pageRouteBuilderAnimation(
                        const LJNEmergencyContact());
                  } else if (settings.name == "/more_secure_setting") {
                    return pageRouteBuilderAnimation(
                        const LJNMoreSecureSetting());
                  } else if (settings.name == "/sound_lock") {
                    return pageRouteBuilderAnimation(const LJNSoundLock());
                  } else if (settings.name == "/personinfo_and_permission") {
                    return pageRouteBuilderAnimation(
                        const LJNPersonalinfoAndPermission());
                  } else if (settings.name ==
                      "/personalinfo_collection_checklist") {
                    return pageRouteBuilderAnimation(
                        const LJNPersonalInfoCollectionChecklist());
                  } else if (settings.name == "/about") {
                    return pageRouteBuilderAnimation(const LJNAbout());
                  } else if (settings.name == "/friend_permission") {
                    return pageRouteBuilderAnimation(
                        const LJNFriendPermission());
                  } else if (settings.name == "/change_details") {
                    return pageRouteBuilderAnimation(const LJNChangeDetails());
                  } else if (settings.name == "/bill_details") {
                    return pageRouteBuilderAnimation(const LJNBillDetails());
                  } else if (settings.name == "/friend_message_record") {
                    return pageRouteBuilderAnimation(
                        const LJNFriendMessageRecord());
                  } else if (settings.name == "/friend_data_setting") {
                    return pageRouteBuilderAnimation(
                        const LJNFriendDataSetting());
                  }

                  return null;
                },
                theme: myStore.state.themeData,
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.unknown
                  },
                ),
              );
            }));
  }

  // 带动效进入页面
  PageRouteBuilder pageRouteBuilderAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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

      logger.info("tttttttttt: ${_tabController.animation!.value}");

      if ((_tabController.animation!.value - 1).abs() < 0.2) {
        // logger.info("来了");
        myStore.dispatch({"type": "contactazshow", "payload": true});
      } else {
        // logger.info("走了");
        myStore.dispatch({"type": "contactazshow", "payload": false});
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
    Size screenSize = MediaQuery.of(context).size;

    if (setStatusHeight == false) {
      if (kIsWeb) {
        // vm.statusHeight = 0;
        myStore.dispatch({"type": "statusHeight", "payload": 0});
      } else {
        // vm.statusHeight = MediaQuery.of(context).padding.top;
        myStore.dispatch({
          "type": "statusHeight",
          "payload": MediaQuery.of(context).padding.top
        });
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

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          // 新appbar透明度
          double percent75Position = screenSize.height * 0.25; // 开始显示新appbar的位置
          // double newAppbarHeight = 90.w + 17.w;
          // double coverOpacity = (vm.homescrollpixels + vm.statusHeight) /
          //     (percent75Position - vm.statusHeight);
          // if (coverOpacity < 0) {
          //   coverOpacity = 0;
          // } else if (coverOpacity > 1) {
          //   coverOpacity = 1;
          // }

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
                    visible: vm.showMiniProgramDrawer == false,
                    child: Container(
                        height: 106.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 237, 237, 237),
                            border: Border(
                                top: BorderSide(
                              color: const Color.fromARGB(255, 220, 220, 220),
                              width: 1.5.w,
                              style: BorderStyle.solid,
                            ))),
                        child: TabBar(
                          dividerColor:
                              const Color.fromARGB(255, 218, 218, 218),
                          labelColor: const Color.fromARGB(255, 7, 192, 103),
                          labelStyle: TextStyle(
                              height: 1.08, fontSize: fontSizeScale(22.w)),
                          unselectedLabelColor:
                              const Color.fromARGB(222, 0, 0, 0),
                          indicator: const BoxDecoration(),
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          overlayColor:
                              WidgetStateProperty.all(const Color(0x00000000)),
                          tabs: <Widget>[
                            Tab(
                              height: 105.w,
                              iconMargin: EdgeInsets.only(bottom: 8.w),
                              icon: SizedBox(
                                  height: 50.w,
                                  width: 50.w,
                                  // color: Colors.red,
                                  child: Center(child: icon1)),
                              text: "微信",
                            ),
                            Tab(
                              height: 105.w,
                              iconMargin: EdgeInsets.only(bottom: 8.w),
                              icon: SizedBox(
                                  height: 50.w,
                                  width: 50.w,
                                  // color: Colors.red,
                                  child: Center(child: icon2)),
                              text: "通信录",
                            ),
                            Tab(
                              height: 105.w,
                              iconMargin: EdgeInsets.only(bottom: 8.w),
                              icon: SizedBox(
                                  height: 50.w,
                                  width: 50.w,
                                  // color: Colors.red,
                                  child: Center(child: icon3)),
                              text: "发现",
                            ),
                            Tab(
                              height: 105.w,
                              iconMargin: EdgeInsets.only(bottom: 8.w),
                              icon: SizedBox(
                                  height: 50.w,
                                  width: 50.w,
                                  // color: Colors.red,
                                  child: Center(child: icon4)),
                              text: "我",
                            ),
                          ],
                        ))),
                appBar: null,
                body: TabBarView(
                  physics: vm.showMiniProgramDrawer == true
                      ? const NeverScrollableScrollPhysics()
                      : const MyTabbarFastStopScrollPhysics(),
                  controller: _tabController,
                  children: const <Widget>[
                    // LJNTestPage(),
                    LJNHome22Page(),
                    LJNContactPage(),
                    LJNDiscoveryPage(),
                    LJNUserPage(),
                  ],
                ),
              ),

              // 浮动在顶部的appbar
              Visibility(
                visible: (vm.homescrollpixels + vm.statusHeight!) <=
                    percent75Position,
                child: Positioned(
                    top: vm.homescrollpixels,
                    left: _appbarLeft,
                    child: Container(
                        width: 750.0.w,
                        height: vm.statusHeight! + 90.w,
                        color: vm.homescrollpixels == 0
                            ? const Color.fromARGB(255, 237, 237, 237)
                            : Colors.transparent,
                        // color: vm.homescrollpixels == 0
                        //     ? const Color.fromARGB(255, 237, 237, 237)
                        //     : Colors.red,
                        child: Listener(
                            onPointerUp: (event) {
                              myStore.dispatch({
                                "type": "showMiniProgramDrawer",
                                "payload": false
                              });
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
                                    backgroundColor: const Color.fromARGB(
                                        255, 237, 237, 237),
                                    foregroundColor: const Color.fromARGB(
                                        255, 237, 237, 237),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          color: Colors.transparent,
                                          height: 90.w,
                                          padding: EdgeInsets.only(
                                              right: 33.w), // 设置右侧内边距
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
                                          if (vm.homescrollpixels == 0) {
                                            vm.showpopup = !vm.showpopup!;
                                            myStore.dispatch({
                                              "type": "showpopup",
                                              "payload": vm.showpopup
                                            });
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          height: 90.w,
                                          padding: EdgeInsets.only(
                                              right: 40.w), // 设置右侧内边距
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
                                ])))),
              ),

              // 弹出的扫码界面
              const PopupMenu()
            ],
          );
        });
  }
}

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Visibility(
              visible: vm.showpopup as bool,
              child: Stack(
                children: [
                  GestureDetector(
                      onTapDown: (_) {
                        vm.showpopup = !vm.showpopup!;
                        myStore.dispatch(
                            {"type": "showpopup", "payload": vm.showpopup});
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.transparent)),
                  Positioned(
                      right: 15.w,
                      top: vm.statusHeight! + 80.w,
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
                                        color: const Color.fromARGB(
                                            255, 76, 76, 76),
                                        const IconData(
                                          0xe62c,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 42.w,
                                      ))
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
                                  GestureDetector(
                                    onTapDown: (_) {
                                      myStore.dispatch({
                                        "type": "button1Bg",
                                        "payload": const Color.fromARGB(
                                            255, 68, 68, 68)
                                      });

                                      logger.info("按下");
                                    },
                                    onTapCancel: () {
                                      myStore.dispatch({
                                        "type": "button1Bg",
                                        "payload": const Color.fromARGB(
                                            255, 76, 76, 76)
                                      });

                                      logger.info("取消按下");
                                    },
                                    onTapUp: (tapDownDetails) {
                                      Future.delayed(
                                          const Duration(milliseconds: 50), () {
                                        myStore.dispatch({
                                          "type": "button1Bg",
                                          "payload": const Color.fromARGB(
                                              255, 76, 76, 76)
                                        });

                                        myStore.dispatch({
                                          "type": "showpopup",
                                          "payload": false
                                        });
                                        // Navigator.pushNamed(
                                        // context, '/qrcode_scanner');
                                      });

                                      logger.info("弹起");
                                    },
                                    child: Container(
                                      height: 105.w,
                                      color: vm.button1Bg,
                                      child: Row(children: [
                                        SizedBox(
                                          height: 105.w,
                                          width: 105.w,
                                          child: Center(
                                            child: Icon(
                                              color: Colors.white,
                                              const IconData(
                                                0xe676,
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
                                                color: const Color.fromARGB(
                                                    255, 85, 85, 85),
                                                width: 1.5.w,
                                                style: BorderStyle.solid,
                                              ))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '发起群聊',
                                                    style: TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(30.w),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                        )
                                      ]),
                                    ),
                                  ),
                                  // 添加朋友
                                  GestureDetector(
                                    onTapDown: (_) {
                                      myStore.dispatch({
                                        "type": "button2Bg",
                                        "payload": const Color.fromARGB(
                                            255, 68, 68, 68)
                                      });

                                      logger.info("按下");
                                    },
                                    onTapCancel: () {
                                      myStore.dispatch({
                                        "type": "button2Bg",
                                        "payload": const Color.fromARGB(
                                            255, 76, 76, 76)
                                      });

                                      logger.info("取消按下");
                                    },
                                    onTapUp: (tapDownDetails) {
                                      Future.delayed(
                                          const Duration(milliseconds: 50), () {
                                        myStore.dispatch({
                                          "type": "button2Bg",
                                          "payload": const Color.fromARGB(
                                              255, 76, 76, 76)
                                        });

                                        myStore.dispatch({
                                          "type": "showpopup",
                                          "payload": false
                                        });
                                        // Navigator.pushNamed(
                                        // context, '/qrcode_scanner');
                                      });

                                      logger.info("弹起");
                                    },
                                    child: Container(
                                      height: 105.w,
                                      color: vm.button2Bg,
                                      child: Row(children: [
                                        SizedBox(
                                          height: 105.w,
                                          width: 105.w,
                                          child: Center(
                                            child: Icon(
                                              color: Colors.white,
                                              const IconData(
                                                0xe61f,
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
                                                color: const Color.fromARGB(
                                                    255, 85, 85, 85),
                                                width: 1.5.w,
                                                style: BorderStyle.solid,
                                              ))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '添加朋友',
                                                    style: TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(30.w),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                        )
                                      ]),
                                    ),
                                  ),
                                  // 扫一扫
                                  GestureDetector(
                                    onTapDown: (_) {
                                      myStore.dispatch({
                                        "type": "button3Bg",
                                        "payload": const Color.fromARGB(
                                            255, 68, 68, 68)
                                      });

                                      logger.info("按下");
                                    },
                                    onTapCancel: () {
                                      myStore.dispatch({
                                        "type": "button3Bg",
                                        "payload": const Color.fromARGB(
                                            255, 76, 76, 76)
                                      });

                                      logger.info("取消按下");
                                    },
                                    onTapUp: (tapDownDetails) {
                                      Future.delayed(
                                          const Duration(milliseconds: 50), () {
                                        myStore.dispatch({
                                          "type": "button3Bg",
                                          "payload": const Color.fromARGB(
                                              255, 76, 76, 76)
                                        });

                                        myStore.dispatch({
                                          "type": "showpopup",
                                          "payload": false
                                        });
                                        Navigator.pushNamed(
                                            context, '/qrcode_scanner');
                                      });

                                      logger.info("弹起");
                                    },
                                    child: Container(
                                      height: 105.w,
                                      color: vm.button3Bg,
                                      child: Row(children: [
                                        SizedBox(
                                          height: 105.w,
                                          width: 105.w,
                                          child: Center(
                                            child: Icon(
                                              color: Colors.white,
                                              const IconData(
                                                0xe69a,
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
                                                color: const Color.fromARGB(
                                                    255, 85, 85, 85),
                                                width: 1.5.w,
                                                style: BorderStyle.solid,
                                              ))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '扫一扫',
                                                    style: TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(30.w),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                        )
                                      ]),
                                    ),
                                  ),
                                  // 收付款
                                  GestureDetector(
                                      onTapDown: (_) {
                                        myStore.dispatch({
                                          "type": "button4Bg",
                                          "payload": const Color.fromARGB(
                                              255, 68, 68, 68)
                                        });

                                        logger.info("按下");
                                      },
                                      onTapCancel: () {
                                        myStore.dispatch({
                                          "type": "button4Bg",
                                          "payload": const Color.fromARGB(
                                              255, 76, 76, 76)
                                        });

                                        logger.info("取消按下");
                                      },
                                      onTapUp: (tapDownDetails) {
                                        Future.delayed(
                                            const Duration(milliseconds: 50),
                                            () {
                                          myStore.dispatch({
                                            "type": "button4Bg",
                                            "payload": const Color.fromARGB(
                                                255, 76, 76, 76)
                                          });

                                          myStore.dispatch({
                                            "type": "showpopup",
                                            "payload": false
                                          });
                                          // Navigator.pushNamed(
                                          // context, '/qrcode_scanner');
                                        });

                                        logger.info("弹起");
                                      },
                                      child: Container(
                                        color: vm.button4Bg,
                                        height: 105.w,
                                        child: Row(children: [
                                          SizedBox(
                                            height: 105.w,
                                            width: 105.w,
                                            child: Center(
                                              child: Icon(
                                                color: Colors.white,
                                                const IconData(
                                                  0xe611,
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
                                                  color: Colors.transparent,
                                                  width: 1.5.w,
                                                  style: BorderStyle.solid,
                                                ))),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '收付款',
                                                      style: TextStyle(
                                                          height: 1.08,
                                                          fontSize:
                                                              fontSizeScale(
                                                                  30.w),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                )),
                                          )
                                        ]),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ));
        });
  }
}
