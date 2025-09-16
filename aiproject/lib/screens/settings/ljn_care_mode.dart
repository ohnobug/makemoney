import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNCareMode extends StatefulWidget {
  const LJNCareMode({super.key});

  @override
  State<LJNCareMode> createState() => _LJNCareMode();
}

class _LJNCareMode extends State<LJNCareMode> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Theme(
          data: theme.copyWith(
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: AppColors.transparent,
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: const LJNAppBar(),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.only(left: 90.w, right: 90.w),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        (systemState.statusHeight + 90.w),
                  ),
                  // color: AppColors.accentRedDark2,
                  child: Column(
                    children: [
                      Container(
                        height: 290.w,
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe622,
                            fontFamily: 'Iconfont',
                          ), // 使用的图标
                          color: AppColors.accentYellowDark3, // 图标颜色
                          size: 110.w, // 图标大小
                        ),
                      ),
                      Text(
                        l10n.caringMode,
                        style: TextStyle(
                            height: 1.08,
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold,
                            fontFamily: "AlibabaPuHuiTi"),
                      ),
                      SizedBox(
                        height: 60.w,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Text(
                          l10n.careModeIntro,
                          style: TextStyle(
                              fontSize: 32.w,
                              fontFamily: "AlibabaPuHuiTi-Medium"),
                        ),
                      ),
                      SizedBox(
                        height: 40.w,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Text(
                          l10n.careModeFeatureAccessibility,
                          style: TextStyle(
                            fontSize: 30.w,
                            color: AppColors.neutralDarkGrey12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.w,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Text(
                          l10n.careModeFeatureReadMessages,
                          style: TextStyle(
                            fontSize: 30.w,
                            color: AppColors.neutralDarkGrey12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.w,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: Text(
                          l10n.careModeFeatureQuietMode,
                          style: TextStyle(
                            fontSize: 30.w,
                            color: AppColors.neutralDarkGrey12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 400.h,
                      ),
                      LJNChangeAccountButton(
                        title: l10n.enable,
                        link: "back",
                        readonly: false,
                        color: AppColors.neutralWhite,
                        backgroundColor: AppColors.brandGreenVibrant7,
                      )
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
