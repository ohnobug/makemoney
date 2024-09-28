import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/LJNReceiveMessage.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_application_1/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNMyMessage.dart';

class LJNChatPage extends StatefulWidget {
  const LJNChatPage({super.key});

  @override
  State<LJNChatPage> createState() => _LJNChatPage();
}

class _LJNChatPage extends State<LJNChatPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  String message = "";
  bool showSendButton = false;
  bool showPlusIcon = true;

  // 输入框控制器，一般用于获取文本、修改文本等
  TextEditingController inputController = TextEditingController();

  // 焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
  FocusNode inputFocusNode = FocusNode();

  //边框样式
  OutlineInputBorder outlineInputBorder =
      const OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none);

  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<Color?> _colorAnimation;

  List<StatefulWidget> messageList = [
    // LJNReceiveMessage(),
    // LJNMyMessage(),
    // LJNReceiveMessage(),
    // LJNMyMessage(),
    // LJNReceiveMessage(),
    // LJNReceiveMessage(),
    // LJNReceiveMessage(),
    // LJNReceiveMessage(),
    // LJNReceiveMessage(),
    // LJNMyMessage(),
    // LJNMyMessage(),
    // LJNMyMessage(),
    // LJNMyMessage(),
  ];

  double _statusHeight = 0;

  double _width = 0;
  Color _color = const Color.fromARGB(255, 76, 190, 102);

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    logger.info("高度: $_statusHeight");

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
    );
    _widthAnimation = Tween<double>(begin: 62.w, end: 113.w).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(179, 76, 190, 103),
      end: const Color.fromARGB(255, 76, 190, 102),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // inputController.text =
    // "生活就像一幅绚丽多彩的画卷，每个人都是这幅画的创作者。在这漫长的人生旅途中，我们用自己的经历、情感和梦想为这幅画增添着独特的色彩。";
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  void _scrollToEnd() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
  }

  @override
  void didChangeMetrics() {
    // 检测键盘是否弹出
    final bottomInset = View.of(context).viewInsets.bottom;
    if (bottomInset > 0) {
      // 键盘弹出，滚动到最底部
      _scrollToEnd();
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
            primary: false,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(90.0.w + _statusHeight),
                child: Container(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  padding: EdgeInsets.only(top: _statusHeight),
                  child: AppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 36.w,
                      ),
                      color: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    primary: false,
                    centerTitle: true,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    toolbarHeight: 90.w,
                    title: const Text("请说英语"),
                    titleTextStyle:
                        TextStyle(fontSize: 32.w, color: Colors.black),
                    backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                    foregroundColor: const Color.fromARGB(255, 237, 237, 237),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(1.w),
                      child: Container(
                        color: const Color.fromARGB(255, 220, 220, 220),
                        height: 0.5.w,
                      ),
                    ),
                    actions: [
                      // 三个点
                      IconButton(
                        icon: Icon(
                            size: 37.w,
                            const IconData(
                              0xe659,
                              fontFamily: 'Iconfont',
                            )),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        padding: const EdgeInsets.only(right: 33.0).w,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )),
            body: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: ColoredBox(
                        color: const Color.fromARGB(255, 237, 237, 237),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            child: messageList.isEmpty
                                ? Container()
                                : Column(
                                    children: messageList,
                                  ),
                          ),
                        ))),

                // 输入部分
                Expanded(
                    flex: 0,
                    child: Container(
                        constraints: BoxConstraints(minHeight: 107.w),
                        width: screenSize.width,
                        padding: const EdgeInsets.only(top: 16, bottom: 16).w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 247, 247, 247),
                            border: Border(
                                top: BorderSide(
                              color: const Color.fromARGB(255, 231, 231, 231),
                              width: 2.w,
                              style: BorderStyle.solid,
                            ))),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                // color: Colors.amber,
                                width: 57.w,
                                height: 57.w,
                                margin: EdgeInsets.only(
                                    left: 20.w, right: 20.w, bottom: 10.w),
                                child: IconButton(
                                  icon: Icon(
                                      size: 56.w,
                                      const IconData(
                                        0xe66c,
                                        fontFamily: 'Iconfont',
                                      )),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0).w,
                                  onPressed: () {
                                    logger.info("语音被点击");
                                  },
                                )),
                            // 消息框
                            Expanded(
                                child: TextField(
                              autofocus: false,
                              controller: inputController,
                              focusNode: inputFocusNode,
                              cursorColor:
                                  const Color.fromRGBO(62, 174, 86, 1.0),
                              // cursorHeight: 44.w,
                              cursorWidth: 3.w,
                              style: TextStyle(
                                  fontSize: 30.w, color: Colors.black),
                              // strutStyle: StrutStyle(fontSize: 20.w),
                              maxLines: 5,
                              minLines: 1,
                              onTapOutside: (event) {
                                SystemChannels.textInput
                                    .invokeMethod("TextInput.hide");
                              },
                              onChanged: (newText) {
                                inputController.value =
                                    inputController.value.copyWith(
                                  text: newText,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: newText.length),
                                  ),
                                );

                                if (inputController.text.isEmpty) {
                                  _animationController
                                      .reverse()
                                      .whenComplete(() {
                                    setState(() {
                                      showPlusIcon = true;
                                    });
                                  });
                                } else {
                                  setState(() {
                                    showPlusIcon = false;
                                  });
                                  _animationController.forward();
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                // focusColor: Colors.red,
                                hoverColor: Colors.white,
                                isCollapsed: true,
                                contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16)
                                    .w,
                                border: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                disabledBorder: outlineInputBorder,
                                focusedErrorBorder: outlineInputBorder,
                                errorBorder: outlineInputBorder,
                              ),
                            )),
                            Container(
                                // color: Colors.amber,
                                width: 57.w,
                                height: 57.w,
                                margin: EdgeInsets.only(
                                    left: 20.w, right: 25.w, bottom: 10.w),
                                child: IconButton(
                                  icon: Icon(
                                      size: 49.w,
                                      const IconData(
                                        0xe702,
                                        fontFamily: 'Iconfont',
                                      )),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    logger.info("笑脸被点击");
                                  },
                                )),
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                _width = _widthAnimation.value;
                                _color = _colorAnimation.value!;

                                return Visibility(
                                    visible: !showPlusIcon,
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            var message = inputController.text;

                                            messageList.add(LJNMyMessage(
                                              message: message.trimRight(),
                                              name: vm.userinfoName as String,
                                              showName: false,
                                            ));
                                            inputController.text = "";
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                                  bottom: 8, right: 15)
                                              .w,
                                          width: _width,
                                          height: 60.w,
                                          decoration: BoxDecoration(
                                            color: _color,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.w)),
                                          ),
                                          child: _width >= 113.w
                                              ? Center(
                                                  child: Text(
                                                    "发送",
                                                    style: TextStyle(
                                                        fontSize: 27.w,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : null,
                                        )));
                              },
                            ),
                            Visibility(
                                visible: showPlusIcon,
                                child: Container(
                                    // color: Colors.amber,
                                    width: 57.w,
                                    height: 57.w,
                                    margin: EdgeInsets.only(
                                        right: 20.w, bottom: 10.w),
                                    child: IconButton(
                                      icon: Icon(
                                          size: 57.w,
                                          const IconData(
                                            0xe726,
                                            fontFamily: 'Iconfont',
                                          )),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        logger.info("加号被点击");
                                      },
                                    )))
                          ],
                        )))
              ],
            ),
          );
        });
  }
}
