import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigaviga/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/tools/viga_action_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_max_width_button.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_text_spans.dart';

class VigaFriendProfilePage extends StatefulWidget {
  const VigaFriendProfilePage({
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
  State<VigaFriendProfilePage> createState() => _VigaFriendProfile();
}

class _VigaFriendProfile extends State<VigaFriendProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
    String cdnBase = systemState.cdnBase;

    return Scaffold(
      primary: false,
      appBar: null,
      body: SizedBox(
        width: 750.w,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            VigaAppBar(
              title: "",
              actions: [
                VigaAppBarActionIconButton(
                  iconData: const IconData(0xe659, fontFamily: 'Iconfont'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat/friend_data_setting',
                    );
                  },
                ),
              ],
            ),
            Positioned(
              top: systemState.appbarHeight + systemState.statusHeight,
              left: 0,
              right: 0,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                    //     theme.colorScheme.surface
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
                          width: 750.w,
                          height: 260.w,
                          decoration: BoxDecoration(
                            color: AppColors.neutralWhite,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.dividerColor,
                                width: 1.0.w,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40.w,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.w),
                                    child: VigaAppNetworkImage(
                                      imageUrl: widget.avatar!,
                                      width: 120.w,
                                      height: 120.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 姓名
                                        VigaTextSpans(
                                          text: widget.name!,
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(40.w),
                                            color: theme.colorScheme.onSurface,
                                          ),
                                          emojiStyle: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(40.w),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20.w,
                                        ),

                                        // 昵称
                                        VigaTextSpans(
                                          text: l10n.nicknameDisplay(
                                              widget.nickname!),
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(27.w),
                                            color: AppColors.neutralDarkGrey1,
                                          ),
                                          emojiStyle: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(27.w),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20.w,
                                        ),

                                        // Vigaviga号
                                        GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: widget.account!));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    textAlign: TextAlign.center,
                                                    AppLocalizations.of(
                                                            context)!
                                                        .copySuccessWithVigavigaId(
                                                            widget.account!)),
                                                duration: Duration(
                                                  seconds: 3,
                                                ), // 设置 Snackbar 显示时间
                                              ),
                                            );
                                          },
                                          child: Text(
                                            l10n.vigavigaIdDisplay(
                                                widget.account!),
                                            style: TextStyle(
                                              height: 1.08,
                                              fontSize: fontSizeScale(27.w),
                                              color: AppColors.neutralDarkGrey1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 朋友资料 与 朋友权限 与 朋友圈
                        VigaFunctionList(
                          children: [
                            // 朋友资料
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.friendProfile,
                              link: '/chat/friend_information',
                              underline: true,
                            ),

                            // 朋友权限
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.friendPermissions,
                              link: '/chat/friend_permissions',
                              underline: true,
                            ),

                            // 朋友圈
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: Container(
                                width: 190.w,
                                padding: EdgeInsets.only(left: 30.w),
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  l10n.moments,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(32.0.w),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              link: '/chat/friend_moments',
                              height: 151.w,
                              showStyle: Expanded(
                                child: SizedBox(
                                  // width: 470.w,
                                  // height: double.infinity,
                                  // margin: EdgeInsets.only(left: 68.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      VigaAppNetworkImage(
                                        imageUrl:
                                            '${systemState.cdnBase}/avatar/chat_81.jpg',
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      VigaAppNetworkImage(
                                        imageUrl:
                                            '${systemState.cdnBase}/avatar/chat_92.jpg',
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      VigaAppNetworkImage(
                                        imageUrl:
                                            '${systemState.cdnBase}/avatar/chat_93.jpg',
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      VigaAppNetworkImage(
                                        imageUrl:
                                            '${systemState.cdnBase}/avatar/chat_86.jpg',
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              underline: true,
                            ),

                            // 视频号
                            VigaFunctionItem(
                              icon: "${systemState.cdnBase}/avatar/02.png",
                              title: Container(
                                width: 190.w,
                                padding: EdgeInsets.only(
                                  left: 30.w,
                                  top: 38.w,
                                ),
                                height: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  l10n.channels,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(32.0.w),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              link: '/ins',
                              showLinkIcon: false,
                              height: 216.w,
                              showStyle: Expanded(
                                child: Row(
                                  // direction: Axis.horizontal,
                                  // width: 490.w + 62.w,
                                  // height: 215.w,
                                  // margin: EdgeInsets.only(left: 68.w),
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 相册
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 38.w,
                                        ),
                                        Text(
                                          widget.name as String,
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(32.0.w),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 28.w,
                                        ),
                                        // 视频
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            VigaAppNetworkImage(
                                              imageUrl:
                                                  '${systemState.cdnBase}/avatar/chat_55.jpg',
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            VigaAppNetworkImage(
                                              imageUrl:
                                                  '${systemState.cdnBase}/avatar/chat_43.jpg',
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            VigaAppNetworkImage(
                                              imageUrl:
                                                  '${systemState.cdnBase}/avatar/chat_96.jpg',
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            VigaAppNetworkImage(
                                              imageUrl:
                                                  '${systemState.cdnBase}/avatar/chat_97.jpg',
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),

                                    // 箭头
                                    Container(
                                      width: 30.w,
                                      margin: EdgeInsets.only(
                                        right: 32.w,
                                        top: 75.w,
                                      ),
                                      child: Icon(
                                        const IconData(
                                          0xed9d,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 30.0.w,
                                        color: theme.colorScheme.onSurface
                                            .withAlpha(100),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              underline: true,
                            ),

                            // 更多信息
                            VigaFunctionItem(
                              icon: "$cdnBase/avatar/02.png",
                              title: l10n.moreInfo,
                              link: '/chat/friend_more_info',
                              underline: false,
                            ),
                          ],
                        ),

                        // 发消息
                        VigaFunctionList(
                          children: [
                            VigaMaxWidthButton(
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 60.w,
                                    // color: AppColors.accentRedPure,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      const IconData(
                                        0xe7b3,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: theme.colorScheme.onSurface,
                                      size: 38.w,
                                    ),
                                  ),
                                  // SizedBox(width: 12.w),
                                  Text(
                                    l10n.sendMessage,
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: 30.w,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  )
                                ],
                              ),
                              underline: true,
                              onPressed: () {
                                Navigator.pushNamed(context, '/chat',
                                    arguments: <String, String>{
                                      'title': "何三七",
                                      'icon': "$cdnBase/avatar/chat_17.jpg",
                                    });
                              },
                            ),
                          ],
                        ),

                        // 音视频通话
                        VigaFunctionList(
                          children: [
                            VigaMaxWidthButton(
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 60.w,
                                    // color: AppColors.accentRedPure,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      const IconData(
                                        0xe88d,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: theme.colorScheme.onSurface,
                                      size: 42.w,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    l10n.audioVideoCall,
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: 30.w,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  )
                                ],
                              ),
                              underline: false,
                              onPressed: () {
                                showVigaActionSheet(
                                  context: context,
                                  actions: [
                                    VigaActionSheetAction(
                                      text: Text.rich(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                              ),
                                              child: Baseline(
                                                baseline: 31.w,
                                                baselineType:
                                                    TextBaseline.alphabetic,
                                                child: Icon(
                                                  const IconData(
                                                    0xe64f,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  size: 40.w,
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: SizedBox(width: 20.w),
                                            ),
                                            TextSpan(
                                              text: l10n.videoCall,
                                              style: TextStyle(
                                                height: 1.08,
                                                fontSize: 30.w,
                                                decoration: TextDecoration.none,
                                                color:
                                                    theme.colorScheme.onSurface,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/video_player');
                                      },
                                    ),
                                    VigaActionSheetAction(
                                      text: Text.rich(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        TextSpan(children: [
                                          WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                            ),
                                            child: Baseline(
                                              baseline: 31.w,
                                              baselineType:
                                                  TextBaseline.alphabetic,
                                              child: Icon(
                                                const IconData(
                                                  0xe64c,
                                                  fontFamily: 'Iconfont',
                                                ),
                                                color:
                                                    theme.colorScheme.onSurface,
                                                size: 40.w,
                                              ),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: SizedBox(width: 20.w),
                                          ),
                                          TextSpan(
                                            text: l10n.voiceCall,
                                            style: TextStyle(
                                              height: 1.08,
                                              fontSize: 30.w,
                                              decoration: TextDecoration.none,
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/chat/dial');
                                      },
                                    ),
                                  ],
                                  cancelButtonText: l10n.cancel,
                                );
                              },
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
          ],
        ),
      ),
    );
  }
}
