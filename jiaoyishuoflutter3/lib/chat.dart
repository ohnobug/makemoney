import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/components/LJNReceiveMessage.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/emojiSelector.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';

import 'components/LJNMyMessage.dart';
import 'tools/tools.dart';

class LJNChatPage extends StatefulWidget {
  const LJNChatPage({super.key, required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  State<LJNChatPage> createState() => _LJNChatPage();
}

class _LJNChatPage extends State<LJNChatPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String message = "";

  // 显示发送按钮
  bool showSendButton = false;

  // 显示加号
  bool showPlusIcon = true;

  // 显示图标选择器
  bool showEmojiSelector = false;

  // 输入框控制器，一般用于获取文本、修改文本等
  TextEditingController inputController = TextEditingController();

  // 焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
  FocusNode inputFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<Color?> _colorAnimation;

  late AnimationController _animationContentController;
  late Animation<double> _keyboradAnimation;

  List<StatefulWidget> messageList = [];

  double _statusHeight = 0;

  double _keyboardHeight = 500.w;
  bool showKeyboard = false;
  double preBottomInsets = 0;

  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();

  @override
  void initState() {
    super.initState();

    // 初始化 _animationContentController
    _animationContentController = AnimationController(
      duration: const Duration(milliseconds: 500), // 动画持续时间
      vsync: this,
    );

    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      setState(() {
        _keyboardHeight = height;
      });
    });

    addList();

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

    // 监听焦点变化
    // inputFocusNode.addListener(() {
    //   logger.info(
    //       "aaaaaaaaaaaaa inputFocusNode.hasFocus: ${inputFocusNode.hasFocus}");

