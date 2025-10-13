import 'dart:async';
import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/api_manager/api.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_chat_function_selector_button.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_my_voice_message.dart';
import 'package:vigaviga/widgets/ljn_show_call_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/contract/chat/widgets/ljn_chat_emoji_selector.dart';
import 'package:vigaviga/store/ljn_popup_cubit.dart';
import 'package:vigaviga/store/ljn_user_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';
import 'widgets/ljn_my_message.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

enum PannelType {
  none,
  emojiSelector,
  keyboard,
  functionSelector,
  voiceButton,
}

class LJNChat extends StatefulWidget {
  const LJNChat({super.key, required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  State<LJNChat> createState() => _LJNChat();
}

class _LJNChat extends State<LJNChat>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  String message = "";

  // 显示加号
  bool showPlusIcon = true;

  // 显示图标选择器
  PannelType pannelType = PannelType.none;

  // 输入框控制器，一般用于获取文本、修改文本等
  TextEditingController inputController = TextEditingController();

  // 焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
  final FocusNode _inputFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<Color?> _colorAnimation;

  late AnimationController _emojiSelectorAnimationContentController;
  late Animation<double> _keyboradAnimation;

  bool showVoiceLottie = false;
  late final AnimationController _voiceLottieController;

  // 文本盒子控制器
  late final AnimationController _voiceTextBoxController;
  late final Animation<double> _voiceTextBoxHeightAnimation;
  late final Animation<double> _voiceTextBoxWidthAnimation;
  late final Animation<double> _voiceTextBoxBottomIconRightAnimation;

  List<Widget> messageList = [];

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

  // 显示满屏视频
  GlobalKey videoContainerKey = GlobalKey();

  Offset openPosition = const Offset(0, 0);
  Size openBoxSize = const Size(0, 0);
  String sourcePath = "";

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
        statusBarColor: Colors.transparent, // 设置状态栏透明
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

    // 初始化 _emojiSelectorAnimationContentController
    _emojiSelectorAnimationContentController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 50),
      vsync: this,
    );

    // 设置第一次打开的情况
    _keyboradAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(
        parent: _emojiSelectorAnimationContentController,
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

    setState(() {
      messageList = mockMessages(context, widget.icon, widget.title);
    });

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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _inputFocusNode.dispose();

    _emojiSelectorAnimationContentController.dispose();
    _animationController.dispose();

    // 录音长按后底部动画
    _voiceLottieController.dispose();

    // 隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      logger.info("切换到后台 showEmojiSelector: $pannelType");
    } else if (state == AppLifecycleState.resumed) {
      // 应用切换到前台
      logger.info("恢复到前台 showEmojiSelector: $pannelType");
      if (pannelType == PannelType.emojiSelector) {
        _showEmojiFunc();
      } else if (pannelType == PannelType.keyboard) {
        _showKeyboardFunc();
      }
    }
  }

  void pannelLog(String event) {
    logger.info(
        "zzzzzzzz event: $event showEmojiSelector:$pannelType keyboardType:$keyboardType");
  }

  // 切换到emoji面板
  void _gotoPositionEmojiPanel({
    required double begin,
    required double end,
    double? value,
    Duration? duration,
    VoidCallback? eachFrameScrollToEnd,
  }) {
    if (value == null) {
      _emojiSelectorAnimationContentController.reset();
    } else {
      _emojiSelectorAnimationContentController.value = value;
    }

    _keyboradAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _emojiSelectorAnimationContentController,
        curve: Curves.easeInOut,
      ),
    );

    if (eachFrameScrollToEnd != null) {
      _emojiSelectorAnimationContentController
          .addListener(eachFrameScrollToEnd);
    }

    // 设置动画状态监听器，确保动画完成时移除监听器
    _emojiSelectorAnimationContentController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (eachFrameScrollToEnd != null) {
          _emojiSelectorAnimationContentController
              .removeListener(eachFrameScrollToEnd);
        }
      }
    });

    // 表情面板打开
    _emojiSelectorAnimationContentController.animateTo(
      1,
      duration:
          duration ?? Duration(milliseconds: _showKeyboradDurationMilliseconds),
    );
  }

  // 键盘打开的状态下切换到其它键盘的时间
  final int _switchDurationMilliseconds = 300;

  // 显示完整键盘所需要的时长
  final int _showKeyboradDurationMilliseconds = 400;

  // 表情选择器高度
  // final double _emojiSelectorHeight = 675.w;
  final double _emojiSelectorHeight = 675.w;

  // 功能选择器高度
  // final double _functionSelectorHeight = 630.w;
  final double _functionSelectorHeight = 500.w;

  // 切换后模式等待时间
  final int _changeTypeMilliseconds = 50;

  // 释放重置大小 当键盘弹出或者收缩的时候
  bool _resizeToAvoidBottomInset = true;

  // 键盘高度
  EdgeInsets _viewInsets = EdgeInsets.all(0);

  // 记录最大的键盘高度
  EdgeInsets _maxInsets = EdgeInsets.all(0);

  // 显示键盘
  void _showKeyboardFunc() {
    logger.info("显示键盘");

    _inputFocusNode.unfocus();

    setState(() {
      _resizeToAvoidBottomInset = true;
      pannelType = PannelType.keyboard;
      keyboardType = TextInputType.text;
    });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.show');

      pannelLog('_showKeyboardFunc');
    });
  }

  // 隐藏键盘
  void _hideKeyboardFunc() {
    logger.info("隐藏键盘");

    setState(() {
      keyboardType = TextInputType.none;
      _resizeToAvoidBottomInset = true;
      pannelType = PannelType.none;
    });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('_hideKeyboardFunc');
    });
  }

  // 笑脸切换到键盘
  void _switchKeyboradFunc({double begin = 0, double end = 0}) {
    logger.info("转换到键盘");

    if (keyboardType != TextInputType.text) {
      _inputFocusNode.unfocus();
    }

    setState(() {
      keyboardType = TextInputType.text;
      _resizeToAvoidBottomInset = false;
      pannelType = PannelType.keyboard;
    });
    _gotoPositionEmojiPanel(
      begin: begin,
      end: end,
      value: 0,
      // 此处的3000毫秒是键盘第一次弹起来的时间
      duration: Duration(
          milliseconds:
              _maxInsets.bottom == 0 ? 3000 : _switchDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    logger.info("begin: $_emojiSelectorHeight     end: ${_maxInsets.bottom}");

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.show');

      //  等待键盘完成显示，将面板关掉
      Future.delayed(Duration(milliseconds: _showKeyboradDurationMilliseconds),
          () {
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
          _resizeToAvoidBottomInset = true;
          pannelType = PannelType.keyboard;
        });

        pannelLog('_switchKeyboradFunc');
      });
    });
  }

  // 键盘转换笑脸面板
  void _switchEmojiFunc({double begin = 0, double end = 0}) {
    logger.info("转换到笑脸");

    if (keyboardType != TextInputType.none) {
      _inputFocusNode.unfocus();
    }

    setState(() {
      keyboardType = TextInputType.none;
      _resizeToAvoidBottomInset = false;
      pannelType = PannelType.emojiSelector;
    });

    // viewInsets.bottom
    // _emojiSelectorHeight

    _gotoPositionEmojiPanel(
      begin: begin,
      end: end,
      value: 0,
      duration: Duration(milliseconds: _switchDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('_switchEmojiFunc');
    });
  }

  // 切换到功能选择面板
  void _switchFunctionSelector({double begin = 0, double end = 0}) {
    logger.info("转换到功能选择面板");

    if (keyboardType != TextInputType.none) {
      _inputFocusNode.unfocus();
    }

    setState(() {
      keyboardType = TextInputType.none;
      _resizeToAvoidBottomInset = false;
      pannelType = PannelType.functionSelector;
    });

    _gotoPositionEmojiPanel(
      begin: begin,
      end: end,
      value: 0,
      duration: Duration(milliseconds: _switchDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('_switchFunctionSelector');
    });
  }

  // 打开Emoji
  void _showEmojiFunc([double? value]) {
    logger.info("显示表情选择器");

    if (keyboardType == TextInputType.text) {
      _inputFocusNode.unfocus();
    }

    setState(() {
      // 显示图标选择器
      pannelType = PannelType.emojiSelector;
      keyboardType = TextInputType.none;
    });

    _gotoPositionEmojiPanel(
        begin: 0,
        end: _emojiSelectorHeight,
        duration: Duration(milliseconds: _showKeyboradDurationMilliseconds),
        eachFrameScrollToEnd: () {
          _scrollToEnd();
        });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('_showEmojiFunc');
    });
  }

  // 点击聊天界面 关闭Emoji
  void _hideEmojiFunc() {
    logger.info("隐藏表情选择器");

    _gotoPositionEmojiPanel(
      begin: _emojiSelectorHeight,
      end: 0,
      duration: Duration(milliseconds: _showKeyboradDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    setState(() {
      pannelType = PannelType.none;
      keyboardType = TextInputType.text;
    });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      pannelLog('_hideEmojiFunc');
    });
  }

  // 打开功能面板
  void _showFunctionSelector([double? value]) {
    logger.info("显示功能选择器");

    if (keyboardType == TextInputType.text) {
      _inputFocusNode.unfocus();
    }

    setState(() {
      // 显示图标选择器
      pannelType = PannelType.functionSelector;
      keyboardType = TextInputType.none;
    });

    _gotoPositionEmojiPanel(
        begin: 0,
        end: _functionSelectorHeight,
        duration: Duration(milliseconds: _showKeyboradDurationMilliseconds),
        eachFrameScrollToEnd: () {
          _scrollToEnd();
        });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      pannelLog('_showFunctionSelector');
    });
  }

  // 关闭功能面板
  void _hideFunctionSelector() {
    logger.info("隐藏功能选择器");

    _gotoPositionEmojiPanel(
      begin: _emojiSelectorHeight,
      end: 0,
      duration: Duration(milliseconds: _showKeyboradDurationMilliseconds),
      eachFrameScrollToEnd: () {
        _scrollToEnd();
      },
    );

    setState(() {
      pannelType = PannelType.none;
      keyboardType = TextInputType.text;
    });

    Future.delayed(Duration(milliseconds: _changeTypeMilliseconds), () {
      _inputFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      pannelLog('_hideFunctionSelector');
    });
  }

  // 按住录制按钮的震动
  Future<void> _triggerVibration() async {
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

  // 更新键盘最大值
  void _updateMaxInsets(EdgeInsets newInsets) {
    _maxInsets = EdgeInsets.only(
      top: max(_maxInsets.top, newInsets.top),
      left: max(_maxInsets.left, newInsets.left),
      right: max(_maxInsets.right, newInsets.right),
      bottom: max(_maxInsets.bottom, newInsets.bottom),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    _viewInsets = MediaQuery.of(context).viewInsets;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMaxInsets(_viewInsets);
      _scrollToEnd();
    });

    AppLocalizations l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (context.read<LJNPopupCubit>().state.showFullScreenVideo == true ||
            context.read<LJNPopupCubit>().state.showFullScreenImage == true) {
          context.read<LJNPopupCubit>().updateReturnButtonEvent(true);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
          return Scaffold(
            // 是否在键盘弹出时调整布局（避免被键盘遮挡）。
            resizeToAvoidBottomInset: _resizeToAvoidBottomInset,
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
                              '/chat/friend_message_record',
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

                    // 主体
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // 聊天信息
                          Expanded(
                            flex: 1,
                            child: ColoredBox(
                              color: colorScheme.surfaceContainer,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(scrollbars: false),
                                child: GestureDetector(
                                  onTap: () {
                                    if (pannelType ==
                                        PannelType.emojiSelector) {
                                      _hideEmojiFunc();
                                    } else if (pannelType ==
                                        PannelType.functionSelector) {
                                      _hideFunctionSelector();
                                    } else if (pannelType ==
                                        PannelType.keyboard) {
                                      _hideKeyboardFunc();
                                    }
                                  },
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      top: 30.w,
                                      bottom: 30.w,
                                    ),
                                    controller: _scrollController,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
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
                              width: systemState.screenSize.width,
                              // margin: EdgeInsets.only(bottom: inputMarginBottom),
                              decoration: BoxDecoration(
                                color: AppColors.neutralGrey2,
                                border: Border(
                                  top: BorderSide(
                                    color: theme.dividerColor,
                                    width: 1.0.w,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                    pannelType == PannelType.voiceButton
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.end,
                                children: [
                                  // 语音按钮
                                  GestureDetector(
                                    onTap: () {
                                      if (pannelType ==
                                          PannelType.emojiSelector) {
                                        _hideEmojiFunc();
                                      } else if (pannelType ==
                                          PannelType.keyboard) {
                                        _hideKeyboardFunc();
                                      } else if (pannelType ==
                                          PannelType.functionSelector) {
                                        _hideFunctionSelector();
                                      }

                                      setState(() {
                                        pannelType =
                                            pannelType == PannelType.none
                                                ? PannelType.voiceButton
                                                : PannelType.none;
                                      });

                                      if (pannelType !=
                                          PannelType.voiceButton) {
                                        _showKeyboardFunc();
                                      }
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      width: 97.w,
                                      height: 107.w,
                                      padding: EdgeInsets.only(
                                        left: 20.w,
                                        right: 20.w,
                                      ),
                                      child: Icon(
                                        const IconData(
                                          0xe66c,
                                          fontFamily: 'Iconfont',
                                        ),
                                        size: 56.w, // 图标大小
                                      ),
                                    ),
                                  ),

                                  pannelType == PannelType.voiceButton
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
                                              _triggerVibration();

                                              if (!_voiceLottieController
                                                  .isAnimating) {
                                                _voiceLottieController
                                                    .forward();
                                              }

                                              record = AudioRecorder();

                                              // 拼接本地存储的文件路径
                                              wmaPath = await getWMAFilePath();

                                              logger.info("开始录音 $wmaPath");

                                              if (await record!
                                                  .hasPermission()) {
                                                record!.stop();
                                                record!.cancel();

                                                beginRecordTime =
                                                    DateTime.now();

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
                                              double svgTop = systemState
                                                      .screenSize.height -
                                                  260.0.w;

                                              // 语音录制动画上的区域
                                              if (event.position.dy < svgTop) {
                                                double right = systemState
                                                        .screenSize.width -
                                                    260.0.w;

                                                logger.info(
                                                    "dddddddddddd${event.position.dx}");

                                                logger.info(
                                                    "fffffffffffff$right");

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

                                                _voiceTextBoxController.value =
                                                    0;

                                                setState(() {
                                                  showCancelVoiceButtons =
                                                      false;

                                                  leftRight = 0;
                                                });
                                              }
                                            },
                                            onPointerUp:
                                                (PointerUpEvent event) {
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
                                                l10n.holdToTalk,
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
                                                focusNode: _inputFocusNode,
                                                onTap: () {
                                                  if (pannelType ==
                                                      PannelType.none) {
                                                    _showKeyboardFunc();
                                                  } else if (pannelType ==
                                                      PannelType
                                                          .emojiSelector) {
                                                    _switchKeyboradFunc(
                                                        begin:
                                                            _emojiSelectorHeight,
                                                        end: _maxInsets.bottom);
                                                  } else if (pannelType ==
                                                      PannelType
                                                          .functionSelector) {
                                                    _switchKeyboradFunc(
                                                        begin:
                                                            _functionSelectorHeight,
                                                        end: _maxInsets.bottom);
                                                  }
                                                },
                                                cursorColor:
                                                    const Color.fromRGBO(
                                                        62, 174, 86, 1.0),
                                                // cursorHeight: 44.w,
                                                cursorWidth: 3.w,
                                                style: TextStyle(
                                                  // height: 1.08,
                                                  fontSize: fontSizeScale(30.w),
                                                  color: colorScheme.onSurface,
                                                ),
                                                // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w),),
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
                                                          offset:
                                                              newText.length),
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
                                                  fillColor:
                                                      AppColors.neutralWhite,
                                                  filled: true,
                                                  // focusColor: AppColors.accentRedPure,
                                                  hoverColor:
                                                      AppColors.neutralWhite,
                                                  isCollapsed: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 19,
                                                    horizontal: 16,
                                                  ).w,
                                                  border:
                                                      const OutlineInputBorder(
                                                    gapPadding: 0,
                                                    borderSide: BorderSide.none,
                                                  ),
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
                                      if (pannelType == PannelType.none) {
                                        _showEmojiFunc(
                                            _emojiSelectorAnimationContentController
                                                    .isAnimating
                                                ? _emojiSelectorAnimationContentController
                                                    .value
                                                : 0);
                                      } else if (pannelType ==
                                          PannelType.voiceButton) {
                                        _showEmojiFunc(
                                            _emojiSelectorAnimationContentController
                                                    .isAnimating
                                                ? _emojiSelectorAnimationContentController
                                                    .value
                                                : 0);
                                      } else if (pannelType ==
                                          PannelType.keyboard) {
                                        _switchEmojiFunc(
                                            begin: _maxInsets.bottom,
                                            end: _emojiSelectorHeight);
                                      } else if (pannelType ==
                                          PannelType.functionSelector) {
                                        _switchEmojiFunc(
                                            begin: _functionSelectorHeight,
                                            end: _emojiSelectorHeight);
                                      } else if (pannelType ==
                                          PannelType.emojiSelector) {
                                        _switchKeyboradFunc(
                                            begin: _emojiSelectorHeight,
                                            end: _maxInsets.bottom);
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
                                            child: _widthAnimation.value >=
                                                    113.w
                                                ? Center(
                                                    child: Text(
                                                      l10n.send,
                                                      style: TextStyle(
                                                        height: 1.08,
                                                        fontSize:
                                                            fontSizeScale(27.w),
                                                        color: AppColors
                                                            .neutralWhite,
                                                      ),
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
                                        if (pannelType == PannelType.none) {
                                          _showFunctionSelector(
                                            _emojiSelectorAnimationContentController
                                                    .isAnimating
                                                ? _emojiSelectorAnimationContentController
                                                    .value
                                                : 0,
                                          );
                                        } else if (pannelType ==
                                            PannelType.voiceButton) {
                                          _showFunctionSelector(
                                            _emojiSelectorAnimationContentController
                                                    .isAnimating
                                                ? _emojiSelectorAnimationContentController
                                                    .value
                                                : 0,
                                          );
                                        } else if (pannelType ==
                                            PannelType.keyboard) {
                                          _switchFunctionSelector(
                                            begin: _maxInsets.bottom,
                                            end: _functionSelectorHeight,
                                          );
                                        } else if (pannelType ==
                                            PannelType.emojiSelector) {
                                          _switchFunctionSelector(
                                            begin: _emojiSelectorHeight,
                                            end: _functionSelectorHeight,
                                          );
                                        } else if (pannelType ==
                                            PannelType.functionSelector) {
                                          _switchKeyboradFunc(
                                            begin: _functionSelectorHeight,
                                            end: _maxInsets.bottom,
                                          );
                                        }
                                      },
                                      child: Container(
                                        color: Colors.transparent,
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

                          // 功能、图标选择器
                          AnimatedBuilder(
                            animation: _emojiSelectorAnimationContentController,
                            builder: (context, child) {
                              return Expanded(
                                flex: 0,
                                child: SizedBox(
                                  width: systemState.screenSize.width,
                                  height: _keyboradAnimation.value,
                                  // color: AppColors.accentRedPure,
                                  child: pannelType == PannelType.emojiSelector
                                      ? const LJNChatEmojiSelector()
                                      : pannelType ==
                                              PannelType.functionSelector
                                          ? _buildChatFunctionSelector(
                                              systemState)
                                          : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // 语音消息
                if (showVoiceLottie) _buildVoiceWidget(systemState),
              ],
            ),
          );
        },
      ),
    );
  }

  // 功能选择器组件
  Widget _buildChatFunctionSelector(SystemState systemState) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return Container(
      width: systemState.screenSize.width,
      padding: EdgeInsets.only(top: 45.w),
      decoration: BoxDecoration(
        color: AppColors.neutralGrey2,
        border: Border(
          top: BorderSide(
            color: theme.dividerColor,
            width: 1.0.w,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Wrap(
        // spacing: 63.w,
        children: [
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.album,
            icon: Icon(
              const IconData(
                0xe6ba,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("相册");
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.camera,
            icon: Icon(
              const IconData(
                0xe6bb,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("拍摄");
              Navigator.pushNamed(
                context,
                '/user/camera',
              );
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.videoCall,
            icon: Icon(
              const IconData(
                0xe64f,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("视频通话");
              showCallPopup(context, systemState);
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.location,
            icon: Icon(
              const IconData(
                0xe630,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("位置");
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.redPacket,
            icon: Icon(
              const IconData(
                0xe6c6,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("红包");
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.gift,
            icon: Icon(
              const IconData(
                0xe62e,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("礼物");
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.transfer,
            icon: Icon(
              const IconData(
                0xe631,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("转账");
            },
          ),
          LJNFunctionSelectorButton(
            systemState: systemState,
            title: l10n.voiceInput,
            icon: Icon(
              const IconData(
                0xe632,
                fontFamily: 'Iconfont',
              ),
              color: AppColors.neutralNearBlack1,
              size: 52.w,
            ),
            onTap: () {
              logger.info("语音输入");
            },
          )
        ],
      ),
    );
  }

  // 按住语音时候的效果
  Widget _buildVoiceWidget(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: systemState.screenSize.width,
      height: systemState.screenSize.height,
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
                width: systemState.screenSize.width,
                height: systemState.screenSize.height,
              ),

              // 动画
              Lottie.asset(
                assetPath('lotties/voicepop.json'),
                width: systemState.screenSize.width,
                height: systemState.screenSize.height,
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
                        width: _voiceTextBoxWidthAnimation.value,
                        height: _voiceTextBoxHeightAnimation.value + 10.w,
                        child: Stack(
                          children: [
                            // 转换后的文字
                            Container(
                              width: _voiceTextBoxWidthAnimation.value,
                              height: _voiceTextBoxHeightAnimation.value,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.w),
                                ),
                                color: leftRight == 2
                                    ? AppColors.brandGreenLightest
                                    : AppColors.accentRedPure,
                              ),
                              alignment: leftRight == 1
                                  ? Alignment.center
                                  : Alignment.topLeft,
                              child: leftRight == 2
                                  ? Stack(
                                      children: [
                                        // 转文字的内容
                                        Container(
                                          width:
                                              _voiceTextBoxWidthAnimation.value,
                                          height: _voiceTextBoxHeightAnimation
                                              .value,
                                          padding: EdgeInsets.all(30.w),
                                          // color: Colors
                                          //     .red,
                                          child: Text(
                                            "你好吗？......",
                                            style: TextStyle(
                                                fontSize: 30.w,
                                                fontFamily: "AlibabaPuHuiTi"),
                                          ),
                                        ),

                                        // 语音图标
                                        Positioned(
                                          right: 38.w,
                                          bottom: 38.w,
                                          child: Icon(
                                            const IconData(
                                              0xe85e,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: AppColors.neutralDarkGrey17,
                                            size: 45.w,
                                          ),
                                        )
                                      ],
                                    )
                                  : Icon(
                                      const IconData(
                                        0xe85e,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: AppColors.neutralDarkGrey17,
                                      size: 45.w,
                                    ),
                            ),

                            // 底下的图标
                            Positioned(
                              right:
                                  _voiceTextBoxBottomIconRightAnimation.value,
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
                                      ? AppColors.brandGreenLightest
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
                          l10n.releaseToCancel,
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

              // 左边关闭按钮
              Positioned(
                left: 75.w -
                    ((135.w * (_voiceLeftButtonScaleAnimation.value - 1)) / 2),
                bottom: 275.w -
                    ((135.w * (_voiceLeftButtonScaleAnimation.value - 1)) / 2) +
                    (_voiceLottieController.value < 0.5
                            ? 0.5
                            : _voiceLottieController.value) *
                        30.w,
                child: Transform.rotate(
                  angle: -8 * (pi / 180),
                  origin: Offset.zero,
                  child: Opacity(
                    opacity: 0.5 + _voiceLottieController.value * 0.5,
                    child: Container(
                      width: 135.w * _voiceLeftButtonScaleAnimation.value,
                      height: 135.w * _voiceLeftButtonScaleAnimation.value,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _voiceLeftButtonColorAnimation.value,
                        borderRadius: BorderRadius.circular(135.w), // 圆角半径
                      ),
                      child: Icon(
                        const IconData(
                          0xe628,
                          fontFamily: 'Iconfont',
                        ),
                        color: showCancelVoiceButtons
                            ? colorScheme.onSurface
                            : AppColors.neutralGrey62,
                        size: 43.w,
                      ),
                    ),
                  ),
                ),
              ),

              // 松开发送
              Positioned(
                bottom: 270.w + _voiceLottieController.value * 30.w,
                child: Container(
                  width: systemState.screenSize.width,
                  alignment: Alignment.center,
                  child: Text(
                    l10n.releaseToSend,
                    style: TextStyle(
                      height: 1.08,
                      color: AppColors.neutralGrey43,
                      fontSize: 30.w,
                      fontFamily: "AlibabaPuHuiTi",
                      decoration: TextDecoration.none,
                    ),
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
                          l10n.convertToText,
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
                    ((135.w * (_voiceRightButtonScaleAnimation.value - 1)) / 2),
                bottom: 275.w -
                    ((135.w * (_voiceRightButtonScaleAnimation.value - 1)) /
                        2) +
                    (_voiceLottieController.value < 0.5
                            ? 0.5
                            : _voiceLottieController.value) *
                        30.w,
                child: Transform.rotate(
                  angle: 8 * (pi / 180),
                  origin: Offset.zero,
                  child: Opacity(
                    opacity: 0.5 + _voiceLottieController.value * 0.5,
                    child: Container(
                      width: 135.w * _voiceRightButtonScaleAnimation.value,
                      height: 135.w * _voiceRightButtonScaleAnimation.value,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _voiceRightButtonColorAnimation.value,
                        borderRadius: BorderRadius.circular(135.w), // 圆角半径
                      ),
                      child: Icon(
                        const IconData(
                          0xe629,
                          fontFamily: 'Iconfont',
                        ),
                        color: showCancelVoiceButtons
                            ? colorScheme.onSurface
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
