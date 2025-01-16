import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_special_function_item.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNChatSetting extends StatefulWidget {
  const LJNChatSetting({super.key});

  @override
  State<LJNChatSetting> createState() => _LJNChatSetting();
}

class _LJNChatSetting extends State<LJNChatSetting> {
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
            title: "聊天",
          ),
          body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                  constraints: BoxConstraints(
                      minHeight: systemState.screenSize.height -
                          90.w -
                          systemState.statusHeight),
                  color: const Color.fromARGB(255, 237, 237, 237),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Column(children: [
                        LJNFunctionItem(
                          title: "使用听筒播放语音消息",
                          // link: '',
                          underline: true,
                          tapEffect: false,
                          showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                  margin: const EdgeInsets.only(right: 32).w,
                                  child: LJNSwitch(
                                    initialValue: false,
                                    onChanged: (value) {
                                      logger.info(value);
                                    },
                                  ))),
                        ),
                        LJNSpecialFunctionItem(
                          title: "使用独立的发送按钮",
                          height: 137.w,
                          // link: '',
                          subTitle: Text(
                            "开启后，键盘上的发送按钮会被替换成换行",
                            maxLines: 3,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 193, 193, 193),
                              fontSize: 24.w,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                          ),
                          showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                  margin: const EdgeInsets.only(right: 32).w,
                                  child: LJNSwitch(
                                    initialValue: false,
                                    onChanged: (value) {
                                      logger.info(value);
                                    },
                                  ))),
                          underline: true,
                        ),
                        const LJNFunctionItem(
                          title: "聊天背景",
                          link: '',
                          underline: true,
                        ),
                        const LJNFunctionItem(
                          title: "表情管理",
                          link: '',
                          underline: false,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 64.w,
                          padding: const EdgeInsets.only(
                                  left: 30.0, right: 0.0, top: 16)
                              .w,
                          child: Text(
                            "聊天记录",
                            style: TextStyle(fontSize: 25.w, height: 1.08),
                          ),
                        ),
                        const LJNFunctionItem(
                          title: "聊天记录迁移与备份",
                          link: '',
                          underline: true,
                        ),
                        const LJNFunctionItem(
                          title: "清空聊天记录",
                          link: '',
                          underline: false,
                        ),
                        SizedBox(height: 16.w),
                      ])))));
    });
  }
}
