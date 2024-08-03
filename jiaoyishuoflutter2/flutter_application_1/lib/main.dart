import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:flutter_application_1/services.dart';
import 'package:provider/provider.dart';
import 'logger.dart';
import 'user.dart';
import 'chat.dart';
import 'provider.dart' as provider;
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  setupLogger(); // 配置全局 Logger

  // 示例用法
  logger.info('Application is starting...');

  await ScreenUtil.ensureScreenSize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => provider.ThemeProvider(lightTheme),
      child: const TabBarApp(),
    ),
  );
}

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        enableScaleWH: () => false,
        enableScaleText: () => false,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        child: MaterialApp(
          initialRoute: '/',
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return PageRouteBuilder<dynamic>(
                pageBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) =>
                    const TabBarExample(),
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
        ));
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
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
            height: 58.w,
            icon: const Icon(Icons.cloud_outlined),
            text: "微信",
          ),
          Tab(
            height: 58.w,
            icon: const Icon(Icons.beach_access_sharp),
            text: "通信录",
          ),
          Tab(
            height: 58.w,
            icon: const Icon(Icons.brightness_5_sharp),
            text: "发现",
          ),
          Tab(
            height: 58.w,
            icon: const Icon(Icons.brightness_6_sharp),
            text: "我",
          ),
        ],
      ),
      body: TabBarView(
        // physics: new NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const <Widget>[
          ChatListView(),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
          Center(
            child: LJNUserInfo(),
          ),
        ],
      ),
    );
  }
}
