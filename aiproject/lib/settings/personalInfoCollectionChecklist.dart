import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import '../../components/LJNFunctionItem.dart';

class LJNPersonalInfoCollectionChecklist extends StatefulWidget {
  const LJNPersonalInfoCollectionChecklist({super.key});

  @override
  State<LJNPersonalInfoCollectionChecklist> createState() =>
      _LJPpersonalInfoCollectionChecklist();
}

class _LJPpersonalInfoCollectionChecklist
    extends State<LJNPersonalInfoCollectionChecklist> {
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
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
                color: Colors.white,
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
                  title: const Text(''),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Colors.black,
                      fontFamily: "AlibabaPuHuiTi-Medium"),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  actions: const [],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: screenSize.height - 90.w - _statusHeight),
                color: Colors.white,
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130.w,
                          ),
                          Text(
                            "个人信息收集清单",
                            style: TextStyle(
                                fontSize: 41.w,
                                fontFamily: "AlibabaPuHuiTi-Medium"),
                          ),
                          SizedBox(
                            height: 45.w,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 68.w, right: 68.w),
                              child: Text(
                                textAlign: TextAlign.center,
                                "    你可以查阅微信对你的个人信息的收集情况。以下只统计i0S 8.0.17、Android 8.0.18及之后版本微信所收集的信息。你使用旧版本微信期间的信息收集情况，微信无法完整统计到。",
                                style: TextStyle(fontSize: 32.w),
                              )),
                          SizedBox(
                            height: 100.0.w,
                          ),
                          SizedBox(
                            width: 630.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 105.w,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "基本信息",
                                    style: TextStyle(
                                        fontSize: 25.w,
                                        color: const Color.fromARGB(
                                            255, 74, 74, 74)),
                                  ),
                                ),
                                const LJNFunctionItem(
                                  title: "头像",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNFunctionItem(
                                  title: "姓名",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNFunctionItem(
                                  title: "手机号",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNFunctionItem(
                                  title: "性别",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNFunctionItem(
                                  title: "地区",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNFunctionItem(
                                  title: "个性签名",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                                const LJNFunctionItem(
                                  title: "地址",
                                  link: '',
                                  underline: true,
                                  tapEffect: true,
                                ),
                              ],
                            ),
                          )
                        ])))));
  }
}
