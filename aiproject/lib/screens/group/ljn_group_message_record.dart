import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/themes.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:spicychat/screens/components/ljn_max_width_button.dart';
import 'package:spicychat/screens/components/ljn_switch.dart';
import 'package:spicychat/tools/ljn_logger.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';

import '../components/ljn_function_item.dart';

class LJNGroupMessageRecord extends StatefulWidget {
  const LJNGroupMessageRecord({
    super.key,
    this.name,
    this.avatar,
    this.nickname,
    this.account,
  });

  final String? name;
  final String? avatar;
  final String? nickname;
  final String? account;

  @override
  State<LJNGroupMessageRecord> createState() => _LJNGroupMessageRecord();
}

class _LJNGroupMessageRecord extends State<LJNGroupMessageRecord> {
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
    return Scaffold(
      primary: false,
      appBar: LJNAppBar(title: AppLocalizations.of(context)!.chatMessages),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                90.w -
                systemState.statusHeight,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.neutralWhite, AppColors.neutralGrey11],
              stops: [0.3, 0.5],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                Container(
                  height: 202.w,
                  width: 750.w,
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 105.w,
                        height: 140.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8).w,
                              child: Image.asset(
                                assetPath('images/avatar_webp/chat_20.webp'),
                                cacheWidth: 210.w.toInt(),
                                cacheHeight: 210.w.toInt(),
                                width: 105.w,
                                height: 105.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 13.w,
                            ),
                            Text(
                              '赵长鹏赵长鹏赵长鹏赵长鹏赵长鹏',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 20.w,
                                color: AppColors.neutralGrey46,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 37.w,
                      ),
                      SizedBox(
                        width: 105.w,
                        height: 140.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8).w,
                              child: Image.asset(
                                assetPath('images/avatar_webp/chat_21.webp'),
                                cacheWidth: 210.w.toInt(),
                                cacheHeight: 210.w.toInt(),
                                width: 105.w,
                                height: 105.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 13.w,
                            ),
                            Text(
                              '郭亮',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 20.w,
                                color: AppColors.neutralGrey46,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 37.w,
                      ),
                      SizedBox(
                        width: 105.w,
                        height: 140.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8).w,
                              child: Image.asset(
                                assetPath('images/avatar_webp/chat_25.webp'),
                                cacheWidth: 210.w.toInt(),
                                cacheHeight: 210.w.toInt(),
                                width: 105.w,
                                height: 105.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 13.w,
                            ),
                            Text(
                              '马化腾',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 20.w,
                                color: AppColors.neutralGrey46,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 37.w,
                      ),
                      SizedBox(
                        width: 105.w,
                        height: 140.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8).w,
                              child: Image.asset(
                                assetPath('images/avatar_webp/chat_28.webp'),
                                cacheWidth: 210.w.toInt(),
                                cacheHeight: 210.w.toInt(),
                                width: 105.w,
                                height: 105.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 13.w,
                            ),
                            Text(
                              '雷军',
                              style: TextStyle(
                                height: 1.08,
                                fontSize: 20.w,
                                color: AppColors.neutralGrey46,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 37.w,
                      ),
                      const IconBox()
                    ],
                  ),
                ),
                Container(
                  color: AppColors.neutralGrey11,
                  height: 16.w,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.groupChatName,
                  link: '',
                  showStyle: "请说英语",
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.groupQRCode,
                  link: '',
                  showStyle: Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          const IconData(
                            0xe74b,
                            fontFamily: 'Iconfont',
                          ),
                          size: 30.w,
                          color: AppColors.neutralGrey45,
                        ),
                      ],
                    ),
                  ),
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.groupAnnouncement,
                  link: '',
                  showStyle: "",
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.remark,
                  link: '',
                  showStyle: "",
                  underline: false,
                ),
                Container(color: AppColors.neutralGrey11, height: 16.w),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.findChatHistory,
                  link: '',
                  showStyle: "",
                  underline: false,
                ),
                Container(color: AppColors.neutralGrey11, height: 16.w),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.muteNotifications,
                  // link: '',
                  underline: true,
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
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.pinToTop,
                  // link: '',
                  underline: true,
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
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.saveToContacts,
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
                  title: AppLocalizations.of(context)!.myNicknameInGroup,
                  link: '',
                  showStyle: "李俊杰",
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.showGroupMemberNicknames,
                  // link: '',
                  underline: false,
                  tapEffect: false,
                  showStyle: Expanded(
                    flex: 0,
                    child: Container(
                      margin: const EdgeInsets.only(right: 32).w,
                      child: LJNSwitch(
                        initialValue: true,
                        onChanged: (value) {
                          logger.info(value);
                        },
                      ),
                    ),
                  ),
                ),
                Container(color: AppColors.neutralGrey11, height: 16.w),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.setChatBackground,
                  link: '',
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.clearChatHistory,
                  link: '',
                  underline: true,
                ),
                LJNFunctionItem(
                  title: AppLocalizations.of(context)!.complain,
                  link: '',
                  underline: false,
                ),
                Container(color: AppColors.neutralGrey11, height: 16.w),
                LJNMaxWidthButton(
                  title: AppLocalizations.of(context)!.leaveGroup,
                  color: AppColors.accentRedPure,
                  underline: false,
                ),
                Container(color: AppColors.neutralGrey11, height: 50.w),
              ],
            ),
          ),
        ),
      ),
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
