import 'package:flutter/material.dart';
import 'package:flutter_application_1/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNMyMessage extends StatefulWidget {
  const LJNMyMessage({super.key});

  @override
  State<LJNMyMessage> createState() => _LJNMyMessage();
}

class _LJNMyMessage extends State<LJNMyMessage> {
  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return Container(
      padding: const EdgeInsets.all(22).w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 姓名与消息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 姓名
                Container(
                  padding:
                      const EdgeInsets.only(right: 23, top: 0, bottom: 3).w,
                  // height: 33.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "李俊杰",
                          style: TextStyle(
                              fontSize: 20.w,
                              color: const Color.fromARGB(255, 130, 130, 130)),
                        )
                      ]),
                ),
                // 消息
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 消息
                    Flexible(
                        child: Container(
                      constraints: const BoxConstraints(maxWidth: 510).w,
                      // width: 640.w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 158, 236, 114),
                          // border: Border.all(
                          //     color:
                          //         Colors.white,
                          //     width: 1.0.w),
                          borderRadius: BorderRadius.circular(8).w),
                      padding: EdgeInsets.only(
                          top: 22.w, bottom: 22.w, left: 25.w, right: 25.w),
                      child: Text(
                        softWrap: true,
                        maxLines: 1000,
                        overflow: TextOverflow.ellipsis,
                        "你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？",
                        style: TextStyle(fontSize: 30.w, color: Colors.black),
                      ),
                    )),

                    // 箭头
                    Container(
                      padding: const EdgeInsets.only(top: 32, right: 10).w,
                      child: Image.asset(
                        assetPath("images/icon/right.png"),
                        width: 10.w,
                        fit: BoxFit.fitWidth,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 头像
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5).w,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 244, 244, 244),
                        width: 1.w),
                    borderRadius: BorderRadius.circular(5).w,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5).w,
                      child: Image.asset(
                        assetPath("images/avatar_webp/chat_4.webp"),
                        width: 78.w,
                        height: 78.w,
                      )))),
        ],
      ),
    );
  }
}
