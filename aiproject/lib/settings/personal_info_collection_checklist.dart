import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNPersonalInfoCollectionChecklist extends StatefulWidget {
  const LJNPersonalInfoCollectionChecklist({super.key});

  @override
  State<LJNPersonalInfoCollectionChecklist> createState() =>
      _LJPpersonalInfoCollectionChecklist();
}

class _LJPpersonalInfoCollectionChecklist
    extends State<LJNPersonalInfoCollectionChecklist> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    return Scaffold(
        primary: false,
        appBar: const LJNAppBar(
          bgColor: Colors.white,
        ),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: vm.screenSize!.height - 90.w - vm.statusHeight!),
                color: Colors.white,
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130.w,
                          ),
                          Text(
                            "个人信息收集清单",
                            style: TextStyle(
                                fontSize: 41.w,
                                fontFamily: "AlibabaPuHuiTi-Medium"),
                          ),
                          SizedBox(
                            height: 45.w,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 68.w, right: 68.w),
                              child: Text(
                                textAlign: TextAlign.center,
                                "    你可以查阅微信对你的个人信息的收集情况。以下只统计i0S 8.0.17、Android 8.0.18及之后版本微信所收集的信息。你使用旧版本微信期间的信息收集情况，微信无法完整统计到。",
                                style: TextStyle(fontSize: 32.w),
                              )),
                          SizedBox(
                            height: 100.0.w,
                          ),

                          // 基本信息
                          SizedBox(
                            width: 690.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 105.w,
                                  margin: EdgeInsets.only(left: 30.w),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 242, 242, 242),
                                    width: 1.5.w,
                                    style: BorderStyle.solid,
                                  ))),
                                  child: Text(
                                    "基本信息",
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        color: const Color.fromARGB(
                                            255, 74, 74, 74)),
                                  ),
                                ),
                                const LJNPCCFunctionItem(
                                  title: "头像",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "姓名",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "手机号",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "性别",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "地区",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "个性签名",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "地址",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          // 设备信息
                          SizedBox(
                            width: 690.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 105.w,
                                  margin: EdgeInsets.only(left: 30.w),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 242, 242, 242),
                                    width: 1.5.w,
                                    style: BorderStyle.solid,
                                  ))),
                                  child: Text(
                                    "设备信息",
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        color: const Color.fromARGB(
                                            255, 74, 74, 74)),
                                  ),
                                ),
                                const LJNPCCFunctionItem(
                                  title: "登录过的设备",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          // 用户使用过程信息
                          SizedBox(
                            width: 690.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 105.w,
                                  margin: EdgeInsets.only(left: 30.w),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 242, 242, 242),
                                    width: 1.5.w,
                                    style: BorderStyle.solid,
                                  ))),
                                  child: Text(
                                    "用户使用过程信息",
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        color: const Color.fromARGB(
                                            255, 74, 74, 74)),
                                  ),
                                ),
                                const LJNPCCFunctionItem(
                                  title: "位置",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "图片与视频",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          // 社交与内容信息
                          SizedBox(
                            width: 690.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 105.w,
                                  margin: EdgeInsets.only(left: 30.w),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 242, 242, 242),
                                    width: 1.5.w,
                                    style: BorderStyle.solid,
                                  ))),
                                  child: Text(
                                    "社交与内容信息",
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        color: const Color.fromARGB(
                                            255, 74, 74, 74)),
                                  ),
                                ),
                                const LJNPCCFunctionItem(
                                  title: "朋友圈",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "状态",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "微信豆",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "微信运动",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                LJNPCCFunctionItem(
                                  title: Text(
                                    "看一看",
                                    style: TextStyle(
                                      height: 1.08,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeScale(32.0.w),
                                      fontFamily: "AlibabaPuHuiTi",
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "公众号",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "小程序",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "视频号",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNPCCFunctionItem(
                                  title: "微信游戏",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          // 联系人信息
                          SizedBox(
                            width: 690.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 105.w,
                                  margin: EdgeInsets.only(left: 30.w),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 242, 242, 242),
                                    width: 1.5.w,
                                    style: BorderStyle.solid,
                                  ))),
                                  child: Text(
                                    "联系人信息",
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        color: const Color.fromARGB(
                                            255, 74, 74, 74)),
                                  ),
                                ),
                                const LJNPCCFunctionItem(
                                  title: "手机联系人",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100.w,
                          )
                        ])))));
  }
}

// 功能列表
class LJNPCCFunctionItem extends StatefulWidget {
  final String? icon;
  final double? height;
  final Object? title;
  final String? link;
  final bool underline;
  final Object? showStyle;
  final bool? tapEffect;
  final Color? backgroundColor;

  const LJNPCCFunctionItem(
      {super.key,
      this.icon,
      this.height,
      required this.title,
      this.link,
      required this.underline,
      this.showStyle,
      this.tapEffect,
      this.backgroundColor});

  @override
  State<LJNPCCFunctionItem> createState() => _LJNPCCFunctionItemState();
}

class _LJNPCCFunctionItemState extends State<LJNPCCFunctionItem> {
  // bool isClicked = false;
  late Color originContainerColor;
  late Color containerColor;
  late bool tapEffect;

  @override
  void initState() {
    super.initState();

    originContainerColor = widget.backgroundColor ?? Colors.white;

    setState(() {
      containerColor = originContainerColor;
      tapEffect = widget.tapEffect ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (tapEffect == false) return;
        setState(() {
          containerColor = const Color.fromARGB(255, 230, 230, 230);
        });
      },
      onTapCancel: () {
        if (tapEffect == false) return;
        setState(() {
          containerColor = originContainerColor;
        });

        logger.info("取消点击");
      },
      onTapUp: (tapDownDetails) {
        if (tapEffect == false) return;
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            containerColor = originContainerColor;
          });

          if (context.mounted && widget.link != null) {
            Navigator.pushNamed(context, widget.link!);
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              // 头像
              Container(
                width: 40.0.w,
                height: 40.0.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(assetPath(widget.icon!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 25.w)
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
                      ? const Color.fromARGB(255, 242, 242, 242)
                      : Colors.transparent,
                  width: 1.5.w,
                  style: BorderStyle.solid,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title is String
                        ?
                        // 标题
                        Text(
                            widget.title as String,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                          )
                        : widget.title as Widget,
                    if (widget.showStyle != null)
                      widget.showStyle is String
                          ? Expanded(
                              child: Container(
                                  padding:
                                      const EdgeInsets.only(right: 10, left: 10)
                                          .w,
                                  // color: Colors.red,
                                  child: Row(
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
                                      ])))
                          : widget.showStyle as Widget,
                    if (widget.link != null)
                      Container(
                          width: 30.w,
                          margin: const EdgeInsets.only(right: 32).w,
                          child: Icon(
                            const IconData(
                              0xed9d,
                              fontFamily: 'Iconfont',
                            ),
                            size: 30.0.w,
                            color: const Color.fromARGB(255, 164, 164, 164),
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
