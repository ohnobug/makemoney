// G:\t\detection\aiproject\lib\widgets\ljn_comment_input_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation; // ✨ [ADDED] 用于平台检查

class LJNCommentInputPage extends StatefulWidget {
  final String? initialText;
  final Function(String)? onCommentSubmitted;

  const LJNCommentInputPage({
    super.key,
    this.initialText,
    this.onCommentSubmitted,
  });

  @override
  State<LJNCommentInputPage> createState() => _LJNCommentInputPageState();
}

class _LJNCommentInputPageState extends State<LJNCommentInputPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEmojiPanelVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      _commentController.text = widget.initialText!;
    }

    // 当键盘弹出或收起时，如果此时表情面板是打开的，就关闭它
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _isEmojiPanelVisible) {
        setState(() {
          _isEmojiPanelVisible = false;
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
    super.dispose();
  }

  /// ✨ [ADDED] 切换表情面板和键盘的核心逻辑
  Future<void> _onEmojiIconTapped() async {
    if (_isEmojiPanelVisible) {
      // 当前是表情 -> 切换到键盘
      setState(() {
        _isEmojiPanelVisible = false;
      });
      // 延迟请求焦点以确保表情面板已收起
      await Future.delayed(const Duration(milliseconds: 100));
      _focusNode.requestFocus();
    } else {
      // 当前是键盘 -> 切换到表情
      // 如果键盘已经打开，先收起它
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        _focusNode.unfocus();
        // 等待键盘完全收起
        await Future.delayed(const Duration(milliseconds: 100));
      }
      setState(() {
        _isEmojiPanelVisible = true;
      });
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
                // ✨ [MODIFIED] 将输入区域和表情面板包裹在一个Column中
                Container(
                  color: Colors.white, // 设置背景色以覆盖表情面板
                  child: Column(
                    children: [
                      _buildInputArea(),
                      _buildEmojiPanel(),
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

  /// ✨ [MODIFIED] 构建表情面板的方法，使用 Offstage 和最新的 EmojiPicker 配置
  Widget _buildEmojiPanel() {
    return Offstage(
      offstage: !_isEmojiPanelVisible,
      child: SizedBox(
        height: 400.w, // 固定一个合适的高度
        child: EmojiPicker(
          textEditingController: _commentController, // ✨ 关键改动：直接关联控制器
          config: Config(
            height: 400.w,
            checkPlatformCompatibility: true,
            // ✨ 优化UI，使其更适合应用
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
              enabled: false, // 官方示例默认开启了底部栏，这里可以关闭
            ),
            searchViewConfig: SearchViewConfig(
              backgroundColor: const Color(0xFFF2F2F2),
              buttonIconColor: Colors.blue.shade100,
            ),
          ),
        ),
      ),
    );
  }
}
