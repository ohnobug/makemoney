import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNEmergencyContact extends StatefulWidget {
  const LJNEmergencyContact({super.key});

  @override
  State<LJNEmergencyContact> createState() => _LJEemergencyContact();
}

class _LJEemergencyContact extends State<LJNEmergencyContact> {
  bool selectedValue = false;

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
              appBar: LJNAppBar(title: "应急联系人", actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/bind_new_phone_number');
                    },
                    child: Container(
                        height: 60.w,
                        constraints: BoxConstraints(minWidth: 98.w),
                        margin: EdgeInsets.only(right: 30.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 74, 193, 99),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.w))),
                        child: Text(
                          "完成",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.w,
                              fontWeight: FontWeight.w100),
                        )))
              ]),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                        width: vm.screenSize!.width,
                        // padding: EdgeInsets.only(left: 90.w, right: 90.w),
                        constraints: BoxConstraints(
                            minHeight: vm.screenSize!.height -
                                (vm.statusHeight! + 90.w)),
                        // color: const Color.fromARGB(255, 231, 15, 15),
                        child: Column(
                          children: [
                            Container(
                              height: 290.w,
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe626,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 74, 193, 99), // 图标颜色
                                size: 195.w, // 图标大小
                              ),
                            ),
                            Text(
                              "应急联系人",
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: 40.w,
                                  // fontWeight: FontWeight.bold,
                                  // fontFamily: "AlibabaPuHuiTi"
                                  fontFamily: "AlibabaPuHuiTi-Medium"),
                            ),
                            SizedBox(
                              height: 60.w,
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.only(left: 27.w, right: 27.w),
                                child: Text(
                                  "从通讯录里选择3位以上你可以随时电话联系的朋友添加成应急联系人。",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 162, 162, 162),
                                      // height: 1.08,
                                      fontSize: 25.w,
                                      fontFamily: "AlibabaPuHuiTi"),
                                )),
                            SizedBox(
                              height: 50.w,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    EdgeInsets.only(left: 27.w, right: 27.w),
                                padding: EdgeInsets.only(bottom: 35.w),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                  width: 2.w,
                                  style: BorderStyle.solid,
                                ))),
                                child: Text(
                                  "了解如何通过应急联系人找回账号密码",
                                  style: TextStyle(
                                      height: 1.08,
                                      color: const Color.fromARGB(
                                          255, 64, 67, 101),
                                      fontSize: 25.w,
                                      fontFamily: "AlibabaPuHuiTi"),
                                )),
                            SizedBox(
                              height: 50.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 27.w, right: 27.w),
                              child: Row(
                                children: [
                                  const IconBox(),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  const IconBox(),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  const IconBox(),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  const IconBox(),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  const IconBox(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))));
        });
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        color: const Color.fromARGB(255, 166, 166, 166),
        borderType: BorderType.RRect,
        strokeWidth: 3.w,
        dashPattern: [16.w, 10.w],
        strokeCap: StrokeCap.round,
        radius: Radius.circular(8.0.w),
        child: SizedBox(
          width: 91.0.w, // 设置宽度
          height: 91.0.w, // 设置高度
          // decoration: BoxDecoration(
          //   color: Colors.transparent, // 背景透明
          //   borderRadius: BorderRadius.circular(8.0.w), // 圆角 8
          //   border: Border.all(
          //     color: const Color.fromARGB(255, 166, 166, 166), // 边框颜色
          //     width: 1.0.w,
          //     style: BorderStyle.solid, // 边框样式
          //   ),
          //   shape: BoxShape.rectangle, // 矩形盒子
          // ),
          child: Center(
            child: Icon(
              const IconData(
                0xe616,
                fontFamily: 'Iconfont',
              ), // 使用的图标
              color: const Color.fromARGB(255, 166, 166, 166), // 图标颜色
              size: 36.0.w, // 图标大小
            ),
          ),
        ));
  }
}
