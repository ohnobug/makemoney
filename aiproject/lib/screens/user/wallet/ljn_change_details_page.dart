import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_detail_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNChangeDetailsPage extends StatefulWidget {
  const LJNChangeDetailsPage({super.key});

  @override
  State<LJNChangeDetailsPage> createState() => _LJNChangeDetailsPage();
}

class _LJNChangeDetailsPage extends State<LJNChangeDetailsPage> {
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

        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.balanceDetails,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      systemState.appbarHeight -
                      systemState.statusHeight),
              color: theme.colorScheme.surfaceContainer,
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
                      color: AppColors.neutralGrey2,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: l10n.yearAndMonth(DateTime(2024, 12)),
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(30.w),
                                color: theme.colorScheme.onSurface,
                                // fontWeight: FontWeight.bold,
                                
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
                                color: theme.colorScheme.onSurface, // 图标颜色
                                size: 30.w, // 图标大小
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -32,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -56,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -14,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: 200,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -49,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -18,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -21,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -29,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -91,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -5,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -73,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -47,
                      icon: "$cdnBase/avatar/01.png",
                      link: '',
                      underline: true,
                    ),
                    LJNChangeDetailItem(
                      title: "原乡智选",
                      change: -15,
                      icon: "$cdnBase/avatar/01.png",
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
