import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNCollectionAndPayment extends StatefulWidget {
  const LJNCollectionAndPayment({super.key});

  @override
  State<LJNCollectionAndPayment> createState() =>
      _LJNCollectionAndPaymentState();
}

class _LJNCollectionAndPaymentState extends State<LJNCollectionAndPayment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: const LJNAppBar(
                title: "收付款",
                bgColor: Color.fromARGB(255, 42, 172, 102),
                color: Colors.white,
              ),
              body: ColoredBox(
                  color: const Color.fromARGB(255, 42, 172, 102),
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: 15.w, left: 15.w, right: 15.w),
                                padding: EdgeInsets.all(30.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.w)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 110.w,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1.w,
                                                    color: const Color.fromARGB(
                                                        255, 243, 243, 243)))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  const IconData(
                                                    0xe611,
                                                    fontFamily: 'Iconfont',
                                                  ), // 使用的图标
                                                  color: const Color.fromARGB(
                                                      255, 0, 213, 106), // 图标颜色
                                                  size: 35.w, // 图标大小
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  "付款码",
                                                  style: TextStyle(
                                                      fontSize: 32.w,
                                                      height: 1.08,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              0,
                                                              213,
                                                              106)),
                                                )
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // 点击事件
                                              },
                                              child: Container(
                                                height: 90.w,
                                                color: Colors.transparent,
                                                child: Icon(
                                                  color: const Color.fromARGB(
                                                      255, 181, 181, 181),
                                                  const IconData(
                                                    0xe659,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  size: 43.w, // 图标大小
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      height: 40.w,
                                    ),
                                    Text(
                                      "优先使用零钱付款",
                                      style: TextStyle(
                                          fontSize: 25.w,
                                          color: const Color.fromARGB(
                                              255, 157, 161, 162)),
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Image.asset(
                                      assetPath("images/avatar/linecode.png"),
                                      width: 630.0.w,
                                      height: 195.0.w,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 55.w,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(bottom: 60.w),
                                        height: 320.w,
                                        width: vm.screenSize!.width,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1.w,
                                                    color: const Color.fromARGB(
                                                        255, 243, 243, 243)))),
                                        child: Image.asset(
                                          assetPath("images/avatar/qrcode.png"),
                                          width: 320.0.w,
                                          height: 320.0.w,
                                          fit: BoxFit.contain,
                                        )),
                                    SizedBox(
                                      height: 33.w,
                                    ),
                                    Column(
                                      children: [
                                        // 优先付款方式
                                        SizedBox(
                                          width: vm.screenSize!.width,
                                          height: 25.w,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "优先付款方式",
                                                style: TextStyle(
                                                    fontSize: 25.w,
                                                    height: 1.08,
                                                    color: const Color.fromARGB(
                                                        255, 96, 96, 96)),
                                              ),
                                              Flex(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Text(
                                                    "更改",
                                                    style: TextStyle(
                                                        fontSize: 25.w,
                                                        height: 1.08,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 96, 96, 96)),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Icon(
                                                    const IconData(
                                                      0xe891,
                                                      fontFamily: 'Iconfont',
                                                    ), // 使用的图标
                                                    color: const Color.fromARGB(
                                                        255,
                                                        96,
                                                        96,
                                                        96), // 图标颜色
                                                    size: 28.w, // 图标大小
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20.w,
                                        ),

                                        // 零钱
                                        Container(
                                          height: 107.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 33.w),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 250, 231),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.w)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // 零钱
                                              Flex(
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    Icon(
                                                      const IconData(
                                                        0xe6cc,
                                                        fontFamily: 'Iconfont',
                                                      ), // 使用的图标
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              251,
                                                              193,
                                                              30), // 图标颜色
                                                      size: 38.w, // 图标大小
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      "零钱",
                                                      style: TextStyle(
                                                          fontSize: 25.w,
                                                          height: 1.08,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              106, 102, 83)),
                                                    ),
                                                  ]),

                                              // 打勾
                                              Icon(
                                                const IconData(
                                                  0xe60d,
                                                  fontFamily: 'Iconfont',
                                                ), // 使用的图标
                                                color: const Color.fromARGB(
                                                    255, 0, 198, 106), // 图标颜色
                                                size: 30.w, // 图标大小
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),

                            SizedBox(
                              height: 10.w,
                            ),

                            Container(
                                margin: EdgeInsets.only(
                                    top: 15.w, left: 15.w, right: 15.w),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.w)),
                                ),
                                child: const Column(children: [
                                  LJNCAPFunctionItem(
                                    title: "数字人民币付款",
                                    icon: 0xe6f5,
                                    iconColor: Colors.red,
                                    link: '',
                                    color: Colors.black,
                                    backgroundColor: Colors.white,
                                    underline: false,
                                  ),
                                ])),

                            SizedBox(
                              height: 10.w,
                            ),

                            // 列表
                            Container(
                                margin: EdgeInsets.only(
                                    top: 15.w, left: 15.w, right: 15.w),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.w)),
                                ),
                                child: const Column(children: [
                                  LJNCAPFunctionItem(
                                    title: "二维码收款",
                                    icon: 0xe623,
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 56, 179, 114),
                                    underline: true,
                                  ),
                                  LJNCAPFunctionItem(
                                    title: "赞赏码",
                                    icon: 0xe67b,
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 56, 179, 114),
                                    underline: true,
                                  ),
                                  LJNCAPFunctionItem(
                                    title: "群收款",
                                    icon: 0xe624,
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 56, 179, 114),
                                    underline: true,
                                  ),
                                  LJNCAPFunctionItem(
                                    title: "面对面红包",
                                    icon: 0xe625,
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 56, 179, 114),
                                    underline: true,
                                  ),
                                  LJNCAPFunctionItem(
                                    title: "向银行卡或手机号转账",
                                    icon: 0xe661,
                                    link: '',
                                    backgroundColor:
                                        Color.fromARGB(255, 56, 179, 114),
                                    underline: false,
                                  ),
                                ])),

                            SizedBox(
                              height: 20.w,
                            )
                          ],
                        ),
                      ))));
        });
  }
}

