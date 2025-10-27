import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_change_account_button.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNYouthModePage extends StatefulWidget {
  const LJNYouthModePage({super.key});

  @override
  State<LJNYouthModePage> createState() => _LJNYouthModePage();
}

class _LJNYouthModePage extends State<LJNYouthModePage> {
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
            appBar: const LJNAppBar(),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
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
                            0xe7fc,
                            fontFamily: 'Iconfont',
                          ), // 使用的图标
                          color: AppColors.brandGreenVibrant4, // 图标颜色
                          size: 110.w, // 图标大小
                        ),
                      ),
                      Text(
                        l10n.youthMode,
                        style: TextStyle(
                          height: 1.08,
                          fontSize: 40.w,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                      SizedBox(
                        height: 25.w,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 70.w,
                          right: 70.w,
                        ),
                        child: Text(
                          l10n.youthModeFullDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 32.w),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        height: 500.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 650.w,
                        // color: Colors.amber,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 22.w,
                              height: 1.08,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment
                                    .middle, // 确保 `Radio` 垂直居中
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedValue = !selectedValue;
                                    });
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 40.w,
                                    margin: EdgeInsets.only(right: 11.w),
                                    child: selectedValue
                                        ? Icon(
                                            const IconData(
                                              0xe65a,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: AppColors.brandGreenVibrant7,
                                            size: 36.w,
                                          )
                                        : Icon(
                                            const IconData(
                                              0xe65b,
                                              fontFamily: 'Iconfont',
                                            ), // 使用的图标
                                            color: AppColors.neutralGrey78,
                                            size: 36.w,
                                          ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: l10n.iHaveReadAndAgree,
                                style: const TextStyle(
                                  color: AppColors.neutralGrey78,
                                ),
                              ),
                              TextSpan(
                                text: l10n.youthModeTermsOfServiceTitle,
                                style: const TextStyle(
                                  color: AppColors.brandBlueDark7,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // 点击条款时的事件处理
                                    logger.info("点击了《Vigaviga青少年模式功能使用条款》");
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.start, // 控制文本的对齐方式
                        ),
                      ),
                      SizedBox(
                        height: 43.w,
                      ),
                      
                      // 按钮
                      selectedValue
                          ? LJNChangeAccountButton(
                              title: l10n.enable,
                              link: "back",
                              readonly: false,
                              color: AppColors.neutralWhite,
                              backgroundColor: AppColors.brandGreenVibrant7,
                            )
                          : LJNChangeAccountButton(
                              title: l10n.enable,
                              link: "back",
                              readonly: false,
                              color: AppColors.neutralGrey41,
                              backgroundColor: AppColors.neutralGrey7,
                            ),
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
