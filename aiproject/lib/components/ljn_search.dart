import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

class LJNSearch extends StatefulWidget {
  final Function? onTap;
  final String? link;
  final String title;

  const LJNSearch({
    super.key,
    this.onTap,
    required this.link,
    required this.title,
  });

  @override
  State<LJNSearch> createState() => _LJNSearch();
}

class _LJNSearch extends State<LJNSearch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return GestureDetector(
        onTap: () {
          if (widget.link is String) {
            Navigator.pushNamed(context, widget.link!);
          }

          if (widget.onTap is Function) {
            widget.onTap!();
          }
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 15.w, left: 15.w, right: 15.w),
          height: 80.w,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0.w, horizontal: 20.0.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15).w,
              // border: Border.all(color: Color.fromRGBO(158, 158, 158, 0.3),),
            ),
            child: Center(
              // 保证整体内容居中
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        const IconData(
                          0xe612,
                          fontFamily: 'Iconfont',
                        ),
                        color: Color.fromARGB(255, 173, 173, 173),
                        size: 37.w,
                      ),
                    ),
                    TextSpan(
                      text: " ${widget.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 31.w,
                        color: Color.fromARGB(255, 173, 173, 173),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
