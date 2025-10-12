import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';
import 'package:vigaviga/widgets/ljn_switch.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNGroupMessageRecordPage extends StatefulWidget {
  const LJNGroupMessageRecordPage({
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
  State<LJNGroupMessageRecordPage> createState() => _LJNGroupMessageRecord();
}

class _LJNGroupMessageRecord extends State<LJNGroupMessageRecordPage> {
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
          appBar: LJNAppBar(title: l10n.chatMessages),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    systemState.appbarHeight -
                    systemState.statusHeight,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.neutralWhite,
                    theme.colorScheme.surfaceContainer
                  ],
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
                    // 群成员头像
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
                                    assetPath(
                                        'images/avatar_webp/chat_20.webp'),
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
                                    assetPath(
                                        'images/avatar_webp/chat_21.webp'),
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
                                    assetPath(
                                        'images/avatar_webp/chat_25.webp'),
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
                                    assetPath(
                                        'images/avatar_webp/chat_28.webp'),
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

                    // 群聊名称、 群二维码、 群公告、 群备注
                    LJNFunctionList(children: [
                      // 群聊名称
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.groupChatName,
                        link: '',
                        showStyle: "请说英语",
                        underline: true,
                      ),
                      // 群二维码
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.groupQRCode,
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
                      // 群公告
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.groupAnnouncement,
                        link: '',
                        showStyle: "",
                        underline: true,
                      ),
                      // 群备注
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.remark,
                        link: '',
                        showStyle: "",
                        underline: false,
                      ),
                    ]),

                    // 查找聊天记录
                    LJNFunctionList(
                      children: [
                        // 查找聊天记录
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.findChatHistory,
                          link: '',
                          showStyle: "",
                          underline: false,
                        ),
                      ],
                    ),

                    // 消息设置
                    LJNFunctionList(
                      children: [
                        // 消息免打扰
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
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

                        // 置顶聊天
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
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

                        // 保存到通讯录
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.saveToContacts,
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

                    // 聊天设置
                    LJNFunctionList(
                      children: [
                        // 我的群昵称
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.myNicknameInGroup,
                          link: '',
                          showStyle: "李俊杰",
                          underline: true,
                        ),

                        // 显示群成员昵称
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.showGroupMemberNicknames,
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
                      ],
                    ),

                    // 设置聊天背景、清空聊天记录、投诉
                    LJNFunctionList(children: [
                      // 设置聊天背景
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.setChatBackground,
                        link: '',
                        underline: true,
                      ),

                      // 清空聊天记录
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.clearChatHistory,
                        link: '',
                        underline: true,
                      ),

                      // 投诉
                      LJNFunctionItem(
                        icon: "images/avatar/02.png",
                        title: l10n.complain,
                        link: '',
                        underline: false,
                      ),
                    ]),

                    // 退出群聊
                    LJNFunctionList(children: [
                      // 退出群聊
                      LJNMaxWidthButton(
                        title: l10n.leaveGroup,
                        color: AppColors.accentRedPure,
                        underline: false,
                      ),
                    ]),

                    SizedBox(height: 100.w)
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
