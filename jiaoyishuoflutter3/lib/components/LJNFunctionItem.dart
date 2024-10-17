// 功能列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNFunctionItem extends StatefulWidget {
  final String id;
  final String? icon;
  final double? height;
  final String title;
  final String? link;
  final bool underline;
  final Widget? showStyle;

  const LJNFunctionItem({
    super.key,
    required this.id,
    this.icon,
    this.height,
    required this.title,
    this.link,
    required this.underline,
    this.showStyle,
  });

  @override
  State<LJNFunctionItem> createState() => _LJNFunctionItemState();
}

class _LJNFunctionItemState extends State<LJNFunctionItem> {
  // bool isClicked = false;
  Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
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

          if (mounted) {
            if (widget.link != null) {
              Navigator.pushNamed(context, widget.link!);
            }
          }
        });

        logger.info("弹起");
      },
      child: Container(
        height: widget.height ?? 105.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
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
              SizedBox(width: 20.w)
            ],
            Expanded(
              child: Container(
                height: double.infinity,
                // height: double.infinity,
                width: 400.w,
                decoration: widget.underline
                    ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                        color: const Color.fromARGB(255, 242, 242, 242),
                        width: 1.5.w,
                        style: BorderStyle.solid,
                      )))
                    : BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.transparent,
                            width: 1.5.w,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
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
                            fontSize: 32.0.w,
                            fontFamily: "AlibabaPuHuiTi-Medium",
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, left: 10).w,
                          // color: Colors.red,
                          child: widget.showStyle,
                        )),

                    Container(
                        width: 27.w,
                        margin: const EdgeInsets.only(right: 32).w,
                        child: Icon(
                          const IconData(
                            0xed9d,
                            fontFamily: 'Iconfont',
                          ),
                          size: 27.0.w,
                          color: const Color.fromARGB(255, 175, 175, 175),
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
