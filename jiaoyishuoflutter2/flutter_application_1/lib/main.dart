import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat.dart';
import 'package:flutter_application_1/discovery.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/store.dart';
import 'contact.dart';
import 'logger.dart';
import 'user.dart';
import 'home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_redux/flutter_redux.dart';

// import 'package:flutter_application_1/provider.dart';
// import 'package:provider/provider.dart';
// import 'provider.dart' as provider;

void main() async {
  setupLogger();
  logger.info('Application is starting...');
  await ScreenUtil.ensureScreenSize();

  runApp(
    const TabBarApp(),
  );
}

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: myStore,
        child: ScreenUtilInit(
            designSize: const Size(750, 1333),
            minTextAdapt: true,
            splitScreenMode: true,
            enableScaleWH: () => true,
            enableScaleText: () => true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme:
                      Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: child,
              );
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) =>
                        const CustomTabbar(),
                    // const CustomTabbar(),
                    transitionsBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) {
                      final Tween<Offset> offsetTween = Tween<Offset>(
                          begin: const Offset(0.0, 0.0),
                          end: const Offset(-1.0, 0.0));
                      final Animation<Offset> slideOutLeftAnimation =
                          offsetTween.animate(secondaryAnimation);
                      return SlideTransition(
                          position: slideOutLeftAnimation, child: child);
                    },
                  );
                } else if (settings.name == '/services') {
                  return PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LJNServicesPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  );
                } else if (settings.name == '/chat') {
                  return PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LJNChatPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  );
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
            )));
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

  // late Store<StoreType> mstore;
  late EdgeInsets devicesPadding;
  late AppBar? appbar;

  double _appbarLeft = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, animationDuration: Duration.zero);

    _tabController.animation!.addListener(() {
      logger.info(_tabController.animation);
      if (_tabController.animation!.value == 1) {
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

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        logger.info('================================================');
        logger.info(_tabController.index);
        myStore.dispatch({"type": "homescrollpixels", "payload": 0});
        logger.info('================================================');

      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    devicesPadding = MediaQuery.of(context).padding;

    Icon icon1 = Icon(
      const IconData(
        0xe7b3,
        fontFamily: 'Iconfont',
      ),
      size: 50.w,
    );
    Icon icon2 = Icon(
      const IconData(
        0xe608,
        fontFamily: 'Iconfont',
      ),
      size: 50.w,
    );
    Icon icon3 = Icon(
      const IconData(
        0xe61c,
        fontFamily: 'Iconfont',
      ),
      size: 50.w,
    );
    Icon icon4 = Icon(
      const IconData(
        0xe63f,
        fontFamily: 'Iconfont',
      ),
      size: 50.w,
    );

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          Text appBarTitle = const Text("");

          if (changeIcon == 0) {
            icon1 = Icon(
              const IconData(
                0xe676,
                fontFamily: 'Iconfont',
              ),
              size: 50.w,
            );

            appBarTitle = const Text("微信");
          } else if (changeIcon == 1) {
            icon2 = Icon(
              const IconData(
                0xe609,
                fontFamily: 'Iconfont',
              ),
              size: 50.w,
            );

            appBarTitle = const Text("通信录");
          } else if (changeIcon == 2) {
            icon3 = Icon(
              const IconData(
                0xe638,
                fontFamily: 'Iconfont',
              ),
              size: 50.w,
            );

            appBarTitle = const Text("发现");
          } else if (changeIcon == 3) {
            icon4 = Icon(
              const IconData(
                0xe62b,
                fontFamily: 'Iconfont',
              ),
              size: 50.w,
            );

            appBarTitle = const Text("我的");
          }

          return Stack(
            children: [
              // 主界面
              Scaffold(
                primary: false,
                bottomNavigationBar: ColoredBox(
                  color: const Color.fromARGB(255, 247, 247, 247),
                  child: TabBar(
                    dividerColor: const Color.fromARGB(255, 218, 218, 218),
                    labelColor: const Color.fromARGB(255, 43, 174, 106),
                    unselectedLabelColor: const Color.fromARGB(222, 0, 0, 0),
                    indicator: const BoxDecoration(),
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    overlayColor:
                        WidgetStateProperty.all(const Color(0x00000000)),
                    tabs: <Widget>[
                      Tab(
                        height: 115.w,
                        icon: icon1,
                        text: "微信",
                      ),
                      Tab(
                        height: 115.w,
                        icon: icon2,
                        text: "通信录",
                      ),
                      Tab(
                        height: 115.w,
                        icon: icon3,
                        text: "发现",
                      ),
                      Tab(
                        height: 115.w,
                        icon: icon4,
                        text: "我",
                      ),
                    ],
                  ),
                ),
                appBar: null,
                body: TabBarView(
                  controller: _tabController,
                  children: const <Widget>[
                    LJNHomePage(),
                    LJNContactPage(),
                    LJNDiscoveryPage(),
                    LJNUserPage(),
                  ],
                ),
              ),

              // 浮动在顶部的appbar
              Transform.translate(
                  offset: Offset(_appbarLeft, 0),
                  child: Container(
                      width: 750.0.w,
                      height: vm.homescrollpixels!.abs() +
                          devicesPadding.top +
                          90.w,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      // color: const Color.fromARGB(255, 237, 237, 237),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppBar(
                              title: appBarTitle,
                              centerTitle: true,
                              titleTextStyle: TextStyle(fontSize: 32.w),
                              toolbarHeight: 90.w,
                              elevation: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 237, 237, 237),
                              foregroundColor:
                                  const Color.fromARGB(255, 237, 237, 237),
                              actions: [
                                IconButton(
                                  icon: Icon(
                                      size: 37.w,
                                      const IconData(
                                        0xe612,
                                        fontFamily: 'Iconfont',
                                      )),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  padding: const EdgeInsets.only(right: 40.0).w,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                      size: 40.w,
                                      const IconData(
                                        0xe726,
                                        fontFamily: 'Iconfont',
                                      )),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  padding: const EdgeInsets.only(right: 33.0).w,
                                  onPressed: () {
                                    vm.showpopup = !vm.showpopup!;
                                    myStore.dispatch({
                                      "type": "showpopup",
                                      "payload": vm.showpopup
                                    });
                                  },
                                ),
                              ],
                            )
                          ]))),

              // 弹出的扫码界面
              if (vm.showpopup!)
                Stack(
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
                        top: devicesPadding.top + 92.w,
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
                                    Icon(
                                        size: 28.w,
                                        Icons.text_rotation_angledown_rounded)
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
                                    GestureDetector(
                                      onTapDown: (details) {
                                        logger.info("发起群聊被点击。");
                                        myStore.dispatch({
                                          "type": "showpopup",
                                          "payload": false
                                        });
                                      },
                                      child: SizedBox(
                                        height: 105.w,
                                        child: Row(children: [
                                          SizedBox(
                                            height: 105.w,
                                            width: 105.w,
                                            child: Center(
                                              child: Icon(
                                                  color: Colors.white,
                                                  size: 50.w,
                                                  Icons.add_location_alt_sharp),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 85, 85, 85),
                                                  width: 2.w,
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
                                                          fontSize: 30.w,
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
                                      ),
                                    ),
                                    GestureDetector(
                                      onTapDown: (details) {
                                        logger.info("添加朋友被点击。");
                                        myStore.dispatch({
                                          "type": "showpopup",
                                          "payload": false
                                        });
                                      },
                                      child: SizedBox(
                                        height: 105.w,
                                        child: Row(children: [
                                          SizedBox(
                                            height: 105.w,
                                            width: 105.w,
                                            child: Center(
                                              child: Icon(
                                                  color: Colors.white,
                                                  size: 50.w,
                                                  Icons.backup_table_rounded),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 85, 85, 85),
                                                  width: 2.w,
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
                                                          fontSize: 30.w,
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
                                      ),
                                    ),
                                    GestureDetector(
                                      onTapDown: (details) {
                                        logger.info("扫一扫被点击。");
                                        myStore.dispatch({
                                          "type": "showpopup",
                                          "payload": false
                                        });
                                      },
                                      child: SizedBox(
                                        height: 105.w,
                                        child: Row(children: [
                                          SizedBox(
                                            height: 105.w,
                                            width: 105.w,
                                            child: Center(
                                              child: Icon(
                                                  color: Colors.white,
                                                  size: 50.w,
                                                  Icons.accessible_rounded),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 85, 85, 85),
                                                  width: 2.w,
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
                                                          fontSize: 30.w,
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
                                      ),
                                    ),
                                    GestureDetector(
                                        onTapDown: (details) {
                                          logger.info("收付款被点击。");
                                          myStore.dispatch({
                                            "type": "showpopup",
                                            "payload": false
                                          });
                                        },
                                        child: SizedBox(
                                          height: 105.w,
                                          child: Row(children: [
                                            SizedBox(
                                              height: 105.w,
                                              width: 105.w,
                                              child: Center(
                                                child: Icon(
                                                    color: Colors.white,
                                                    size: 50.w,
                                                    Icons.qr_code_scanner),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.w,
                                                    style: BorderStyle.solid,
                                                  ))),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '收付款',
                                                        style: TextStyle(
                                                            fontSize: 30.w,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color:
                                                                Colors.white),
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
                ),
            ],
          );
        });
  }
}
