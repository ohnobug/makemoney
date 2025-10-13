import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
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
                          CachedNetworkImage(
                            imageUrl: "${systemState.cdnBase}/icon/logo.jpeg",
                            width: 150.0.w,
                            height: 150.0.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: 20.w,
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
                      SizedBox(height: 50.w),
                      LJNFunctionList(
                        children: [
                          LJNFunctionItem(
                            icon: "$cdnBase/avatar/02.png",
                            title: l10n.featureIntroduction,
                            link: '',
                            backgroundColor: AppColors.neutralWhite,
                            underline: true,
                          ),
                          LJNFunctionItem(
                            icon: "$cdnBase/avatar/02.png",
                            title: l10n.complain,
                            link: '',
                            backgroundColor: AppColors.neutralWhite,
                            underline: true,
                          ),
                          LJNFunctionItem(
                            icon: "$cdnBase/avatar/02.png",
                            title: l10n.checkNewVersion,
                            link: '',
                            backgroundColor: AppColors.neutralWhite,
                            underline: false,
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
