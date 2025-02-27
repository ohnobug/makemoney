import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';
import '../components/ljn_function_item.dart';

class LJNUserMoreInfo extends StatefulWidget {
  const LJNUserMoreInfo({
    super.key,
  });

  @override
  State<LJNUserMoreInfo> createState() => _LJNUserMoreInfo();
}

class _LJNUserMoreInfo extends State<LJNUserMoreInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
      primary: false,
      appBar: const LJNAppBar(
        title: "更多信息",
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
            child: Column(
              children: [
                const LJNFunctionItem(
                  title: "性别",
                  link: '',
                  showStyle: "男",
                  underline: false,
                ),
                const LJNFunctionItem(
                  title: "地区",
                  link: '',
                  showStyle: "广东广州",
                  underline: false,
                ),
                LJNFunctionItem(
                  height: 135.w,
                  title: '个人签名',
                  // link: '',
                  showStyle: Container(
                    // color: Colors.red,
                    margin: EdgeInsets.only(right: 40.w),
                    width: 345.w,
                    child: Text(
                      "为者常成，行者常至。",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // height: 1.25,
                        fontSize: 32.w,
                        color: const Color.fromARGB(255, 92, 92, 92),
                      ),
                    ),
                  ),
                  underline: true,
                ),
                LJNFunctionItem(
                  title: "注册时间",
                  // link: '',
                  showStyle: Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 40.w),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "2013年11月",
                        style: TextStyle(
                          height: 1.08,
                          fontSize: ljnFontSizeScale(32.0.w),
                          fontFamily: "AlibabaPuHuiTi",
                          color: const Color.fromARGB(255, 83, 83, 83),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  underline: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        ),
      ),
    );
  }
}
