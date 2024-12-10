import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNChangeAccountButton.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNTeenageMode extends StatefulWidget {
  const LJNTeenageMode({super.key});

  @override
  State<LJNTeenageMode> createState() => _LJNTeenageMode();
}

class _LJNTeenageMode extends State<LJNTeenageMode> {
  bool selectedValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: const LJNAppBar(
                bgColor: Colors.transparent,
              ),
              body: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight:
                                screenSize.height - (vm.statusHeight! + 90.w)),
                        // color: const Color.fromARGB(255, 231, 15, 15),
                        child: Column(
                          children: [
                            Container(
                              height: 290.w,
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe7fc,
                                  fontFamily: 'Iconfont',
                                ), // 使用的图标
                                color: const Color.fromARGB(
                                    255, 63, 198, 94), // 图标颜色
                                size: 110.w, // 图标大小
                              ),
                            ),
                            Text(
                              "青少年模式",
                              style: TextStyle(
                                  height: 1.08,
                                  fontSize: 40.w,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "AlibabaPuHuiTi"),
                            ),
                            SizedBox(
                              height: 25.w,
                            ),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 70.w, right: 70.w),
                                child: Text(
                                  "为呵护未成年人健康成长，微信推出青少年模式。该模式下部分功能将受限制使用，请监护人主动设置。",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 32.w),
                                )),
                            SizedBox(
                              height: 625.w,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                      fontSize: 22.w, height: 1.08), // 全局文本样式
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment
                                          .middle, // 确保 `Radio` 垂直居中
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedValue = !selectedValue;
                                          });
                                        },
                                        child: Container(
                                          width: 40.w,
                                          height: 40.w,
                                          margin: EdgeInsets.only(right: 11.w),
                                          child: selectedValue
                                              ? Icon(
                                                  const IconData(
                                                    0xe65a,
                                                    fontFamily: 'Iconfont',
                                                  ), // 使用的图标
                                                  color: const Color.fromARGB(
                                                      255, 5, 190, 94),
                                                  size: 36.w,
                                                )
                                              : Icon(
                                                  const IconData(
                                                    0xe65b,
                                                    fontFamily: 'Iconfont',
                                                  ), // 使用的图标
                                                  color: const Color.fromARGB(
                                                      255, 100, 100, 100),
                                                  size: 36.w,
                                                ),
                                        ),
                                      ),
                                    ),
                                    const TextSpan(
                                        text: "我已阅读并同意",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100))),
                                    TextSpan(
                                      text: "《微信青少年模式功能使用条款》",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 48, 61, 88),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // 点击条款时的事件处理
                                          logger.info("点击了《微信青少年模式功能使用条款》");
                                        },
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start, // 控制文本的对齐方式
                              ),
                            ),
                            SizedBox(
                              height: 43.w,
                            ),
                            selectedValue
                                ? const LJNChangeAccountButton(
                                    title: '开启',
                                    link: "back",
                                    readonly: false,
                                    color: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 5, 190, 94),
                                  )
                                : const LJNChangeAccountButton(
                                    title: '开启',
                                    link: "back",
                                    readonly: false,
                                    color: Color.fromARGB(255, 176, 176, 176),
                                    backgroundColor:
                                        Color.fromARGB(255, 241, 241, 241),
                                  ),
                          ],
                        ),
                      ))));
        });
  }
}
