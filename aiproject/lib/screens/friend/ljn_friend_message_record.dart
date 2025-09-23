import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import '../../widgets/ljn_function_item.dart';

class LJNFriendMessageRecord extends StatefulWidget {
  const LJNFriendMessageRecord({
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
  State<LJNFriendMessageRecord> createState() => _LJNFriendMessageRecord();
}

class _LJNFriendMessageRecord extends State<LJNFriendMessageRecord> {
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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(title: l10n.chatMessages),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  90.w -
                  systemState.statusHeight),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            // gradient: LinearGradient(
            //   colors: [
            //     AppColors.neutralWhite,
            //     theme.colorScheme.surfaceContainer
            //   ],
            //   stops: [0.3, 0.5],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
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
                  padding: EdgeInsets.only(
                    left: 25.w,
                    right: 25.w,
                  ),
                  color: theme.colorScheme.surface,
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
                                assetPath(context
                                    .read<LJNUserCubit>()
                                    .state
                                    .userinfoAvatar!),
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
                              '邓子乔',
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

                // 查找聊天记录
                LJNFunctionList(
                  children: [
                    LJNFunctionItem(
                      title: l10n.findChatHistory,
                      link: '',
                      underline: false,
                    )
                  ],
                ),

                // 消息设置
                LJNFunctionList(
                  children: [
                    // 静音
                    LJNFunctionItem(
                      title: l10n.muteNotifications,
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
                    // 置顶
                    LJNFunctionItem(
                      title: l10n.pinToTop,
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

                    // 消息提醒
                    LJNFunctionItem(
                      title: l10n.alert,
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
                  ],
                ),

                // // 设置聊天背景
                // LJNFunctionList(
                //   children: [
                //     LJNFunctionItem(
                //       title: l10n.setChatBackground,
                //       link: '',
                //       underline: false,
                //     ),
                //   ],
                // ),

                // 清除聊天记录
                LJNFunctionList(
                  children: [
                    LJNFunctionItem(
                      title: l10n.clearChatHistory,
                      link: '',
                      underline: false,
                    ),
                  ],
                ),

                // 投诉
                LJNFunctionList(
                  children: [
                    LJNFunctionItem(
                      title: l10n.complain,
                      link: '',
                      underline: false,
                    ),
                  ],
                ),

                SizedBox(height: 100.w)
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
        options: RoundedRectDottedBorderOptions(
          color: AppColors.neutralGrey47,
          padding: const EdgeInsets.all(0),
          borderPadding: const EdgeInsets.all(0),
          stackFit: StackFit.loose,
          strokeWidth: 2.5.w,
          dashPattern: [16.w, 10.w],
          strokeCap: StrokeCap.round,
          radius: Radius.circular(8.0.w),
        ),
        child: SizedBox(
          width: 105.0.w, // 设置宽度
          height: 105.0.w, // 设置高度
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
              size: 42.0.w, // 图标大小
            ),
          ),
        ),
      ),
    );
  }
}
