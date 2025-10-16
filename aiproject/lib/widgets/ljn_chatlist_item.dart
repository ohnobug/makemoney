import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

class ChatListItem extends StatefulWidget {
  final String avatar;
  final double? avatarRadius;
  final String friendName;
  final String message;
  final bool notice;
  final bool underline;
  final dynamic lastedTime;
  final int? badge;
  final Function()? onPressed;

  const ChatListItem({
    super.key,
    required this.avatar,
    this.avatarRadius,
    required this.friendName,
    required this.message,
    required this.notice,
    required this.underline,
    required this.lastedTime,
    this.badge,
    this.onPressed,
  });

  @override
  State<ChatListItem> createState() => _ChatListItem();
}

// =========================================================================
// ====================    这里是完整的、修正后的 State 类    ====================
// =========================================================================
class _ChatListItem extends State<ChatListItem> {
  // 唯一的内部状态：只用来记录列表项是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如此处的 Theme）的值。
    // 这样每次UI刷新（包括主题切换），都能拿到最新的正确颜色。
    ThemeData theme = Theme.of(context);
    Color normalColor = theme.listTileTheme.tileColor!;
    Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 根据内部状态 _isPressed 动态地计算出当前应该显示的背景颜色。
    Color currentColor = _isPressed ? pressedColor : normalColor;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return GestureDetector(
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
              logger.info("取消点击");
            });
          },
          onTapUp: (tapDownDetails) {
            // 延迟一小段时间再执行回调，让用户能看到颜色恢复的动画效果
            Future.delayed(const Duration(milliseconds: 50), () {
              setState(() {
                _isPressed = false;
              });
              // 检查 widget 是否还在树上，并且 onPressed 回调不为空
              if (mounted && widget.onPressed != null) {
                widget.onPressed!();
              }
            });

            logger.info("弹起");
          },
          child: Stack(
            children: [
              // 头像以及名称日期等信息
              Container(
                // 使用在 build 方法开头计算出的正确颜色
                color: currentColor,
                height: 135.0.w,
                padding: const EdgeInsets.only(left: 30.0).w,
                child: Row(
                  children: [
                    // 头像
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.avatarRadius ?? 8.0.w),
                      child: CachedNetworkImage(
                        imageUrl: widget.avatar,
                        width: 90.0.w,
                        height: 90.0.w,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: 23.w),

                    // 右边区域
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: widget.underline
                                ? (theme.listTileTheme.shape
                                        as RoundedRectangleBorder)
                                    .side
                                : BorderSide.none,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 8.w,
                            ),

                            // 好友名称和消息时间
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 好友名称
                                Expanded(
                                    child: LJNTextSpans(
                                  strutStyle: StrutStyle(
                                    height: 1.08,
                                    forceStrutHeight: true,
                                    fontSize: 31.w,
                                  ),
                                  text: widget.friendName,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(31.0.w),
                                    color: widget.notice
                                        ? AppColors.accentRedPure
                                        : theme.colorScheme.onSurface,
                                    
                                  ),
                                  emojiStyle: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(31.w),
                                    fontFamily: "NotoColorEmoji-Regular",
                                  ),
                                )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                // 消息时间
                                widget.lastedTime is String
                                    ? Text(
                                        widget.lastedTime,
                                        style: TextStyle(
                                          height: 1.08,
                                          fontSize: fontSizeScale(25.0.w),
                                          color: widget.notice
                                              ? AppColors.accentRedPure
                                              : AppColors.neutralGrey45,
                                        ),
                                      )
                                    : widget.lastedTime,

                                SizedBox(
                                  width: 30.w,
                                )
                              ],
                            ),

                            SizedBox(height: 10.w),

                            // 好友消息
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: LJNTextSpans(
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
                                ),

                                // 铃铛
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  margin:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
                                  child: widget.notice
                                      ? Icon(
                                          const IconData(
                                            0xe606,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 28.0.w,
                                          color: AppColors.neutralGrey39,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 角标
              if (widget.badge != null)
                if (widget.badge! > 0)
                  Positioned(
                    left: 95.w,
                    top: 16.w,
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(246, 89, 87, 1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.badge.toString(),
                        maxLines: 1,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: fontSizeScale(20.w),
                          color: AppColors.neutralWhite,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  )
                else if (widget.badge! == -1)
                  Positioned(
                    left: 109.w,
                    top: 20.w,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(246, 89, 87, 1),
                      ),
                      child: null,
                    ),
                  )
            ],
          ),
        );
      },
    );
  }
}
