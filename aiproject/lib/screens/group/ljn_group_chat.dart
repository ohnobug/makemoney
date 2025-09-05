import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_my_voice_message.dart';
import 'package:vigaviga/widgets/ljn_receive_message.dart';
import 'package:vigaviga/widgets/ljn_video_draggable_box.dart';
import 'package:vigaviga/widgets/ljn_video_message.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/chat/widgets/ljn_chat_emoji_selector.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import '../../widgets/ljn_my_message.dart';
import '../../store/ljn_system_cubit.dart';
import '../../tools/ljn_tools.dart';
import 'package:lottie/lottie.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;

class LJNGroupChat extends StatefulWidget {
  const LJNGroupChat({super.key, required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  State<LJNGroupChat> createState() => _LJNGroupChat();
}

class _LJNGroupChat extends State<LJNGroupChat>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String message = "";

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

  late AnimationController _emojiPanelAnimationContentController;
  late Animation<double> _keyboradAnimation;

  bool showVoiceLottie = false;
  late final AnimationController _voiceLottieController;

  // 文本盒子控制器
  late final AnimationController _voiceTextBoxController;
  late final Animation<double> _voiceTextBoxHeightAnimation;
  late final Animation<double> _voiceTextBoxWidthAnimation;
  late final Animation<double> _voiceTextBoxBottomIconRightAnimation;

  List<StatefulWidget> messageList = [];

  // 取消按钮变大效果
  late AnimationController _voiceLeftButtonScaleController;
  late Animation<double> _voiceLeftButtonScaleAnimation;
  late final AnimationController _voiceLeftButtonColorController;
  late final Animation<Color?> _voiceLeftButtonColorAnimation;
  int leftRight = 0;

  // 转文字按钮变大效果
  late AnimationController _voiceRightButtonScaleController;
  late Animation<double> _voiceRightButtonScaleAnimation;
  late final AnimationController _voiceRightButtonColorController;
  late final Animation<Color?> _voiceRightButtonColorAnimation;

  // 键盘高度
  bool showKeyboard = false;

  // 显示满屏视频
  bool showFullScreenVideo = false;

  GlobalKey videoContainerKey = GlobalKey();

  Offset openPosition = const Offset(0, 0);
  Size openBoxSize = const Size(0, 0);
  String videoPath = "";

  // 显示语音按钮
  bool showVoiceButton = false;

  // 退出语音录制
  bool showCancelVoiceButtons = false;

  AudioRecorder? record;
  String? wmaPath;
  late DateTime beginRecordTime;

  // 键盘输入类型
  TextInputType keyboardType = TextInputType.none;

  // DateTime? _lastExecuted; // 用来记录上次执行的时间

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent, // 设置状态栏透明
        statusBarIconBrightness: Brightness.dark, // 设置状态栏图标颜色
      ),
    );

    // 放大缩小语音
    _voiceTextBoxController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _voiceTextBoxHeightAnimation =
        Tween<double>(begin: 190.w, end: 253.w).animate(
      CurvedAnimation(
        parent: _voiceTextBoxController,
        curve: Curves.easeInOut,
      ),
    );

    _voiceTextBoxWidthAnimation =
        Tween<double>(begin: 175.w, end: 640.w).animate(
      CurvedAnimation(
        parent: _voiceTextBoxController,
        curve: Curves.easeInOut,
      ),
    );

    _voiceTextBoxBottomIconRightAnimation =
        Tween<double>(begin: 68.5.w, end: 38.w).animate(
      CurvedAnimation(
        parent: _voiceTextBoxController,
        curve: Curves.easeInOut,
      ),
    );

    // 左边放大缩小
    _voiceLeftButtonScaleController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _voiceLeftButtonScaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2222).animate(
      CurvedAnimation(
        parent: _voiceLeftButtonScaleController,
        curve: Curves.linear,
      ),
    );

    // 左边控制颜色
    _voiceLeftButtonColorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _voiceLeftButtonColorAnimation = ColorTween(
      begin: Color(0xFF3a3a3a),
      end: AppColors.neutralWhite,
    ).animate(_voiceLeftButtonColorController);

    // 右边放大缩小
    _voiceRightButtonScaleController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _voiceRightButtonScaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2222).animate(
      CurvedAnimation(
        parent: _voiceRightButtonScaleController,
        curve: Curves.linear,
      ),
    );

    // 右边控制颜色
    _voiceRightButtonColorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _voiceRightButtonColorAnimation = ColorTween(
      begin: Color(0xFF3a3a3a),
      end: AppColors.neutralWhite,
    ).animate(_voiceRightButtonColorController);

    _voiceLottieController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _changeTypeMilliseconds),
    );

    // 初始化 _emojiPanelAnimationContentController
    _emojiPanelAnimationContentController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );

    // 设置第一次打开的情况
    _keyboradAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(
        parent: _emojiPanelAnimationContentController,
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
      begin: AppColors.greenTransparent70,
      end: AppColors.brandGreenVibrant1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    mock();

    WidgetsBinding.instance.addObserver(this);
  }

  // 获取临时文件名
  Future<String> getWMAFilePath() async {
    // 获取应用的文档目录
    final directory = await getApplicationDocumentsDirectory();

    var uuid = Uuid();
    String filepath = uuid.v4();

    // 获取文件名
    String filename = path.basename(filepath);

    // 可以在这里进行其他操作，比如拼接完整的文件路径等
    String fullPath = '${directory.path}/$filename.m4a';

    logger.info(fullPath);

    return fullPath;
  }

  void _scrollToEnd() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent,
    );
  }

  void mock() {
    messageList.add(
      const LJNMyMessage(
        message: '今晚，我们开始吧，准备好了吗？',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '嗯，准备好了。虽然有点紧张，但我知道我们已经决定了。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_31.webp",
        name: "武则天",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '我也是。虽然我们之前谈了很多次，但真的要开始时，心里还是有些忐忑。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '我也是。突然想到，万一不能顺利怀上怎么办？',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_30.webp",
        name: "彭长老",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '别担心，慢慢来。就算不顺利，我们也会一起面对，不急的。最重要的是我们愿意一起尝试，给自己一个机会。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '你说得对，我只是怕自己压力太大，万一做不到怎么办。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_32.webp",
        name: "方人智",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '我们做不到的事很少，我相信我们能行。而且，压力大了，放轻松点，别太给自己太多负担。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '嗯，我知道。你也知道，我的身体不是那么好，可能会有点麻烦。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_33.webp",
        name: "全金发",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '我知道，但我们一起走这条路，不管怎么样，我们都有彼此支持。我会陪着你，咱们不会有任何困难是过不去的。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '有你在我身边，我就不怕了。你觉得，如果不顺利，我们也不应该急对吧？',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_34.webp",
        name: "段正明",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '对，别急，顺其自然。如果真有问题，我们可以一起去看医生，解决的办法总有的。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '嗯，既然你这么说，我也放心了。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_35.webp",
        name: "万大平",
      ),
    );
    messageList.add(
      const LJNReceiveMessage(
        message: '其实，我一直很期待有个孩子，能有一个属于我们的家庭。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_36.webp",
        name: "慧真",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '我也是。我们将来可以一起看他成长，一起陪着他做作业、玩游戏，甚至一起教他做事。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '你觉得我们的孩子会是什么样的？像你，还是像我？',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_37.webp",
        name: "李世民",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '不管像谁，都一定是最棒的。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNMyMessage(
        message: '但我想，他应该会有你的聪明和我的耐心，能很好地适应生活中的挑战。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '那也太完美了吧。希望他能继承我们的优点，少一些缺点。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_38.webp",
        name: "施戴子",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '无论如何，我们都得给他一个充满爱的家庭，这才是最重要的。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNMyMessage(
        message: '今晚，就是我们的开始了。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '是的，今晚开始。未来的路我们一起走。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_39.webp",
        name: "者勒米",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '今晚，我们做的每一步，都是为了未来的孩子，都是为了我们共同的未来。',
        showName: true,
      ),
    );

    messageList.add(
      const LJNReceiveMessage(
        message: '嗯，今晚我们就开始，未来的一切，交给时间。',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_40.webp",
        name: "甘宝宝",
      ),
    );
    messageList.add(
      const LJNReceiveMessage(
        message: '你准备好了吗？',
        showName: true,
        friendAvatar: "images/avatar_webp/chat_41.webp",
        name: "李萍",
      ),
    );
    messageList.add(
      const LJNMyMessage(
        message: '准备好了，永远准备好。',
        showName: true,
      ),
    );

    messageList.add(
      LJNVideoMessage(
        video: 'images/ins/test.mp4',
        width: 768,
        height: 576,
        showName: true,
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
      ),
    );

    messageList.add(
      LJNVideoMessage(
        video: 'images/ins/video2.mp4',
        width: 576,
        height: 1024,
        showName: true,
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
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    inputFocusNode.dispose();
    _emojiPanelAnimationContentController.dispose();
    _animationController.dispose();

    // 隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    // 录音长按后底部动画
    _voiceLottieController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      logger.info(
          "切换到后台 showEmojiSelector: $showEmojiSelector showKeyboard: $showKeyboard");
    } else if (state == AppLifecycleState.resumed) {
      // 应用切换到前台
      logger.info(
          "恢复到前台 showEmojiSelector: $showEmojiSelector showKeyboard: $showKeyboard");
      if (showEmojiSelector) {
        showEmojiFunc();
      } else if (showKeyboard) {
        showKeyboardFunc();
      }
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
      hideKeyboardFunc();
    }

    lastKeyboradHeight = bottom;
  }

  void pannelLog(String event) {
    logger.info(
        "zzzzzzzz event: $event showEmojiSelector:$showEmojiSelector showKeyboard:$showKeyboard keyboardType:$keyboardType");
  }

  void _gotoPositionEmojiPanel({
    required double begin,
    required double end,
    double? value,
    Duration? duration,
    VoidCallback? eachFrameScrollToEnd,
  }) {
    if (value == null) {
      _emojiPanelAnimationContentController.reset();
    } else {
      _emojiPanelAnimationContentController.value = value;
    }

    _keyboradAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _emojiPanelAnimationContentController,
        curve: Curves.easeInOut,
      ),
    );

    if (eachFrameScrollToEnd != null) {
      _emojiPanelAnimationContentController.addListener(eachFrameScrollToEnd);
    }

    // 设置动画状态监听器，确保动画完成时移除监听器
    _emojiPanelAnimationContentController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (eachFrameScrollToEnd != null) {
          _emojiPanelAnimationContentController
              .removeListener(eachFrameScrollToEnd);
        }
      }
    });

    // 表情面板打开
    _emojiPanelAnimationContentController.animateTo(
      1,
      duration: duration ??
          Duration(milliseconds: _toggleEmojiPannelDurationMilliseconds),
    );
  }

  final int _switchDurationMilliseconds = 50;
  final int _toggleEmojiPannelDurationMilliseconds = 400;
  final double _emojiPanelHeight = 670.h;

  // 切换模式等待时间
  final int _changeTypeMilliseconds = 50;

  // 显示键盘
  void showKeyboardFunc() {
    logger.info("显示键盘");

    inputFocusNode.unfocus();

    setState(() {
      resizeToAvoidBottomInset = true;
      showKeyboard = true;
      showVoiceButton = false;
      keyboardType = TextInputType.text;
    });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.show');

      pannelLog('showKeyboardFunc');
    });
  }

  // 隐藏键盘
  void hideKeyboardFunc() {
    logger.info("隐藏键盘");

    setState(() {
      keyboardType = TextInputType.none;
      resizeToAvoidBottomInset = true;
      showKeyboard = false;
    });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('hideKeyboardFunc');
    });
  }

  // 笑脸切换到键盘
  void switchKeyboradFunc() {
    logger.info("转换到键盘");

    if (keyboardType != TextInputType.text) {
      inputFocusNode.unfocus();
    }

    setState(() {
      keyboardType = TextInputType.text;
      resizeToAvoidBottomInset = false;
      showKeyboard = true;
    });
    _gotoPositionEmojiPanel(
      begin: _emojiPanelHeight,
      end: _maxInsets.bottom,
      value: 0,
      duration: Duration(
          milliseconds:
              _maxInsets.bottom == 0 ? 3000 : _switchDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    logger.info("begin: $_emojiPanelHeight     end: ${_maxInsets.bottom}");

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.show');

      //  等待键盘完成显示，将面板关掉
      Future.delayed(
          Duration(milliseconds: _toggleEmojiPannelDurationMilliseconds), () {
        _gotoPositionEmojiPanel(
          begin: 0,
          end: 0,
          value: 0,
          duration: Duration(milliseconds: 0),
          eachFrameScrollToEnd: () {
            _scrollToEnd();
          },
        );

        setState(() {
          keyboardType = TextInputType.text;
          resizeToAvoidBottomInset = true;
          showKeyboard = true;
          showEmojiSelector = false;
        });

        pannelLog('switchKeyboradFunc');
      });
    });
  }

  // 键盘转换笑脸面板
  void switchEmojiFunc() {
    logger.info("转换到笑脸");

    if (keyboardType != TextInputType.none) {
      inputFocusNode.unfocus();
    }

    setState(() {
      keyboardType = TextInputType.none;
      resizeToAvoidBottomInset = false;
      showKeyboard = false;
      showEmojiSelector = true;
    });

    _gotoPositionEmojiPanel(
      begin: viewInsets.bottom,
      end: _emojiPanelHeight,
      value: 0,
      duration: Duration(milliseconds: _switchDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('switchEmojiFunc');
    });
  }

  // 打开Emoji
  void showEmojiFunc([double? value]) {
    logger.info("显示表情选择器");

    if (keyboardType == TextInputType.text) {
      inputFocusNode.unfocus();
    }

    setState(() {
      // 显示图标选择器
      showEmojiSelector = true;
      // 隐藏键盘
      showKeyboard = false;
      // 语音按钮要隐藏
      showVoiceButton = false;
      keyboardType = TextInputType.none;
    });

    _gotoPositionEmojiPanel(
        begin: 0,
        end: _emojiPanelHeight,
        duration:
            Duration(milliseconds: _toggleEmojiPannelDurationMilliseconds),
        eachFrameScrollToEnd: () {
          _scrollToEnd();
        });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('showEmojiFunc');
    });
  }

  // 点击聊天界面 关闭Emoji
  void hideEmojiFunc([double? value]) {
    logger.info("隐藏表情选择器");

    _gotoPositionEmojiPanel(
      begin: _emojiPanelHeight,
      end: 0,
      duration: Duration(milliseconds: _toggleEmojiPannelDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    setState(() {
      showEmojiSelector = false;
      showKeyboard = false;
      keyboardType = TextInputType.text;
    });
    Future.delayed(
        Duration(milliseconds: _toggleEmojiPannelDurationMilliseconds), () {
      inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      pannelLog('hideEmojiFunc');
    });
  }

  // 按住录制按钮的震动
  Future<void> triggerVibration() async {
    // 检查设备是否支持振动
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      // 检查是否支持振幅控制
      final hasAmplitudeControl = await Vibration.hasAmplitudeControl();
      if (hasAmplitudeControl == true) {
        // 支持振幅控制，使用指定振幅振动
        Vibration.vibrate(duration: 50, amplitude: 128); // 128 是中等强度
      } else {
        // 不支持振幅控制，使用默认振动
        Vibration.vibrate(duration: 50, amplitude: 128);
      }
    } else {
      // 设备不支持振动
      logger.info("设备不支持振动");
    }
  }

  // 停止录音
  void _voiceButtonUp() {
    setState(() {
      showVoiceLottie = false;
      leftRight = 0;

      _voiceLottieController.reset();
      _voiceLeftButtonScaleController.reset();
      _voiceLeftButtonColorController.reset();
      _voiceRightButtonScaleController.reset();
      _voiceRightButtonColorController.reset();
      _voiceTextBoxController.reset();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 停止录音
      final path = await record!.stop();
      await record!.dispose();
      Duration difference = DateTime.now().difference(beginRecordTime);
      logger.info("停止录音 $path");

      setState(() {
        messageList.add(
          LJNMyVoiceMessage(
            message: '${formatDuration(difference)}"',
            voicePath: wmaPath!,
            showName: false,
          ),
        );
      });

      _scrollToEnd();
    });
  }

  bool resizeToAvoidBottomInset = true;

  EdgeInsets viewInsets = EdgeInsets.all(0);

  EdgeInsets _maxInsets = EdgeInsets.all(0);

  // 更新键盘最大值
  void updateMaxInsets(EdgeInsets newInsets) {
    _maxInsets = EdgeInsets.only(
      top: max(_maxInsets.top, newInsets.top),
      left: max(_maxInsets.left, newInsets.left),
      right: max(_maxInsets.right, newInsets.right),
      bottom: max(_maxInsets.bottom, newInsets.bottom),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewInsets = MediaQuery.of(context).viewInsets;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateMaxInsets(viewInsets);
      _scrollToEnd();
    });

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          // 是否在键盘弹出时调整布局（避免被键盘遮挡）。
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: false,
          extendBody: false,
          appBar: null,
          body: Stack(
            children: [
              Column(
                children: [
                  // 标题栏
                  LJNAppBar(
                    title: widget.title,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          // 点击事件
                          Navigator.pushNamed(
                            context,
                            '/group_message_record',
                          );
                        },
                        child: Container(
                          height: 90.w,
                          color: AppColors.transparent,
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

                  // 主体
                  Expanded(
                      child: Column(
                    children: [
                      // 聊天信息
                      Expanded(
                        flex: 1,
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: Listener(
                              onPointerDown: (e) {
                                if (showEmojiSelector) {
                                  hideEmojiFunc();
                                } else if (showKeyboard) {
                                  hideKeyboardFunc();
                                }
                              },
                              child: SingleChildScrollView(
                                padding:
                                    EdgeInsets.only(top: 30.w, bottom: 30.w),
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                child: messageList.isEmpty
                                    ? Container()
                                    : Column(
                                        children: messageList,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 输入部分
                      Expanded(
                        flex: 0,
                        child: Container(
                          constraints: BoxConstraints(minHeight: 107.w),
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.only(bottom: inputMarginBottom),
                          decoration: BoxDecoration(
                            color: AppColors.neutralGrey2,
                            border: Border(
                              top: BorderSide(
                                color: AppColors.neutralGrey16,
                                width: 1.5.w,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: showVoiceButton
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.end,
                            children: [
                              // 语音按钮
                              GestureDetector(
                                onTap: () {
                                  if (showEmojiSelector) {
                                    hideEmojiFunc();
                                  } else if (showKeyboard) {
                                    hideKeyboardFunc();
                                  }

                                  setState(() {
                                    showVoiceButton = !showVoiceButton;
                                  });
                                  if (!showVoiceButton) {
                                    showKeyboardFunc();
                                  }
                                },
                                child: Container(
                                  color: AppColors.transparent,
                                  width: 97.w,
                                  height: 107.w,
                                  padding:
                                      EdgeInsets.only(left: 20.w, right: 20.w),
                                  child: Icon(
                                    const IconData(
                                      0xe66c,
                                      fontFamily: 'Iconfont',
                                    ),
                                    size: 56.w, // 图标大小
                                  ),
                                ),
                              ),

                              showVoiceButton
                                  ?
                                  // 长按录音
                                  Expanded(
                                      flex: 1,
                                      child: Listener(
                                        onPointerDown:
                                            (PointerDownEvent event) async {
                                          // 手指按下时
                                          setState(() {
                                            showVoiceLottie = true;
                                          });

                                          // 震动
                                          triggerVibration();

                                          if (!_voiceLottieController
                                              .isAnimating) {
                                            _voiceLottieController.forward();
                                          }

                                          record = AudioRecorder();

                                          // 拼接本地存储的文件路径
                                          wmaPath = await getWMAFilePath();

                                          logger.info("开始录音 $wmaPath");

                                          if (await record!.hasPermission()) {
                                            record!.stop();
                                            record!.cancel();

                                            beginRecordTime = DateTime.now();

                                            // Start recording to file
                                            await record!.start(
                                                const RecordConfig(),
                                                path: wmaPath!);

                                            // await record!.startStream(
                                            //     const RecordConfig(
                                            //         encoder:
                                            //             AudioEncoder
                                            //                 .pcm16bits),);
                                          }
                                        },
                                        onPointerMove:
                                            (PointerMoveEvent event) {
                                          double svgTop =
                                              systemState.screenSize.height -
                                                  260.0.w;

                                          // 语音录制动画上的区域
                                          if (event.position.dy < svgTop) {
                                            double right =
                                                systemState.screenSize.width -
                                                    260.0.w;

                                            logger.info(
                                                "dddddddddddd${event.position.dx}");

                                            logger.info("fffffffffffff$right");

                                            setState(() {
                                              leftRight =
                                                  event.position.dx > right
                                                      ? 2
                                                      : 1;
                                            });

                                            setState(() {
                                              showCancelVoiceButtons = true;
                                            });

                                            // 手指滑动右边
                                            if (leftRight == 2) {
                                              if (_voiceLeftButtonColorController
                                                      .value ==
                                                  1) {
                                                _voiceLeftButtonColorController
                                                    .reset();
                                              }

                                              if (_voiceLeftButtonScaleController
                                                      .value ==
                                                  1) {
                                                _voiceLeftButtonScaleController
                                                    .reset();
                                              }

                                              if (!_voiceRightButtonColorController
                                                  .isAnimating) {
                                                _voiceRightButtonColorController
                                                    .forward();
                                              }

                                              if (!_voiceRightButtonScaleController
                                                  .isAnimating) {
                                                _voiceRightButtonScaleController
                                                    .forward();
                                              }

                                              if (!_voiceTextBoxController
                                                  .isAnimating) {
                                                _voiceTextBoxController
                                                    .forward();
                                              }
                                            } else {
                                              if (_voiceRightButtonColorController
                                                      .value ==
                                                  1) {
                                                _voiceRightButtonColorController
                                                    .reset();
                                              }
                                              if (_voiceRightButtonScaleController
                                                      .value ==
                                                  1) {
                                                _voiceRightButtonScaleController
                                                    .reset();
                                              }

                                              if (!_voiceLeftButtonColorController
                                                  .isAnimating) {
                                                _voiceLeftButtonColorController
                                                    .forward();
                                              }

                                              if (!_voiceLeftButtonScaleController
                                                  .isAnimating) {
                                                _voiceLeftButtonScaleController
                                                    .forward();
                                              }

                                              if (!_voiceTextBoxController
                                                  .isAnimating) {
                                                _voiceTextBoxController
                                                    .reverse();
                                              }
                                            }
                                          } else {
                                            _voiceLeftButtonColorController
                                                .value = 0;
                                            _voiceLeftButtonScaleController
                                                .value = 0;
                                            _voiceRightButtonColorController
                                                .value = 0;
                                            _voiceRightButtonScaleController
                                                .value = 0;

                                            _voiceTextBoxController.value = 0;

                                            setState(() {
                                              showCancelVoiceButtons = false;

                                              leftRight = 0;
                                            });
                                          }
                                        },
                                        onPointerUp: (PointerUpEvent event) {
                                          _voiceButtonUp();
                                        },
                                        onPointerCancel:
                                            (PointerCancelEvent event) {
                                          _voiceButtonUp();
                                        },
                                        child: Container(
                                          height: 77.w,
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            color: AppColors.neutralWhite,
                                            borderRadius:
                                                BorderRadius.circular(8.w),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .holdToTalk,
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
                                          padding: const EdgeInsets.only(
                                                  top: 16, bottom: 16)
                                              .w,
                                          child: TextField(
                                            readOnly: false,
                                            autofocus: false,
                                            showCursor: true,
                                            keyboardType: keyboardType,
                                            controller: inputController,
                                            focusNode: inputFocusNode,
                                            onTap: () {
                                              logger.info(
                                                  "showEmojiSelector: $showEmojiSelector");
                                              logger.info(
                                                  "showKeyboard: $showKeyboard");

                                              if (showEmojiSelector == false &&
                                                  showKeyboard == false) {
                                                showKeyboardFunc();
                                              } else if (showEmojiSelector ==
                                                      true &&
                                                  showKeyboard == false) {
                                                switchKeyboradFunc();
                                              }
                                            },
                                            cursorColor: const Color.fromRGBO(
                                                62, 174, 86, 1.0),
                                            // cursorHeight: 44.w,
                                            cursorWidth: 3.w,
                                            style: TextStyle(
                                                // height: 1.08,
                                                fontSize: fontSizeScale(30.w),
                                                color: Theme.of(context).colorScheme.onSurface),
                                            // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w),),
                                            maxLines: 5,
                                            minLines: 1,
                                            onChanged: (newText) {
                                              inputController.value =
                                                  inputController.value
                                                      .copyWith(
                                                text: newText,
                                                selection:
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: newText.length),
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
                                                _animationController.forward();
                                              }
                                            },
                                            decoration: InputDecoration(
                                              fillColor: AppColors.neutralWhite,
                                              filled: true,
                                              // focusColor: AppColors.accentRedPure,
                                              hoverColor:
                                                  AppColors.neutralWhite,
                                              isCollapsed: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                          vertical: 14,
                                                          horizontal: 16)
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
                                          ))
                                      // 经调查 C:\flutter\packages\flutter\lib\src\widgets\editable_text.dart  4239行控制必须得到焦点才显示光标
                                      ),

                              // 笑脸按钮
                              GestureDetector(
                                onTap: () {
                                  logger.info(
                                      "showEmojiSelector: $showEmojiSelector  showKeyboard: $showKeyboard");

                                  if (showEmojiSelector == false &&
                                      showKeyboard == false) {
                                    showEmojiFunc(
                                        _emojiPanelAnimationContentController
                                                .isAnimating
                                            ? _emojiPanelAnimationContentController
                                                .value
                                            : 0);
                                  } else if (showEmojiSelector == false &&
                                      showKeyboard == true) {
                                    switchEmojiFunc();
                                  } else if (showEmojiSelector == true &&
                                      showKeyboard == false) {
                                    logger.info("aaaaaa 切换到键盘");
                                    switchKeyboradFunc();
                                  }
                                },
                                child: Container(
                                  color: AppColors.transparent,
                                  width: 102.w,
                                  height: 107.w,
                                  padding:
                                      EdgeInsets.only(left: 20.w, right: 25.w),
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
                                          var message = inputController.text;

                                          // 发送消息
                                          messageList.add(
                                            LJNMyMessage(
                                              message: message.trimRight(),
                                              name: context
                                                  .read<LJNUserCubit>()
                                                  .state
                                                  .userinfoName as String,
                                              showName: false,
                                            ),
                                          );
                                          inputController.text = "";

                                          // 发送消息后滚动到底部
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            _scrollToEnd();
                                          });
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            // top: 16.w,
                                            bottom: 24.w,
                                            right: 15.w),
                                        width: _widthAnimation.value,
                                        height: 60.w,
                                        decoration: BoxDecoration(
                                          color: _colorAnimation.value!,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.w),
                                          ),
                                        ),
                                        child: _widthAnimation.value >= 113.w
                                            ? Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .send,
                                                  style: TextStyle(
                                                      height: 1.08,
                                                      fontSize:
                                                          fontSizeScale(27.w),
                                                      color: AppColors
                                                          .neutralWhite),
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  );
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
                                    color: AppColors.transparent,
                                    width: 87.w,
                                    height: 107.w,
                                    padding: EdgeInsets.only(right: 20.w),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      const IconData(
                                        0xe726,
                                        fontFamily: 'Iconfont',
                                      ),
                                      size: 57.w, // 图标大小
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      // 图标选择器
                      AnimatedBuilder(
                        animation: _emojiPanelAnimationContentController,
                        builder: (context, child) {
                          return Expanded(
                            flex: 0,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: _keyboradAnimation.value,
                                // color: AppColors.accentRedPure,
                                child: showEmojiSelector
                                    ? const LJNChatEmojiSelector()
                                    : null),
                          );
                        },
                      ),
                    ],
                  ))
                ],
              ),

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
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      // padding: EdgeInsets.only(top: systemState.statusHeight),
                      child: // 图标选择器
                          AnimatedBuilder(
                        animation: Listenable.merge([
                          _voiceLottieController,
                          _voiceLeftButtonScaleController,
                          _voiceLeftButtonColorController,
                          _voiceRightButtonScaleController,
                          _voiceRightButtonColorController,
                          _voiceTextBoxController,
                        ]),
                        builder: (context, child) {
                          return Stack(
                            children: [
                              // 背景
                              Container(
                                color: AppColors.blackTransparent73,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              ),

                              // 动画
                              Lottie.asset(
                                assetPath('lotties/voicepop.json'),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
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
                                bottom: 116.w,
                                child: Icon(
                                  const IconData(
                                    0xe81d,
                                    fontFamily: 'Iconfont',
                                  ),
                                  color: AppColors.neutralGrey71,
                                  size: 50.w,
                                ),
                              ),

                              // 转文字和关闭按钮上面的文字上面的图案
                              leftRight != 0
                                  ? Positioned(
                                      left: 55.w,
                                      bottom: 618.w,
                                      child: SizedBox(
                                        width:
                                            _voiceTextBoxWidthAnimation.value,
                                        height:
                                            _voiceTextBoxHeightAnimation.value +
                                                10.w,
                                        child: Stack(
                                          children: [
                                            // 转换后的文字
                                            Container(
                                              width: _voiceTextBoxWidthAnimation
                                                  .value,
                                              height:
                                                  _voiceTextBoxHeightAnimation
                                                      .value,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(24.w),
                                                  ),
                                                  color: leftRight == 2
                                                      ? AppColors
                                                          .brandGreenLightest
                                                      : AppColors.accentRedPure),
                                              alignment: leftRight == 1
                                                  ? Alignment.center
                                                  : Alignment.topLeft,
                                              child: leftRight == 2
                                                  ? Stack(
                                                      children: [
                                                        // 转文字的内容
                                                        Container(
                                                          width:
                                                              _voiceTextBoxWidthAnimation
                                                                  .value,
                                                          height:
                                                              _voiceTextBoxHeightAnimation
                                                                  .value,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  30.w),
                                                          // color: Colors
                                                          //     .red,
                                                          child: Text(
                                                            "你好吗？......",
                                                            style: TextStyle(
                                                                fontSize: 30.w,
                                                                fontFamily:
                                                                    "AlibabaPuHuiTi"),
                                                          ),
                                                        ),

                                                        // 语音图标
                                                        Positioned(
                                                            right: 38.w,
                                                            bottom: 38.w,
                                                            child: Icon(
                                                              const IconData(
                                                                0xe85e,
                                                                fontFamily:
                                                                    'Iconfont',
                                                              ),
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  60, 60, 60),
                                                              size: 45.w,
                                                            ))
                                                      ],
                                                    )
                                                  : Icon(
                                                      const IconData(
                                                        0xe85e,
                                                        fontFamily: 'Iconfont',
                                                      ),
                                                      color: AppColors
                                                          .neutralDarkGrey17,
                                                      size: 45.w,
                                                    ),
                                            ),

                                            // 底下的图标
                                            Positioned(
                                              right:
                                                  _voiceTextBoxBottomIconRightAnimation
                                                      .value,
                                              bottom: 0.w,
                                              child: SizedBox(
                                                width: 38.w,
                                                height: 23.w,
                                                child: Icon(
                                                  const IconData(
                                                    0xe60a,
                                                    fontFamily: 'Iconfont',
                                                  ), // 使用的图标
                                                  color: leftRight == 2
                                                      ? AppColors
                                                          .brandGreenLightest
                                                      : AppColors.accentRedPure, // 图标颜色
                                                  size: 40.0.w, // 图标大小
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),

                              // 关闭按钮上面的文字
                              showCancelVoiceButtons
                                  ? Positioned(
                                      left: 0,
                                      bottom: 480.w,
                                      child: Container(
                                        width: 290.w,
                                        height: 30.w,
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .releaseToCancel,
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: "AlibabaPuHuiTi",
                                            height: 1.08,
                                            fontSize: 29.w,
                                            color: AppColors.neutralGrey52,
                                          ),
                                        ),
                                      ))
                                  : SizedBox(),

                              // 左边关闭按钮
                              Positioned(
                                left: 75.w -
                                    ((135.w *
                                            (_voiceLeftButtonScaleAnimation
                                                    .value -
                                                1)) /
                                        2),
                                bottom: 275.w -
                                    ((135.w *
                                            (_voiceLeftButtonScaleAnimation
                                                    .value -
                                                1)) /
                                        2) +
                                    (_voiceLottieController.value < 0.5
                                            ? 0.5
                                            : _voiceLottieController.value) *
                                        30.w,
                                child: Transform.rotate(
                                  angle: -8 * (pi / 180),
                                  origin: Offset.zero,
                                  child: Opacity(
                                    opacity: 0.5 +
                                        _voiceLottieController.value * 0.5,
                                    child: Container(
                                      width: 135.w *
                                          _voiceLeftButtonScaleAnimation.value,
                                      height: 135.w *
                                          _voiceLeftButtonScaleAnimation.value,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _voiceLeftButtonColorAnimation
                                            .value,
                                        borderRadius: BorderRadius.circular(
                                            135.w), // 圆角半径
                                      ),
                                      child: Icon(
                                        const IconData(
                                          0xe628,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: showCancelVoiceButtons
                                            ? Theme.of(context).colorScheme.onSurface
                                            : AppColors.neutralGrey62,
                                        size: 43.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // 松开发送
                              Positioned(
                                bottom:
                                    270.w + _voiceLottieController.value * 30.w,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.releaseToSend,
                                    style: TextStyle(
                                        height: 1.08,
                                        color: AppColors.neutralGrey43,
                                        fontSize: 30.w,
                                        fontFamily: "AlibabaPuHuiTi",
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),

                              // 转文字按钮上面的文字
                              showCancelVoiceButtons
                                  ? Positioned(
                                      right: 0,
                                      bottom: 480.w,
                                      child: Container(
                                        width: 290.w,
                                        height: 30.w,
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .convertToText,
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: "AlibabaPuHuiTi",
                                            height: 1.08,
                                            fontSize: 29.w,
                                            color: AppColors.neutralGrey52,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),

                              // 右边转文字按钮
                              Positioned(
                                right: 75.w -
                                    ((135.w *
                                            (_voiceRightButtonScaleAnimation
                                                    .value -
                                                1)) /
                                        2),
                                bottom: 275.w -
                                    ((135.w *
                                            (_voiceRightButtonScaleAnimation
                                                    .value -
                                                1)) /
                                        2) +
                                    (_voiceLottieController.value < 0.5
                                            ? 0.5
                                            : _voiceLottieController.value) *
                                        30.w,
                                child: Transform.rotate(
                                  angle: 8 * (pi / 180),
                                  origin: Offset.zero,
                                  child: Opacity(
                                    opacity: 0.5 +
                                        _voiceLottieController.value * 0.5,
                                    child: Container(
                                      width: 135.w *
                                          _voiceRightButtonScaleAnimation.value,
                                      height: 135.w *
                                          _voiceRightButtonScaleAnimation.value,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _voiceRightButtonColorAnimation
                                            .value,
                                        borderRadius: BorderRadius.circular(
                                            135.w), // 圆角半径
                                      ),
                                      child: Icon(
                                        const IconData(
                                          0xe629,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: showCancelVoiceButtons
                                            ? Theme.of(context).colorScheme.onSurface
                                            : AppColors.neutralGrey62,
                                        size: 43.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : SizedBox()
            ],
          ),
        );
      },
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
