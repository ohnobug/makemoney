import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class FunctionButton extends StatefulWidget {
  final SystemState systemState;
  final String title;
  final Function onTap;
  final Icon icon;

  const FunctionButton(
      {super.key,
      required this.systemState,
      required this.title,
      required this.onTap,
      required this.icon});

  @override
  State<FunctionButton> createState() => _FunctionButtonState();
}

class _FunctionButtonState extends State<FunctionButton> {
  Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.systemState.screenSize.width) / 4,
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
              setState(() {
                bgColor = Colors.white;
              });
            },
            onTapCancel: () {
              setState(() {
                bgColor = Colors.white;
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
                    borderRadius: BorderRadius.all(Radius.circular(27.w)),
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
