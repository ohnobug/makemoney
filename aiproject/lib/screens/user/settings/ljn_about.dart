import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';

class LJNAbout extends StatefulWidget {
  const LJNAbout({super.key});

  @override
  State<LJNAbout> createState() => _LJNAbout();
}

class _LJNAbout extends State<LJNAbout> {
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
              backgroundColor: Colors.transparent,
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: LJNAppBar(),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  width: 750.w,
                  // padding: EdgeInsets.only(left: 90.w, right: 90.w),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        (systemState.statusHeight + 90.w),
                  ),
                  // color: AppColors.accentRedDark2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 470.w,
                        width: 750.w,
                        // color: AppColors.accentRedPure,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(
                            //   const IconData(
                            //     0xe6b8,
                            //     fontFamily: 'Iconfont',
                            //   ), // 使用的图标
                            //   color: const Color.fromARGB(//       255, 75, 190, 97), // 图标颜色
                            //   size: 110.w, // 图标大小
                            // ),
                            Image.asset(
                              assetPath("images/icon/logo.png"),
                              width: 122.0.w,
                              height: 122.0.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 70.w,
                            ),
                            Text(
                              l10n.app_name,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 43.w,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "AlibabaPuHuiTi-Medium",
                              ),
                            ),
                            SizedBox(
                              height: 18.w,
                            ),
                            Text(
                              "Version 8.0.53",
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 27.w,
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 630.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          // borderRadius:
                          //     BorderRadius.all(Radius.circular(12.w),),
                          border: Border(
                              // top: BorderSide(
                              //   color: theme.dividerColor,
                              //   width: 1.0.w,
                              //   style: BorderStyle.solid,
                              // ),
                              // bottom: BorderSide(
                              //   color: theme.dividerColor,
                              //   width: 1.0.w,
                              //   style: BorderStyle.solid,
                              // ),
                              ),
                        ),
                        child: Column(
                          children: [
                            LJNFunctionList(
                              children: [
                                LJNFunctionItem(
                                  icon: "images/avatar/02.png",
                                  title: l10n.featureIntroduction,
                                  link: '',
                                  backgroundColor: AppColors.neutralWhite,
                                  underline: true,
                                ),
                                LJNFunctionItem(
                                  icon: "images/avatar/02.png",
                                  title: l10n.complain,
                                  link: '',
                                  backgroundColor: AppColors.neutralWhite,
                                  underline: true,
                                ),
                                LJNFunctionItem(
                                  icon: "images/avatar/02.png",
                                  title: l10n.checkNewVersion,
                                  link: '',
                                  backgroundColor: AppColors.neutralWhite,
                                  underline: false,
                                )
                              ],
                            ),
                            SizedBox(height: 100.w)
                          ],
                        ),
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
