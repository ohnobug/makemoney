import 'package:flutter/material.dart';
import 'package:vigaviga/widgets/ljn_spans.dart';

// 这是一个常用的匹配 emoji 的正则表达式
final emojiRegex = RegExp(
    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

class LJNTextSpans extends StatelessWidget {
  final String text;
  final TextOverflow textOverflow;
  final TextStyle? style;
  final TextStyle? emojiStyle;
  final int? maxLines;
  final StrutStyle? strutStyle;

  const LJNTextSpans(
      {super.key,
      required this.text,
      this.style,
      this.emojiStyle,
      this.maxLines = 1,
      this.textOverflow = TextOverflow.ellipsis,
      this.strutStyle});

  @override
  Widget build(BuildContext context) {
    // 在 Widget 的 build 方法内部构建 TextSpan 列表
    List<InlineSpan> spans = LJNBuildspan(context, text, style, emojiStyle);

    return RichText(
      maxLines: maxLines,
      overflow: textOverflow,
      strutStyle: strutStyle,
      text: TextSpan(
        children: spans,
      ),
    );
  }
}
