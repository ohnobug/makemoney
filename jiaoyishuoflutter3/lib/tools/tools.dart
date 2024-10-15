import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String assetPath(String path) {
  if (kIsWeb) {
    return path;
  }

  if (Platform.isAndroid) {
    return 'assets/$path';
  }

  return 'assets/$path';
}

// 正则表达式匹配所有 emoji
final RegExp emojiRegex = RegExp(
  r'[\u{1F600}-\u{1F64F}]|' // 表情符号
  r'[\u{1F300}-\u{1F5FF}]|' // 符号和图形
  r'[\u{1F680}-\u{1F6FF}]|' // 交通工具和符号
  r'[\u{1F700}-\u{1F77F}]|' // 箭头、符号
  r'[\u{1F780}-\u{1F7FF}]|' // 符号
  r'[\u{1F800}-\u{1F8FF}]|' // 符号
  r'[\u{2600}-\u{26FF}]|' // 各类符号
  r'[\u{2700}-\u{27BF}]|' // 各类符号
  r'[\u{1F900}-\u{1F9FF}]|' // 各类符号
  r'[\u{1FA70}-\u{1FAFF}]|' // emoji v12.0
  r'[\u{200D}]|' // 零宽字符
  r'[\u{2640}\u{2642}]', // 性别符号
  unicode: true,
);
// 解析推文内容，将emoji和文本分开处理
List<TextSpan> buildTextSpans(
    String text, TextStyle fontTextStyle, TextStyle iconTextStyle) {
  List<TextSpan> spans = [];
  final matches = emojiRegex.allMatches(text);
  int lastMatchEnd = 0;

  fontTextStyle = TextStyle(
          color: Colors.black, fontSize: 30.w, fontFamily: "AlibabaPuHuiTi")
      .merge(fontTextStyle);
  iconTextStyle = TextStyle(
          color: Colors.black,
          fontSize: 30.w,
          fontFamily: "NotoColorEmoji-Regular")
      .merge(iconTextStyle);

  for (final match in matches) {
    // 添加前面的非emoji文本
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd, match.start),
        style: fontTextStyle,
      ));
    }
    // 添加emoji
    spans.add(
      TextSpan(
        text: match.group(0),
        style: iconTextStyle,
      ),
    );
    lastMatchEnd = match.end;
  }

  // 添加最后的非emoji文本
  if (lastMatchEnd < text.length) {
    spans.add(
      TextSpan(text: text.substring(lastMatchEnd), style: fontTextStyle),
    );
  }

  return spans;
}
