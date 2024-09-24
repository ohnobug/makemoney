import 'package:flutter/material.dart';
import 'package:flutter_application_1/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNReceiveMessage extends StatefulWidget {
  const LJNReceiveMessage({super.key});

  @override
  State<LJNReceiveMessage> createState() => _LJNReceiveMessage();
}

class _LJNReceiveMessage extends State<LJNReceiveMessage> {
  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return Container(
      padding: const EdgeInsets.all(22).w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        assetPath("images/avatar_webp/chat_8.webp"),
                        width: 78.w,
                        height: 78.w,
                      )))),
          // SizedBox(width: 10.w,),
          // 姓名与消息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 姓名
                Container(
                  padding: const EdgeInsets.only(left: 23, top: 0, bottom: 3).w,
                  // height: 33.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "许信将",
                          style: TextStyle(
                              fontSize: 20.w,
                              color: const Color.fromARGB(255, 130, 130, 130)),
                        )
                      ]),
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
                      // width: 640.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(
                          //     color:
                          //         Colors.white,
                          //     width: 1.0.w),
                          borderRadius: BorderRadius.circular(8).w),
                      padding: EdgeInsets.only(
                          top: 22.w, bottom: 24.w, left: 25.w, right: 22.w),
                      child: Text(
                        softWrap: true,
                        maxLines: 1000,
                        overflow: TextOverflow.ellipsis,
                        "你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？你那个中介靠谱吗？",
                        style: TextStyle(fontSize: 29.w, color: Colors.black),
                      ),
                    )),
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