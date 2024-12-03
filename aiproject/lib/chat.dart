import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/components/LJNReceiveMessage.dart';
import 'package:jiaoyishuoflutter3/components/LJNVideoMessage.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/emojiSelector.dart';
import 'package:video_player/video_player.dart';
// import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';

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

  // 键盘高度
  double maxKeyboradHeight = 0;

  // 第一次打开键盘
  bool isFirstOpenKeyborad = true;

  bool showKeyboard = false;
  double preBottomInsets = 0;

  // 显示满屏视频
  bool showFullScreenVideo = false;

  GlobalKey videoContainerKey = GlobalKey();

  Offset openPosition = const Offset(0, 0);
  Size openBoxSize = const Size(0, 0);

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ));

    // 初始化 _animationContentController
    _animationContentController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );

    // 设置第一次打开的情况
    _keyboradAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

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

    mock();

    // inputController.text =
    // "生活就像一幅绚丽多彩的画卷，每个人都是这幅画的创作者。在这漫长的人生旅途中，我们用自己的经历、情感和梦想为这幅画增添着独特的色彩。";
    WidgetsBinding.instance.addObserver(this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   logger.info("aaaaaaaaaaa WidgetsBinding.instance.addPostFrameCallback");
    //   _scrollToEnd();
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  void _scrollToEnd() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  void mock() {
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

    messageList.add(LJNVideoMessage(
      message: '准备好了，永远准备好。',
      showName: false,
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        setState(() {
          openPosition = position;
          logger.info("openPosition: $openPosition");

          openBoxSize = size;
          showFullScreenVideo = true;
        });
      },
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    _animationContentController.dispose();
    _animationController.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    super.dispose();
  }

  bool isKeyboardActived = false;
  double currentKeyboradHeight = 0;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    detectKeyborad1();
  }

  // 检测第一次打开
  void detectKeyborad1() {
    final bottom = EdgeInsets.fromViewPadding(
            View.of(context).viewInsets, View.of(context).devicePixelRatio)
        .bottom;

    // 获取最高点
    maxKeyboradHeight = max(bottom, maxKeyboradHeight);

    // 如果是第一次打开键盘则记录
    if (isFirstOpenKeyborad) {
      // 第一次打开时候的动态键盘高度
      currentKeyboradHeight = bottom;

      _keyboradAnimation = Tween<double>(
              begin: currentKeyboradHeight, end: currentKeyboradHeight)
          .animate(
        CurvedAnimation(
          parent: _animationContentController,
          curve: Curves.easeInOut,
        ),
      );

      _animationContentController.value = 1;

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          showKeyboard = true;
          isFirstOpenKeyborad = false;
        });

        _scrollToEnd();
      });
    }
  }

  // 键盘关闭检测
  double lastKeyboradHeight = 0;
  void keyboradCloseDetect() {
    final bottom = EdgeInsets.fromViewPadding(
            View.of(context).viewInsets, View.of(context).devicePixelRatio)
        .bottom;

    if (showKeyboard == true && lastKeyboradHeight > bottom) {
      showKeyboard = false;

      logger.info("aaaaaaaa 用户关闭");

      // 检测到键盘用户主动关闭
      hideKeyboardFunc(bottom / maxKeyboradHeight);
    }

    lastKeyboradHeight = bottom;
  }

  // 显示键盘
  void showKeyboardFunc([double? value]) {
    // 显示键盘
    SystemChannels.textInput.invokeMethod('TextInput.show');

    _keyboradAnimation =
        Tween<double>(begin: 0, end: maxKeyboradHeight).animate(
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
    _animationContentController.forward(from: value ?? 0).then((_) {
      _scrollToEnd();
    });
  }

  // 显示键盘
  void hideKeyboardFunc([double? value]) {
    logger.info("aaaaaaaa begin: $value");

    // 隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _keyboradAnimation =
        Tween<double>(begin: 0, end: maxKeyboradHeight).animate(
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
    _animationContentController.reverse(from: value ?? 1);
  }

  // 笑脸切换到键盘
  void switchKeyboradFunc() {
    SystemChannels.textInput.invokeMethod('TextInput.show');

    // 如果没有键盘高度则降到大约的位置后矫正
    if (isFirstOpenKeyborad) {
      // logger.info("aaaaaa 笑脸切换到键盘，是第一次打开键盘");

      setState(() {
        // 显示图标选择器
        showEmojiSelector = false;
        // 显示键盘
        showKeyboard = true;

        isFirstOpenKeyborad = false;
      });

      _keyboradAnimation = Tween<double>(begin: 280.3, end: 670.h).animate(
        CurvedAnimation(
          parent: _animationContentController,
          curve: Curves.easeInOut,
        ),
      );

      // 表情面板打开
      _animationContentController.reverse(from: 1).then((_) {
        _scrollToEnd();
        // _animationContentController.reverseDuration = oldDuration;
      });

      // 得到键盘高度后矫正
      Future.delayed(const Duration(milliseconds: 400), () {
        _keyboradAnimation =
            Tween<double>(begin: 280.3, end: maxKeyboradHeight).animate(
          CurvedAnimation(
            parent: _animationContentController,
            curve: Curves.easeInOut,
          ),
        );

        // 表情面板打开
        _animationContentController
            .animateTo(1, duration: const Duration(milliseconds: 20))
            .then((_) {
          _scrollToEnd();
        });
      });
    } else {
      _keyboradAnimation =
          Tween<double>(begin: maxKeyboradHeight, end: 670.h).animate(
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
      _animationContentController.reverse(from: 1).then((_) {
        _scrollToEnd();
      });
    }
  }

  void showEmojiFunc([double? value]) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _keyboradAnimation = Tween<double>(begin: 0, end: 670.h).animate(
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

    _animationContentController.value = value ?? 0;

    // 表情面板打开
    _animationContentController.forward().then((_) {
      _scrollToEnd();
    });
  }

  void hideEmojiFunc([double? value]) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _keyboradAnimation = Tween<double>(begin: 0, end: 670.h).animate(
      CurvedAnimation(
        parent: _animationContentController,
        curve: Curves.easeInOut,
      ),
    );

    _animationContentController.value = value ?? 1;
    // 表情面板打开
    _animationContentController.reverse().then((_) {
      setState(() {
        // 显示图标选择器
        showEmojiSelector = false;
        // 隐藏键盘
        showKeyboard = false;
      });
    });
  }

  // 键盘转换笑脸面板
  void switchEmojiFunc() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _keyboradAnimation =
        Tween<double>(begin: maxKeyboradHeight, end: 670.h).animate(
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

    _animationContentController.value = 0;

    // 表情面板打开
    _animationContentController.forward().then((_) {
      _scrollToEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.info("aaaaaaa 来了 $lastKeyboradHeight $showKeyboard");

    Size screenSize = MediaQuery.of(context).size;
    if (kIsWeb) {
      _statusHeight = 0;
    } else {
      _statusHeight = MediaQuery.of(context).padding.top;
    }

    keyboradCloseDetect();

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return PopScope(
              canPop: false, // 不允许默认弹出，使用自定义逻辑控制返回
              onPopInvokedWithResult: (didPop, result) async {
                if (didPop) {
                  return;
                }

                if (showFullScreenVideo) {
                  // 如果正在显示全屏视频，只退出全屏模式
                  setState(() {
                    showFullScreenVideo = false;
                  });
                } else {
                  // 否则允许正常返回
                  Navigator.of(context).pop(result);
                }
              },
              child: Stack(
                children: [
                  // 聊天框
                  Scaffold(
                      // 是否在键盘弹出时调整布局（避免被键盘遮挡）。
                      resizeToAvoidBottomInset: false,
                      primary: false,
                      extendBody: false,
                      appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(90.0.w + _statusHeight),
                          child: Container(
                            color: const Color.fromARGB(255, 237, 237, 237),
                            padding: EdgeInsets.only(top: _statusHeight),
                            child: AppBar(
                              leading: GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pop(), // 点击事件
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
                              backgroundColor:
                                  const Color.fromARGB(255, 237, 237, 237),
                              foregroundColor:
                                  const Color.fromARGB(255, 237, 237, 237),
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(1.w),
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 220, 220, 220),
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
                                    padding:
                                        EdgeInsets.only(right: 33.w), // 设置右侧内边距
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
                              // 聊天信息
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      logger.info(
                                          "aaaaaaaa showEmojiSelector: $showEmojiSelector _animationContentController.value: ${_animationContentController.value}");

                                      if (showEmojiSelector == true) {
                                        // 如果是上升过程，取消显示，则需要打断，从打断的位置下降
                                        hideEmojiFunc(
                                            _animationContentController
                                                    .isAnimating
                                                ? _animationContentController
                                                    .value
                                                : 0);
                                      } else if (showKeyboard == true) {
                                        hideKeyboardFunc(
                                            _animationContentController
                                                    .isAnimating
                                                ? _animationContentController
                                                    .value
                                                : 0);
                                      }
                                    },
                                    child: ColoredBox(
                                        color: const Color.fromARGB(
                                            255, 237, 237, 237),
                                        child: ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(scrollbars: false),
                                          child: SingleChildScrollView(
                                            padding: EdgeInsets.only(
                                                top: 30.w, bottom: 30.w),
                                            controller: _scrollController,
                                            // keyboardDismissBehavior:
                                            //     ScrollViewKeyboardDismissBehavior
                                            //         .onDrag,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(
                                                    parent:
                                                        BouncingScrollPhysics()),
                                            child: messageList.isEmpty
                                                ? Container()
                                                : Column(
                                                    children: messageList,
                                                  ),
                                          ),
                                        )),
                                  )),

                              // 输入部分
                              Expanded(
                                  flex: 0,
                                  child: Container(
                                      constraints:
                                          BoxConstraints(minHeight: 107.w),
                                      width: screenSize.width,
                                      // margin: EdgeInsets.only(bottom: inputMarginBottom),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 247, 247, 247),
                                          border: Border(
                                              top: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 231, 231, 231),
                                            width: 1.5.w,
                                            style: BorderStyle.solid,
                                          ))),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // 语音按钮
                                          Container(
                                              color: Colors.transparent,
                                              width: 97.w,
                                              height: 107.w,
                                              padding: EdgeInsets.only(
                                                  left: 20.w, right: 20.w),
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

                                          // 消息输入框
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              top: 16,
                                                              bottom: 16)
                                                          .w,
                                                  child: TextField(
                                                    readOnly: false,
                                                    autofocus: false,
                                                    showCursor: true,
                                                    controller: inputController,
                                                    focusNode: inputFocusNode,
                                                    onTap: () {
                                                      if (isFirstOpenKeyborad) {
                                                        SystemChannels.textInput
                                                            .invokeMethod(
                                                                'TextInput.show');
                                                        return;
                                                      }

                                                      if (showEmojiSelector ==
                                                              false &&
                                                          showKeyboard ==
                                                              false) {
                                                        showKeyboardFunc(
                                                            _animationContentController
                                                                    .isAnimating
                                                                ? _animationContentController
                                                                    .value
                                                                : 0);
                                                      } else if (showEmojiSelector ==
                                                              true &&
                                                          showKeyboard ==
                                                              false) {
                                                        if (isFirstOpenKeyborad) {
                                                          switchKeyboradFunc();
                                                        } else {
                                                          switchKeyboradFunc();
                                                        }
                                                      }
                                                    },
                                                    cursorColor:
                                                        const Color.fromRGBO(
                                                            62, 174, 86, 1.0),
                                                    // cursorHeight: 44.w,
                                                    cursorWidth: 3.w,
                                                    style: TextStyle(
                                                        // height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(30.w),
                                                        color: Colors.black),
                                                    // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w)),
                                                    maxLines: 5,
                                                    minLines: 1,
                                                    onChanged: (newText) {
                                                      inputController.value =
                                                          inputController.value
                                                              .copyWith(
                                                        text: newText,
                                                        selection: TextSelection
                                                            .fromPosition(
                                                          TextPosition(
                                                              offset: newText
                                                                  .length),
                                                        ),
                                                      );

                                                      if (inputController
                                                          .text.isEmpty) {
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
                                                        _animationController
                                                            .forward();
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      // focusColor: Colors.red,
                                                      hoverColor: Colors.white,
                                                      isCollapsed: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 14,
                                                                  horizontal:
                                                                      16)
                                                              .w,
                                                      border:
                                                          const OutlineInputBorder(
                                                              gapPadding: 0,
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      // focusedBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                                      // enabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                                      // disabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                                      // focusedErrorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                                      // errorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                                                    ),
                                                  ))
                                              // C:\flutter\packages\flutter\lib\src\widgets\editable_text.dart  4239行控制必须得到焦点才显示光标
                                              ),

                                          // 笑脸按钮
                                          Container(
                                            color: Colors.transparent,
                                            width: 102.w,
                                            height: 107.w,
                                            padding: EdgeInsets.only(
                                                left: 20.w, right: 25.w),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (showEmojiSelector ==
                                                        false &&
                                                    showKeyboard == false) {
                                                  showEmojiFunc(
                                                      _animationContentController
                                                              .isAnimating
                                                          ? _animationContentController
                                                              .value
                                                          : 0);
                                                } else if (showEmojiSelector ==
                                                        false &&
                                                    showKeyboard == true) {
                                                  switchEmojiFunc();
                                                } else if (showEmojiSelector ==
                                                        true &&
                                                    showKeyboard == false) {
                                                  logger.info("aaaaaa 切换到键盘");
                                                  switchKeyboradFunc();
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
                                                              inputController
                                                                  .text;

                                                          messageList
                                                              .add(LJNMyMessage(
                                                            message: message
                                                                .trimRight(),
                                                            name:
                                                                vm.userinfoName
                                                                    as String,
                                                            showName: false,
                                                          ));
                                                          inputController.text =
                                                              "";

                                                          _scrollToEnd();

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
                                                        margin: EdgeInsets.only(
                                                            // top: 16.w,
                                                            bottom: 24.w,
                                                            right: 15.w),
                                                        width: _widthAnimation
                                                            .value,
                                                        height: 60.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _colorAnimation
                                                              .value!,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.w)),
                                                        ),
                                                        child: _widthAnimation
                                                                    .value >=
                                                                113.w
                                                            ? Center(
                                                                child: Text(
                                                                  "发送",
                                                                  style: TextStyle(
                                                                      height:
                                                                          1.08,
                                                                      fontSize:
                                                                          fontSizeScale(27
                                                                              .w),
                                                                      color: Colors
                                                                          .white),
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
                                                  color: Colors.transparent,
                                                  width: 87.w,
                                                  height: 107.w,
                                                  padding: EdgeInsets.only(
                                                      right: 20.w),
                                                  alignment: Alignment.center,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      logger.info(
                                                          "加号被点击"); // 点击事件
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
                                  // late double height;
                                  // if (isFirstOpenKeyborad) {
                                  //   if (showEmojiSelector) {
                                  //     height = _keyboradAnimation.value;
                                  //   } else {
                                  //     height = currentKeyboradHeight;
                                  //   }
                                  // } else {
                                  // height = _keyboradAnimation.value;
                                  // }

                                  return Expanded(
                                      flex: 0,
                                      child: SizedBox(
                                          width: screenSize.width,
                                          height: _keyboradAnimation.value,
                                          // color: Colors.red,
                                          child: showEmojiSelector
                                              ? const LJNEmojiSelector()
                                              : null));
                                },
                              ),
                            ],
                          ))),

                  // 放大
                  showFullScreenVideo
                      ? DraggableBox(
                          openBoxSize: openBoxSize,
                          openPosition: openPosition,
                          onClose: () {
                            setState(() {
                              showFullScreenVideo = false;
                            });
                          },
                        )
                      : Container()
                ],
              ));
        });
  }
}

