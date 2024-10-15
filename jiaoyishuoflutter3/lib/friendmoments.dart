import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNFriendmomentsPage extends StatefulWidget {
  const LJNFriendmomentsPage({super.key});

  @override
  State<LJNFriendmomentsPage> createState() => _LJNFriendmomentsPage();
}

class _LJNFriendmomentsPage extends State<LJNFriendmomentsPage> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: null,
              body: Column(
                children: [
                  // 背景信息
                  SizedBox(
                      height: _statusHeight + 630.w,
                      width: 750.w,
                      child: Stack(
                        children: [
                          // 背景
                          Image.asset(
                            assetPath('images/avatar/fj.jpg'),
                            width: 750.w,
                            height: _statusHeight + 530.w,
                            fit: BoxFit.cover,
                          ),

                          // 返回按钮
                          Positioned(
                              top: 45.w,
                              child: Container(
                                  width: 750.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 34.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          // wallet
                                        }, // 点击事件
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Icon(
                                            const IconData(
                                              0xed9e,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255), // 图标颜色
                                            size: 40.w, // 图标大小
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          // wallet
                                        }, // 点击事件
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Icon(
                                            const IconData(
                                              0xe64d,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255), // 图标颜色
                                            size: 45.w, // 图标大小
                                          ),
                                        ),
                                      )
                                    ],
                                  ))),

                          // 头像以及姓名
                          Positioned(
                              top: 460.w,
                              child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 35.w),
                                  width: 750.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 15.w, top: 10.w),
                                          child: Text(
                                            vm.userinfoName!,
                                            style: TextStyle(
                                                fontSize: 40.w,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10).w,
                                        child: Image.asset(
                                          vm.userinfoAvatar as String,
                                          width: 120.w,
                                          height: 120.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )))
                        ],
                      )),
                  // 样式1
                  SizedBox(
                    width: 750.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 77.w,
                            height: 77.w,
                            margin: EdgeInsets.only(left: 37.w, right: 20.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10).w,
                              child: Image.asset(
                                vm.userinfoAvatar as String,
                                width: 77.w,
                                height: 77.w,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 10.w,
                                // ),
                                Text(
                                  "考研第一名",
                                  style: TextStyle(
                                      fontSize: 35.w,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 74, 88, 142)),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "用坚持和努力,定义自己的未来。每一天,都是一次新的开始。不要让犹豫阻挡你前行的脚步,最适合行动的时间,就是现在。早安",
                                        style: TextStyle(
                                            fontSize: 35.w,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: "☀️", // 将太阳符号放到下一行
                                        style: TextStyle(
                                            fontSize: 35.w,
                                            fontFamily:
                                                "NotoColorEmoji-Regular"),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
