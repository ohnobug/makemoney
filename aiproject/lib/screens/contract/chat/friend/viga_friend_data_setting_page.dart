import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_popup.dart';
import 'package:vigaviga/widgets/viga_switch.dart';
import 'package:vigaviga/widgets/viga_max_width_button.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaFriendDataSettingPage extends StatefulWidget {
  const VigaFriendDataSettingPage({
    super.key,
  });

  @override
  State<VigaFriendDataSettingPage> createState() => _VigaFriendDataSetting();
}

class _VigaFriendDataSetting extends State<VigaFriendDataSettingPage> {
  bool showPopup = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Positioned(
          child: Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: l10n.profileSettings,
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
                    children: [
                      VigaFunctionList(children: [
                        VigaFunctionItem(
                          title: l10n.setRemarkAndTags,
                          link: '/chat/set_notes_and_labels',
                          showStyle: "邓子乔",
                          underline: true,
                        ),
                        VigaFunctionItem(
                          title: l10n.friendPermissions,
                          link: '/chat/friend_permissions',
                          underline: false,
                        ),
                      ]),

                      VigaFunctionList(children: [
                        VigaFunctionItem(
                          title: l10n.recommendToFriend,
                          link: '',
                          underline: true,
                        ),
                      ]),

                      // 设置星标朋友
                      VigaFunctionList(children: [
                        VigaFunctionItem(
                          title: l10n.setAsStarFriend,
                          // link: '',
                          underline: false,
                          tapEffect: false,
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
                      ]),

                      // 添加到黑名单、投诉
                      VigaFunctionList(
                        children: [
                          VigaFunctionItem(
                            title: l10n.addToBlocklist,
                            tapEffect: false,
                            underline: true,
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
                          VigaFunctionItem(
                            title: l10n.complain,
                            link: '',
                            underline: false,
                          ),
                        ],
                      ),

                      // 删除好友
                      VigaFunctionList(
                        children: [
                          VigaMaxWidthButton(
                            title: l10n.delete,
                            color: AppColors.accentRedPure,
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
          ),
        ),
        if (showPopup)
          VigaPopup(
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
