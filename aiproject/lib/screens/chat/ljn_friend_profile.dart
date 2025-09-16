import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigaviga/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_show_call_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_max_width_button.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';

class LJNFriendProfile extends StatefulWidget {
  const LJNFriendProfile({
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
  State<LJNFriendProfile> createState() => _LJNFriendProfile();
}

class _LJNFriendProfile extends State<LJNFriendProfile>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
      appBar: null,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            LJNAppBar(
              title: "",
              actions: [
                GestureDetector(
                  onTap: () {
                    // 点击事件
                    Navigator.pushNamed(
                      context,
                      '/friend_data_setting',
                    );
                  },
                  child: Container(
                    height: 90.w,
                    color: AppColors.transparent,
                    padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                    alignment: Alignment.center,
                    child: Icon(
                      const IconData(
                        0xe659,
                        fontFamily: 'Iconfont',
                      ),
                      size: 42.w, // 图标大小
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 90.w + systemState.statusHeight,
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
                                width: 1.5.w,
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
                                    child: Image.asset(
                                      assetPath(widget.avatar!),
                                      width: 120.w,
                                      height: 120.w,
                                      cacheWidth: 240.w.toInt(),
                                      cacheHeight: 240.w.toInt(),
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
                                        LJNTextSpans(
                                          text: widget.name!,
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(40.w),
                                            color: theme.colorScheme.onSurface,
                                            fontFamily: "AlibabaPuHuiTi-Medium",
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
                                        LJNTextSpans(
                                          text: l10n.nicknameDisplay(
                                              widget.nickname!),
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(27.w),
                                            color: AppColors.neutralDarkGrey1,
                                            fontFamily: "AlibabaPuHuiTi-Medium",
                                          ),
                                          emojiStyle: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(27.w),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20.w,
                                        ),

                                        // 微信号
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
                                                        .copySuccessWithWechatId(
                                                            widget.account!)),
                                                duration: Duration(
                                                  seconds: 3,
                                                ), // 设置 Snackbar 显示时间
                                              ),
                                            );
                                          },
                                          child: Text(
                                            l10n.wechatIdDisplay(
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
                        LJNFunctionList(
                          children: [
                            // 朋友资料
                            LJNFunctionItem(
                              title: l10n.friendProfile,
                              link: '/friend_information',
                              underline: true,
                            ),

                            // 朋友权限
                            LJNFunctionItem(
                              title: l10n.friendPermissions,
                              link: '/friend_permissions',
                              underline: true,
                            ),

                            // 朋友圈
                            LJNFunctionItem(
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
                                    fontFamily: "AlibabaPuHuiTi",
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              link: '/friendmoments',
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
                                      Image.asset(
                                        assetPath(
                                            'images/avatar_webp/chat_81.webp'),
                                        cacheWidth: 180.w.toInt(),
                                        cacheHeight: 180.w.toInt(),
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Image.asset(
                                        assetPath(
                                            'images/avatar_webp/chat_92.webp'),
                                        cacheWidth: 180.w.toInt(),
                                        cacheHeight: 180.w.toInt(),
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Image.asset(
                                        assetPath(
                                            'images/avatar_webp/chat_93.webp'),
                                        cacheWidth: 180.w.toInt(),
                                        cacheHeight: 180.w.toInt(),
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Image.asset(
                                        assetPath(
                                            'images/avatar_webp/chat_86.webp'),
                                        cacheWidth: 180.w.toInt(),
                                        cacheHeight: 180.w.toInt(),
                                        width: 90.w,
                                        height: 90.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              underline: false,
                            ),

                            // 视频号
                            LJNFunctionItem(
                              title: Container(
                                width: 190.w,
                                padding: EdgeInsets.only(left: 30.w, top: 38.w),
                                height: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  l10n.channels,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(32.0.w),
                                    fontFamily: "AlibabaPuHuiTi",
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
                                            fontFamily: "AlibabaPuHuiTi",
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
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_55.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_43.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_96.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
                                              width: 90.w,
                                              height: 90.w,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Image.asset(
                                              assetPath(
                                                  'images/avatar_webp/chat_97.webp'),
                                              cacheWidth: 180.w.toInt(),
                                              cacheHeight: 180.w.toInt(),
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
                                          right: 32.w, top: 75.w),
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
                            LJNFunctionItem(
                              title: l10n.moreInfo,
                              link: '/friend_more_info',
                              underline: false,
                            ),
                          ],
                        ),

                        // 发消息
                        LJNFunctionList(
                          children: [
                            LJNMaxWidthButton(
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
                                      'icon': "images/avatar_webp/chat_17.webp",
                                    });
                              },
                            ),
                          ],
                        ),

                        // 音视频通话
                        LJNFunctionList(
                          children: [
                            LJNMaxWidthButton(
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
                                showCallPopup(context, systemState);
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
