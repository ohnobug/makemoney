import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_function_item.dart';
import 'package:jiaoyishuoflutter3/components/ljn_switch.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';

class LJNServicesManager extends StatefulWidget {
  const LJNServicesManager({super.key});

  @override
  State<LJNServicesManager> createState() => _LJNServicesManagerState();
}

class _LJNServicesManagerState extends State<LJNServicesManager> {
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
            title: "",
            bgColor: Colors.white,
          ),
          body: ColoredBox(
            color: Colors.white,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 205.w),
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 60.w, right: 60.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100.w,
                      ),
                      Text(
                        "服务管理",
                        style: TextStyle(
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 35.w,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "你可以指定出现在“服务”内的服务。若选择关闭部分服务，相应服务入口将隐藏，但不会清空任何历史数据。",
                        style: TextStyle(fontSize: 31.w, color: Colors.black),
                      ),
                      SizedBox(
                        height: 103.w,
                      ),
                      Container(
                        height: 50.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: const Color.fromARGB(255, 241, 241, 241),
                            ),
                          ),
                        ),
                        child: const Text(
                          "金融理财",
                          style: TextStyle(
                            color: Color.fromARGB(255, 101, 101, 101),
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "信用卡还款",
                        icon: "images/icon/server_icon1.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "微粒贷借钱",
                        icon: "images/icon/discovery_icon4.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "理财通",
                        icon: "images/icon/server_icon2.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "保险服务",
                        icon: "images/icon/server_icon3.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.w,
                      ),
                      Container(
                        height: 50.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: const Color.fromARGB(255, 241, 241, 241),
                            ),
                          ),
                        ),
                        child: const Text(
                          "交通出行",
                          style: TextStyle(
                            color: Color.fromARGB(255, 101, 101, 101),
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "出行服务",
                        icon: "images/icon/server_icon10.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "火车票机票",
                        icon: "images/icon/server_icon11.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "滴滴出行",
                        icon: "images/icon/server_icon12.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "酒店民宿",
                        icon: "images/icon/server_icon122.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.w,
                      ),
                      Container(
                        height: 50.w,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: const Color.fromARGB(255, 241, 241, 241),
                            ),
                          ),
                        ),
                        child: const Text(
                          "购物消费",
                          style: TextStyle(
                            color: Color.fromARGB(255, 101, 101, 101),
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "品牌发现",
                        icon: "images/icon/server_icon13.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "京东购物",
                        icon: "images/icon/server_icon14.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "美团外卖",
                        icon: "images/icon/server_icon15.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "电影演出玩乐",
                        icon: "images/icon/server_icon16.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "美团团购",
                        icon: "images/icon/server_icon15.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "拼多多",
                        icon: "images/icon/server_icon18.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "唯品会特卖",
                        icon: "images/icon/server_icon19.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      LJNFunctionItem(
                        title: "转转二手",
                        icon: "images/icon/server_icon20.png",
                        link: '/qrcode_scanner',
                        margin: const EdgeInsets.all(0),
                        underline: true,
                        showLinkIcon: false,
                        showStyle: Expanded(
                          flex: 0,
                          child: LJNSwitch(
                            initialValue: true,
                            onChanged: (value) {
                              logger.info(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 150.w)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
