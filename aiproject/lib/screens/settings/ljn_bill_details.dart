import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/screens/components/ljn_appbar.dart';
import 'package:vigaviga/screens/components/ljn_change_detail_item.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNBillDetails extends StatefulWidget {
  const LJNBillDetails({super.key});

  @override
  State<LJNBillDetails> createState() => _LJNBillDetails();
}

class _LJNBillDetails extends State<LJNBillDetails>
    with SingleTickerProviderStateMixin {
  bool showFilterBg = false;
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  // 收支类型
  String incomeAndExpenditureType = "all";
  // 交易类型
  String transactionType = "all";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
    );

    _widthAnimation = Tween<double>(begin: -1030.w, end: 0.w).animate(
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
      return Scaffold(
        primary: false,
        appBar: null,
        body: Stack(children: [
          Scaffold(
            primary: false,
            appBar:
                LJNAppBar(title: AppLocalizations.of(context)!.bill, actions: [
              GestureDetector(
                onTap: () {
                  // 点击事件
                },
                child: Container(
                  // color: AppColors.transparent,
                  height: 90.w,
                  color: AppColors.transparent,
                  // color: Colors.amber,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 33.w),
                  child: Text(
                    AppLocalizations.of(context)!.faq,
                    style: TextStyle(
                      // height: 1.08,
                      color: AppColors.neutralBlack,
                      fontSize: fontSizeScale(32.w),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ]),
            body: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: Theme.of(context).colorScheme.surface,
              child: Column(children: [
                // 全部账单 标题选项
                Container(
                  height: 130.w,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  decoration: BoxDecoration(
                    color: AppColors.neutralGrey9,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.neutralGrey15,
                        width: 2.w,
                        style: BorderStyle.solid,
                      ),
                      bottom: BorderSide(
                        color: AppColors.neutralGrey15,
                        width: 2.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 全部账单
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showFilterBg = true;
                          });
                          _animationController.forward();
                        },
                        child: Container(
                          height: 70.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          decoration: BoxDecoration(
                            color: AppColors.neutralGrey20,
                            borderRadius: BorderRadius.all(
                              Radius.circular(70.w),
                            ),
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.allBills,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(30.w),
                                    color: AppColors.neutralBlack,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: "AlibabaPuHuiTi",
                                  ),
                                ),
                                WidgetSpan(
                                  alignment:
                                      PlaceholderAlignment.middle, // 图标垂直对齐方式
                                  child: Icon(
                                    const IconData(
                                      0xe60a,
                                      fontFamily: 'Iconfont',
                                    ), // 使用的图标
                                    color: AppColors.neutralBlack, // 图标颜色
                                    size: 25.w, // 图标大小
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 统计
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.statistics,
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(30.w),
                                color: AppColors.neutralGrey55,
                                // fontWeight: FontWeight.bold,
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                            ),
                            WidgetSpan(
                              alignment:
                                  PlaceholderAlignment.middle, // 图标垂直对齐方式
                              child: Icon(
                                const IconData(
                                  0xed9d,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: AppColors.neutralGrey55, // 图标颜色
                                size: 30.w, // 图标大小
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // 日期选择
                Container(
                  height: 107.w,
                  padding: EdgeInsets.only(left: 42.w),
                  alignment: Alignment.centerLeft,
                  color: AppColors.neutralGrey2,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .yearAndMonth(DateTime(2023, 12)),
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(30.w),
                            color: AppColors.neutralBlack,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "AlibabaPuHuiTi",
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle, // 图标垂直对齐方式
                          child: Icon(
                            const IconData(
                              0xe891,
                              fontFamily: 'Iconfont',
                            ), // 使用的图标
                            color: AppColors.neutralBlack, // 图标颜色
                            size: 30.w, // 图标大小
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 列表
                SizedBox(
                    height: MediaQuery.of(context).size.height -
                        90.w -
                        systemState.statusHeight -
                        107.w -
                        130.w,
                    width: 750.w,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -32,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -56,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -14,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: 200,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -49,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -18,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -21,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -29,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -91,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -5,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -73,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -47,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -15,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                            ]),
                      ),
                    ))
              ]),
            ),
          ),
          // 背景
          showFilterBg
              ? GestureDetector(
                  onTap: () {
                    _animationController.reverse().then((_) {
                      setState(() {
                        showFilterBg = false;
                      });
                    });
                  },
                  child: Container(
                    color: AppColors.blackTransparent45,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ))
              : Container(),

          // 底部弹窗
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  bottom: _widthAnimation.value, // Slide up from the bottom
                  width: 750.w,
                  height: 1030.w,
                  child: Container(
                    height: 1030.w,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 45.w, right: 45.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.w),
                        topRight: Radius.circular(18.w),
                      ),
                    ),
                    child: Column(
                      children: [
                        // 选择筛选项
                        Container(
                          height: 135.w,
                          width: 750.w,
                          padding: EdgeInsets.only(top: 47.w),
                          child: Text(
                            AppLocalizations.of(context)!.selectFilter,
                            style: TextStyle(
                              color: AppColors.neutralBlack,
                              height: 1.08,
                              fontSize: 27.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // 收支类型
                        Container(
                          height: 62.w,
                          width: 750.w,
                          padding: EdgeInsets.only(bottom: 39.w),
                          child: Text(
                            AppLocalizations.of(context)!.incomeExpenseType,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 24.w,
                              color: AppColors.neutralDarkGrey11,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 22.w, // 子组件之间的水平间距
                          runSpacing: 20.w, // 子组件之间的垂直间距（如果换行）
                          children: [
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.all,
                              selected: incomeAndExpenditureType == "all"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  incomeAndExpenditureType = "all";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.expense,
                              selected:
                                  incomeAndExpenditureType == "expenditure"
                                      ? true
                                      : false,
                              onTap: () {
                                setState(() {
                                  incomeAndExpenditureType = "expenditure";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.income,
                              selected: incomeAndExpenditureType == "income"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  incomeAndExpenditureType = "income";
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 52.w,
                        ),
                        // 交易类型
                        Container(
                          height: 62.w,
                          width: 750.w,
                          padding: EdgeInsets.only(bottom: 39.w),
                          child: Text(
                            AppLocalizations.of(context)!.transactionType,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: 24.w,
                              color: AppColors.neutralDarkGrey11,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 22.w, // 子组件之间的水平间距
                          runSpacing: 20.w, // 子组件之间的垂直间距（如果换行）
                          children: [
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.all,
                              selected: transactionType == "all" ? true : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "all";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.redPacket,
                              selected:
                                  transactionType == "redpack" ? true : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "redpack";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.transfer,
                              selected: transactionType == "transaction"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "transaction";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title:
                                  AppLocalizations.of(context)!.groupSplitBill,
                              selected: transactionType == "group_collection"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "group_collection";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title:
                                  AppLocalizations.of(context)!.qrCodePayment,
                              selected: transactionType ==
                                      "qr_code_payment_and_receipt"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  transactionType =
                                      "qr_code_payment_and_receipt";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title:
                                  AppLocalizations.of(context)!.merchantPayment,
                              selected:
                                  transactionType == "merchant_consumption"
                                      ? true
                                      : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "merchant_consumption";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!
                                  .topUpAndWithdrawal,
                              selected:
                                  transactionType == "recharge_and_withdrawal"
                                      ? true
                                      : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "recharge_and_withdrawal";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!
                                  .creditCardRepayment,
                              selected: transactionType == "credit_card_payment"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "credit_card_payment";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: AppLocalizations.of(context)!.withRefund,
                              selected: transactionType ==
                                      "there_is_a_refund_available"
                                  ? true
                                  : false,
                              onTap: () {
                                setState(() {
                                  transactionType =
                                      "there_is_a_refund_available";
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 140.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _animationController.reverse().then((_) {
                                  setState(() {
                                    showFilterBg = false;
                                  });
                                });
                              },
                              child: Container(
                                width: 225.w,
                                height: 90.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.neutralGrey6,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.w),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: TextStyle(
                                    color: AppColors.neutralBlack,
                                    fontSize: 30.w,
                                    height: 1.08,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                _animationController.reverse().then((_) {
                                  setState(() {
                                    showFilterBg = false;
                                  });
                                });
                              },
                              child: Container(
                                width: 225.w,
                                height: 90.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.brandGreenVibrant3,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.w),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.confirm,
                                  style: TextStyle(
                                    color: AppColors.neutralWhite,
                                    fontSize: 30.w,
                                    height: 1.08,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
        ]),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}

class LJNFilterButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const LJNFilterButton({
    super.key,
    required this.title,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logger.info("qqqqqqqqq");
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: 205.w,
        height: 85.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.brandTealBackground2
              : AppColors.neutralGrey2,
          border: Border.all(
            color:
                selected ? AppColors.brandGreenPrimary : AppColors.neutralGrey2,
            width: 2.w,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            height: 1.08,
            fontSize: 26.w,
            color:
                selected ? AppColors.brandGreenDarker3 : AppColors.neutralBlack,
          ),
        ),
      ),
    );
  }
}
