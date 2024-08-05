import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/discovery.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/store.dart';
import 'package:provider/provider.dart';
import 'contact.dart';
import 'logger.dart';
import 'user.dart';
import 'chat.dart';
import 'provider.dart' as provider;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';



void main() async {
  setupLogger(); // 配置全局 Logger

  // 示例用法
  logger.info('Application is starting...');

  await ScreenUtil.ensureScreenSize();


  runApp(
    ChangeNotifierProvider(
      create: (_) => provider.ThemeProvider(lightTheme),
      child: TabBarApp(store: mystore),
    ),
  );
}

class TabBarApp extends StatelessWidget {
  final Store<bool> store;

  const TabBarApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return StoreProvider<bool>(
        store: store,
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
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return PageRouteBuilder<dynamic>(
                    pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) =>
                        const CustomTabbar(),
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
                        const Services(),
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
              theme: themeProvider.themeData,
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

  late Store<bool> store;

  @override
  void initState() {
    super.initState();

    store = StoreProvider.of<bool>(context, listen: false);

    _tabController = TabController(length: 4, vsync: this);
    _tabController.animation!.addListener(() {

      if (_tabController.animation!.value == 1) {
        logger.info("来了");
        store.dispatch({"type": "mainAnimation", "payload": true});
      } else {
        logger.info("走了");
        store.dispatch({"type": "mainAnimation", "payload": false});
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    if (changeIcon == 0) {
      icon1 = Icon(
        const IconData(
          0xe676,
          fontFamily: 'Iconfont',
        ),
        size: 50.w,
      );
    } else if (changeIcon == 1) {
      icon2 = Icon(
        const IconData(
          0xe609,
          fontFamily: 'Iconfont',
        ),
        size: 50.w,
      );
    } else if (changeIcon == 2) {
      icon3 = Icon(
        const IconData(
          0xe638,
          fontFamily: 'Iconfont',
        ),
        size: 50.w,
      );
    } else if (changeIcon == 3) {
      icon4 = Icon(
        const IconData(
          0xe62b,
          fontFamily: 'Iconfont',
        ),
        size: 50.w,
      );
    }

    return Scaffold(
        bottomNavigationBar: ColoredBox(
          color: const Color.fromARGB(255, 247, 247, 247),
          child: TabBar(
            dividerColor: const Color.fromARGB(255, 218, 218, 218),
            labelColor: const Color.fromARGB(255, 43, 174, 106),
            unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0),
            indicator: const BoxDecoration(),
            indicatorColor: Colors.transparent,
            // indicatorWeight: 30,
            controller: _tabController,
            overlayColor: WidgetStateProperty.all(const Color(0x00000000)),
            // TabBarTheme: ThemeData(useMaterial3: false),
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
        body: TabBarView(
          // physics: new NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const <Widget>[
            LJNChatListView(),
            LJNContactPage(),
            LJNDiscoveryPage(),
            LJNUserPage(),
          ],
        ));
  }
}
