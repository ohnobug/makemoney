import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/LJNReceiveMessage.dart';
import 'package:flutter_application_1/components/LJNSendButton.dart';
import 'package:flutter_application_1/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/LJNMyMessage.dart';

class LJNChatPage extends StatefulWidget {
  const LJNChatPage({super.key});

  @override
  State<LJNChatPage> createState() => _LJNChatPage();
}

class _LJNChatPage extends State<LJNChatPage> with WidgetsBindingObserver {
  String message = "";
  bool showSendButton = false;
  bool showPlusIcon = true;

  late LJNSendButton _sendButton;

  // 输入框控制器，一般用于获取文本、修改文本等
  TextEditingController inputController = TextEditingController();

  // 焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
  FocusNode inputFocusNode = FocusNode();

  //边框样式
  OutlineInputBorder outlineInputBorder =
      const OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();


    _sendButton = const LJNSendButton();

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

    return Scaffold(
      primary: false,
      appBar: AppBar(
        primary: true,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: MediaQuery.of(context).padding.top + 90.w,
        title: const Text("请说英语"),
        titleTextStyle: TextStyle(fontSize: 32.w, color: Colors.black),
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
      body: Column(
        children: [
          Expanded(
              child: ColoredBox(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: const Column(
                        children: [
                          LJNReceiveMessage(),
                          LJNMyMessage(),
                          LJNReceiveMessage(),
                          LJNMyMessage(),
                          LJNReceiveMessage(),
                          LJNReceiveMessage(),
                          LJNReceiveMessage(),
                          LJNReceiveMessage(),
                          LJNReceiveMessage(),
                          LJNMyMessage(),
                          LJNMyMessage(),
                          LJNMyMessage(),
                          LJNMyMessage(),
                        ],
                      ),
                    ),
                  ))),
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
                      IconButton(
                        icon: Icon(
                            size: 52.w,
                            const IconData(
                              0xe66c,
                              fontFamily: 'Iconfont',
                            )),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 20.0, right: 20.0).w,
                        onPressed: () {
                          logger.info("语音被点击");
                        },
                      ),
                      Expanded(
                          child: TextField(
                        autofocus: false,
                        controller: inputController,
                        focusNode: inputFocusNode,
                        cursorColor: const Color.fromRGBO(62, 174, 86, 1.0),
                        style: TextStyle(fontSize: 30.w, color: Colors.black),
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

                          if (inputController.text.isNotEmpty) {
                            setState(() {
                              showSendButton = true;
                            });
                          } else {
                            setState(() {
                              showSendButton = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          // focusColor: Colors.red,
                          hoverColor: Colors.white,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20)
                              .w,
                          border: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          focusedErrorBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                        ),
                      )),
                      IconButton(
                        icon: Icon(
                            size: 46.w,
                            const IconData(
                              0xe702,
                              fontFamily: 'Iconfont',
                            )),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        padding:
                            const EdgeInsets.only(left: 20.0, right: 12.0).w,
                        onPressed: () {
                          logger.info("笑脸被点击");
                        },
                      ),

                      if (showSendButton) _sendButton
                      // Visibility(
                      //     visible: !showSendButton,
                      //     child: IconButton(
                      //       icon: Icon(
                      //           size: 52.w,
                      //           const IconData(
                      //             0xe726,
                      //             fontFamily: 'Iconfont',
                      //           )),
                      //       highlightColor: Colors.transparent,
                      //       splashColor: Colors.transparent,
                      //       padding:
                      //           const EdgeInsets.only(left: 12.0, right: 20.0)
                      //               .w,
                      //       onPressed: () {
                      //         logger.info("加号被点击");
                      //       },
                      //     ))
                    ],
                  )))
        ],
      ),
    );
  }
}
