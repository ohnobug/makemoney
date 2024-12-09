import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeDetailItem.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNBillDetails extends StatefulWidget {
  const LJNBillDetails({super.key});

  @override
  State<LJNBillDetails> createState() => _LJNBillDetails();
}

class _LJNBillDetails extends State<LJNBillDetails> {
  double _statusHeight = 0;
  bool showFilter = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(vm);
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(StoreType vm) {
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        primary: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.0.w + _statusHeight),
            child: Container(
                width: screenSize.width,
                color: const Color.fromARGB(255, 237, 237, 237),
                padding: EdgeInsets.only(top: _statusHeight),
                child: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      // wallet
                    }, // 点击事件
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(
                        const IconData(
                          0xed9e,
                          fontFamily: 'Iconfont',
                        ), // 使用的图标
                        color: Colors.black, // 图标颜色
                        size: 36.w, // 图标大小
                      ),
                    ),
                  ),
                  primary: false,
                  centerTitle: true,
                  title: const Text('账单'),
                  toolbarHeight: 90.w,
                  titleTextStyle: TextStyle(
                      height: 1.08,
                      fontSize: fontSizeScale(32.w),
                      color: Colors.black,
                      fontFamily: "AlibabaPuHuiTi-Medium"),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  foregroundColor: const Color.fromARGB(255, 237, 237, 237),
                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(1.w),
                  //   child: Container(
                  //     color: const Color.fromARGB(255, 220, 220, 220),
                  //     height: 1.w,
                  //   ),
                  // ),
                  actions: const [
                    // // 三个点
                    // GestureDetector(
                    //     onTap: () {
                    //       // 点击事件
                    //     },
                    //     child: Container(
                    //         color: Colors.transparent,
                    //         padding: EdgeInsets.only(right: 33.w),
                    //         child: Text("账单",
                    //             style: TextStyle(height: 1.08,
                    //                 color: Colors.black,
                    //                 fontSize: fontSizeScale(30.w),
                    //                 fontWeight: FontWeight.w500)))),
                  ],
                ))),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Stack(
              children: [
                // 列表
                Container(
                    constraints: BoxConstraints(
                        minHeight: screenSize.height - 90.w - _statusHeight),
                    color: const Color.fromARGB(255, 237, 237, 237),
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 130.w,
                                width: screenSize.width,
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 239, 239, 239),
                                    border: Border(
                                        top: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 232, 232, 232),
                                          width: 2.w,
                                          style: BorderStyle.solid,
                                        ),
                                        bottom: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 232, 232, 232),
                                          width: 2.w,
                                          style: BorderStyle.solid,
                                        ))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 全部账单
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showFilter = true;
                                          });
                                        },
                                        child: Container(
                                          height: 70.w,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 25.w, right: 25.w),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 227, 227, 227),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(70.w)),
                                          ),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "全部账单",
                                                  style: TextStyle(
                                                    height: 1.08,
                                                    fontSize:
                                                        fontSizeScale(30.w),
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        "AlibabaPuHuiTi",
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle, // 图标垂直对齐方式
                                                  child: Icon(
                                                    const IconData(
                                                      0xe60a,
                                                      fontFamily: 'Iconfont',
                                                    ), // 使用的图标
                                                    color: Colors.black, // 图标颜色
                                                    size: 30.w, // 图标大小
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
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: "AlibabaPuHuiTi",
                                            ),
                                          ),
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment
                                                .middle, // 图标垂直对齐方式
                                            child: Icon(
                                              const IconData(
                                                0xed9d,
                                                fontFamily: 'Iconfont',
                                              ), // 使用的图标
                                              color: Colors.black, // 图标颜色
                                              size: 30.w, // 图标大小
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  height: 107.w,
                                  padding: EdgeInsets.only(left: 42.w),
                                  alignment: Alignment.centerLeft,
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247),
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
                                          alignment: PlaceholderAlignment
                                              .middle, // 图标垂直对齐方式
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
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -32,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -56,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -14,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: 200,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -49,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -18,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -21,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -29,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -91,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -5,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -73,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -47,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                              const LJNChangeDetailItem(
                                title: "原乡智选",
                                change: -15,
                                icon: "images/avatar/01.png",
                                link: '',
                                underline: true,
                              ),
                            ]))),

                showFilter
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            showFilter = false;
                          });
                        },
                        child: Container(
                          color: const Color.fromARGB(115, 0, 0, 0),
                          width: screenSize.width,
                          height: screenSize.height,
                        ))
                    : Container(),

                // 弹窗
                AnimatedPositioned(
                  duration: const Duration(
                      seconds: 1), // Duration of the slide-in animation
                  curve: Curves.easeOut, // Smooth easing curve
                  bottom: showFilter ? 0 : -1030.w, // Slide up from the bottom
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
                          children: const [
                            LJNFilterButton(
                              title: "全部",
                              selected: true,
                            ),
                            LJNFilterButton(
                              title: "支出",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "收入",
                              selected: false,
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
                          children: const [
                            LJNFilterButton(
                              title: "全部",
                              selected: true,
                            ),
                            LJNFilterButton(
                              title: "红包",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "转账",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "群收款",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "二维码收付款",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "商户消费",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "充值提现",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "信用卡还款",
                              selected: false,
                            ),
                            LJNFilterButton(
                              title: "有退款",
                              selected: false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 140.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 225.w,
                                height: 90.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w)),
                                ),
                                child: Text(
                                  "取消",
                                  style:
                                      TextStyle(fontSize: 30.w, height: 1.08),
                                )),
                            SizedBox(
                              width: 30.w,
                            ),
                            Container(
                                width: 225.w,
                                height: 90.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 74, 193, 99),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.w)),
                                ),
                                child: Text(
                                  "确定",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.w,
                                      height: 1.08),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class LJNFilterButton extends StatelessWidget {
  final String title;
  final bool selected;

  const LJNFilterButton({
    super.key,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color:
              selected ? const Color.fromARGB(255, 49, 176, 78) : Colors.black,
        ),
      ),
    );
  }
}
