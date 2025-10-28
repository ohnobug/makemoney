import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaSoundLockPage extends StatefulWidget {
  const VigaSoundLockPage({super.key});

  @override
  State<VigaSoundLockPage> createState() => _VigaSoundLockPage();
}

class _VigaSoundLockPage extends State<VigaSoundLockPage> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        String cdnBase = systemState.cdnBase;

        return Scaffold(
          primary: false,
          appBar: const VigaAppBar(),
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
                    Container(
                      height: 290.w,
                      alignment: Alignment.center,
                      child: Icon(
                        const IconData(
                          0xe6b8,
                          fontFamily: 'Iconfont',
                        ), // 使用的图标
                        color: AppColors.brandGreenVibrant2, // 图标颜色
                        size: 200.w, // 图标大小
                      ),
                    ),
                    Text(
                      l10n.voiceprint,
                      style: TextStyle(
                        height: 1.08,
                        fontSize: 40.w,
                      ),
                    ),
                    SizedBox(
                      height: 60.w,
                    ),
                    VigaFunctionList(children: [
                      // 语音锁
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
                        title: l10n.loginWithVoiceprint,
                        tapEffect: false,
                        underline: true,
                        // backgroundColor: AppColors.neutralGrey2,
                        showStyle: Expanded(
                          flex: 0,
                          child: Container(
                            margin: const EdgeInsets.only(right: 32).w,
                            child: VigaSwitch(
                              initialValue: false,
                              onChanged: (value) {
                                logger.info(value);
                              },
                            ),
                          ),
                        ),
                      ),

                      // 重置并移除
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
                        title: l10n.resetAndRemove,
                        link: '',
                        // backgroundColor: AppColors.neutralGrey2,
                        underline: true,
                      ),

                      // 尝试验证我的声音
                      VigaFunctionItem(
                        icon: "$cdnBase/avatar/02.png",
                        title: l10n.tryToVerifyMyVoice,
                        link: '',
                        // backgroundColor: AppColors.neutralGrey2,
                        underline: false,
                      ),
                    ])
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
