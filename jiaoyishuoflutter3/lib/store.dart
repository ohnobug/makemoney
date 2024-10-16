import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// 主题数据
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      // titleTextStyle: TextStyle(
      //   fontSize: 30.w,
      //     color: Color.fromARGB(255, 157, 17, 17), fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.black)),
  // tabBarTheme:
  //     const TabBarTheme(labelStyle: TextStyle(fontFamily: "AlibabaPuHuiTi")),
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  tabBarTheme:
      const TabBarTheme(labelStyle: TextStyle(fontFamily: "AlibabaPuHuiTi")),
  primaryColor: Colors.black,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      // titleTextStyle: TextStyle(
      //     color: Color.fromARGB(255, 157, 17, 17),
      //     fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.black)),
  // tabBarTheme:
  //     const TabBarTheme(labelStyle: TextStyle(fontFamily: "AlibabaPuHuiTi")),
  colorScheme: const ColorScheme.dark(
    primaryContainer: Colors.black,
    primary: Colors.white,
    secondary: Colors.grey,
  ),
  tabBarTheme:
      const TabBarTheme(labelStyle: TextStyle(fontFamily: "AlibabaPuHuiTi")),
  primaryColor: Colors.white,
  fontFamilyFallback: const ['Noto Sans SC'],
);

class StoreType {
  String? userinfoName; // 昵称
  String? userinfoAccount; // 账号
  double? walletBalance; // 余额
  double? walletFoundationBalance; // 基金余额
  String? userinfoAvatar; // 头像

  bool? contactazshow; // 通信录中的 A-Z 是否显示
  bool? mainpage1isload; // 页面 1 是否显示
  bool? mainpage2isload; // 页面 2 是否显示
  bool? mainpage3isload; // 页面 3 是否显示
  bool? mainpage4isload; // 页面 4 是否显示
  bool? showpopup; // 扫一扫 是否显示

  Color? button1Bg;
  Color? button2Bg;
  Color? button3Bg;
  Color? button4Bg;

  ThemeData? themeData;
  double? homescrollpixels; // 首页滚动情况

  StoreType({
    this.userinfoName,
    this.userinfoAccount,
    this.walletBalance,
    this.walletFoundationBalance,
    this.userinfoAvatar,
    this.contactazshow,
    this.mainpage1isload,
    this.mainpage2isload,
    this.mainpage3isload,
    this.mainpage4isload,
    this.showpopup,
    this.themeData,
    this.homescrollpixels,
    this.button1Bg,
    this.button2Bg,
    this.button3Bg,
    this.button4Bg,
  });

  StoreType copyWith({
    String? userinfoName,
    String? userinfoAccount,
    double? walletBalance,
    double? walletFoundationBalance,
    String? userinfoAvatar,
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
    bool? showpopup,
    ThemeData? themeData,
    double? homescrollpixels,
    Color? button1Bg,
    Color? button2Bg,
    Color? button3Bg,
    Color? button4Bg,
  }) {
    return StoreType(
      userinfoName: userinfoName ?? this.userinfoName,
      userinfoAccount: userinfoAccount ?? this.userinfoAccount,
      walletBalance: walletBalance ?? this.walletBalance,
      walletFoundationBalance:
          walletFoundationBalance ?? this.walletFoundationBalance,
      userinfoAvatar: userinfoAvatar ?? this.userinfoAvatar,
      contactazshow: contactazshow ?? this.contactazshow,
      mainpage1isload: mainpage1isload ?? this.mainpage1isload,
      mainpage2isload: mainpage2isload ?? this.mainpage2isload,
      mainpage3isload: mainpage3isload ?? this.mainpage3isload,
      mainpage4isload: mainpage4isload ?? this.mainpage4isload,
      showpopup: showpopup ?? this.showpopup,
      themeData: themeData ?? this.themeData,
      homescrollpixels: homescrollpixels ?? this.homescrollpixels,
      button1Bg: button1Bg ?? this.button1Bg,
      button2Bg: button2Bg ?? this.button2Bg,
      button3Bg: button3Bg ?? this.button3Bg,
      button4Bg: button4Bg ?? this.button4Bg,
    );
  }
}

StoreType counterReducer(StoreType state, dynamic action) {
  if (action['type'] == "themeData") {
    return state.copyWith(themeData: action['payload']);
  }

  if (action['type'] == "userinfoName") {
    return state.copyWith(userinfoName: action['payload']);
  }

  if (action['type'] == "userinfoAccount") {
    return state.copyWith(userinfoAccount: action['payload']);
  }

  if (action['type'] == "walletBalance") {
    return state.copyWith(walletBalance: action['payload']);
  }

  if (action['type'] == "walletFoundationBalance") {
    return state.copyWith(walletFoundationBalance: action['payload']);
  }

  if (action['type'] == "userinfoAvatar") {
    return state.copyWith(userinfoAvatar: action['payload']);
  }

  if (action['type'] == "contactazshow") {
    return state.copyWith(contactazshow: action['payload']);
  }

  if (action['type'] == "mainpage1isload") {
    return state.copyWith(mainpage1isload: action['payload']);
  }

  if (action['type'] == "mainpage2isload") {
    return state.copyWith(mainpage2isload: action['payload']);
  }

  if (action['type'] == "mainpage3isload") {
    return state.copyWith(mainpage3isload: action['payload']);
  }

  if (action['type'] == "mainpage4isload") {
    return state.copyWith(mainpage4isload: action['payload']);
  }

  if (action['type'] == "showpopup") {
    return state.copyWith(showpopup: action['payload']);
  }

  if (action['type'] == "homescrollpixels") {
    return state.copyWith(homescrollpixels: action['payload']);
  }

  if (action['type'] == "button1Bg") {
    return state.copyWith(button1Bg: action['payload']);
  }

  if (action['type'] == "button2Bg") {
    return state.copyWith(button2Bg: action['payload']);
  }

  if (action['type'] == "button3Bg") {
    return state.copyWith(button3Bg: action['payload']);
  }

  if (action['type'] == "button4Bg") {
    return state.copyWith(button4Bg: action['payload']);
  }

  return state;
}

final myStore = Store<StoreType>(counterReducer,
    initialState: StoreType(
        userinfoName: "",
        userinfoAccount: "",
        walletBalance: 0.0,
        walletFoundationBalance: 0.0,
        userinfoAvatar: "",
        contactazshow: false,
        mainpage1isload: false,
        mainpage2isload: false,
        mainpage3isload: false,
        mainpage4isload: false,
        showpopup: false,
        themeData: lightTheme,
        homescrollpixels: 0.0,
        button1Bg: const Color.fromARGB(255, 76, 76, 76),
        button2Bg: const Color.fromARGB(255, 76, 76, 76),
        button3Bg: const Color.fromARGB(255, 76, 76, 76),
        button4Bg: const Color.fromARGB(255, 76, 76, 76)));
