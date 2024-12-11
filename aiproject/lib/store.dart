import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// 主题数据
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      // titleTextStyle: TextStyle(height: 1.08,
      //   fontSize: fontSizeScale(30.w),
      //     color: Color.fromARGB(255, 157, 17, 17), fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.black)),
  // tabBarTheme:
  //     const TabBarTheme(labelStyle: TextStyle(height: 1.08,fontFamily: "AlibabaPuHuiTi")),
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(height: 1.08, fontFamily: "AlibabaPuHuiTi")),
  primaryColor: Colors.black,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      // titleTextStyle: TextStyle(height: 1.08,
      //     color: Color.fromARGB(255, 157, 17, 17),
      //     fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: Colors.black)),
  // tabBarTheme:
  //     const TabBarTheme(labelStyle: TextStyle(height: 1.08,fontFamily: "AlibabaPuHuiTi")),
  colorScheme: const ColorScheme.dark(
    primaryContainer: Colors.black,
    primary: Colors.white,
    secondary: Colors.grey,
  ),
  tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(height: 1.08, fontFamily: "AlibabaPuHuiTi")),
  primaryColor: Colors.black,
  fontFamily: "AlibabaPuHuiTi",
  fontFamilyFallback: const ['Noto Sans SC'],
);

class StoreType {
  String? userinfoName; // 昵称
  String? userinfoAccount; // 账号
  String? userinfoPhone; // 手机

  double? walletBalance; // 余额
  double? walletFoundationBalance; // 基金余额
  String? userinfoAvatar; // 头像
  bool? showMiniProgramDrawer; // 显示小程序抽屉

  bool? contactazshow; // 通信录中的 A-Z 是否显示
  bool? mainpage1isload; // 页面 1 是否显示
  bool? mainpage2isload; // 页面 2 是否显示
  bool? mainpage3isload; // 页面 3 是否显示
  bool? mainpage4isload; // 页面 4 是否显示

  ThemeData? themeData;
  double homescrollpixels = 0; // 首页滚动情况

  Size? screenSize;
  double? statusHeight;

  StoreType(
      {this.userinfoName,
      this.userinfoAccount,
      this.userinfoPhone,
      this.walletBalance,
      this.walletFoundationBalance,
      this.userinfoAvatar,
      this.showMiniProgramDrawer,
      this.contactazshow,
      this.mainpage1isload,
      this.mainpage2isload,
      this.mainpage3isload,
      this.mainpage4isload,
      this.themeData,
      required this.homescrollpixels,
      this.screenSize,
      this.statusHeight});

  StoreType copyWith({
    String? userinfoName,
    String? userinfoAccount,
    String? userinfoPhone,
    double? walletBalance,
    double? walletFoundationBalance,
    String? userinfoAvatar,
    bool? showMiniProgramDrawer,
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
    ThemeData? themeData,
    double? homescrollpixels,
    Size? screenSize,
    double? statusHeight,
  }) {
    return StoreType(
      userinfoName: userinfoName ?? this.userinfoName,
      userinfoAccount: userinfoAccount ?? this.userinfoAccount,
      userinfoPhone: userinfoPhone ?? this.userinfoPhone,
      walletBalance: walletBalance ?? this.walletBalance,
      walletFoundationBalance:
          walletFoundationBalance ?? this.walletFoundationBalance,
      userinfoAvatar: userinfoAvatar ?? this.userinfoAvatar,
      showMiniProgramDrawer:
          showMiniProgramDrawer ?? this.showMiniProgramDrawer,
      contactazshow: contactazshow ?? this.contactazshow,
      mainpage1isload: mainpage1isload ?? this.mainpage1isload,
      mainpage2isload: mainpage2isload ?? this.mainpage2isload,
      mainpage3isload: mainpage3isload ?? this.mainpage3isload,
      mainpage4isload: mainpage4isload ?? this.mainpage4isload,
      themeData: themeData ?? this.themeData,
      homescrollpixels: homescrollpixels ?? this.homescrollpixels,
      screenSize: screenSize ?? this.screenSize,
      statusHeight: statusHeight ?? this.statusHeight,
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

  if (action['type'] == "userinfoPhone") {
    return state.copyWith(userinfoPhone: action['payload']);
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

  if (action['type'] == "showMiniProgramDrawer") {
    return state.copyWith(showMiniProgramDrawer: action['payload']);
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

  if (action['type'] == "homescrollpixels") {
    return state.copyWith(homescrollpixels: action['payload']);
  }

  if (action['type'] == "screenSize") {
    return state.copyWith(screenSize: action['payload']);
  }

  if (action['type'] == "statusHeight") {
    return state.copyWith(statusHeight: action['payload']);
  }
  return state;
}

final myStore = Store<StoreType>(counterReducer,
    initialState: StoreType(
        userinfoName: "",
        userinfoAccount: "",
        userinfoPhone: "",
        walletBalance: 0.0,
        walletFoundationBalance: 0.0,
        userinfoAvatar: "",
        showMiniProgramDrawer: false,
        contactazshow: false,
        mainpage1isload: false,
        mainpage2isload: false,
        mainpage3isload: false,
        mainpage4isload: false,
        themeData: lightTheme,
        homescrollpixels: 0.0,
        screenSize: const Size(0, 0),
        statusHeight: 0.0));
