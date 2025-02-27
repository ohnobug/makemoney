import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

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

class _ChatListItem extends State<ChatListItem> {
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return GestureDetector(
          onTapDown: (_) {
            setState(() {
              containerColor = const Color.fromARGB(255, 229, 229, 229);
            });
          },
          onTapCancel: () {
            setState(() {
              containerColor = Colors.white;
            });

            logger.info("取消点击");
          },
          onTapUp: (tapDownDetails) {
            Future.delayed(const Duration(milliseconds: 50), () {
              setState(() {
                containerColor = Colors.white;
              });
              widget.onPressed!();
            });

            logger.info("弹起");
          },
          child: Stack(
            children: [
              // 头像以及名称日期等信息
              Container(
                color: containerColor,
                height: 135.0.w,
                padding: const EdgeInsets.only(left: 30.0).w,
                child: Row(
                  children: [
                    // 头像
                    ClipRRect(
                      borderRadius: BorderRadius.circular(widget.avatarRadius ??
                          8.0.w), // Adjust the radius as needed
                      child: Image.asset(
                        assetPath(widget.avatar),
                        width: 90.0.w,
                        height: 90.0.w,
                        cacheHeight: 180.w.toInt(),
                        cacheWidth: 180.w.toInt(),
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: 23.w),

                    // 右边区域
                    Expanded(
                      child: Container(
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          border: Border(
                            bottom: BorderSide(
                              color: widget.underline
                                  ? const Color.fromARGB(255, 242, 242, 242)
                                  : Colors.transparent,
                              width: 1.5.w,
                              style: BorderStyle.solid,
                            ),
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
                                  child: RichText(
                                    strutStyle: StrutStyle(
                                        height: 1.08,
                                        forceStrutHeight: true,
                                        fontSize: 31.w),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      children: buildTextSpans(
                                        widget.friendName,
                                        TextStyle(
                                            height: 1.08,
                                            fontSize: ljnFontSizeScale(31.0.w),
                                            color: widget.notice
                                                ? Colors.red
                                                : Colors.black,
                                            fontFamily: "AlibabaPuHuiTi"),
                                        TextStyle(
                                            height: 1.08,
                                            fontSize: ljnFontSizeScale(31.w),
                                            fontFamily:
                                                "NotoColorEmoji-Regular"),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                // 消息时间
                                widget.lastedTime is String
                                    ? Text(
                                        widget.lastedTime,
                                        style: TextStyle(
                                          height: 1.08,
                                          // fontFamily: "Roboto-Regular",
                                          fontSize: ljnFontSizeScale(25.0.w),
                                          color: widget.notice
                                              ? Colors.red
                                              : const Color.fromARGB(
                                                  255, 170, 170, 170),
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
                                  // color: Colors.amber,
                                  // width: 400.w,
                                  // margin: EdgeInsets.only(right: 65.w),
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      children: buildTextSpans(
                                        widget.message,
                                        TextStyle(
                                          height: 1.08,
                                          fontSize: ljnFontSizeScale(25.w),
                                          color: const Color.fromARGB(
                                              255, 170, 170, 170),
                                        ),
                                        TextStyle(
                                          height: 1.08,
                                          fontSize: ljnFontSizeScale(25.w),
                                          color: const Color.fromARGB(
                                              255, 170, 170, 170),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 铃铛
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  // color: Colors.red,
                                  margin:
                                      EdgeInsets.only(left: 30.w, right: 30.w),
                                  child: widget.notice
                                      ? Icon(
                                          const IconData(
                                            0xe606,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 28.0.w,
                                          color: const Color.fromARGB(
                                              255, 180, 180, 180),
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
                      width: 35.w, // 盒子宽度
                      height: 35.w, // 盒子高度
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // 圆形
                        color: Color.fromRGBO(246, 89, 87, 1), // 盒子颜色
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.badge.toString(), // 这里可以替换成你想要显示的数字
                        maxLines: 1,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: ljnFontSizeScale(20.w), // 数字大小
                          color: Colors.white, // 数字颜色
                          fontWeight: FontWeight.w600,
                          fontFamily: "LJNFont",
                        ),
                      ),
                    ),
                  )
                else if (widget.badge! == -1)
                  Positioned(
                    left: 109.w,
                    top: 20.w,
                    child: Container(
                      width: 20.w, // 盒子宽度
                      height: 20.w, // 盒子高度
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // 圆形
                        color: Color.fromRGBO(246, 89, 87, 1), // 盒子颜色
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
