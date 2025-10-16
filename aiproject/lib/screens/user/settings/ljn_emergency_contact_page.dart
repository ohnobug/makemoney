import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNEmergencyContactPage extends StatefulWidget {
  const LJNEmergencyContactPage({super.key});

  @override
  State<LJNEmergencyContactPage> createState() => _LJEemergencyContact();
}

class _LJEemergencyContact extends State<LJNEmergencyContactPage> {
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
      return Scaffold(
        primary: false,
        appBar: LJNAppBar(title: l10n.emergencyContacts, actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/settings/security/bind_phone');
            },
            child: Container(
              height: 60.w,
              constraints: BoxConstraints(minWidth: 98.w),
              margin: EdgeInsets.only(right: 30.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.brandGreenVibrant3,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.w),
                ),
              ),
              child: Text(
                l10n.done,
                // textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutralWhite,
                  fontSize: 25.w,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          )
        ]),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                  Container(
                    height: 290.w,
                    alignment: Alignment.center,
                    child: Icon(
                      const IconData(
                        0xe626,
                        fontFamily: 'Iconfont',
                      ), // 使用的图标
                      color: AppColors.brandGreenVibrant3, // 图标颜色
                      size: 195.w, // 图标大小
                    ),
                  ),
                  Text(
                    l10n.emergencyContacts,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: 40.w,
                    ),
                  ),
                  SizedBox(
                    height: 60.w,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 27.w, right: 27.w),
                    child: Text(
                      l10n.addEmergencyContactsGuidanceFull(3),
                      style: TextStyle(
                        color: AppColors.neutralGrey51,
                        // height: 1.08,
                        fontSize: 25.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.w,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: 27.w,
                      right: 27.w,
                    ),
                    padding: EdgeInsets.only(bottom: 35.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: theme.dividerColor,
                          width: 2.w,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(
                      l10n.learnHowToRecoverPassword,
                      style: TextStyle(
                        height: 1.08,
                        color: AppColors.brandPurpleDark4,
                        fontSize: 25.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 27.w, right: 27.w),
                    child: Row(
                      children: [
                        const IconBox(),
                        SizedBox(
                          width: 20.w,
                        ),
                        const IconBox(),
                        SizedBox(
                          width: 20.w,
                        ),
                        const IconBox(),
                        SizedBox(
                          width: 20.w,
                        ),
                        const IconBox(),
                        SizedBox(
                          width: 20.w,
                        ),
                        const IconBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RectDottedBorderOptions(
        strokeCap: StrokeCap.round,
        color: AppColors.neutralGrey47,
        dashPattern: [16.w, 10.w],
        strokeWidth: 3.w,
        padding: EdgeInsets.all(16),
      ),
      child: SizedBox(
        width: 55.0.w, // 设置宽度
        height: 55.0.w, // 设置高度
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
            size: 36.0.w, // 图标大小
          ),
        ),
      ),
    );
  }
}
