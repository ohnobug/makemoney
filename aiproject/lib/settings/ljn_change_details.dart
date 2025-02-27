import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiaoyishuoflutter3/components/ljn_appbar.dart';
import 'package:jiaoyishuoflutter3/components/ljn_change_detail_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

class LJNChangeDetails extends StatefulWidget {
  const LJNChangeDetails({super.key});

  @override
  State<LJNChangeDetails> createState() => _LJNChangeDetails();
}

class _LJNChangeDetails extends State<LJNChangeDetails> {
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
            title: "零钱明细",
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 107.w,
                      padding: EdgeInsets.only(left: 42.w),
                      alignment: Alignment.centerLeft,
                      color: const Color.fromARGB(255, 247, 247, 247),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "2024年12月",
                              style: TextStyle(
                                height: 1.08,
                                fontSize: ljnFontSizeScale(30.w),
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                            ),
                            WidgetSpan(
                              alignment:
                                  PlaceholderAlignment.middle, // 图标垂直对齐方式
                              child: Icon(
                                const IconData(
                                  0xe891,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: Colors.black, // 图标颜色
                                size: 30.w, // 图标大小
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -32,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -56,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -14,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: 200,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -49,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -18,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -21,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -29,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -91,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -5,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -73,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -47,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    const LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -15,
                      icon: "images/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