class DraggableBox extends StatefulWidget {
  final VoidCallback? onClose;

  final Size openBoxSize;
  final Offset openPosition;

  const DraggableBox(
      {super.key,
      this.onClose,
      required this.openBoxSize,
      required this.openPosition});

  @override
  State<DraggableBox> createState() => _DraggableBoxState();
}

class _DraggableBoxState extends State<DraggableBox>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  late Animation<Size> _sizedAnimation;
  late AnimationController _bgTransparentController;
  late Animation<double> _bganimation;
  VideoPlayerController? _videoController;
  Offset _boxOffset = Offset.zero; // 小盒子的偏移量

  late AnimationController _innerSizedController;
  late Animation<double> _innerSizedAnimation;

  @override
  void initState() {
    super.initState();

    // 控制透明
    _bgTransparentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _bganimation =
        Tween<double>(begin: 0, end: 255).animate(_bgTransparentController);

    // 初始化动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // 回弹动画时长
    );

    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(_animationController);
    _sizedAnimation =
        Tween<Size>(begin: const Size(0, 0), end: const Size(0, 0))
            .animate(_animationController);

    // 控制内部大小
    _innerSizedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _innerSizedAnimation =
        Tween<double>(begin: 1, end: 0).animate(_innerSizedController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bgTransparentController.dispose();
    _innerSizedController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  double videoWidth = 0;
  double videoHeight = 0;
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    _videoController ??= VideoPlayerController.asset(
      assetPath('images/ins/test.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: false,
        allowBackgroundPlayback: false,
      ),
    )..initialize().then((_) {
        // 动态计算视频宽高
        videoWidth = screenSize.width;
        videoHeight = videoWidth / _videoController!.value.aspectRatio;

        // 中心点坐标
        Offset center = Offset((screenSize.width - videoWidth) / 2,
            (screenSize.height - videoHeight) / 2);

        _positionAnimation = Tween<Offset>(
          begin: widget.openPosition,
          end: Offset(0, center.dy),
        ).animate(_animationController);

        _sizedAnimation = Tween<Size>(
          begin: widget.openBoxSize,
          end: Size(videoWidth, videoHeight),
        ).animate(_animationController);

        _bgTransparentController.forward(from: 0.0);
        _animationController.forward(from: 0).then((_) {
          setState(() {
            _videoController?.play();
          });
        });
      });

    return Stack(
      children: [
        // 大盒子（全屏）
        AnimatedBuilder(
            animation: _bgTransparentController,
            builder: (context, child) {
              return Container(
                width: screenSize.width,
                height: screenSize.height,
                color: Color.fromARGB(_bganimation.value.toInt(), 0, 0, 0),
              );
            }),

        // 小盒子
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                left: _positionAnimation.value.dx + _boxOffset.dx,
                top: _positionAnimation.value.dy + _boxOffset.dy,
                child: GestureDetector(
                    onPanDown: (details) {
                      _animationController.stop();
                      _bgTransparentController.stop();
                      _innerSizedController.stop();
                    },
                    onPanUpdate: (details) {
                      // 更新偏移量
                      setState(() {
                        // 偏移
                        _boxOffset += details.delta;

                        // 背景
                        double euclideanDistance = _boxOffset.dy.abs();
                        double v = euclideanDistance / (screenSize.height / 2);
                        if (v > 1) v = 1;
                        _bgTransparentController.value = 1 - v;

                        // 大小
                        _innerSizedController.value = v;
                      });
                    },
                    onPanEnd: (details) {
                      // 使用 Tween 动画将偏移量平滑过渡到 (0, 0)
                      _positionAnimation = Tween<Offset>(
                        begin: Offset(
                            _positionAnimation.value.dx + _boxOffset.dx,
                            _positionAnimation.value.dy + _boxOffset.dy),
                        end: Offset(0, (screenSize.height - videoHeight) / 2),
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.linear, // 使用缓动曲线
                      ));

                      _boxOffset = Offset.zero;

                      _animationController.reset();
                      _animationController.forward(from: 0.0); // 开始动画

                      _bganimation = Tween<double>(
                              begin: _bgTransparentController.value, end: 255)
                          .animate(_bgTransparentController);
                      _bgTransparentController.forward();
                      _innerSizedController.reverse();
                    },
                    child: Container(
                        width: _sizedAnimation.value.width,
                        height: _sizedAnimation.value.height,
                        alignment: Alignment.topCenter,
                        color: Colors.transparent,
                        child: SizedBox(
                          // color: const Color.fromARGB(255, 194, 194, 194),
                          width: _sizedAnimation.value.width *
                              _innerSizedAnimation.value,
                          height: _sizedAnimation.value.height *
                              _innerSizedAnimation.value,
                          child: AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                        ))

                    // Container(
                    //   width: 100,
                    //   height: 100,
                    //   color: Colors.red,
                    // ),
                    ),
              );
            }),

        // 关闭按钮
        Positioned(
          top: 90.w,
          right: 30.w,
          child: GestureDetector(
            onTap: () {
              _videoController?.pause();

              Offset beginPosition = Offset(
                  _positionAnimation.value.dx + _boxOffset.dx,
                  _positionAnimation.value.dy + _boxOffset.dy);

              // 使用 Tween 动画将偏移量平滑过渡到 (0, 0)
              _positionAnimation = Tween<Offset>(
                begin: widget.openPosition,
                end: beginPosition,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.linear, // 使用缓动曲线
              ));

              // _animationController.reset();
              _animationController.reverse().then((_) {
                if (widget.onClose != null) widget.onClose!();
              });
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 39.w),
              width: 50.w,
              height: 50.w,
              child: Icon(
                const IconData(
                  0xe601,
                  fontFamily: 'Iconfont',
                ),
                size: 50.w, // 图标的大小
                color: const Color.fromARGB(255, 255, 255, 255), // 图标颜色
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// 面板状态：打开、隐藏


// 点击笑脸按钮：
//     1、笑脸选择器尚未被打开，则0~600动画打开笑脸选择器。
//     2、当前显示键盘，则切换笑脸选择器。键盘高度~600动画打开笑脸选择器。
//     3、当前显示笑脸选择器，则切换到键盘，面板高度600~键盘高度。

// 点击聊天记录：
//     1、笑脸选择器、键盘尚未打开，则无任何效果
//     2、笑脸选择器打开状态，则600~0动画关闭笑脸选择器。
//     3、键盘打开状态，则键盘高度~0动画关闭键盘。

// 点击聊天框：
//     1、如果笑脸选择器和键盘都没打开，则动画打开键盘。（！！！需要考虑第一次打开，没有高度的情况）
//     2、如果笑脸选择器打开，但键盘没有打开，则动画切换到键盘。（！！！需要考虑第一次打开，没有高度的情况）


// 键盘高度获取：
//     第一次点击笑脸图标和聊天框的时候，记录最大值