    //   if (inputFocusNode.hasFocus) {
    //     setState(() {
    //       showKeyboard = true;
    //       showEmojiSelector = false;
    //     });
    //   } else {
    //     // logger.info("TextField lost focus");
    //   }
    // });
  }

  void _scrollToEnd() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    super.dispose();
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

  // 显示键盘
  void showKeyboardFunc(double keyboardHeight) {
    // 显示键盘
    SystemChannels.textInput.invokeMethod('TextInput.show');

    _keyboradAnimation = Tween<double>(begin: 0, end: keyboardHeight).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      // 显示图标选择器
      showEmojiSelector = false;
      // 隐藏键盘
      showKeyboard = true;
    });

    // 表情面板打开
    _animationContentController.forward();
  }

  // 显示键盘
  void hideKeyboardFunc(double keyboardHeight) {
    // 隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _keyboradAnimation = Tween<double>(begin: keyboardHeight, end: 0).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      // 显示图标选择器
      showEmojiSelector = false;
      // 隐藏键盘
      showKeyboard = false;
    });

    // 表情面板打开
    _animationContentController.forward();
  }

  // 笑脸切换到键盘
  void switchKeyboradFunc(double keyboardHeight) {
    SystemChannels.textInput.invokeMethod('TextInput.show');

    _keyboradAnimation =
        Tween<double>(begin: 600.w, end: keyboardHeight).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      // 显示图标选择器
      showEmojiSelector = false;
      // 显示键盘
      showKeyboard = true;
    });

    // 表情面板打开
    _animationContentController.forward();
  }

  void showEmojiFunc() {
    _keyboradAnimation = Tween<double>(begin: 0, end: 600.w).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      // 显示图标选择器
      showEmojiSelector = true;
      // 隐藏键盘
      showKeyboard = false;
    });

    // 表情面板打开
    _animationContentController.forward();
  }

  void hideEmojiFunc() {
    _keyboradAnimation = Tween<double>(begin: 600.w, end: 0.w).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      // 显示图标选择器
      showEmojiSelector = false;
      // 隐藏键盘
      showKeyboard = false;
    });

    // 表情面板打开
    _animationContentController.forward();
  }

  // 键盘转换笑脸面板
  void switchEmojiFunc() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _keyboradAnimation =
        Tween<double>(begin: _keyboardHeight, end: 600.w).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      // 显示图标选择器
      showEmojiSelector = true;
      // 隐藏键盘
      showKeyboard = false;
    });

    // 表情面板打开
    _animationContentController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              // 是否在键盘弹出时调整布局（避免被键盘遮挡）。
              resizeToAvoidBottomInset: false,
              primary: false,
              extendBody: false,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(90.0.w + _statusHeight),
                  child: Container(
                    color: const Color.fromARGB(255, 237, 237, 237),
                    padding: EdgeInsets.only(top: _statusHeight),
                    child: AppBar(
                      leading: GestureDetector(
                        onTap: () => Navigator.of(context).pop(), // 点击事件
                        child: Container(
                          // 加盒子是为了扩大点击区域
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
                      elevation: 0,
                      scrolledUnderElevation: 0,
                      toolbarHeight: 90.w,
                      title: Text(widget.title),
                      titleTextStyle: TextStyle(
                        height: 1.08,
                        fontSize: fontSizeScale(32.w),
                        color: Colors.black,
                        fontFamily: "AlibabaPuHuiTi-Medium",
                      ),
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
                        GestureDetector(
                          onTap: () {
                            // 点击事件
                          },
                          child: Container(
                            height: 90.w,
                            color: Colors.transparent,
                            padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
                            child: Icon(
                              const IconData(
                                0xe659,
                                fontFamily: 'Iconfont',
                              ),
                              size: 37.w, // 图标大小
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              body: SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              if (showKeyboard == true) {
                                hideKeyboardFunc();
                              } else if (showEmojiSelector == true) {
                                hideEmojiFunc();
                              }
                            },
                            child: ColoredBox(
                                color: const Color.fromARGB(255, 237, 237, 237),
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: messageList.isEmpty
                                      ? Container()
                                      : ListView.builder(
                                          controller: _scrollController,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
                                          itemCount: messageList.length,
                                          itemBuilder: (context, index) {
                                            return messageList[index]; // 返回消息项
                                          },
                                        ),
                                )),
                          )),

                      // 输入部分
                      Expanded(
                          flex: 0,
                          child: Container(
                              constraints: BoxConstraints(minHeight: 107.w),
                              width: screenSize.width,
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16).w,
                              // margin: EdgeInsets.only(bottom: inputMarginBottom),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247),
                                  border: Border(
                                      top: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 231, 231, 231),
                                    width: 1.5.w,
                                    style: BorderStyle.solid,
                                  ))),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // 语音按钮
                                  Container(
                                      // color: Colors.amber,
                                      width: 57.w,
                                      height: 57.w,
                                      margin: EdgeInsets.only(
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 10.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          logger.info("语音被点击"); // 点击事件
                                        },
                                        child: Icon(
                                          const IconData(
                                            0xe66c,
                                            fontFamily: 'Iconfont',
                                          ),
                                          size: 56.w, // 图标大小
                                        ),
                                      )),

                                  // 消息框
                                  Expanded(
                                      child:
                                          // C:\flutter\packages\flutter\lib\src\widgets\editable_text.dart  4239行控制必须得到焦点才显示光标
                                          TextField(
                                    readOnly: false,
                                    autofocus: false,
                                    showCursor: true,
                                    controller: inputController,
                                    focusNode: inputFocusNode,
                                    onTap: () {
                                      if (showEmojiSelector == false &&
                                          showKeyboard == false) {
                                        showKeyboardFunc(_keyboardHeight);
                                      } else if (showEmojiSelector == true &&
                                          showKeyboard == false) {
                                        switchKeyboradFunc(_keyboardHeight);
                                      }
                                    },
                                    cursorColor:
                                        const Color.fromRGBO(62, 174, 86, 1.0),
                                    // cursorHeight: 44.w,
                                    cursorWidth: 3.w,
                                    style: TextStyle(
                                        // height: 1.08,
                                        fontSize: fontSizeScale(30.w),
                                        color: Colors.black),
                                    // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w)),
                                    maxLines: 5,
                                    minLines: 1,
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                                  vertical: 14, horizontal: 16)
                                              .w,
                                      border: const OutlineInputBorder(
                                          gapPadding: 0,
                                          borderSide: BorderSide.none),
                                      // focusedBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                      // enabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                      // disabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                      // focusedErrorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                      // errorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                    ),
                                  )),

                                  // 笑脸按钮
                                  Container(
                                    // color: Colors.amber,
                                    width: 57.w,
                                    height: 57.w,
                                    margin: EdgeInsets.only(
                                        left: 20.w, right: 25.w, bottom: 10.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (showEmojiSelector == false &&
                                            showKeyboard == false) {
                                          showEmojiFunc();
                                        } else if (showEmojiSelector == true &&
                                            showKeyboard == false) {
                                          switchKeyboradFunc(_keyboardHeight);
                                        } else if (showEmojiSelector == false &&
                                            showKeyboard == true) {
                                          switchEmojiFunc();
                                        }
                                      },
                                      child: Icon(
                                        const IconData(
                                          0xe702,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 49.w, // 图标大小
                                      ),
                                    ),
                                  ),

                                  // 发送按钮 与 图标变换
                                  AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Visibility(
                                          visible: !showPlusIcon,
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var message =
                                                      inputController.text;

                                                  messageList.add(LJNMyMessage(
                                                    message:
                                                        message.trimRight(),
                                                    name: vm.userinfoName
                                                        as String,
                                                    showName: false,
                                                  ));
                                                  inputController.text = "";

                                                  // SystemChannels.textInput
                                                  //     .invokeMethod("TextInput.show");
                                                  // WidgetsBinding.instance
                                                  // .addPostFrameCallback((_) {
                                                  // inputFocusNode.requestFocus()
                                                  // FocusScope.of(context)
                                                  // .requestFocus(inputFocusNode);
                                                  // });
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                        bottom: 8, right: 15)
                                                    .w,
                                                width: _widthAnimation.value,
                                                height: 60.w,
                                                decoration: BoxDecoration(
                                                  color: _colorAnimation.value!,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.w)),
                                                ),
                                                child: _widthAnimation.value >=
                                                        113.w
                                                    ? Center(
                                                        child: Text(
                                                          "发送",
                                                          style: TextStyle(
                                                              height: 1.08,
                                                              fontSize:
                                                                  fontSizeScale(
                                                                      27.w),
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    : null,
                                              )));
                                    },
                                  ),

                                  // 加号
                                  Visibility(
                                      visible: showPlusIcon,
                                      child: Container(
                                          // color: Colors.amber,
                                          width: 57.w,
                                          height: 57.w,
                                          margin: EdgeInsets.only(
                                              right: 20.w, bottom: 10.w),
                                          child: GestureDetector(
                                            onTap: () {
                                              logger.info("加号被点击"); // 点击事件
                                            },
                                            child: Icon(
                                              const IconData(
                                                0xe726,
                                                fontFamily: 'Iconfont',
                                              ),
                                              size: 57.w, // 图标大小
                                            ),
                                          )))
                                ],
                              ))),

                      // 图标选择器
                      AnimatedBuilder(
                        animation: _animationContentController,
                        builder: (context, child) {
                          return Expanded(
                              flex: 0,
                              child: Container(
                                  width: screenSize.width,
                                  height: _keyboradAnimation.value,
                                  color: Colors.red,
                                  child: showEmojiSelector
                                      ? const LJNEmojiSelector()
                                      : null));
                        },
                      ),
                    ],
                  )));
        });
  }

  void addList() {
    messageList.add(const LJNMyMessage(
      message: '今晚，我们开始吧，准备好了吗？',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '嗯，准备好了。虽然有点紧张，但我知道我们已经决定了。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '我也是。虽然我们之前谈了很多次，但真的要开始时，心里还是有些忐忑。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '我也是。突然想到，万一不能顺利怀上怎么办？',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '别担心，慢慢来。就算不顺利，我们也会一起面对，不急的。最重要的是我们愿意一起尝试，给自己一个机会。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '你说得对，我只是怕自己压力太大，万一做不到怎么办。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '我们做不到的事很少，我相信我们能行。而且，压力大了，放轻松点，别太给自己太多负担。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '嗯，我知道。你也知道，我的身体不是那么好，可能会有点麻烦。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '我知道，但我们一起走这条路，不管怎么样，我们都有彼此支持。我会陪着你，咱们不会有任何困难是过不去的。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '有你在我身边，我就不怕了。你觉得，如果不顺利，我们也不应该急对吧？',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '对，别急，顺其自然。如果真有问题，我们可以一起去看医生，解决的办法总有的。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '嗯，既然你这么说，我也放心了。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(LJNReceiveMessage(
      message: '其实，我一直很期待有个孩子，能有一个属于我们的家庭。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '我也是。我们将来可以一起看他成长，一起陪着他做作业、玩游戏，甚至一起教他做事。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '你觉得我们的孩子会是什么样的？像你，还是像我？',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '不管像谁，都一定是最棒的。',
      showName: false,
    ));

    messageList.add(const LJNMyMessage(
      message: '但我想，他应该会有你的聪明和我的耐心，能很好地适应生活中的挑战。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '那也太完美了吧。希望他能继承我们的优点，少一些缺点。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '无论如何，我们都得给他一个充满爱的家庭，这才是最重要的。',
      showName: false,
    ));

    messageList.add(const LJNMyMessage(
      message: '今晚，就是我们的开始了。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '是的，今晚开始。未来的路我们一起走。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '今晚，我们做的每一步，都是为了未来的孩子，都是为了我们共同的未来。',
      showName: false,
    ));

    messageList.add(LJNReceiveMessage(
      message: '嗯，今晚我们就开始，未来的一切，交给时间。',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(LJNReceiveMessage(
      message: '你准备好了吗？',
      showName: false,
      friendAvatar: widget.icon,
      name: widget.title,
    ));
    messageList.add(const LJNMyMessage(
      message: '准备好了，永远准备好。',
      showName: false,
    ));
  }
}
