import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/ljn_function_item.dart';

class LJNMoreSecureSetting extends StatefulWidget {
  const LJNMoreSecureSetting({super.key});

  @override
  State<LJNMoreSecureSetting> createState() => _LJNAaccountAndSecure();
}

class _LJNAaccountAndSecure extends State<LJNMoreSecureSetting> {
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
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: const LJNAppBar(
                title: "更多安全设置",
              ),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight:
                              vm.screenSize!.height - 90.w - vm.statusHeight!),
                      color: const Color.fromARGB(255, 237, 237, 237),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(children: [
                            const LJNFunctionItem(
                              title: "QQ号",
                              link: '/',
                              showStyle: "2281551151",
                              underline: true,
                            ),
                            const LJNFunctionItem(
                              title: "邮箱地址",
                              link: '/',
                              showStyle: "未绑定",
                              underline: false,
                            ),
                            SizedBox(height: 16.w),
                            const LJNFunctionItem(
                              title: "手机安全防护",
                              link: '/',
                              underline: false,
                            ),
                          ])))));
        });
  }
}
