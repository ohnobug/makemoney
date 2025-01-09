import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'components/ljn_function_item.dart';

class LJNFriendMoreInfo extends StatefulWidget {
  const LJNFriendMoreInfo({
    super.key,
  });

  @override
  State<LJNFriendMoreInfo> createState() => _LJNFriendMoreInfo();
}

class _LJNFriendMoreInfo extends State<LJNFriendMoreInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage() {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: const LJNAppBar(
                title: "更多信息",
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
                              title: "我和她的共同群聊",
                              link: '',
                              showStyle: "4个",
                              underline: false,
                            ),
                            Container(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                height: 16.w),
                            LJNFunctionItem(
                              height: 135.w,
                              title: '个人签名',
                              // link: '',
                              showStyle: Container(
                                  // color: Colors.red,
                                  margin: EdgeInsets.only(right: 40.w),
                                  width: 345.w,
                                  child: Text(
                                    "理想不伟大，只愿年过半百，归来仍是少年",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        // height: 1.25,
                                        fontSize: 32.w,
                                        color: const Color.fromARGB(
                                            255, 92, 92, 92)),
                                  )),
                              underline: true,
                            ),
                            LJNFunctionItem(
                              height: 135.w,
                              title: '来源',
                              // link: '',
                              showStyle: Container(
                                  // color: Colors.red,
                                  margin: EdgeInsets.only(right: 40.w),
                                  width: 345.w,
                                  child: Text(
                                    '通过群聊"深圳腾讯公司董事会"添加',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        // height: 1.25,
                                        fontSize: 32.w,
                                        color: const Color.fromARGB(
                                            255, 92, 92, 92)),
                                  )),
                              underline: true,
                            ),
                            LJNFunctionItem(
                              title: "添加时间",
                              // link: '',
                              showStyle: Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(right: 40.w),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "2013年11月",
                                  style: TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(32.0.w),
                                      fontFamily: "AlibabaPuHuiTi",
                                      color: const Color.fromARGB(
                                          255, 83, 83, 83)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                              underline: false,
                            ),
                          ])))));
        });
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.w,
      width: 105.w,
      alignment: Alignment.topLeft,
      child: DottedBorder(
          color: const Color.fromARGB(255, 166, 166, 166),
          borderType: BorderType.RRect,
          padding: const EdgeInsets.all(0),
          borderPadding: const EdgeInsets.all(0),
          stackFit: StackFit.loose,
          strokeWidth: 3.w,
          dashPattern: [16.w, 10.w],
          strokeCap: StrokeCap.round,
          radius: Radius.circular(8.0.w),
          child: SizedBox(
            width: 105.0.w, // 设置宽度
            height: 105.0.w, // 设置高度
            // decoration: BoxDecoration(
            //   color: Colors.transparent, // 背景透明
            //   borderRadius: BorderRadius.circular(8.0.w), // 圆角 8
            //   border: Border.all(
            //     color: const Color.fromARGB(255, 166, 166, 166), // 边框颜色
            //     width: 1.0.w,
            //     style: BorderStyle.solid, // 边框样式
            //   ),
            //   shape: BoxShape.rectangle, // 矩形盒子
            // ),
            child: Center(
              child: Icon(
                const IconData(
                  0xe616,
                  fontFamily: 'Iconfont',
                ), // 使用的图标
                color: const Color.fromARGB(255, 166, 166, 166), // 图标颜色
                size: 42.0.w, // 图标大小
              ),
            ),
          )),
    );
  }
}
