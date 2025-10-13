// --- 小程序列表项组 ---
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

class LJNFunctionListSection extends StatelessWidget {
  final String title;
  final String moreUrl;
  final List<LJNChatListItem> chatItems;

  const LJNFunctionListSection({
    super.key,
    required this.title,
    required this.chatItems,
    required this.moreUrl,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        top: 18,
        left: 18,
        right: 18,
      ).w,
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16.0).w,
      ),
      padding: const EdgeInsets.only(bottom: 16).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 33.w,
              bottom: 16.w,
              left: 30.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(28.w),
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (moreUrl.isNotEmpty)
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, moreUrl),
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(right: 33.w),
                      child: Icon(
                        const IconData(0xe659, fontFamily: 'Iconfont'),
                        size: 37.w,
                      ),
                    ),
                  )
              ],
            ),
          ),
          ListView.builder(
            primary: false,
            itemCount: chatItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => chatItems[index],
          ),
        ],
      ),
    );
  }
}

// --- 小程序列表项 (已修正) ---
class LJNChatListItem extends StatefulWidget {
  final String avatar;
  final String friendName;
  final String message;
  final Function()? onPressed;

  const LJNChatListItem({
    super.key,
    required this.avatar,
    required this.friendName,
    required this.message,
    this.onPressed,
  });

  @override
  State<LJNChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<LJNChatListItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;
    final Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        color: currentColor,
        height: 135.0.w,
        padding: const EdgeInsets.only(left: 30.0).w,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(95).w,
              child: CachedNetworkImage(
                imageUrl: widget.avatar,
                width: 95.w,
                height: 95.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 23.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12.w),
                  LJNTextSpans(
                    text: widget.friendName,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(28.0.w),
                      color: theme.colorScheme.onSurface,
                      fontFamily: "AlibabaPuHuiTi",
                    ),
                    emojiStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(28.w),
                      fontFamily: "NotoColorEmoji-Regular",
                    ),
                  ),
                  SizedBox(height: 10.w),
                  LJNTextSpans(
                    text: widget.message,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(25.w),
                      color: AppColors.neutralGrey45,
                    ),
                    emojiStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(25.w),
                      color: AppColors.neutralGrey45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
