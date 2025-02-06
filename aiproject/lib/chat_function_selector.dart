import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class LJNChatFunctionSelector extends StatefulWidget {
  const LJNChatFunctionSelector({super.key});

  @override
  State<LJNChatFunctionSelector> createState() => _LJNChatFunctionSelector();
}

class _LJNChatFunctionSelector extends State<LJNChatFunctionSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Container(
          padding: EdgeInsets.only(top: 98.w),
          color: const Color.fromARGB(255, 247, 247, 247),
          child: Wrap(
            // spacing: 63.w,
            children: [
              FunctionButton(
                  systemState: systemState,
                  title: "相册",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("相册");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "拍摄",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("拍摄");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "视频通话",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("视频通话");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "位置",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("位置");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "红包",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("红包");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "礼物",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("礼物");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "转账",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("转账");
                  }),
              FunctionButton(
                  systemState: systemState,
                  title: "语音输入",
                  icon: Icon(
                    const IconData(
                      0xe612,
                      fontFamily: 'Iconfont',
                    ),
                    color: const Color.fromARGB(255, 176, 176, 176),
                    size: 52.w,
                  ),
                  onTap: () {
                    logger.info("语音输入");
                  })
            ],
          ));
    });
  }
}

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
                  height: 105.w,
                  width: 105.w,
                  margin: EdgeInsets.only(bottom: 12.w),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.w)),
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
