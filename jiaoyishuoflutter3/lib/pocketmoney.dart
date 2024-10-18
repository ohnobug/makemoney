import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNPocketMoneyPage extends StatefulWidget {
  const LJNPocketMoneyPage({super.key});

  @override
  State<LJNPocketMoneyPage> createState() => _LJNPocketMoneyPage();
}

class _LJNPocketMoneyPage extends State<LJNPocketMoneyPage> {
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
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: null,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: _statusHeight + 45.w),
                      width: 750.w,
                      padding: EdgeInsets.symmetric(horizontal: 34.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            }, // 点击事件
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                const IconData(
                                  0xed9e,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 16, 16, 16), // 图标颜色
                                size: 40.w, // 图标大小
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            }, // 点击事件
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                const IconData(
                                  0xe64d,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 16, 16, 16), // 图标颜色
                                size: 45.w, // 图标大小
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 130.w,
                  ),
                  Container(
                    height: 100.w,
                    width: 100.w,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 195, 57),
                      shape: BoxShape.circle, // 设置为圆形
                    ),
                    child: Icon(
                      const IconData(
                        0xe640,
                        fontFamily: 'Iconfont',
                      ),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 46.w,
                    ),
                  ),
                  SizedBox(
                    height: 78.w,
                  ),
                  Text(
                    "我的零钱",
                    style: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(32.w),
                        fontFamily: "AlibabaPuHuiTi-Medium",
                        color: const Color.fromARGB(255, 16, 16, 16)),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  // 余额
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top, // 向上对齐
                          child: Baseline(
                            baseline: 68.w * 0.22, // 根据文字的 fontSize 调整基线
                            baselineType: TextBaseline.alphabetic,
                            child: Icon(
                              const IconData(
                                0xe640,
                                fontFamily: 'Iconfont',
                              ),
                              color: const Color.fromARGB(255, 16, 16, 16),
                              size: 45.w,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: vm.walletBalance.toString(),
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(68.w),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                            color: const Color.fromARGB(255, 16, 16, 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.w,
                  ),
                  Text(
                    "转入零钱通 , 能赚又能花",
                    style: TextStyle(
                        height: 1.08,
                        color: const Color.fromARGB(255, 239, 154, 81),
                        fontSize: fontSizeScale(30.w),
                        fontFamily: "AlibabaPuHuiTi-Medium"),
                  ),
                  const Expanded(
                    flex: 490,
                    child: SizedBox(),
                  ),
                  Container(
                    height: 95.w,
                    width: 345.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 74, 193, 99),
                      borderRadius: BorderRadius.circular(12.w), // 设置圆角为 12.w
                    ),
                    child: Center(
                      child: Text(
                        "充值",
                        style: TextStyle(
                          height: 1.08,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: fontSizeScale(32.w),
                          fontFamily: "AlibabaPuHuiTi-Medium",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 33.w,
                  ),
                  Container(
                    height: 95.w,
                    width: 345.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 242, 242, 242),
                      borderRadius: BorderRadius.circular(12.w), // 设置圆角为 12.w
                    ),
                    child: Center(
                      child: Text(
                        "提现",
                        style: TextStyle(
                          height: 1.08,
                          color: const Color.fromARGB(255, 16, 16, 16),
                          fontSize: fontSizeScale(32.w),
                          fontFamily: "AlibabaPuHuiTi-Medium",
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 143,
                    child: SizedBox(),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "常见问题",
                      style: TextStyle(
                          height: 1.08,
                          color: const Color.fromARGB(255, 58, 81, 124),
                          fontSize: fontSizeScale(25.w),
                          fontFamily: "AlibabaPuHuiTi-Medium"),
                    ),
                    TextSpan(
                      text: " | ",
                      style: TextStyle(
                          height: 1.08,
                          color: const Color.fromARGB(255, 169, 169, 169),
                          fontSize: fontSizeScale(25.w),
                          fontFamily: "AlibabaPuHuiTi-Medium"),
                    ),
                    TextSpan(
                      text: "账户升级服务",
                      style: TextStyle(
                          height: 1.08,
                          color: const Color.fromARGB(255, 58, 81, 124),
                          fontSize: fontSizeScale(25.w),
                          fontFamily: "AlibabaPuHuiTi-Medium"),
                    ),
                  ])),
                  SizedBox(
                    height: 26.w,
                  ),
                  Text(
                    "本服务由财付通和微众银行提供",
                    style: TextStyle(
                        height: 1.08,
                        color: const Color.fromARGB(255, 169, 169, 169),
                        fontSize: fontSizeScale(20.w),
                        fontFamily: "AlibabaPuHuiTi-Medium"),
                  ),
                  SizedBox(
                    height: 50.w,
                  ),
                ],
              ));
        });
  }
}

