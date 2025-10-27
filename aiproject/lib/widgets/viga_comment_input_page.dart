// G:\t\detection\aiproject\lib\widgets\viga_comment_input_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation; // ✨ [ADDED] 用于平台检查

class VigaCommentInputPage extends StatefulWidget {
  final String? initialText;
  final Function(String)? onCommentSubmitted;

  const VigaCommentInputPage({
    super.key,
    this.initialText,
    this.onCommentSubmitted,
  });

  @override
  State<VigaCommentInputPage> createState() => _VigaCommentInputPageState();
}

class _VigaCommentInputPageState extends State<VigaCommentInputPage>
    with TickerProviderStateMixin {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEmojiPanelVisible = false;

  // 新增状态变量
  late AnimationController _panelAnimationController;
  double _currentBottomHeight = 0.0;
  double _targetBottomHeight = 0.0;
  bool _isAnimating = false;
  bool _isKeyboardVisible = false;
  double _maxKeyboardHeight = 0.0; // 记录历史键盘高度最大值

  // 常量定义
  static const double defaultEmojiPanelHeight = 500.0;

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      _commentController.text = widget.initialText!;
    }

    // 初始化动画控制器
    _panelAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450), // 调整为与键盘弹出时间匹配
    );

    // 监听动画控制器
    _panelAnimationController.addListener(() {
      if (!mounted) return;
      setState(() {
        // 使用插值计算当前高度
        final progress = _panelAnimationController.value;
        _currentBottomHeight = _targetBottomHeight * progress;
      });
    });

    _panelAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        setState(() {
          _isAnimating = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    _panelAnimationController.dispose();
    super.dispose();
  }

  /// 核心切换逻辑 - 切换到表情面板
  Future<void> _switchToEmojiPanel() async {
    if (_isAnimating) return;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // 使用历史键盘高度最大值作为起始高度
    final startHeight = _maxKeyboardHeight > 0 ? _maxKeyboardHeight : (keyboardHeight > 0 ? keyboardHeight : 0.0);
    final targetHeight = defaultEmojiPanelHeight.w;

    setState(() {
      _isAnimating = true;
      _isEmojiPanelVisible = true;
      _currentBottomHeight = startHeight;
      _targetBottomHeight = targetHeight;
      _isKeyboardVisible = false;
    });

    // 如果有键盘，收起键盘（与动画同步进行）
    if (keyboardHeight > 0) {
      _focusNode.unfocus();
    }

    // 开始动画 - 从历史最大键盘高度动画到表情面板高度
    _panelAnimationController.forward(from: 0.0);
  }

  /// 核心切换逻辑 - 切换到键盘
  Future<void> _switchToKeyboard() async {
    if (_isAnimating) return;

    // 使用历史键盘高度最大值作为目标高度
    final targetHeight = _maxKeyboardHeight > 0 ? _maxKeyboardHeight : 350.0;
    final startHeight = _currentBottomHeight;

    setState(() {
      _isAnimating = true;
      _isEmojiPanelVisible = false;
      _currentBottomHeight = startHeight;
      _targetBottomHeight = targetHeight;
      _isKeyboardVisible = true;
    });

    // 请求焦点显示键盘（与动画同步进行）
    _focusNode.requestFocus();

    // 开始动画
    await _panelAnimationController.forward(from: 0.0);

    if (!mounted) return;

    setState(() {
      _currentBottomHeight = 0.0;
      _targetBottomHeight = 0.0;
    });
  }

  /// 处理键盘高度变化
  void _handleKeyboardHeightChange() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // 更新键盘可见状态
    if (keyboardHeight > 0) {
      _isKeyboardVisible = true;
      // 记录历史键盘高度最大值
      if (keyboardHeight > _maxKeyboardHeight) {
        _maxKeyboardHeight = keyboardHeight;
      }
    } else if (!_isAnimating) {
      _isKeyboardVisible = false;
    }

    // 确保输入框始终有焦点
    if (!_focusNode.hasFocus && !_isEmojiPanelVisible) {
      _focusNode.requestFocus();
    }
  }

  /// ✨ [MODIFIED] 切换表情面板和键盘的核心逻辑
  Future<void> _onEmojiIconTapped() async {
    if (_isEmojiPanelVisible) {
      // 当前是表情 -> 切换到键盘
      await _switchToKeyboard();
    } else {
      // 当前是键盘 -> 切换到表情
      await _switchToEmojiPanel();
    }
  }

  void _submitComment() {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      widget.onCommentSubmitted?.call(comment);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // 获取键盘高度
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    // 处理键盘高度变化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleKeyboardHeightChange();
    });

    // 计算当前底部高度
    double currentBottomHeight = 0.0;
    if (_isEmojiPanelVisible) {
      currentBottomHeight = _currentBottomHeight;
    } else if (keyboardHeight > 0) {
      currentBottomHeight = keyboardHeight;
    } else if (_isAnimating && _isKeyboardVisible) {
      currentBottomHeight = _currentBottomHeight;
    }

    // ✨ [MODIFIED] 使用 WillPopScope 优化返回逻辑
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => {
        if (_isEmojiPanelVisible)
          {
            setState(() {
              _isEmojiPanelVisible = false;
            })
          }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.black.withAlpha(128),
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.transparent)),
                // ✨ [MODIFIED] 输入区域
                _buildInputArea(),
                // ✨ [MODIFIED] 底部区域 - 统一处理键盘和表情面板
                AnimatedContainer(
                  duration: const Duration(milliseconds: 450), // 调整为与键盘弹出时间匹配
                  height: currentBottomHeight,
                  child: Column(
                    children: [
                      // 表情面板
                      if (_isEmojiPanelVisible) _buildEmojiPanel(),
                      // 底部垫高
                      Expanded(
                        child: Container(
                          color: _isEmojiPanelVisible ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
        // ✨ [ADDED] 添加一个细微的顶部边框，在表情面板出现时更好看
        border:
            Border(top: BorderSide(color: Colors.grey.shade200, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.w, 15.w, 15.w, 15.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  focusNode: _focusNode,
                  maxLines: 5,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _submitComment(),
                  decoration: InputDecoration(
                    hintText: '留下你的精彩评论...',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 20.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.w),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              // --- 表情图标 ---
              GestureDetector(
                onTap: _onEmojiIconTapped,
                child: Container(
                  height: 80.w,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Icon(
                    _isEmojiPanelVisible
                        ? Icons.keyboard_alt_outlined
                        : Icons.emoji_emotions_outlined,
                    color: Colors.grey.shade600,
                    size: 50.w,
                  ),
                ),
              ),
              // --- 发送按钮 ---
              GestureDetector(
                onTap: _submitComment,
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✨ [MODIFIED] 构建表情面板的方法
  Widget _buildEmojiPanel() {
    return EmojiPicker(
      textEditingController: _commentController,
      config: Config(
        height: defaultEmojiPanelHeight.w,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
          columns: 8,
          backgroundColor: const Color(0xFFF2F2F2),
        ),
        categoryViewConfig: const CategoryViewConfig(
          backgroundColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColorSelected: Colors.blue,
        ),
        bottomActionBarConfig: const BottomActionBarConfig(
          enabled: false,
        ),
        searchViewConfig: SearchViewConfig(
          backgroundColor: const Color(0xFFF2F2F2),
          buttonIconColor: Colors.blue.shade100,
        ),
      ),
    );
  }
}
