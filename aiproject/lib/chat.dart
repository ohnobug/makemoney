import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/components/LJNReceiveMessage.dart';
import 'package:jiaoyishuoflutter3/components/LJNReceiveVideoMessage.dart';
import 'package:jiaoyishuoflutter3/components/LJNVideoDraggableBox.dart';
import 'package:jiaoyishuoflutter3/components/LJNVideoMessage.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/emojiSelector.dart';
import 'components/LJNMyMessage.dart';
import 'tools/tools.dart';
import 'package:lottie/lottie.dart';

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

  bool showVoiceLottie = false;
  late final AnimationController _voiceLottieController;

  List<StatefulWidget> messageList = [];

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
  String videoPath = "";

  // 显示语音按钮
  bool showVoiceButton = false;

  // late AnimationController _voiceIconController;
  // late Animation<double> _voiceIconAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
    ));

    _voiceLottieController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

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

    // // 初始化动画控制器
    // _voiceIconController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 300), // 动画时长
    // )..repeat(reverse: true); // 循环播放

    // // 初始化动画
    // _voiceIconAnimation = Tween<double>(
    //   begin: 106.w, // 起始位置（底部）
    //   end: 200.w, // 结束位置（顶部）
    // ).animate(CurvedAnimation(
    //   parent: _voiceIconController,
    //   curve: Curves.easeInOut, // 动画曲线
    // ));

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
      video: 'images/ins/test.mp4',
      width: 768,
      height: 576,
      showName: false,
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        setState(() {
          openPosition = position;
          logger.info("openPosition: $openPosition");
          openBoxSize = size;
          videoPath = 'images/ins/test.mp4';

          showFullScreenVideo = true;
        });
      },
    ));

    messageList.add(LJNVideoMessage(
      video: 'images/ins/video2.mp4',
      width: 576,
      height: 1024,
      showName: false,
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        setState(() {
          openPosition = position;
          logger.info("openPosition: $openPosition");
          openBoxSize = size;
          videoPath = 'images/ins/video2.mp4';

          showFullScreenVideo = true;
        });
      },
    ));

    messageList.add(LJNReceiveVideoMessage(
      video: 'images/ins/video2.mp4',
      width: 576,
      height: 1024,
      friendAvatar: widget.icon,
      showName: false,
      name: '小白',
      onTap: (Offset position, Size size) {
        // 关闭键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        setState(() {
          openPosition = position;
          logger.info("openPosition: $openPosition");
          openBoxSize = size;
          videoPath = 'images/ins/video2.mp4';

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

    _voiceLottieController.dispose();

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

  // 打开Emoji
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

  // 关闭Emoji
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

  @override
  Widget build(BuildContext context) {
    logger.info("aaaaaaa 来了 $lastKeyboradHeight $showKeyboard");

    Size screenSize = MediaQuery.of(context).size;

    keyboradCloseDetect();

    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Stack(
            children: [
              Scaffold(
                  // 是否在键盘弹出时调整布局（避免被键盘遮挡）。
                  resizeToAvoidBottomInset: false,
                  primary: false,
                  extendBody: false,
                  appBar: LJNAppBar(
                    title: widget.title,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          // 点击事件
                          Navigator.pushNamed(
                            context,
                            '/friend_message_record',
                          );
                        },
                        child: Container(
                          height: 90.w,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right: 33.w), // 设置右侧内边距
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
                                        _animationContentController.isAnimating
                                            ? _animationContentController.value
                                            : 0);
                                  } else if (showKeyboard == true) {
                                    hideKeyboardFunc(
                                        _animationContentController.isAnimating
                                            ? _animationContentController.value
                                            : 0);
                                  }
                                },
                                child: ColoredBox(
                                    color: const Color.fromARGB(
                                        255, 237, 237, 237),
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
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
                                  constraints: BoxConstraints(minHeight: 107.w),
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
                                    crossAxisAlignment: showVoiceButton
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.end,
                                    children: [
                                      // 语音按钮
                                      GestureDetector(
                                          onTap: () {
                                            // logger.info("语音被点击"); // 点击事件
                                            setState(() {
                                              showVoiceButton =
                                                  !showVoiceButton;
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            width: 97.w,
                                            height: 107.w,
                                            padding: EdgeInsets.only(
                                                left: 20.w, right: 20.w),
                                            child: Icon(
                                              const IconData(
                                                0xe66c,
                                                fontFamily: 'Iconfont',
                                              ),
                                              size: 56.w, // 图标大小
                                            ),
                                          )),

                                      showVoiceButton
                                          ?
                                          // 长按录音
                                          Expanded(
                                              flex: 1,
                                              child: Listener(
                                                onPointerDown:
                                                    (PointerDownEvent event) {
                                                  // 手指按下时
                                                  setState(() {
                                                    showVoiceLottie = true;
                                                  });
                                                  _voiceLottieController
                                                      .forward();
                                                },
                                                onPointerMove:
                                                    (PointerMoveEvent event) {
                                                  // 判断手指是否在按钮区域内
                                                  // final RenderBox box =
                                                  //     context.findRenderObject()
                                                  //         as RenderBox;
                                                  // final Offset localOffset =
                                                  //     box.globalToLocal(
                                                  //         event.position);
                                                  // if (box.size
                                                  //     .contains(localOffset)) {
                                                  //   setState(() {
                                                  //     showVoiceLottie = true;
                                                  //   });
                                                  //   _voiceLottieController
                                                  //       .forward();
                                                  // }
                                                  //  else {
                                                  //   setState(() {
                                                  //     showVoiceLottie = false;
                                                  //   });
                                                  //   _voiceLottieController
                                                  //       .reset();
                                                  // }
                                                },
                                                onPointerUp:
                                                    (PointerUpEvent event) {
                                                  // 手指释放时
                                                  setState(() {
                                                    showVoiceLottie = false;
                                                  });
                                                  _voiceLottieController
                                                      .reset();
                                                },
                                                onPointerCancel:
                                                    (PointerCancelEvent event) {
                                                  // 手指取消时
                                                  setState(() {
                                                    showVoiceLottie = false;
                                                  });
                                                  _voiceLottieController
                                                      .reset();
                                                },
                                                child: Container(
                                                  height: 77.w,
                                                  padding: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.w),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "按住 说话",
                                                    style: TextStyle(
                                                      fontSize: 31.w,
                                                      height: 1.08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          :
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
                                      GestureDetector(
                                        onTap: () {
                                          if (showEmojiSelector == false &&
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
                                        child: Container(
                                          color: Colors.transparent,
                                          width: 102.w,
                                          height: 107.w,
                                          padding: EdgeInsets.only(
                                              left: 20.w, right: 25.w),
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

                                                      messageList
                                                          .add(LJNMyMessage(
                                                        message:
                                                            message.trimRight(),
                                                        name: vm.userinfoName
                                                            as String,
                                                        showName: false,
                                                      ));
                                                      inputController.text = "";

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
                                                    width:
                                                        _widthAnimation.value,
                                                    height: 60.w,
                                                    decoration: BoxDecoration(
                                                      color: _colorAnimation
                                                          .value!,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.w)),
                                                    ),
                                                    child: _widthAnimation
                                                                .value >=
                                                            113.w
                                                        ? Center(
                                                            child: Text(
                                                              "发送",
                                                              style: TextStyle(
                                                                  height: 1.08,
                                                                  fontSize:
                                                                      fontSizeScale(
                                                                          27.w),
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
                                          child: GestureDetector(
                                              onTap: () {
                                                logger.info("加号被点击"); // 点击事件
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                width: 87.w,
                                                height: 107.w,
                                                padding: EdgeInsets.only(
                                                    right: 20.w),
                                                alignment: Alignment.center,
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

              // 视频放大
              showFullScreenVideo
                  ? LJNVideoDraggableBox(
                      openBoxSize: openBoxSize,
                      openPosition: openPosition,
                      videoPath: videoPath,
                      onClose: () {
                        setState(() {
                          showFullScreenVideo = false;
                        });
                      },
                    )
                  : Container(),

              // 语音消息
              showVoiceLottie
                  ? Container(
                      color: const Color.fromARGB(120, 0, 0, 0),
                      width: screenSize.width,
                      height: screenSize.height,
                      // padding: EdgeInsets.only(top: vm.statusHeight!),
                      child: // 图标选择器
                          AnimatedBuilder(
                              animation: _voiceLottieController,
                              builder: (context, child) {
                                return Stack(
                                  children: [
                                    Lottie.asset(
                                      assetPath('lotties/voicepop.json'),
                                      width: screenSize.width,
                                      height: screenSize.height,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.bottomCenter,
                                      renderCache: RenderCache.drawingCommands,
                                      controller: _voiceLottieController,
                                      onLoaded: (composition) {
                                        // _lottieController
                                        //   ..duration = const Duration(milliseconds: 600)
                                        //   ..forward();
                                      },
                                    ),

                                    // 说话中图标
                                    Positioned(
                                        right: 350.w,
                                        bottom: 90.w +
                                            _voiceLottieController.value * 26.w,
                                        child: Icon(
                                          const IconData(
                                            0xe81d,
                                            fontFamily: 'Iconfont',
                                          ),
                                          color: const Color.fromARGB(
                                              255, 111, 111, 111),
                                          size: 50.w,
                                        )),

                                    // 左边关闭按钮
                                    Positioned(
                                        left: 75.w,
                                        bottom: 275.w +
                                            (_voiceLottieController.value < 0.5
                                                    ? 0.5
                                                    : _voiceLottieController
                                                        .value) *
                                                30.w,
                                        child: Transform.rotate(
                                          angle: -8 * (pi / 180),
                                          origin: Offset.zero,
                                          child: Opacity(
                                              opacity: 0.5 +
                                                  _voiceLottieController.value *
                                                      0.5,
                                              child: Container(
                                                width: 135.w,
                                                height: 135.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                      0xFF3a3a3a), // 颜色 #3a3a3a
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          135.w), // 圆角半径
                                                ),
                                                child: Icon(
                                                  const IconData(
                                                    0xe628,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  color: const Color.fromARGB(
                                                      255, 143, 143, 143),
                                                  size: 40.w,
                                                ),
                                              )),
                                        )),

                                    // 松开发送
                                    Positioned(
                                      bottom: 270.w +
                                          _voiceLottieController.value * 30.w,
                                      child: Container(
                                          width: screenSize.width,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '松开发送',
                                            style: TextStyle(
                                                height: 1.08,
                                                color: Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize: 30.w,
                                                fontFamily: "AlibabaPuHuiTi",
                                                decoration:
                                                    TextDecoration.none),
                                          )),
                                    ),

                                    // 右边转文字按钮
                                    Positioned(
                                        right: 75.w,
                                        bottom: 275.w +
                                            (_voiceLottieController.value < 0.5
                                                    ? 0.5
                                                    : _voiceLottieController
                                                        .value) *
                                                30.w,
                                        child: Transform.rotate(
                                          angle: 8 * (pi / 180),
                                          origin: Offset.zero,
                                          child: Opacity(
                                              opacity: 0.5 +
                                                  _voiceLottieController.value *
                                                      0.5,
                                              child: Container(
                                                width: 135.w,
                                                height: 135.w,
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                      0xFF3a3a3a), // 颜色 #3a3a3a
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          135.w), // 圆角半径
                                                ),
                                                child: Icon(
                                                  const IconData(
                                                    0xe629,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  color: const Color.fromARGB(
                                                      255, 143, 143, 143),
                                                  size: 40.w,
                                                ),
                                              )),
                                        ))
                                  ],
                                );
                              }))
                  : SizedBox()
            ],
          );
        });
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
