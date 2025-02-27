import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';

class LJNFunctionSelectorButton extends StatefulWidget {
  final SystemState systemState;
  final String title;
  final Function onTap;
  final Icon icon;

  const LJNFunctionSelectorButton({
    super.key,
    required this.systemState,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  State<LJNFunctionSelectorButton> createState() =>
      _LJNFunctionSelectorButtonState();
}

class _LJNFunctionSelectorButtonState extends State<LJNFunctionSelectorButton> {
  Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width) / 4,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                bgColor = Color.fromARGB(255, 222, 222, 222);
              });

              widget.onTap();
            },
            onTapUp: (_) {
              Future.delayed(Duration(milliseconds: 300), () {
                setState(() {
                  bgColor = Colors.white;
                });
              });
            },
            onTapCancel: () {
              Future.delayed(Duration(milliseconds: 300), () {
                setState(() {
                  bgColor = Colors.white;
                });
              });
            },
            child: Column(
              children: [
                Container(
                  height: 106.w,
                  width: 106.w,
                  margin: EdgeInsets.only(bottom: 12.w),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(27.w),
                    ),
                  ),
                  child: widget.icon,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22.w,
                    color: Color.fromARGB(255, 101, 101, 101),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 71.w,
          ),
        ],
      ),
    );
  }
}
