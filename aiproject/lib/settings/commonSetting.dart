import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNSwitch.dart';
import 'package:jiaoyishuoflutter3/components/pageloading.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import '../../components/LJNFunctionItem.dart';

class LJNCommonSetting extends StatefulWidget {
  const LJNCommonSetting({super.key});

  @override
  State<LJNCommonSetting> createState() => _LJNCommonSetting();
}

class _LJNCommonSetting extends State<LJNCommonSetting> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();

    myStore.dispatch({"type": "homescrollpixels", "payload": 0.0});

    Future.delayed(const Duration(milliseconds: 300), () {
      myStore.dispatch({"type": "mainpage3isload", "payload": true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return vm.mainpage3isload! ? _buildPage(vm) : const LJNPageLoading();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: _statusHeight),
                child: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      // wallet
                    }, // 点击事件
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        const IconData(
                          0xed9e,
                          fontFamily: 'Iconfont',
                        ), // 使用的图标
                        color: Colors.black, // 图标颜色
                        size: 36.w, // 图标大小
                      ),
                    ),
                  ),
                  primary: false,
                  centerTitle: true,
                  title: const Text('通用设置'),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Colors.black,
                      fontFamily: "AlibabaPuHuiTi-Medium"),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  foregroundColor: const Color.fromARGB(255, 237, 237, 237),
                  actions: const [],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: screenSize.height - 90.w - _statusHeight),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding:
                            const EdgeInsets.only(left: 30.0, right: 0.0).w,
                        child: Text(
                          "界面与显示",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "深色模式",
                        link: '',
                        underline: true,
                        tapEffect: true,
                        showStyle: "跟随系统",
                      ),
                      LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "开启横屏模式",
                        // link: '',
                        underline: true,
                        tapEffect: false,
                        showStyle: Container(
                            margin: const EdgeInsets.only(right: 20).w,
                            child: LJNSwitch(
                              initialValue: false,
                              onChanged: (value) {
                                logger.info(value);
                              },
                            )),
                      ),
                      LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "开启NFC功能",
                        // link: '',
                        underline: true,
                        tapEffect: false,
                        showStyle: Container(
                            margin: const EdgeInsets.only(right: 20).w,
                            child: LJNSwitch(
                              initialValue: true,
                              onChanged: (value) {
                                logger.info(value);
                              },
                            )),
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "自动下载微信安装包",
                        link: '',
                        underline: true,
                        tapEffect: true,
                        showStyle: "仅Wi-Fi网络",
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "多语言",
                        link: '',
                        underline: true,
                        tapEffect: true,
                        showStyle: "跟随系统",
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "翻译",
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 64.w,
                        padding: const EdgeInsets.only(
                                left: 30.0, right: 0.0, top: 16)
                            .w,
                        child: Text(
                          "其他",
                          style: TextStyle(fontSize: 25.w, height: 1.08),
                        ),
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "存储空间",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "字体大小",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "照片、视频、文件和通话",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "音乐和音频",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "发现页管理",
                        link: '',
                        underline: true,
                      ),
                      const LJNFunctionItem(
                        id: "5c620baa-7a31-5080-8e04-413f6c9d3c7a",
                        title: "辅助功能",
                        link: '',
                        underline: false,
                      ),
                      SizedBox(height: 16.w),
                    ])))));
  }
}
