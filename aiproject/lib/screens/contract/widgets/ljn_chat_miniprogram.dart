import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_button.dart';
import 'package:vigaviga/widgets/ljn_function_buttons_section.dart';

class LJNChatMiniProgram extends StatefulWidget {
  final Function reverse;

  const LJNChatMiniProgram({super.key, required this.reverse});

  @override
  State<LJNChatMiniProgram> createState() => _LJNChatMiniProgram();
}

class _LJNChatMiniProgram extends State<LJNChatMiniProgram> {
  final ScrollController _scrollController = ScrollController();
  // Size _screenSize = const Size(0, 0);
  bool figerRelease = false;
  // Timer? _timer;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      // 手指释放才生效
      if (!figerRelease) return;

      // 超出边缘
      if (_scrollController.position.outOfRange) {
        double currentScrollPosition = _scrollController.position.pixels;
        // 获取最大滚动范围
        double maxScrollExtent = _scrollController.position.maxScrollExtent;

        logger.info("超出: ${currentScrollPosition - maxScrollExtent}");

        // 检查是否超出
        if (currentScrollPosition > maxScrollExtent) {
          if (currentScrollPosition - maxScrollExtent > 200.w) {
            widget.reverse();

            // // 500毫秒后，恢复到原初的样子
            // _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
            //   setState(() {
            //     _scrollController.jumpTo(0);
            //     context
            //         .read<LJNSystemCubit>()
            //         .updateShowMiniProgramDrawer(false);
            //   });
            // });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    logger.info("撤退");
    // _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        double newAppbarHeight = systemState.appbarHeight + 17.w;

        double miniprogramboxScale = 0.8 +
            (0.2 *
                ((systemState.homescrollpixels +
                        systemState.statusHeight -
                        400.w) /
                    (MediaQuery.of(context).size.height -
                        newAppbarHeight -
                        400.w)));
        if (miniprogramboxScale < 0) {
          miniprogramboxScale = 0;
        } else if (miniprogramboxScale > 1) {
          miniprogramboxScale = 1;
        }

        return Container(
          width: 750.w,
          height: systemState.homescrollpixels +
              (systemState.appbarHeight + systemState.statusHeight + 200.w),
          color: Color.fromARGB(
            (255 * 0.8).toInt(),
            50,
            48,
            70,
          ),
          child: Transform.scale(
            scale: miniprogramboxScale,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // appbar标题
                Theme(
                  data: theme.copyWith(
                    appBarTheme: theme.appBarTheme.copyWith(
                      backgroundColor: Colors.transparent,
                      titleTextStyle:
                          theme.appBarTheme.titleTextStyle!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: LJNAppBar(
                    title: l10n.recent,
                    leading: Container(),
                    actions: [
                      Container(
                        // width: 80.w,
                        height: 55.w,
                        margin: EdgeInsets.only(right: 30.w),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.greyTransparent15,
                          borderRadius: BorderRadius.all(
                            Radius.circular(35.w),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              const IconData(
                                0xe612,
                                fontFamily: 'Iconfont',
                              ),
                              color: AppColors.brandBlueGreyLight,
                              size: 26.w,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              l10n.search,
                              style: TextStyle(
                                fontSize: 26.w,
                                color: AppColors.brandBlueGreyLight,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // 列表
                Expanded(
                  child: Listener(
                    onPointerDown: (event) {
                      figerRelease = false;
                    },
                    onPointerUp: (event) {
                      figerRelease = true;
                    },
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        child: Theme(
                          data: theme.copyWith(
                            cardTheme: theme.cardTheme.copyWith(
                              color: Colors.transparent,
                            ),
                            colorScheme: theme.colorScheme.copyWith(
                              onSurface: Colors.white,
                            ),
                          ),
                          child: Column(
                            children: [
                              // 听一听
                              LJNFunctionButtonsSection(
                                title: l10n.listen,
                                buttons: [
                                  LJNFunctionButton(
                                    icon: "images/miniprogram_icon/duitang.jpg",
                                    title: "堆糖",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/tiankongyueduqi.jpg",
                                    title: "天空阅读器",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                ],
                              ),

                              // 最近使用的小程序
                              LJNFunctionButtonsSection(
                                title: l10n.recentMiniPrograms,
                                rightWidget: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("/miniprogram_list");
                                  },
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: l10n.more,
                                          style: TextStyle(
                                            height: 1.08,
                                            fontSize: fontSizeScale(26.w),
                                            color: AppColors.neutralGrey42,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: SizedBox(
                                            width: 5.w,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: SizedBox(
                                            width: 26.w,
                                            child: Icon(
                                              const IconData(
                                                0xed9d,
                                                fontFamily: 'Iconfont',
                                              ),
                                              color: theme.colorScheme.onSurface
                                                  .withAlpha(100),
                                              size: 26.w,
                                            ),
                                          ),
                                          alignment: PlaceholderAlignment
                                              .middle, // 使图标与文本垂直居中对齐
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                buttons: [
                                  LJNFunctionButton(
                                    icon: "images/miniprogram_icon/duitang.jpg",
                                    title: "堆糖",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/tiankongyueduqi.jpg",
                                    title: "天空阅读器",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/qishuwang.jpg",
                                    title: "奇书网",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/xueyouyoujiao.jpg",
                                    title: "学有优教",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/haiziwang.jpg",
                                    title: "孩子王",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/qianbixiaoshuo.jpg",
                                    title: "铅笔小说",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/chengquanshipin.jpg",
                                    title: "成全视频",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/xiaomishangcheng.jpg",
                                    title: "小米商城",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                ],
                              ),

                              // 我的常用小程序
                              LJNFunctionButtonsSection(
                                title: l10n.myMiniPrograms,
                                buttons: [
                                  LJNFunctionButton(
                                    icon: "images/miniprogram_icon/duitang.jpg",
                                    title: "堆糖",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/tiankongyueduqi.jpg",
                                    title: "天空阅读器",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/qishuwang.jpg",
                                    title: "奇书网",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/xueyouyoujiao.jpg",
                                    title: "学有优教",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/chengquanshipin.jpg",
                                    title: "成全视频",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/xiaomishangcheng.jpg",
                                    title: "小米商城",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/meituxiuxiu.jpg",
                                    title: "美图秀秀",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                  LJNFunctionButton(
                                    icon:
                                        "images/miniprogram_icon/luobokuaipao.jpg",
                                    title: "萝卜快跑",
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                    },
                                  ),
                                ],
                              ),

                              // 占位
                              Container(
                                color: Colors.transparent,
                                width: 750.w,
                                height: 500.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
