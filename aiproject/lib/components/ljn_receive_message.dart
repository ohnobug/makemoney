import 'package:flutter/material.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNReceiveMessage extends StatefulWidget {
  const LJNReceiveMessage({
    super.key,
    required this.message,
    required this.showName,
    required this.friendAvatar,
    required this.name,
    this.onFriendAvatarTap,
  });

  final String name;
  final bool showName;
  final String message;
  final String friendAvatar;
  final Function? onFriendAvatarTap;

  @override
  State<LJNReceiveMessage> createState() => _LJNReceiveMessage();
}

class _LJNReceiveMessage extends State<LJNReceiveMessage> {
  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return Container(
      padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          GestureDetector(
            onTap: () {
              if (widget.onFriendAvatarTap != null) {
                widget.onFriendAvatarTap!();
              }

              Navigator.pushNamed(context, '/friendprofile',
                  arguments: <String, String>{
                    'name': widget.name,
                    'avatar': widget.friendAvatar,
                    'nickname': widget.name,
                    'account': "tathagata_buddha_loveyou",
                  });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8).w,
              child: Image.asset(
                assetPath(widget.friendAvatar),
                cacheWidth: 156.w.toInt(),
                cacheHeight: 156.w.toInt(),
                width: 78.w,
                height: 78.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // SizedBox(width: 10.w,),
          // 姓名与消息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 姓名
                if (widget.showName)
                  Container(
                    padding:
                        const EdgeInsets.only(left: 23, top: 0, bottom: 3).w,
                    // height: 33.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(20.w),
                            color: AppColors.neutralGrey66,
                          ),
                        )
                      ],
                    ),
                  ),
                // 消息
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 箭头
                    Container(
                      padding: const EdgeInsets.only(top: 32, left: 10).w,
                      child: Image.asset(
                        assetPath("images/icon_webp/left.png"),
                        width: 10.w,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    // 消息
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 510).w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8).w,
                        ),
                        padding: EdgeInsets.only(
                          top: 20.w,
                          bottom: 18.w,
                          left: 23.w,
                          right: 22.w,
                        ),
                        child: Text(
                          softWrap: true,
                          maxLines: 1000,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          widget.message,
                          style: TextStyle(
                            height: 1.25,
                            fontSize: fontSizeScale(31.w),
                            color: Colors.black,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
