import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNCommonSetting extends StatefulWidget {
  const LJNCommonSetting({super.key});

  @override
  State<LJNCommonSetting> createState() => _LJNCommonSetting();
}

class _LJNCommonSetting extends State<LJNCommonSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            title: "通用设置",
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: const Color.fromARGB(255, 237, 237, 237),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 64.w,
                    padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
                    child: Text(
                      "界面与显示",
                      style: TextStyle(fontSize: 25.w, height: 1.08),
                    ),
                  ),
                  const LJNFunctionItem(
                    title: "深色模式",
                    link: '',
                    underline: true,
                    tapEffect: true,
                    showStyle: "跟随系统",
                  ),
                  LJNFunctionItem(
                    title: "开启横屏模式",
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
                        ),
                      ),
                    ),
                  ),
                  LJNFunctionItem(
                    title: "开启NFC功能",
                    // link: '',
                    underline: true,
                    tapEffect: false,
                    showStyle: Expanded(
                      flex: 0,
                      child: Container(
                        margin: const EdgeInsets.only(right: 32).w,
                        child: LJNSwitch(
                          initialValue: true,
                          onChanged: (value) {
                            logger.info(value);
                          },
                        ),
                      ),
                    ),
                  ),
                  const LJNFunctionItem(
                    title: "自动下载微信安装包",
                    link: '',
                    underline: true,
                    tapEffect: true,
                    showStyle: "仅Wi-Fi网络",
                  ),
                  const LJNFunctionItem(
                    title: "多语言",
                    link: '',
                    underline: true,
                    tapEffect: true,
                    showStyle: "跟随系统",
                  ),
                  const LJNFunctionItem(
                    title: "翻译",
                    link: '',
                    underline: false,
                    tapEffect: true,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 64.w,
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 0.0, top: 16)
                            .w,
                    child: Text(
                      "其他",
                      style: TextStyle(fontSize: 25.w, height: 1.08),
                    ),
                  ),
                  const LJNFunctionItem(
                    title: "存储空间",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "字体大小",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "照片、视频、文件和通话",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "音乐和音频",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "发现页管理",
                    link: '',
                    underline: true,
                  ),
                  const LJNFunctionItem(
                    title: "辅助功能",
                    link: '',
                    underline: false,
                  ),
                  SizedBox(height: 16.w),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
