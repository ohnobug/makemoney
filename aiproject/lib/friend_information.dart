import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_alphabet.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'components/ljn_function_item.dart';

class LJNFriendInformation extends StatefulWidget {
  const LJNFriendInformation({
    super.key,
  });

  @override
  State<LJNFriendInformation> createState() => _LJNFriendInformation();
}

class _LJNFriendInformation extends State<LJNFriendInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Scaffold(
      primary: false,
      appBar: const LJNAppBar(
        title: "朋友资料",
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
                LJNAlphabet(
                  title: '备注',
                  bgColor: Color.fromARGB(255, 237, 237, 237),
                ),
                const LJNFunctionItem(
                  title: "备注名",
                  link: '/set_notes_and_labels',
                  showStyle: "马化腾",
                  underline: true,
                ),
                const LJNFunctionItem(
                  title: "标签",
                  link: '',
                  showStyle: "同学、朋友",
                  underline: true,
                ),
                const LJNFunctionItem(
                  title: "电话",
                  link: '',
                  showStyle: "+86 18718988850",
                  underline: true,
                ),
                const LJNFunctionItem(
                  title: "描述",
                  link: '',
                  showStyle: "-",
                  underline: false,
                ),
                LJNAlphabet(
                  title: '更多信息',
                  bgColor: Color.fromARGB(255, 237, 237, 237),
                ),
                const LJNFunctionItem(
                  title: "我和她共同的群聊",
                  link: '',
                  showStyle: "4个",
                  underline: false,
                ),
                Container(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  height: 16.w,
                ),
                LJNFunctionItem(
                  height: 135.w,
                  title: '签名',
                  underline: true,
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
                      )),
                ),
                LJNFunctionItem(
                  height: 135.w,
                  title: '来源',
                  underline: true,
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
                        color: const Color.fromARGB(255, 92, 92, 92),
                      ),
                    ),
                  ),
                ),
                LJNFunctionItem(
                  title: "添加时间",
                  // link: '',
                  underline: false,
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
                          color: const Color.fromARGB(255, 83, 83, 83),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
