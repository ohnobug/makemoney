import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNPopup extends StatefulWidget {
  final Function? onReturn;

  const LJNPopup({super.key, this.onReturn});

  @override
  State<LJNPopup> createState() => _LJNPopupState();
}

class _LJNPopupState extends State<LJNPopup> {
  bool showFilterBg = false;

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
        return Stack(
          children: [
            // 背景
            Container(
              color: AppColors.blackTransparent45,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

            // 弹窗
            Positioned(
              left: (MediaQuery.of(context).size.width - 603.w) / 2,
              top: (MediaQuery.of(context).size.height - 495.w) / 2,
              child: Container(
                width: 603.w,
                height: 495.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  color: AppColors.neutralWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.w),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 136.w,
                      padding: EdgeInsets.only(top: 63.w, bottom: 35.w),
                      child: Text(
                        l10n.addedToDesktopAttempt,
                        style: TextStyle(
                          fontFamily: "AlibabaPuHuiTi",
                          fontSize: 30.w,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                          decoration: TextDecoration.none,
                          height: 1.08,
                        ),
                      ),
                    ),
                    Container(
                      height: 126.w,
                      padding: EdgeInsets.only(left: 60.w, right: 60.w),
                      child: Text(
                        AppLocalizations.of(context)!
                            .shortcutPermissionGuidanceFull,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "AlibabaPuHuiTi",
                          decoration: TextDecoration.none,
                          fontSize: 32.w,
                          color: AppColors.neutralGrey69,
                        ),
                      ),
                    ),
                    Container(
                      height: 62.w,
                      margin: EdgeInsets.only(top: 20.w),
                      alignment: Alignment.center,
                      // color: Colors.purple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            const IconData(
                              0xe65b,
                              fontFamily: 'Iconfont',
                            ),
                            color: AppColors.neutralGrey41,
                            size: 45.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            l10n.doNotRemindAgain,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "AlibabaPuHuiTi",
                              decoration: TextDecoration.none,
                              fontSize: 30.w,
                              color: theme.colorScheme.onSurface,
                              height: 1.08,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 106.w,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        border: Border(
                          top: BorderSide(
                            width: 1.w,
                            color: AppColors.neutralGrey5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onReturn != null) {
                                  widget.onReturn!();
                                }
                              },
                              child: Container(
                                height: 106.w,
                                color: AppColors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  l10n.back,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 32.w,
                                    color: theme.colorScheme.onSurface,
                                    fontFamily: "AlibabaPuHuiTi-Medium",
                                    height: 1.08,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 106.w,
                            width: 1.w,
                            color: AppColors.neutralGrey5,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onReturn != null) {
                                  widget.onReturn!();
                                }
                              },
                              child: Container(
                                height: 106.w,
                                color: AppColors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  l10n.learnMore,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 32.w,
                                    color: AppColors.brandBlueDark2,
                                    fontFamily: "AlibabaPuHuiTi-Medium",
                                    height: 1.08,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
