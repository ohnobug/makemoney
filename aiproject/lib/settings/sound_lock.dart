import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_function_item.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class LJNSoundLock extends StatefulWidget {
  const LJNSoundLock({super.key});

  @override
  State<LJNSoundLock> createState() => _LJNSoundLock();
}

class _LJNSoundLock extends State<LJNSoundLock> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            bgColor: Colors.white,
          ),
          body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Container(
                    width: systemState.screenSize.width,
                    // padding: EdgeInsets.only(left: 90.w, right: 90.w),
                    constraints: BoxConstraints(
                        minHeight: systemState.screenSize.height -
                            (systemState.statusHeight + 90.w)),
                    // color: const Color.fromARGB(255, 231, 15, 15),
                    child: Column(
                      children: [
                        Container(
                          height: 290.w,
                          alignment: Alignment.center,
                          child: Icon(
                            const IconData(
                              0xe6b8,
                              fontFamily: 'Iconfont',
                            ), // 使用的图标
                            color:
                                const Color.fromARGB(255, 75, 190, 97), // 图标颜色
                            size: 200.w, // 图标大小
                          ),
                        ),
                        Text(
                          "声音锁",
                          style: TextStyle(
                              height: 1.08,
                              fontSize: 40.w,
                              // fontWeight: FontWeight.bold,
                              fontFamily: "AlibabaPuHuiTi-Medium"),
                        ),
                        SizedBox(
                          height: 60.w,
                        ),
                        Container(
                            width: 630.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              // color:
                              //     const Color.fromARGB(255, 247, 247, 247),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.w)),
                            ),
                            child: Column(children: [
                              LJNFunctionItem(
                                title: "用声音锁登录微信",
                                tapEffect: false,
                                underline: true,
                                backgroundColor:
                                    const Color.fromARGB(255, 247, 247, 247),
                                showStyle: Expanded(
                                    flex: 0,
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 32).w,
                                        child: LJNSwitch(
                                          initialValue: false,
                                          onChanged: (value) {
                                            logger.info(value);
                                          },
                                        ))),
                              ),
                              const LJNFunctionItem(
                                title: "重设与删除",
                                link: '',
                                backgroundColor:
                                    Color.fromARGB(255, 247, 247, 247),
                                underline: true,
                              ),
                              const LJNFunctionItem(
                                title: "尝试验证我的声音",
                                link: '',
                                backgroundColor:
                                    Color.fromARGB(255, 247, 247, 247),
                                underline: false,
                              ),
                            ]))
                      ],
                    ),
                  ))));
    });
  }
}
