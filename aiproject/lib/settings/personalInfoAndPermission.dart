import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import '../../components/LJNFunctionItem.dart';

class LJNPersonalinfoAndPermission extends StatefulWidget {
  const LJNPersonalinfoAndPermission({super.key});

  @override
  State<LJNPersonalinfoAndPermission> createState() =>
      _LJNPersonalinfoAndPermission();
}

class _LJNPersonalinfoAndPermission
    extends State<LJNPersonalinfoAndPermission> {
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
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + vm.statusHeight!),
            child: Container(
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: vm.statusHeight!),
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
                  title: const Text('个人信息与权限'),
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
                    minHeight: screenSize.height - 90.w - vm.statusHeight!),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(children: [
                      const LJNFunctionItem(
                        title: "系统权限管理",
                        link: '',
                        underline: true,
                        tapEffect: true,
                      ),
                      const LJNFunctionItem(
                        title: "授权管理",
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                      SizedBox(height: 16.w),
                      const LJNFunctionItem(
                        title: "个性化广告管理",
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                      SizedBox(height: 16.w),
                      const LJNFunctionItem(
                        title: "个人信息浏览与导出",
                        link: '',
                        underline: false,
                        tapEffect: true,
                      ),
                      SizedBox(height: 920.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "《隐私保护指引摘要》",
                            style: TextStyle(
                                fontSize: 26.w,
                                height: 1.08,
                                color: const Color.fromARGB(255, 81, 88, 135)),
                          ),
                          Text(
                            "《隐私保护指引》",
                            style: TextStyle(
                                fontSize: 26.w,
                                height: 1.08,
                                color: const Color.fromARGB(255, 81, 88, 135)),
                          )
                        ],
                      )
                    ])))));
  }
}
