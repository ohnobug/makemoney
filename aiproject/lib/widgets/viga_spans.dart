import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_tools.dart';

// ignore: non_constant_identifier_names
List<InlineSpan> VigaBuildspan(
  BuildContext context,
  String text,
  TextStyle? fontTextStyle,
  TextStyle? iconTextStyle,
) {
  ThemeData theme = Theme.of(context);

  List<InlineSpan> spans = [];
  final matches = emojiRegex.allMatches(text);
  int lastMatchEnd = 0;

  // 为字体和图标设置默认样式，并与传入的样式合并
  TextStyle defaultFontTextStyle = TextStyle(
    height: 1.08,
    color: theme.colorScheme.onSurface,
    fontSize: 30.sp, // 使用 sp 适配字体大小
    
  ).merge(fontTextStyle);

  TextStyle defaultIconTextStyle = TextStyle(
    height: 1.08,
    color: theme.colorScheme.onSurface,
    fontSize: 30.sp, // 使用 sp 适配字体大小
    fontFamily: "NotoColorEmoji-Regular",
  ).merge(iconTextStyle);

  defaultIconTextStyle = defaultIconTextStyle.merge(
    TextStyle(fontSize: defaultFontTextStyle.fontSize! * 0.9),
  );

  for (final match in matches) {
    // 添加前面的非 emoji 文本
    if (match.start > lastMatchEnd) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: defaultFontTextStyle,
        ),
      );
    }

    double iconHeight =
        (defaultIconTextStyle.height! * defaultIconTextStyle.fontSize!);

    // 添加 emoji
    spans.add(
      // 为了居中 emoji
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          width: iconHeight * 1.2,
          height: iconHeight,
          alignment: Alignment.topLeft,
          child: Text(
            match.group(0) as String,
            style: defaultIconTextStyle,
            strutStyle: StrutStyle(
              fontSize: defaultIconTextStyle.fontSize,
              forceStrutHeight: true,
              height: 1,
            ),
          ),
        ),
      ),
    );

    lastMatchEnd = match.end;
  }

  // 添加最后的非 emoji 文本
  if (lastMatchEnd < text.length) {
    spans.add(
      TextSpan(
        text: text.substring(lastMatchEnd),
        style: defaultFontTextStyle,
      ),
    );
  }

  return spans;
}
