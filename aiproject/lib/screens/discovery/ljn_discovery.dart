import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_text_spans.dart';
import '../../widgets/ljn_function_item.dart';

class LJNDiscovery extends StatefulWidget {
  const LJNDiscovery({super.key});

  @override
  State<LJNDiscovery> createState() => _LJNDiscovery();
}

class _LJNDiscovery extends State<LJNDiscovery> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(0);
      context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
      context.read<LJNSystemCubit>().updateMainpage3isload(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return systemState.mainpage3isload!
          ? _buildPage(systemState)
          : const LJNPageLoading();
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ColoredBox(
        color: theme.colorScheme.surfaceContainer,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            children: [
              SizedBox(height: systemState.statusHeight + 90.w),

              // 朋友圈
              LJNFunctionItem(
                title: l10n.moments,
                icon: "images/icon/discovery_icon1.png",
                link: '/friendmoments',
                underline: false,
              ),
              SizedBox(height: 16.w),

              // 视频号、直播
              LJNFunctionItem(
                title: l10n.channels,
                icon: "images/icon/discovery_icon2.png",
                link: '/ins',
                underline: true,
                showStyle: SizedBox(
                  width: 400.w,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6).w,
                          child: Image.asset(
                            assetPath('images/avatar_webp/chat_4.webp'),
                            width: 60.w,
                            height: 60.w,
                            cacheWidth: 120.w.toInt(),
                            cacheHeight: 120.w.toInt(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Expanded(
                          child: LJNTextSpans(
                            text: "李俊南集团💖李俊男李俊男李俊男李俊男李俊男李俊男李俊男李俊男  最近💖",
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(26.w),
                              color: AppColors.neutralDarkGrey10,
                              fontFamily: "AlibabaPuHuiTi",
                            ),
                            emojiStyle: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(26.w),
                              fontFamily: "NotoColorEmoji-Regular",
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              LJNFunctionItem(
                title: l10n.live,
                icon: "images/icon/discovery_icon3.png",
                link: '/tiktik',
                underline: false,
                showStyle: SizedBox(
                  width: 400.w,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "小歪今天穿什么直播中",
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(26.w),
                              color: AppColors.neutralDarkGrey10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60).w,
                          child: Image.asset(
                            assetPath('images/avatar_webp/chat_4.webp'),
                            cacheWidth: 120.w.toInt(),
                            cacheHeight: 120.w.toInt(),
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 16.w),

              // 扫一扫、听一听
              LJNFunctionItem(
                title: l10n.scan,
                icon: "images/icon/discovery_icon4.png",
                link: '/qrcode_scanner',
                underline: true,
              ),
              LJNFunctionItem(
                title: l10n.listen,
                icon: "images/icon/discovery_icon5.png",
                link: '',
                underline: false,
              ),
              SizedBox(height: 16.w),

              // 看一看、搜一搜
              LJNFunctionItem(
                title: l10n.look,
                icon: "images/icon/discovery_icon6.png",
                link: '',
                underline: true,
              ),
              LJNFunctionItem(
                title: l10n.searchAction,
                icon: "images/icon/discovery_icon7.png",
                link: '/search',
                underline: false,
              ),
              SizedBox(height: 16.w),

              // 附近
              LJNFunctionItem(
                title: l10n.nearby,
                icon: "images/icon/discovery_icon8.png",
                link: '',
                underline: false,
              ),
              SizedBox(height: 16.w),

              // 购物、游戏
              LJNFunctionItem(
                title: l10n.shopping,
                icon: "images/icon/discovery_icon9.png",
                link: '',
                underline: true,
              ),
              LJNFunctionItem(
                title: l10n.games,
                icon: "images/icon/discovery_icon10.png",
                link: '',
                underline: false,
              ),
              SizedBox(height: 16.w),

              // 小程序
              LJNFunctionItem(
                title: l10n.miniPrograms,
                icon: "images/icon/discovery_icon11.png",
                link: '/miniprogram_list',
                underline: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