class LJNCAPFunctionItem extends StatefulWidget {
  final int? icon;
  final Color? iconColor;
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? color;
  final Color? backgroundColor;

  const LJNCAPFunctionItem({
    super.key,
    this.icon,
    this.iconColor,
    this.height,
    required this.title,
    this.link,
    required this.underline,
    this.showStyle,
    this.tapEffect,
    this.color,
    this.backgroundColor,
  });

  @override
  State<LJNCAPFunctionItem> createState() => _LJNCAPFunctionItemState();
}

class _LJNCAPFunctionItemState extends State<LJNCAPFunctionItem> {
  // bool isClicked = false;
  late Color backgroundColor;
  late Color originBackgroundColor;
  late bool tapEffect;

  @override
  void initState() {
    super.initState();
    originBackgroundColor = widget.backgroundColor ?? Colors.white;

    setState(() {
      backgroundColor = originBackgroundColor;
      tapEffect = widget.tapEffect ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          backgroundColor = darkenColor(originBackgroundColor, 0.1);
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;
        setState(() {
          backgroundColor = originBackgroundColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            backgroundColor = originBackgroundColor;
          });

          // if (mounted) {
          //   if (widget.link != null) {
          //     Navigator.pushNamed(context, widget.link!);
          //   }
          // }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 125.0.w,
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              // 头像
              SizedBox(
                width: 40.0.w,
                height: 40.0.w,
                child: Icon(
                  IconData(
                    widget.icon!,
                    fontFamily: 'Iconfont',
                  ), // 使用的图标
                  color: widget.iconColor ?? Colors.white, // 图标颜色
                  size: 35.w, // 图标大小
                ),
              ),
              SizedBox(width: 10.w)
            ],
            Expanded(
              child: Container(
                height: double.infinity,
                // height: double.infinity,
                // width: 400.w,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: widget.underline
                      ? const Color.fromARGB(255, 60, 182, 118)
                      : Colors.transparent,
                  width: 2.w,
                  style: BorderStyle.solid,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Expanded(
                      flex: 0,
                      // width: 100.w,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(32.0.w),
                            fontFamily: "AlibabaPuHuiTi",
                            color: widget.color ?? Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    if (widget.showStyle != null)
                      Flexible(
                          flex: 1,
                          child: Container(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10).w,
                              // color: Colors.red,
                              child: widget.showStyle is String
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                          Text(
                                            widget.showStyle as String,
                                            style: TextStyle(
                                              height: 1.08,
                                              fontSize: fontSizeScale(30.w),
                                              color: const Color.fromARGB(
                                                  255, 83, 83, 83),
                                            ),
                                          )
                                        ])
                                  : widget.showStyle as Widget)),

                    if (widget.link != null)
                      SizedBox(
                          width: 30.w,
                          child: Icon(
                            const IconData(
                              0xed9d,
                              fontFamily: 'Iconfont',
                            ),
                            size: 30.0.w,
                            color: const Color.fromARGB(255, 110, 216, 163),
                          ))
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
