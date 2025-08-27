import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

class LJNPopup extends StatefulWidget {
  final Function? onReturn;

  const LJNPopup({super.key, this.onReturn});

  @override
  State<LJNPopup> createState() => _LJNPopupState();
}

class _LJNPopupState extends State<LJNPopup> {
  bool showFilterBg = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Stack(
          children: [
            // 背景
            Container(
              color: const Color.fromARGB(115, 0, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

            // 弹窗
            Positioned(
              left: (MediaQuery.of(context).size.width - 603.w) / 2,
              top: (MediaQuery.of(context).size.height - 495.w) / 2,
              child: Container(
                width: 603.w,
                height: 495.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.w),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 136.w,
                      padding: EdgeInsets.only(top: 63.w, bottom: 35.w),
                      child: Text(
                        "已尝试添加到桌面",
                        style: TextStyle(
                          fontFamily: "AlibabaPuHuiTi",
                          fontSize: 30.w,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          height: 1.08,
                        ),
                      ),
                    ),
                    Container(
                      height: 126.w,
                      padding: EdgeInsets.only(left: 60.w, right: 60.w),
                      child: Text(
                        '若添加失败，请前往系统设置，为微信打开"创建桌面快捷方式"的权限。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "AlibabaPuHuiTi",
                          decoration: TextDecoration.none,
                          fontSize: 32.w,
                          color: const Color.fromARGB(255, 114, 114, 114),
                        ),
                      ),
                    ),
                    Container(
                      height: 62.w,
                      margin: EdgeInsets.only(top: 20.w),
                      alignment: Alignment.center,
                      // color: Colors.purple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            const IconData(
                              0xe65b,
                              fontFamily: 'Iconfont',
                            ),
                            color: const Color.fromARGB(255, 176, 176, 176),
                            size: 45.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            '不再提醒',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "AlibabaPuHuiTi",
                              decoration: TextDecoration.none,
                              fontSize: 30.w,
                              color: Colors.black,
                              height: 1.08,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 106.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            width: 1.w,
                            color: const Color.fromARGB(255, 243, 243, 243),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onReturn != null) {
                                  widget.onReturn!();
                                }
                              },
                              child: Container(
                                height: 106.w,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  '返回',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 32.w,
                                      color: Colors.black,
                                      fontFamily: "AlibabaPuHuiTi-Medium",
                                      height: 1.08),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 106.w,
                            width: 1.w,
                            color: const Color.fromARGB(255, 243, 243, 243),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onReturn != null) {
                                  widget.onReturn!();
                                }
                              },
                              child: Container(
                                height: 106.w,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  '了解详情',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 32.w,
                                      color: const Color.fromARGB(
                                          255, 78, 96, 146),
                                      fontFamily: "AlibabaPuHuiTi-Medium",
                                      height: 1.08),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
