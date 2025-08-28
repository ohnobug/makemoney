import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_function_item.dart';
import 'package:spicychat/screens/components/ljn_switch.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

class LJNSoundLock extends StatefulWidget {
  const LJNSoundLock({super.key});

  @override
  State<LJNSoundLock> createState() => _LJNSoundLock();
}

class _LJNSoundLock extends State<LJNSoundLock> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            bgColor: AppColors.neutralWhite,
          ),
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
                          0xe6b8,
                          fontFamily: 'Iconfont',
                        ), // 使用的图标
                        color: AppColors.brandGreenVibrant2, // 图标颜色
                        size: 200.w, // 图标大小
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.voiceprint,
                      style: TextStyle(
                        height: 1.08,
                        fontSize: 40.w,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
                    ),
                    SizedBox(
                      height: 60.w,
                    ),
                    Container(
                      width: 630.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        // color:
                        //     AppColors.neutralGrey2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.w),
                        ),
                      ),
                      child: Column(
                        children: [
                          LJNFunctionItem(
                            title: AppLocalizations.of(context)!
                                .loginWithVoiceprint,
                            tapEffect: false,
                            underline: true,
                            backgroundColor: AppColors.neutralGrey2,
                            showStyle: Expanded(
                              flex: 0,
                              child: Container(
                                margin: const EdgeInsets.only(right: 32).w,
                                child: LJNSwitch(
                                  initialValue: false,
                                  onChanged: (value) {
                                    logger.info(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                          LJNFunctionItem(
                            title: AppLocalizations.of(context)!.resetAndRemove,
                            link: '',
                            backgroundColor: AppColors.neutralGrey2,
                            underline: true,
                          ),
                          LJNFunctionItem(
                            title: AppLocalizations.of(context)!
                                .tryToVerifyMyVoice,
                            link: '',
                            backgroundColor: AppColors.neutralGrey2,
                            underline: false,
                          ),
                        ],
                      ),
                    )
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
