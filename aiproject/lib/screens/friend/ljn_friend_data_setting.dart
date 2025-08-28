import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_popup.dart';
import 'package:spicychat/screens/components/ljn_switch.dart';
import 'package:spicychat/screens/components/ljn_max_width_button.dart';
import 'package:spicychat/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNFriendDataSetting extends StatefulWidget {
  const LJNFriendDataSetting({
    super.key,
  });

  @override
  State<LJNFriendDataSetting> createState() => _LJNFriendDataSetting();
}

class _LJNFriendDataSetting extends State<LJNFriendDataSetting> {
  bool showPopup = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    return Stack(
      children: [
        Positioned(
          child: Scaffold(
            primary: false,
            appBar: LJNAppBar(
              title: AppLocalizations.of(context)!.profileSettings,
            ),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        90.w -
                        systemState.statusHeight),
                color: AppColors.neutralGrey11,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.setRemarkAndTags,
                        link: '/set_notes_and_labels',
                        showStyle: "邓子乔",
                        underline: true,
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.friendPermissions,
                        link: '/friend_permissions',
                        underline: false,
                      ),
                      Container(color: AppColors.neutralGrey11, height: 16.w),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.recommendToFriend,
                        link: '',
                        underline: true,
                      ),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.addToDesktop,
                        // link: '',
                        underline: false,
                        onPress: () {
                          setState(() {
                            showPopup = true;
                          });
                        },
                      ),
                      Container(color: AppColors.neutralGrey11, height: 16.w),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.setAsStarFriend,
                        // link: '',
                        underline: false,
                        tapEffect: false,
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
                      Container(color: AppColors.neutralGrey11, height: 16.w),
                      LJNFunctionItem(
                        title: AppLocalizations.of(context)!.addToBlocklist,
                        tapEffect: false,
                        underline: true,
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
                        title: AppLocalizations.of(context)!.complain,
                        link: '',
                        underline: false,
                      ),
                      Container(color: AppColors.neutralGrey11, height: 16.w),
                      LJNMaxWidthButton(
                        title: AppLocalizations.of(context)!.delete,
                        color: AppColors.accentRedPure,
                        underline: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (showPopup)
          LJNPopup(
            onReturn: () {
              setState(() {
                showPopup = false;
              });
            },
          )
      ],
    );
  }
}

class IconBox extends StatelessWidget {
  const IconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.w,
      width: 105.w,
      alignment: Alignment.topLeft,
      child: DottedBorder(
        // color: AppColors.neutralGrey47,
        // borderType: BorderType.RRect,
        // padding: const EdgeInsets.all(0),
        // borderPadding: const EdgeInsets.all(0),
        // stackFit: StackFit.loose,
        // strokeWidth: 3.w,
        // dashPattern: [16.w, 10.w],
        // strokeCap: StrokeCap.round,
        // radius: Radius.circular(8.0.w),
        child: SizedBox(
          width: 105.0.w, // 设置宽度
          height: 105.0.w, // 设置高度
          // decoration: BoxDecoration(
          //   color: AppColors.transparent, // 背景透明
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
              size: 42.0.w, // 图标大小
            ),
          ),
        ),
      ),
    );
  }
}
