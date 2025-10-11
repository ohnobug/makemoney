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

class LJNUserMoreInfoPage extends StatefulWidget {
  const LJNUserMoreInfoPage({
    super.key,
  });

  @override
  State<LJNUserMoreInfoPage> createState() => _LJNUserMoreInfoPage();
}

class _LJNUserMoreInfoPage extends State<LJNUserMoreInfoPage> {
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
                systemState.appbarHeight -
                systemState.statusHeight,
          ),
          color: theme.colorScheme.surfaceContainer,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 性别
                LJNFunctionList(children: [
                  // 性别
                  LJNFunctionItem(
                    icon: "images/avatar/02.png",
                    title: l10n.gender,
                    link: '',
                    showStyle: l10n.male,
                    underline: false,
                  ),
                ]),

                // 地区
                LJNFunctionList(children: [
                  // 地区
                  LJNFunctionItem(
                    icon: "images/avatar/02.png",
                    title: l10n.region,
                    link: '',
                    showStyle: l10n.guangdongGuangzhou,
                    underline: false,
                  ),
                ]),

                // 个人签名及注册时间
                LJNFunctionList(
                  children: [
                    // 个人签名
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
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

                    // 注册时间
                    LJNFunctionItem(
                      icon: "images/avatar/02.png",
                      title: l10n.registrationTime,
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
        options: RoundedRectDottedBorderOptions(
          color: AppColors.neutralGrey47,
          padding: const EdgeInsets.all(0),
          borderPadding: const EdgeInsets.all(0),
          stackFit: StackFit.loose,
          strokeWidth: 2.5.w,
          dashPattern: [16.w, 10.w],
          strokeCap: StrokeCap.round,
          radius: Radius.circular(8.0.w),
        ),
        child: SizedBox(
          width: 105.0.w, // 设置宽度
          height: 105.0.w, // 设置高度
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
