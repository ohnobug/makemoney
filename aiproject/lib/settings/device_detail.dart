import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_max_width_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNDeviceDetail extends StatefulWidget {
  const LJNDeviceDetail({super.key});

  @override
  State<LJNDeviceDetail> createState() => _LJNDeviceDetail();
}

class _LJNDeviceDetail extends State<LJNDeviceDetail> {
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
            title: "设备详情",
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
                            // height: 150.w,

                            title: "设备名称",
                            link: '',
                            tapEffect: true,
                            underline: true,
                            showStyle: Expanded(
                                flex: 1,
                                child: Text(
                                  "当前设备",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 32.w,
                                      height: 1.08,
                                      color: const Color.fromARGB(
                                          255, 180, 180, 180)),
                                ))),
                        LJNFunctionItem(
                            // height: 150.w,

                            title: "设备类型",
                            // link: '',
                            tapEffect: false,
                            underline: false,
                            showStyle: Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.only(right: 30.w),
                                    child: Text(
                                      "Windows 11 x64",
                                      style: TextStyle(
                                          fontSize: 32.w,
                                          height: 1.08,
                                          color: const Color.fromARGB(
                                              255, 180, 180, 180)),
                                    )))),
                        SizedBox(
                          height: 16.w,
                        ),
                        LJNFunctionItem(
                            // height: 150.w,

                            title: "最近活跃时间",
                            // link: '',
                            tapEffect: false,
                            underline: false,
                            showStyle: Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.only(right: 30.w),
                                    child: Text(
                                      "11月10日 下午15:23",
                                      style: TextStyle(
                                          fontSize: 32.w,
                                          height: 1.08,
                                          color: const Color.fromARGB(
                                              255, 180, 180, 180)),
                                    )))),
                        Container(
                            margin: EdgeInsets.only(
                                left: 30.w,
                                right: 30.w,
                                top: 22.w,
                                bottom: 22.w),
                            child: Text(
                              "登录微信后，当设备处于安全状态时，微信会自动延长登录时间以保持朋友消息的及时收发，此时会更新最近活跃时间。",
                              style: TextStyle(
                                  fontSize: 27.w,
                                  color:
                                      const Color.fromARGB(255, 149, 149, 149)),
                            )),
                        const LJNMaxWidthButton(
                          title: "删除该设备",
                          color: Colors.red,
                          link: '',
                          underline: false,
                        ),
                        SizedBox(height: 106.w),
                      ])))));
    });
  }
}
