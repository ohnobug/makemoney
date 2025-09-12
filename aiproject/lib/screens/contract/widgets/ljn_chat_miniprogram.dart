import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

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
            _scrollController.jumpTo(0);
            widget.reverse();
            context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    logger.info("撤退");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        double newAppbarHeight = 90.w + 17.w;

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
          width: MediaQuery.of(context).size.width,
          height: systemState.homescrollpixels +
              (90.w + systemState.statusHeight + 200.w),
          color: Color.fromARGB((255 * 0.8).toInt(), 50, 48, 70),
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
                        child: Column(
                          children: [
                            // 听一听
                            FunctionButtonsSection(
                              title: l10n.listen,
                              buttons: [
                                FunctionButton(
                                  icon: "images/miniprogram_icon/duitang.jpg",
                                  title: "堆糖",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
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
                            FunctionButtonsSection(
                              title: AppLocalizations.of(context)!
                                  .recentMiniPrograms,
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
                                            color: AppColors.neutralGrey41,
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
                                FunctionButton(
                                  icon: "images/miniprogram_icon/duitang.jpg",
                                  title: "堆糖",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/tiankongyueduqi.jpg",
                                  title: "天空阅读器",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon: "images/miniprogram_icon/qishuwang.jpg",
                                  title: "奇书网",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/xueyouyoujiao.jpg",
                                  title: "学有优教",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon: "images/miniprogram_icon/haiziwang.jpg",
                                  title: "孩子王",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/qianbixiaoshuo.jpg",
                                  title: "铅笔小说",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/chengquanshipin.jpg",
                                  title: "成全视频",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
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
                            FunctionButtonsSection(
                              title: l10n.myMiniPrograms,
                              buttons: [
                                FunctionButton(
                                  icon: "images/miniprogram_icon/duitang.jpg",
                                  title: "堆糖",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/tiankongyueduqi.jpg",
                                  title: "天空阅读器",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon: "images/miniprogram_icon/qishuwang.jpg",
                                  title: "奇书网",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/xueyouyoujiao.jpg",
                                  title: "学有优教",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/chengquanshipin.jpg",
                                  title: "成全视频",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/xiaomishangcheng.jpg",
                                  title: "小米商城",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
                                  icon:
                                      "images/miniprogram_icon/meituxiuxiu.jpg",
                                  title: "美图秀秀",
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        "/open_miniprogram?link=${Uri.encodeComponent('http://inner_list_of_third_party_information_sharing/')}");
                                  },
                                ),
                                FunctionButton(
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

                            Container(
                              color: Colors.blue,
                              width: 750.w,
                              height: 500.w,
                            )
                          ],
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

// 小程序按钮项组
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;
  final Widget? rightWidget;

  const FunctionButtonsSection({
    super.key,
    required this.title,
    required this.buttons,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.w, bottom: 0.w, left: 18.w, right: 18.w),
      // decoration: BoxDecoration(
      //   color: AppColors.neutralWhite,
      //   borderRadius: BorderRadius.circular(16.0).w,
      // ),
      padding: const EdgeInsets.only(bottom: 0).w,
      // color: AppColors.accentRedPure,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 标题
          Container(
            height: 50.w,
            margin: EdgeInsets.only(top: 33.w, left: 45.w, right: 45.w),
            // color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    height: 1.08,
                    fontSize: fontSizeScale(26.w),
                    color: AppColors.neutralGrey42,
                  ),
                ),
                if (rightWidget != null) rightWidget!,
              ],
            ),
          ),

          SizedBox(
            height: 15.w,
          ),

          // 使用 SizedBox 控制 GridView 的大小
          Container(
            // color: AppColors.brandTealVibrant,
            margin: const EdgeInsets.all(0),
            padding: EdgeInsets.only(bottom: 16.w, left: 16.0.w, right: 16.w),
            child: GridView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(), // 禁用滚动
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 每行显示4个子组件
                crossAxisSpacing: 16.w, // 列间距
                mainAxisSpacing: 10.w, // 行间距
                childAspectRatio: 1,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return buttons[index];
              },
              shrinkWrap: true, // 根据内容调整 GridView 大小
            ),
          ),
        ],
      ),
    );
  }
}

// 小程序按钮
class FunctionButton extends StatefulWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  FunctionButtonState createState() => FunctionButtonState();
}

class FunctionButtonState extends State<FunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.orange,
          color: _isPressed
              ? AppColors.greyTransparent33
              : AppColors.transparent, // 按下时背景色
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 使按钮大小适应内容
            children: [
              ClipOval(
                child: Image.asset(
                  assetPath(widget.icon),
                  width: 92.w,
                  height: 92.w,
                  cacheHeight: 180.w.toInt(),
                  cacheWidth: 180.w.toInt(),
                  fit: BoxFit.cover, // 让图片完全填满圆形区域
                ),
              ),
              SizedBox(height: 15.w), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                  height: 1.08,
                  decoration: TextDecoration.none,
                  color: AppColors.neutralWhite,
                  fontSize: fontSizeScale(26.0.w),
                  overflow: TextOverflow.ellipsis,
                ), // 标题颜色
              ),
            ],
          ),
        ),
      ),
    );
  }
}
