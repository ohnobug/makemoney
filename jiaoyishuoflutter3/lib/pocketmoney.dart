import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(90.0.w + _statusHeight),
                  child: Container(
                    // color: const Color.fromARGB(255, 237, 237, 237),
                    padding: EdgeInsets.only(top: _statusHeight),
                    child: AppBar(
                      primary: false,
                      title: const Text("朋友圈"),
                      centerTitle: true,
                      titleTextStyle: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(32.w),
                        color: Colors.transparent,
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
                      toolbarHeight: 90.w,
                      elevation: 0,
                      scrolledUnderElevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      leading: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          color: Colors.transparent,
                          child: Icon(
                            const IconData(0xed9e, fontFamily: 'Iconfont'),
                            color: Colors.black,
                            size: 36.w,
                          ),
                        ),
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            // color: Colors.black,
                            height: 90.w,
                            padding: EdgeInsets.only(right: 40.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "零钱明细",
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 32.w),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              body: SizedBox(
                  width: 750.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 90.w,
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
                        height: 30.w,
                      ),
                      // 余额
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Baseline(
                                baseline: -7.5.w, // 根据文字的 fontSize 调整基线
                                baselineType: TextBaseline.alphabetic,
                                child: Icon(
                                  const IconData(
                                    0xe90d,
                                    fontFamily: 'Iconfont',
                                  ),
                                  color: const Color.fromARGB(255, 16, 16, 16),
                                  size: 60.w,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: vm.walletBalance.toString(),
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(85.w),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Quicksand",
                                color: const Color.fromARGB(255, 16, 16, 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      Text(
                        "转入零钱通 , 能赚又能花",
                        style: TextStyle(
                            height: 1.08,
                            color: const Color.fromARGB(255, 231, 159, 83),
                            fontSize: fontSizeScale(30.w),
                            fontFamily: "AlibabaPuHuiTi-Medium"),
                      ),
                      const Expanded(
                        flex: 490,
                        child: SizedBox(),
                      ),

                      const LJNChargeButton(
                        title: "充值",
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(255, 74, 193, 99),
                      ),

                      SizedBox(
                        height: 33.w,
                      ),
                      // ????????
                      const LJNChargeButton(
                        title: "提现",
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
                            fontSize: fontSizeScale(21.w),
                            fontFamily: "AlibabaPuHuiTi-Medium"),
                      ),
                      SizedBox(
                        height: 50.w,
                      ),
                    ],
                  )));
        });
  }
}

class LJNChargeButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final String? link;
  final bool? readonly;

  const LJNChargeButton({
    super.key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.readonly,
    this.link,
  });

  @override
  State<LJNChargeButton> createState() => _LJNChargeButtonState();
}

class _LJNChargeButtonState extends State<LJNChargeButton> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  @override
  void initState() {
    super.initState();

    // 判断是否有 backgroundColor，若没有，则使用默认颜色
    originContainerColor =
        widget.backgroundColor ?? const Color.fromARGB(255, 242, 242, 242);

    setState(() {
      containerColor = originContainerColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = const Color.fromARGB(255, 41, 41, 41);
    if (widget.color is Color) {
      fontColor = widget.color!;
    }

    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.readonly == true) return;

        setState(() {
          containerColor = darkenColor(originContainerColor, 0.11);
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (widget.readonly == true) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (mounted) {
            if (widget.link == 'back') {
              Navigator.of(context).pop();
            } else if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: 95.w,
        width: 345.w,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12.w), // 设置圆角为 12.w
        ),
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: TextStyle(
            height: 1.08,
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSizeScale(32.w),
            fontFamily: "AlibabaPuHuiTi",
          ),
        ),
      ),
    );
  }
}