class TweetWidget extends StatelessWidget {
  final String time;
  final String avatarUrl;
  final String name;
  final String tweetContent;

  const TweetWidget({
    super.key,
    required this.time,
    required this.avatarUrl,
    required this.name,
    required this.tweetContent,
  });

  // 生成随机数
  int generateRandomNumber() {
    var random = Random();
    return random.nextInt(103) + 1; // 生成1到103的随机数
  }

  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      "刘德华💖",
      "周杰伦",
      "王菲",
      "张学友",
      "李宇春💖",
      "特朗普",
      "史泰龙",
      "阿诺舒华"
    ]; // 人名列表

    List<TextSpan> textSpans = [];

    for (int index = 0; index < names.length; index++) {
      final name = names[index];

      textSpans.add(
        TextSpan(
          children: buildTextSpans(
              name,
              TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(27.w),
                  color: const Color.fromARGB(255, 58, 81, 124),
                  fontFamily: "AlibabaPuHuiTi-Medium"),
              TextStyle(
                  height: 1.08,
                  fontSize: fontSizeScale(27.w),
                  fontFamily: "NotoColorEmoji-Regular")),
        ),
      );

      if (index != names.length - 1) {
        // 逗号
        textSpans.add(
          TextSpan(
            text: ", ",
            style: TextStyle(
              height: 1.08,
              fontSize: fontSizeScale(27.w),
              color: const Color.fromARGB(255, 58, 81, 124),
              fontFamily: "AlibabaPuHuiTi-Medium",
            ),
          ),
        );
      }
    }

    return Container(
      width: 750.w,
      padding: EdgeInsets.only(top: 22.w, bottom: 22.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 242, 242, 242),
            width: 1.5.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 头像
          Container(
            width: 77.w,
            height: 77.w,
            margin: EdgeInsets.only(left: 37.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.w),
              child: Image(
                image: ResizeImage(AssetImage(assetPath(avatarUrl)),
                    height: 154.w.toInt(), width: 154.w.toInt()),
                width: 77.w,
                height: 77.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 姓名和推文
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 姓名
                    Text(
                      name,
                      style: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(30.w),
                        fontFamily: "AlibabaPuHuiTi-Medium",
                        // fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 58, 81, 124),
                      ),
                    ),
                    // 推文
                    RichText(
                      text: TextSpan(
                        children: buildTextSpans(
                            tweetContent,
                            TextStyle(
                                height: 1.08, fontSize: fontSizeScale(30.w)),
                            TextStyle(
                                height: 1.08, fontSize: fontSizeScale(30.w))),
                      ),
                    ),
                    SizedBox(height: 20.w),

                    SizedBox(
                      // color: Colors.amber,
                      width: 570.w,
                      height: 570.w,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 每行 3 列
                          mainAxisSpacing: 6.w,
                          crossAxisSpacing: 6.w,
                          childAspectRatio: 1,
                        ),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Image(
                            image: ResizeImage(
                              AssetImage(assetPath(
                                  'images/avatar_webp/chat_${generateRandomNumber()}.webp')),
                              width: 380.w.toInt(),
                              height: 380.w.toInt(),
                            ),
                            fit: BoxFit.cover, // 保持原来的 fit 方式
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20.w),

                    // 显示时间与更多
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 时间
                        Text(
                          time,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(26.w),
                            color: const Color.fromARGB(255, 156, 156, 156),
                          ),
                        ),
                        // 更多
                        GestureDetector(
                          onTap: () {
                            // 点击事件
                          },
                          child: Container(
                            height: 38.w,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 248, 248, 248),
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            child: Center(
                              child: Icon(
                                const IconData(
                                  0xe667,
                                  fontFamily: 'Iconfont',
                                ),
                                size: 37.w,
                                color: const Color.fromARGB(255, 58, 81, 124),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.w),

                    Container(
                      constraints: BoxConstraints(minHeight: 51.w),
                      padding: EdgeInsets.only(
                          left: 18.w, right: 18.w, top: 15.w, bottom: 15.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 247, 247),
                        borderRadius: BorderRadius.circular(5.w), // 设置圆角
                      ),
                      child: Column(
                        // 将 Row 改为 Column
                        crossAxisAlignment: CrossAxisAlignment.start, // 修改对齐方式
                        children: [
                          RichText(
                            maxLines: 1000,
                            overflow: TextOverflow.visible,
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Icon(
                                  const IconData(
                                    0xe70a,
                                    fontFamily: 'Iconfont',
                                  ),
                                  color: const Color.fromARGB(
                                      255, 58, 81, 124), // 图标颜色
                                  size: 30.w, // 图标大小
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 3.w), // 图标和文本之间的间距
                              ),
                              TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(27.w))),
                              ...textSpans
                            ]),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
