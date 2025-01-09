import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/ljn_function_item.dart';

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
    return Scaffold(
        primary: false,
        appBar: const LJNAppBar(
          title: "个人信息与权限",
        ),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: vm.screenSize!.height - 90.w - vm.statusHeight!),
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
