import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_button.dart';
import 'package:vigaviga/widgets/ljn_function_buttons_section.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';

class LJNUser extends StatefulWidget {
  const LJNUser({super.key});

  @override
  State<LJNUser> createState() => _LJNUserState();
}

class _LJNUserState extends State<LJNUser> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(0);
      context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
      context.read<LJNSystemCubit>().updateMainpage4isload(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage4isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
  }

  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 106.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            // gradient: LinearGradient(
            //   colors: [
            //     theme.cardTheme.color!,
            //     theme.colorScheme.surfaceContainer
            //   ],
            //   stops: [0.3, 0.5],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
        ),
        SizedBox(
          width: 750.w,
          height: MediaQuery.of(context).size.height,
          // color: theme.colorScheme.surface,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 顶部功能区域
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    padding: EdgeInsets.only(
                      top: 120.0.w + systemState.statusHeight,
                      left: 32.w,
                      bottom: 30.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 头像
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/userinfo');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10).w,
                            child: BlocBuilder<LJNUserCubit, LJNUserState>(
                              builder: (context, state) {
                                if (state.userinfoAvatar == null ||
                                    state.userinfoAvatar!.isEmpty) {
                                  return Image.asset(
                                    assetPath('images/avatar/default.png'),
                                    cacheWidth: 240.w.toInt(),
                                    cacheHeight: 240.w.toInt(),
                                    width: 120.w,
                                    height: 120.w,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.asset(
                                    assetPath(state.userinfoAvatar!),
                                    cacheWidth: 240.w.toInt(),
                                    cacheHeight: 240.w.toInt(),
                                    width: 120.w,
                                    height: 120.w,
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: 30.w),

                        // 用户信息区域
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 用户名与Vigaviga号
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/userinfo');
                                },
                                child: Container(
                                  color: AppColors.transparent,
                                  padding: EdgeInsets.only(right: 40.w),
                                  child: Column(
                                    children: [
                                      // 用户名
                                      Container(
                                        width: double.infinity,
                                        color: AppColors.transparent,
                                        child: BlocBuilder<LJNUserCubit,
                                            LJNUserState>(
                                          builder: (context, state) {
                                            return Text(
                                              state.userinfoName!,
                                              style: TextStyle(
                                                height: 1.5,
                                                fontSize: fontSizeScale(42.w),
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    theme.colorScheme.onSurface,
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                      SizedBox(height: 20.w),

                                      // Vigaviga号
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 使用 Expanded 包裹 BlocBuilder，让文本自动填充可用空间
                                          Expanded(
                                            child: BlocBuilder<LJNUserCubit,
                                                LJNUserState>(
                                              builder: (context, state) {
                                                return Text(
                                                  l10n.vigavigaIdDisplay(
                                                      state.userinfoAccount!),
                                                  style: TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(28.w),
                                                    color:
                                                        AppColors.neutralGrey71,
                                                  ),
                                                  // 可选: 如果文本太长，可以设置如何显示，比如用省略号
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                );
                                              },
                                            ),
                                          ),
                                          // 二维码图标（这部分保持不变）
                                          Row(
                                            children: [
                                              Icon(
                                                const IconData(
                                                  0xe74b,
                                                  fontFamily: 'Iconfont',
                                                ),
                                                size: 23.w,
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withAlpha(100),
                                              ),
                                              SizedBox(width: 43.w),
                                              Icon(
                                                const IconData(
                                                  0xed9d,
                                                  fontFamily: 'Iconfont',
                                                ),
                                                size: 28.w,
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withAlpha(100),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.w),

                              // 状态
                              Row(
                                children: [
                                  // 状态
                                  LJNStatusButton(
                                    text: l10n.addStatus,
                                    onPressed: () {
                                      logger.info('点击状态');
                                    },
                                  ),
                                  SizedBox(width: 14.w),
                                  // 朋友状态
                                  LJNStatusButton(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 30.w,
                                          width: 85.w,
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned(
                                                // top: 6.w,
                                                left: 0.w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors
                                                          .neutralWhite,
                                                      width: 2.0.w,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      200,
                                                    ).w,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      1000,
                                                    ).w,
                                                    child: Image.asset(
                                                      'assets/images/avatar_webp/chat_4.webp',
                                                      width: 30.w,
                                                      height: 30.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // top: 6.w,
                                                left: 25.w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors
                                                          .neutralWhite,
                                                      width: 2.0.w,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      200,
                                                    ).w,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      1000,
                                                    ).w,
                                                    child: Image.asset(
                                                      'assets/images/avatar_webp/chat_5.webp',
                                                      width: 30.w,
                                                      height: 30.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                // top: 6.w,
                                                left: 50.w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors
                                                          .neutralWhite,
                                                      width: 2.0.w,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      200,
                                                    ).w,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      100,
                                                    ).w,
                                                    child: Image.asset(
                                                      'assets/images/avatar_webp/chat_6.webp',
                                                      width: 30.w,
                                                      height: 30.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          l10n.andXMoreFriends(8),
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: 24.w,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      logger.info('等四个朋友');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 金融理财
                  LJNFunctionButtonsSection(
                    title: l10n.financialServices,
                    buttons: [
                      // 服务
                      LJNFunctionButton(
                        icon: "images/icon/server_icon1.png",
                        title: l10n.services,
                        onPressed: () {
                          Navigator.pushNamed(context, '/services');
                        },
                      ),
                      // 朋友圈
                      LJNFunctionButton(
                        icon: "images/icon/server_icon2.png",
                        title: l10n.moments,
                        onPressed: () {
                          logger.info('点击了理财通按钮~~');
                        },
                      ),
                      // 设置
                      LJNFunctionButton(
                        icon: "images/icon/server_icon3.png",
                        title: l10n.settings,
                        onPressed: () {
                          // logger.info('点击了保险服务按钮~~');
                          Navigator.pushNamed(context, '/setting');
                        },
                      ),
                    ],
                  ),

                  // 生活服务
                  LJNFunctionButtonsSection(
                    title: l10n.lifeServices,
                    buttons: [
                      LJNFunctionButton(
                        icon: "images/icon/server_icon4.png",
                        title: l10n.mobileTopUp,
                        onPressed: () {
                          logger.info('点击了手机充值按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon5.png",
                        title: l10n.utilityPayments,
                        onPressed: () {
                          logger.info('点击了生活缴费按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon6.png",
                        title: l10n.qCoinTopUp,
                        onPressed: () {
                          logger.info('点击了Q币充值按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon7.png",
                        title: l10n.cityServices,
                        onPressed: () {
                          logger.info('点击了城市服务按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon8.png",
                        title: l10n.tencentCharity,
                        onPressed: () {
                          logger.info('点击了腾讯公益按钮~~');
                        },
                      ),
                      LJNFunctionButton(
                        icon: "images/icon/server_icon9.png",
                        title: l10n.healthCare,
                        onPressed: () {
                          logger.info('点击了医疗健康按钮~~');
                        },
                      ),
                    ],
                  ),

                  // LJNVerticalGap(
                  //   height: 8.w,
                  // ),

                  // // 服务
                  // LJNFunctionList(
                  //   children: [
                  //     LJNFunctionItem(
                  //       title: l10n.services,
                  //       icon: "images/icon/icon1.png",
                  //       link: '/services',
                  //       underline: false,
                  //     )
                  //   ],
                  // ),

                  // // 功能列表
                  // LJNFunctionList(
                  //   children: [
                  //     // LJNFunctionItem(
                  //     //   title: l10n.favorite,
                  //     //   icon: "images/icon/icon2.png",
                  //     //   link:
                  //     //       "/open_miniprogram?link=${Uri.encodeComponent('https://baidu.com')}",
                  //     //   underline: true,
                  //     // ),
                  //     LJNFunctionItem(
                  //       title: l10n.moments,
                  //       icon: "images/icon/icon3.png",
                  //       link: '/friendmoments',
                  //       underline: false,
                  //     ),
                  //     // LJNFunctionItem(
                  //     //   title: l10n.channels,
                  //     //   icon: "images/icon/icon4.png",
                  //     //   link: '/video_player',
                  //     //   underline: true,
                  //     // ),
                  //     // LJNFunctionItem(
                  //     //   title: l10n.storeOrdersAndCardPack,
                  //     //   icon: "images/icon/icon5.png",
                  //     //   link: '/test',
                  //     //   underline: true,
                  //     // ),
                  //     // LJNFunctionItem(
                  //     //   title: l10n.stickers,
                  //     //   icon: "images/icon/icon6.png",
                  //     //   link:
                  //     //       "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/code.html')}",
                  //     //   underline: false,
                  //     // ),
                  //   ],
                  // ),

                  // // 设置
                  // LJNFunctionList(
                  //   children: [
                  //     LJNFunctionItem(
                  //       title: l10n.settings,
                  //       icon: "images/icon/icon7.png",
                  //       link: '/setting',
                  //       underline: false,
                  //     )
                  //   ],
                  // ),

                  SizedBox(height: 100.w)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LJNStatusButton extends StatelessWidget {
  /// 当按钮中只显示文本时使用此属性。
  final String? text;

  /// 当按钮中需要显示复杂的子组件（如图标+文本）时使用此属性。
  /// 如果 `text` 不为 null，`child` 将被忽略。
  final Widget? child;

  /// 按钮的点击回调函数。
  final VoidCallback onPressed;

  const LJNStatusButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 使用 Flutter 内置的 OutlinedButton
    return OutlinedButton(
      // 将 onPressed 回调直接传递给 OutlinedButton
      onPressed: onPressed,

      // 根据传入的属性决定按钮的内容
      // 如果 text 不为空，则显示文本
      // 否则，显示 child
      child: text != null
          ? Text(
              text!,
              style: TextStyle(
                // 文本样式可以从主题中继承，也可以在这里覆盖
                // 注意：颜色通常由主题的 `foregroundColor` 控制，这里可以不写
                height: 1.08,
                fontSize: fontSizeScale(24.w),
              ),
            )
          : child!,
    );
  }
}
