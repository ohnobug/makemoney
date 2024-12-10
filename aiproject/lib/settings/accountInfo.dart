import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNAccountInfo extends StatefulWidget {
  const LJNAccountInfo({super.key});

  @override
  State<LJNAccountInfo> createState() => _LJNAccountInfo();
}

class _LJNAccountInfo extends State<LJNAccountInfo> {
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
        appBar: const LJNAppBar(bgColor: Colors.transparent),
        body: StoreConnector<StoreType, StoreType>(
            converter: (store) => store.state,
            builder: (context, vm) {
              return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight:
                              screenSize.height - 90.w - vm.statusHeight!),
                      color: Colors.white,
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Container(
                              width: screenSize.width,
                              padding: EdgeInsets.only(left: 70.w, right: 70.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      // color: Colors.red,
                                      height: 300.w,
                                      alignment: Alignment.bottomCenter,
                                      child: Icon(
                                        color: const Color.fromARGB(
                                            255, 212, 212, 212),
                                        const IconData(
                                          0xe883,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 140.w, // 图标大小
                                      )),
                                  SizedBox(
                                    height: 50.w,
                                  ),
                                  Text(
                                    "微信号：${vm.userinfoAccount}",
                                    style: TextStyle(
                                        fontSize: 40.w,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "AlibabaPuHuiTi"),
                                  ),
                                  SizedBox(
                                    height: 45.w,
                                  ),
                                  Text(
                                    "微信号是账号的唯一凭证，一年只能修改一次。",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30.w,
                                        fontFamily: "AlibabaPuHuiTi"),
                                  ),

                                  SizedBox(
                                    height: 620.w,
                                    child: null,
                                  ),

                                  // 修改微信号
                                  Container(
                                      padding: EdgeInsets.only(bottom: 180.w),
                                      child: const LJNChangeAccountButton(
                                        title: '修改微信号',
                                        link: "/change_account",
                                      ))
                                ],
                              )))));
            }));
  }
}
