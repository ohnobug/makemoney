import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

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
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.moreInfo,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                90.w -
                systemState.statusHeight,
          ),
          color: theme.colorScheme.surfaceContainer,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 我们的共同群聊
                LJNFunctionList(children: [
                  LJNFunctionItem(
                    title: l10n.ourMutualGroupChats,
                    link: '',
                    showStyle: l10n.groupCount(4),
                    underline: false,
                  ),
                ]),

                // 个人签名、来源、添加时间
                LJNFunctionList(
                  children: [
                    // 个人签名
                    LJNFunctionItem(
                      height: 135.w,
                      title: l10n.personalSignature,
                      // link: '',
                      showStyle: Container(
                        // color: AppColors.accentRedPure,
                        margin: EdgeInsets.only(right: 40.w),
                        width: 345.w,
                        child: Text(
                          "为者常成，行者常至。",
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // height: 1.25,
                            fontSize: 32.w,
                            color: theme.colorScheme.onSurface.withAlpha(123),
                          ),
                        ),
                      ),
                      underline: true,
                    ),

                    // 来源
                    LJNFunctionItem(
                      height: 135.w,
                      title: l10n.source,
                      // link: '',
                      showStyle: Container(
                        // color: AppColors.accentRedPure,
                        margin: EdgeInsets.only(right: 40.w),
                        width: 345.w,
                        child: Text(
                          l10n.source_added_from_group_chat("深圳腾讯公司董事会"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            // height: 1.25,
                            fontSize: 32.w,
                            color: theme.colorScheme.onSurface.withAlpha(123),
                          ),
                        ),
                      ),
                      underline: true,
                    ),

                    // 添加时间
                    LJNFunctionItem(
                      title: l10n.addedTime,
                      // link: '',
                      showStyle: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 40.w),
                          alignment: Alignment.centerRight,
                          child: Text(
                            l10n.yearAndMonth(DateTime(2023, 12)),
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(32.0.w),
                              fontFamily: "AlibabaPuHuiTi",
                              color: AppColors.neutralDarkGrey7,
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

                SizedBox(height: 100.w)
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
        // dashPattern: [16.w, 10.w],
        // strokeWidth: 1.w,
        // color: AppColors.neutralGrey47,
        // strokeCap: StrokeCap.round,
        // borderType: BorderType.RRect,
        // radius: Radius.circular(8.0.w),
        // color: AppColors.neutralGrey47,
        // borderType: BorderType.RRect,
        // padding: const EdgeInsets.all(0),
        // borderPadding: const EdgeInsets.all(0),
        // stackFit: StackFit.loose,
        // strokeWidth: 3.w,
        // dashPattern: [16.w, 10.w],
        // strokeCap: StrokeCap.round,
        // radius: Radius.circular(8.0.w),
        child: SizedBox(
          width: 105.0.w, // 设置宽度
          height: 105.0.w, // 设置高度
          // decoration: BoxDecoration(
          //   color: Colors.transparent, // 背景透明
          //   borderRadius: BorderRadius.circular(8.0.w), // 圆角 8
          //   border: Border.all(
          //     color: AppColors.neutralGrey47, // 边框颜色
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
              color: AppColors.neutralGrey47, // 图标颜色
              size: 42.0.w, // 图标大小
            ),
          ),
        ),
      ),
    );
  }
}
