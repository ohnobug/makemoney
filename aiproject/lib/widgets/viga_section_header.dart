// 文件路径: lib/widgets/viga_section_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 一个可复用的区域标题组件
///
/// 包含一个左侧的大标题和一个可选的右侧“查看全部”按钮。
class VigaSectionHeader extends StatelessWidget {
  /// 区域的标题文字
  final String title;

  /// 是否显示右侧的“查看全部”按钮，默认为 true
  final bool showMore;

  /// “查看全部”按钮的文字，默认为 "查看全部"
  final String moreText;

  /// 点击“查看全部”按钮时的回调函数
  final VoidCallback? onMoreTap;

  /// 组件的内边距，可以自定义
  final EdgeInsetsGeometry? padding;

  const VigaSectionHeader({
    super.key,
    required this.title,
    this.showMore = true,
    this.moreText = "查看全部",
    this.onMoreTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      // 优先使用传入的 padding，否则使用默认值
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // 垂直居中对齐
        children: [
          // 左侧标题
          Text(
            title,
            style: TextStyle(
              fontSize: 32.w,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),

          // 右侧“查看全部”按钮（条件渲染）
          if (showMore)
            // 使用 GestureDetector 来添加点击事件
            GestureDetector(
              onTap: onMoreTap,
              // 设置 behavior: HitTestBehavior.opaque 可以让整个 Row 区域都能响应点击
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min, // 让 Row 包裹内容
                children: [
                  Text(
                    moreText,
                    style: TextStyle(fontSize: 24.w, color: theme.hintColor),
                  ),
                  SizedBox(width: 10.w),
                  Icon(
                    const IconData(0xed9d, fontFamily: 'Iconfont'),
                    size: 20.0.w,
                    color: theme.colorScheme.onSurface.withAlpha(100),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
