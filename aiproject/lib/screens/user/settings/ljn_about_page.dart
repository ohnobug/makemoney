import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';

class LJNAboutPage extends StatefulWidget {
  const LJNAboutPage({super.key});

  @override
  State<LJNAboutPage> createState() => _LJNAbout();
}

class _LJNAbout extends State<LJNAboutPage> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  void _checkNewVersion() {
    ThemeData theme = Theme.of(context);

    // 这里实现检查新版本的逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '正在检查新版本...',
          style: TextStyle(fontSize: 28.w),
        ),
        backgroundColor: theme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );

    // 模拟检查版本的过程
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '当前已是最新版本',
              style: TextStyle(fontSize: 28.w),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        String cdnBase = systemState.cdnBase;

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
                      SizedBox(height: 100.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadiusGeometry.circular(20.w),
                            child: Image.asset(
                              assetPath("images/logo.jpeg"),
                              width: 200.0.w,
                              height: 200.0.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            l10n.app_name,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 43.w,
                            ),
                          ),
                          SizedBox(
                            height: 18.w,
                          ),
                          Text(
                            "Version 1.0.0",
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 27.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.w),
                      LJNFunctionList(
                        children: [
                          LJNFunctionItem(
                            icon: "$cdnBase/avatar/02.png",
                            title: l10n.featureIntroduction,
                            link: '/settings/feature_introduction',
                            backgroundColor: AppColors.neutralWhite,
                            underline: true,
                          ),
                          LJNFunctionItem(
                            icon: "$cdnBase/avatar/02.png",
                            title: l10n.complain,
                            link: '/settings/complain',
                            backgroundColor: AppColors.neutralWhite,
                            underline: true,
                          ),
                          LJNFunctionItem(
                            icon: "$cdnBase/avatar/02.png",
                            title: l10n.checkNewVersion,
                            link: null,
                            backgroundColor: AppColors.neutralWhite,
                            underline: false,
                            onPress: _checkNewVersion,
                          )
                        ],
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
