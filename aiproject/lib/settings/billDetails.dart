import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeDetailItem.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

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
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
        });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      primary: false,
      appBar: null,
      body: Stack(children: [
        Scaffold(
          primary: false,
          appBar: LJNAppBar(title: "账单", actions: [
            GestureDetector(
                onTap: () {
                  // 点击事件
                },
                child: Container(
                    // color: Colors.transparent,
                    height: 90.w,
                    color: Colors.transparent,
                    // color: Colors.amber,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: 33.w),
                    child: Text("常见问题",
                        style: TextStyle(
                            height: 1.08,
                            color: Colors.black,
                            fontSize: fontSizeScale(32.w),
                            fontWeight: FontWeight.w500)))),
          ]),
          body: Container(
              constraints: BoxConstraints(
                  minHeight: screenSize.height - 90.w - vm.statusHeight!),
              color: const Color.fromARGB(255, 237, 237, 237),
              child: Column(children: [
                // 全部账单 标题选项
                Container(
                  height: 130.w,
                  width: screenSize.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 239, 239),
                      border: Border(
                          top: BorderSide(
                            color: const Color.fromARGB(255, 232, 232, 232),
                            width: 2.w,
                            style: BorderStyle.solid,
                          ),
                          bottom: BorderSide(
                            color: const Color.fromARGB(255, 232, 232, 232),
                            width: 2.w,
                            style: BorderStyle.solid,
                          ))),
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
                              color: const Color.fromARGB(255, 227, 227, 227),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70.w)),
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "全部账单",
                                    style: TextStyle(
                                      height: 1.08,
                                      fontSize: fontSizeScale(30.w),
                                      color: Colors.black,
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
                                      color: Colors.black, // 图标颜色
                                      size: 25.w, // 图标大小
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),

                      // 统计
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "统计",
                              style: TextStyle(
                                height: 1.08,
                                fontSize: fontSizeScale(30.w),
                                color: const Color.fromARGB(255, 157, 157, 157),
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
                                color: const Color.fromARGB(
                                    255, 157, 157, 157), // 图标颜色
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
                    color: const Color.fromARGB(255, 247, 247, 247),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "2024年12月",
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(30.w),
                              color: Colors.black,
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
                              color: Colors.black, // 图标颜色
                              size: 30.w, // 图标大小
                            ),
                          ),
                        ],
                      ),
                    )),

                // 列表
                SizedBox(
                    height: screenSize.height -
                        90.w -
                        vm.statusHeight! -
                        107.w -
                        130.w,
                    width: 750.w,
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: const SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
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
                                ]))))
              ])),
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
                  color: const Color.fromARGB(115, 0, 0, 0),
                  width: screenSize.width,
                  height: screenSize.height,
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
                    width: screenSize.width,
                    padding: EdgeInsets.only(left: 45.w, right: 45.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            "选择筛选项",
                            style: TextStyle(
                                color: Colors.black,
                                height: 1.08,
                                fontSize: 27.w,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // 收支类型
                        Container(
                          height: 62.w,
                          width: 750.w,
                          padding: EdgeInsets.only(bottom: 39.w),
                          child: Text(
                            "收支类型",
                            style: TextStyle(
                                height: 1.08,
                                fontSize: 24.w,
                                color: const Color.fromARGB(255, 79, 79, 79)),
                          ),
                        ),
                        Wrap(
                          spacing: 22.w, // 子组件之间的水平间距
                          runSpacing: 20.w, // 子组件之间的垂直间距（如果换行）
                          children: [
                            LJNFilterButton(
                              title: "全部",
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
                              title: "支出",
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
                              title: "收入",
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
                            "交易类型",
                            style: TextStyle(
                                height: 1.08,
                                fontSize: 24.w,
                                color: const Color.fromARGB(255, 79, 79, 79)),
                          ),
                        ),
                        Wrap(
                          spacing: 22.w, // 子组件之间的水平间距
                          runSpacing: 20.w, // 子组件之间的垂直间距（如果换行）
                          children: [
                            LJNFilterButton(
                              title: "全部",
                              selected: transactionType == "all" ? true : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "all";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: "红包",
                              selected:
                                  transactionType == "redpack" ? true : false,
                              onTap: () {
                                setState(() {
                                  transactionType = "redpack";
                                });
                              },
                            ),
                            LJNFilterButton(
                              title: "转账",
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
                              title: "群收款",
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
                              title: "二维码收付款",
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
                              title: "商户消费",
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
                              title: "充值提现",
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
                              title: "信用卡还款",
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
                              title: "有退款",
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
                                      color: const Color.fromARGB(
                                          255, 242, 242, 242),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.w)),
                                    ),
                                    child: Text(
                                      "取消",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.w,
                                          height: 1.08),
                                    ))),
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
                                      color: const Color.fromARGB(
                                          255, 74, 193, 99),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.w)),
                                    ),
                                    child: Text(
                                      "确定",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.w,
                                          height: 1.08),
                                    )))
                          ],
                        )
                      ],
                    ),
                  ));
            })
      ]),
    );
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
              ? const Color.fromARGB(255, 232, 249, 241)
              : const Color.fromARGB(255, 247, 247, 247),
          border: Border.all(
            color: selected
                ? const Color.fromARGB(255, 83, 175, 105)
                : const Color.fromARGB(255, 247, 247, 247),
            width: 2.w,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        child: Text(
          title,
          style: TextStyle(
            height: 1.08,
            fontSize: 26.w,
            color: selected
                ? const Color.fromARGB(255, 49, 176, 78)
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
