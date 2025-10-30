import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

// 关键改动 1: 创建数据模型来存储静态数据
// 功能项的数据模型
class FunctionItemData {
  final String icon;
  final String link;
  final bool underline;
  // title 将通过 l10n key 来动态获取
  final String titleKey;

  const FunctionItemData({
    required this.icon,
    required this.link,
    required this.underline,
    required this.titleKey,
  });
}

// 联系人项的数据模型
class ContactItemData {
  final String title;
  final String icon;
  final bool underline;

  const ContactItemData({
    required this.title,
    required this.icon,
    this.underline = true,
  });
}

class ContactInformation extends StatefulWidget {
  final String icon;
  final String title;
  final String link;
  final bool underline;
  final int? showStyle;
  final Function()? onPressed;

  const ContactInformation({
    super.key,
    required this.icon,
    required this.title,
    required this.link,
    required this.underline,
    this.showStyle,
    this.onPressed,
  });

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  // 唯一的内部状态：是否被按下
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 在 build 方法中获取所有依赖 context 的信息
    ThemeData theme = Theme.of(context);

    Color normalColor = theme.listTileTheme.tileColor!;
    Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 根据按压状态动态计算当前颜色
    Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        setState(() => _isPressed = true);
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });

          if (widget.onPressed != null) {
            widget.onPressed!();
          } else if (widget.link.isNotEmpty) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, widget.link);
          }
        });
      },
      child: Container(
        height: 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        // 使用在 build 方法中计算出的颜色
        color: currentColor,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.0.w),
              child: VigaAppNetworkImage(
                imageUrl: widget.icon,
                width: 75.0.w,
                height: 75.0.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                height: 100.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? (theme.listTileTheme.shape as RoundedRectangleBorder)
                            .side
                        : BorderSide.none,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(33.0.w),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
