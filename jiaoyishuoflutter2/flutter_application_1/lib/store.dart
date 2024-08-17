import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// 主题数据
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black)),
  colorScheme: const ColorScheme.light(
    primaryContainer: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey,
  ),
  primaryColor: Colors.black,
  fontFamily: "notosanssc",
);

final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black)),
    colorScheme: const ColorScheme.dark(
      primaryContainer: Colors.black,
      primary: Colors.white,
      secondary: Colors.grey,
    ),
    primaryColor: Colors.white,
    fontFamily: "notosanssc");

class StoreType {
  bool? contactazshow; // 通信录中的 A-Z 是否显示
  bool? mainpage1isload; // 页面 1 是否显示
  bool? mainpage2isload; // 页面 2 是否显示
  bool? mainpage3isload; // 页面 3 是否显示
  bool? mainpage4isload; // 页面 4 是否显示
  bool? showpopup; // 扫一扫 是否显示
  ThemeData? themeData;
  double? homescrollpixels; // 首页滚动情况

  StoreType({
    this.contactazshow,
    this.mainpage1isload,
    this.mainpage2isload,
    this.mainpage3isload,
    this.mainpage4isload,
    this.showpopup,
    this.themeData,
    this.homescrollpixels,
  });

  StoreType copyWith({
    bool? contactazshow,
    bool? mainpage1isload,
    bool? mainpage2isload,
    bool? mainpage3isload,
    bool? mainpage4isload,
    bool? showpopup,
    ThemeData? themeData,
    double? homescrollpixels,
  }) {
    return StoreType(
        contactazshow: contactazshow ?? this.contactazshow,
        mainpage1isload: mainpage1isload ?? this.mainpage1isload,
        mainpage2isload: mainpage2isload ?? this.mainpage2isload,
        mainpage3isload: mainpage3isload ?? this.mainpage3isload,
        mainpage4isload: mainpage4isload ?? this.mainpage4isload,
        showpopup: showpopup ?? this.showpopup,
        themeData: themeData ?? this.themeData,
        homescrollpixels: homescrollpixels ?? this.homescrollpixels);
  }
}

StoreType counterReducer(StoreType state, dynamic action) {
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

  return state;
}

final myStore = Store<StoreType>(counterReducer,
    initialState: StoreType(
      contactazshow: false,
      mainpage1isload: false,
      mainpage2isload: false,
      mainpage3isload: false,
      mainpage4isload: false,
      showpopup: false,
      themeData: lightTheme,
      homescrollpixels: 0.0,
    ));
