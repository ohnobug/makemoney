import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 字体缩放
double fontSizeScale(double size) {
  return size * 1.0;
}

// 图片路径修正
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
// 解析推文内容，将emoji和文本分开处理
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
List<InlineSpan> buildTextSpans(
    String text, TextStyle fontTextStyle, TextStyle iconTextStyle) {
  List<InlineSpan> spans = [];
  final matches = emojiRegex.allMatches(text);
  int lastMatchEnd = 0;

  fontTextStyle = TextStyle(
          height: 1.08,
          color: Colors.black,
          fontSize: fontSizeScale(30.w),
          fontFamily: "AlibabaPuHuiTi")
      .merge(fontTextStyle);

  iconTextStyle = TextStyle(
          height: 1.08,
          color: Colors.black,
          fontSize: fontSizeScale(30.w),
          fontFamily: "NotoColorEmoji-Regular")
      .merge(iconTextStyle);

  // iconTextStyle =
  //     iconTextStyle.merge(TextStyle(fontSize: iconTextStyle.fontSize! * 0.95));

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
        // 为了居中emoji
        WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
                offset: const Offset(0, 0),
                child: SizedBox(
                  width: fontTextStyle.fontSize!,
                  height: fontTextStyle.height! * fontTextStyle.fontSize!,
                  // color: Colors.red,
                  child: Center(
                    child: Text(
                      match.group(0) as String,
                      style: iconTextStyle,
                    ),
                  ),
                ))));

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

// 随机人名
String mockName() {
  List<String> names = [
    "星愿",
    "雨含思念",
    "沧海带不走蝴蝶",
    "池浅",
    "梦之",
    "云落羽",
    "我以为是你",
    "仗剑走天涯",
    "余厌",
    "执笔画倾颜",
    "樱花蜜桃酥",
    "汤十三✌️",
    "浮夸了年华",
    "傲世冷颜",
    "纵横、芯卟死",
    "与孤独合葬",
    "北折",
    "最初呢",
    "嫣花笑、倾城美",
    "林枫听雨",
    "顾辞",
    "孤身浪子",
    "敦睦情谊",
    "夙只希望",
    "柚子伴酒c",
    "演痕、墨轩",
    "别把玩笑当诺言",
    "清河星梦坠落",
    "北街浊酒",
    "筱糖豆﹥ε﹤",
    "孤王戏",
    "堇年",
    "乱世浮生❤️",
    "满身英雄梦",
    "花落人断肠",
    "姐抽的是寂寞",
    "骑驴自拍",
    "亂丗ゐ小苮囡",
    "村头的小怂包儿啊",
    "换胃思考",
    "枕边旧宠",
    "烈火中挣扎",
    "薄凉依稀",
    "夜玉",
    "柚子猫七",
    "黎明前",
    "蓬勃野心😘",
    "吥想苌大",
    "鶴慕",
    "烟雨墨冷竹离殇",
    "灵韵",
    "时光荏苒等谁归",
    "吞了仙女粉",
    "清河星梦坠落",
    "若初见终不悔",
    "彼岸櫻花開得淒美",
    "奴庸",
    "小嘴儿欠啵",
    "含笑拥刀锋",
    "余年寄山水",
    "囚苼🤞",
    "清酒孤欢",
    "那年、那事儿",
    "半度微凉",
    "战帝天",
    "时光如酒你如狗",
    "悲伤逆流成河",
    "果绿森裙",
    "春风乍起",
    "殇。月夜",
    "墨锦倾城染青衣",
    "紅唇",
    "抹平你的忧愁",
    "咕咕奈子鸽",
    "冷月飘霜",
    "吃鸡只用平底锅",
    "美人兮",
    "算了我认输",
    "断缘间",
    "走成熟路线",
    "花事未了",
    "冷瞳少女",
    "笙南",
    "静秋",
    "山川情诗",
    "梦想天空分外蓝",
    "心里无人自有人",
    "云寒",
    "泪倾城-",
    "半度",
    "只对你心动",
    "世界之巅",
    "椛开椛落",
    "酒与心事",
    "傲气与我同生",
    "我趴在云边",
    "踮脚亲你",
    "依稀故人在"
  ];

  Random random = Random();
  return names[random.nextInt(names.length)];
}
