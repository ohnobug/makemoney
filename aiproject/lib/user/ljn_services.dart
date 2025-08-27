import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/components/ljn_appbar.dart';
import 'package:spicychat/components/ljn_max_width_button.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import 'package:spicychat/store/ljn_user_cubit.dart';
import 'package:spicychat/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../tools/ljn_logger.dart';

class LJNServices extends StatefulWidget {
  const LJNServices({super.key});

  @override
  State<LJNServices> createState() => _LJNServices();
}

class _LJNServices extends State<LJNServices>
    with SingleTickerProviderStateMixin {
  bool showSelector = false;
  late AnimationController _animationController;
  late Animation<double> _upAnimation;

  @override
  void initState() {
    super.initState();

    // 初始化 _animationContentController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _upAnimation = Tween<double>(begin: -330.w, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return Stack(children: [
        Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: "服务",
            actions: [
              GestureDetector(
                onTap: () {
                  // 点击事件
                  setState(() {
                    showSelector = true;
                  });

                  _animationController.forward();
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
                    size: 37.w, // 图标大小
                  ),
                ),
              )
            ],
          ),
          body: ColoredBox(
            color: AppColors.neutralGrey11,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 205.w),
                  color: AppColors.neutralGrey11,
                  child: Column(
                    children: [
                      // 余额
                      Container(
                        height: 272.w,
                        margin: const EdgeInsets.all(16).w,
                        decoration: BoxDecoration(
                          color: AppColors.brandGreenSlightlyDesaturated,
                          borderRadius: BorderRadius.circular(16.0).w,
                        ),
                        padding: const EdgeInsets.all(16).w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CollectionAndPayment(
                              icon: Icon(
                                  const IconData(
                                    0xe658,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 72.w,
                                  color: Colors.white),
                              title: '收付款',
                              subTitle: " ",
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/collection_and_payment');
                                logger.info('点击了收付款还款按钮~~');
                              },
                            ),
                            CollectionAndPayment(
                              icon: Icon(
                                  const IconData(
                                    0xe6e4,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 72.w,
                                  color: Colors.white),
                              title: '钱包',
                              subTitle: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 22.w,
                                        child: Icon(
                                          color: AppColors.brandTealMedium,
                                          const IconData(
                                            0xe90d,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 25.w, // 图标大小
                                        ),
                                      ),
                                      alignment: PlaceholderAlignment.middle,
                                    ),
                                    TextSpan(
                                      text: context
                                          .read<LJNUserCubit>()
                                          .state
                                          .walletBalance
                                          .toString(),
                                      style: TextStyle(
                                        height: 1.08,
                                        fontSize: fontSizeScale(27.w),
                                        color: AppColors.brandTealMedium,
                                        // fontWeight: FontWeight.w500,
                                        fontFamily: "LJNFont",
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                // logger.info('点击了钱包按钮~~');
                                Navigator.pushNamed(context, '/wallet');
                              },
                            )
                          ],
                        ),
                      ),

                      // 金融理财
                      FunctionButtonsSection(
                        title: '金融理财',
                        buttons: [
                          FunctionButton(
                            icon: "images/icon/server_icon1.png",
                            title: '信用卡还款',
                            onPressed: () {
                              logger.info('点击了信用卡还款按钮~~');
                            },
                          ),
                          // FunctionButton(
                          //   icon: "images/icon/server_icon2.png",
                          //   title: '微粒贷借钱',
                          //   onPressed: () {
                          //     logger.info('点击了微粒贷借钱按钮~~');
                          //   },
                          // ),
                          FunctionButton(
                            icon: "images/icon/server_icon2.png",
                            title: '理财通',
                            onPressed: () {
                              logger.info('点击了理财通按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon3.png",
                            title: '保险服务',
                            onPressed: () {
                              logger.info('点击了保险服务按钮~~');
                            },
                          ),
                          // FunctionButton(
                          //   icon: "images/icon/server_icon4.png",
                          //   title: '保险服务',
                          //   onPressed: () {
                          //     logger.info('点击了保险服务按钮~~');
                          //   },
                          // ),
                        ],
                      ),

                      // 生活服务
                      FunctionButtonsSection(
                        title: '生活服务',
                        buttons: [
                          FunctionButton(
                            icon: "images/icon/server_icon4.png",
                            title: '手机充值',
                            onPressed: () {
                              logger.info('点击了手机充值按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon5.png",
                            title: '生活缴费',
                            onPressed: () {
                              logger.info('点击了生活缴费按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon6.png",
                            title: 'Q币充值',
                            onPressed: () {
                              logger.info('点击了Q币充值按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon7.png",
                            title: '城市服务',
                            onPressed: () {
                              logger.info('点击了城市服务按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon8.png",
                            title: '腾讯公益',
                            onPressed: () {
                              logger.info('点击了腾讯公益按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon9.png",
                            title: '医疗健康',
                            onPressed: () {
                              logger.info('点击了医疗健康按钮~~');
                            },
                          ),
                        ],
                      ),

                      // 交通出行
                      FunctionButtonsSection(
                        title: '交通出行',
                        buttons: [
                          FunctionButton(
                            icon: "images/icon/server_icon10.png",
                            title: '出行服务',
                            onPressed: () {
                              logger.info('点击了出行服务按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon11.png",
                            title: '火车票机票',
                            onPressed: () {
                              logger.info('点击了火车票机票按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon12.png",
                            title: '滴滴出行',
                            onPressed: () {
                              logger.info('点击了滴滴出行按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon122.png",
                            title: '酒店',
                            onPressed: () {
                              logger.info('点击了酒店按钮~~');
                            },
                          ),
                        ],
                      ),

                      // 购物消费
                      FunctionButtonsSection(
                        title: '购物消费',
                        buttons: [
                          FunctionButton(
                            icon: "images/icon/server_icon13.png",
                            title: '品牌发现',
                            onPressed: () {
                              logger.info('点击了品牌发现按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon14.png",
                            title: '京东购物',
                            onPressed: () {
                              logger.info('点击了京东购物按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon15.png",
                            title: '美团外卖',
                            onPressed: () {
                              logger.info('点击了美团外卖按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon16.png",
                            title: '电影演出玩乐',
                            onPressed: () {
                              logger.info('点击了电影演出玩乐按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon17.png",
                            title: '美团特价',
                            onPressed: () {
                              logger.info('点击了美团特价按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon18.png",
                            title: '拼多多',
                            onPressed: () {
                              logger.info('点击了拼多多按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon19.png",
                            title: '唯品会特卖',
                            onPressed: () {
                              logger.info('点击了唯品会特卖按钮~~');
                            },
                          ),
                          FunctionButton(
                            icon: "images/icon/server_icon20.png",
                            title: '转转二手',
                            onPressed: () {
                              logger.info('点击了转转二手按钮~~');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // 背景色
        if (showSelector)
          GestureDetector(
            onTap: () {
              _animationController.reverse().then((_) {
                setState(() {
                  showSelector = false;
                });
              });
            },
            child: Container(
              color: AppColors.blackTransparent50,
              width: 750.w,
              height: MediaQuery.of(context).size.height,
            ),
          ),

        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Positioned(
              left: 0,
              bottom: _upAnimation.value,
              width: 750.w,
              height: 225.w,
              child: Scaffold(
                backgroundColor: AppColors.transparent,
                primary: false,
                body: Container(
                  width: 750.w,
                  height: 225.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w),
                    ),
                  ),
                  child: Column(
                    children: [
                      LJNMaxWidthButton(
                        title: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "服务管理",
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: 30.w,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        underline: true,
                        onPressed: () {
                          setState(() {
                            showSelector = false;
                            _animationController.reset();
                          });

                          Navigator.pushNamed(
                            context,
                            '/services_manager',
                          );
                        },
                      ),
                      Container(
                        height: 15.w,
                        color: AppColors.neutralGrey2,
                      ),
                      LJNMaxWidthButton(
                        title: "取消",
                        underline: false,
                        onPressed: () {
                          _animationController.reverse().then(
                            (_) {
                              setState(() {
                                showSelector = false;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ]);
    });
  }
}

// 收付款
class CollectionAndPayment extends StatefulWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;
  final Object? subTitle;

  const CollectionAndPayment(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed,
      this.subTitle});

  @override
  State<CollectionAndPayment> createState() => _CollectionAndPaymentState();
}

class _CollectionAndPaymentState extends State<CollectionAndPayment> {
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
        height: 240.w,
        width: 272.w,
        decoration: BoxDecoration(
          color:
              _isPressed ? AppColors.brandGreenDarkest : AppColors.transparent,
          borderRadius: BorderRadius.circular(16.0).w,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors.transparent,
                width: 90.w,
                height: 90.w,
                child: Center(child: widget.icon),
              ),

              // SizedBox(height: 15.w),
              SizedBox(height: 10.w),

              // 钱包、收付款
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                  height: 1.08,
                  // fontWeight: FontWeight.w100,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: fontSizeScale(32.0.w),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 10.w),

              if (widget.subTitle is String)
                // 余额
                Text(
                  widget.subTitle.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    height: 1,
                    // fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                    color: AppColors.whiteTransparent63,
                    fontSize: fontSizeScale(29.0.w),
                    overflow: TextOverflow.ellipsis,
                    fontFamily: "LJNFont",
                  ),
                ),
              if (widget.subTitle is Widget) widget.subTitle as Widget
            ],
          ),
        ),
      ),
    );
  }
}

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
          color:
              _isPressed ? Colors.grey[200] : AppColors.transparent, // 按下时背景色
          borderRadius: BorderRadius.circular(10.0).w, // 圆角半径
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 使按钮大小适应内容
            children: [
              Image.asset(
                assetPath(widget.icon),
                width: 57.w,
                height: 57.w,
              ), // 图标颜色
              SizedBox(height: 16.w), // 图标和标题之间的间距
              Text(
                widget.title,
                maxLines: 1,
                style: TextStyle(
                  height: 1.08,
                  decoration: TextDecoration.none,
                  color: AppColors.neutralDarkGrey20,
                  fontSize: fontSizeScale(25.0.w),
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

// FunctionButtonsSection 组件
class FunctionButtonsSection extends StatelessWidget {
  final String title;
  final List<FunctionButton> buttons;

  const FunctionButtonsSection({
    super.key,
    required this.title,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16).w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0).w,
      ),
      padding: const EdgeInsets.only(bottom: 16).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  // height: 80.w,
                  // color: Colors.amber,
                  padding: EdgeInsets.only(top: 33.w, bottom: 16.w, left: 30.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(27.w),
                      color: AppColors.neutralDarkGrey5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 使用 SizedBox 控制 GridView 的大小
          Container(
            padding: const EdgeInsets.all(16.0).w,
            // height: 200, // 根据实际需要调整高度
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 每行显示4个子组件
                crossAxisSpacing: 16.w, // 列间距
                mainAxisSpacing: 12.w, // 行间距
                childAspectRatio: (1 / 1),
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return Center(child: buttons[index]);
              },
              shrinkWrap: true, // 根据内容调整 GridView 大小
              physics: const NeverScrollableScrollPhysics(), // 禁用滚动
            ),
          ),
        ],
      ),
    );
  }
}
