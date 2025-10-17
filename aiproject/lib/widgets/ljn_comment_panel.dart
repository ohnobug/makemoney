// G:\t\detection\aiproject\lib\widgets\ljn_comment_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 评论数据模型
class CommentData {
  final String username;
  final String avatarUrl;
  final String content;
  final String timestamp;
  final String location;
  final int likes;
  final String? imageUrl;

  CommentData({
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.timestamp,
    required this.location,
    required this.likes,
    this.imageUrl,
  });
}

// 可重用的评论面板组件
class LJNCommentPanel extends StatefulWidget {
  final List<CommentData> comments;
  final VoidCallback? onClose;
  final ValueChanged<String>? onSendComment;
  final double panelHeight;
  final bool showInput;

  const LJNCommentPanel({
    super.key,
    required this.comments,
    this.onClose,
    this.onSendComment,
    this.panelHeight = 800,
    this.showInput = true,
  });

  @override
  State<LJNCommentPanel> createState() => _LJNCommentPanelState();
}

class _LJNCommentPanelState extends State<LJNCommentPanel>
    with SingleTickerProviderStateMixin {
  final TextEditingController _commentController = TextEditingController();
  late AnimationController _animationController;

  double _currentHeight = 600;
  final double _minHeight = 300;
  final double _maxHeight = 800;
  final double _dismissThreshold = 100; // 拖动小于这个阈值自动收起

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.panelHeight.w;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _sendComment() {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      widget.onSendComment?.call(comment);
      _commentController.clear();
    }
  }

  void _animateToHeight(double targetHeight) {
    _animationController.reset();
    _animationController.forward().then((_) {
      _currentHeight = targetHeight;
      if (targetHeight <= _minHeight + _dismissThreshold) {
        // 自动收起
        widget.onClose?.call();
      }
    });
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    final newHeight = _currentHeight - details.delta.dy;
    if (newHeight >= _minHeight && newHeight <= _maxHeight) {
      setState(() {
        _currentHeight = newHeight;
      });
    }
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    // 根据拖动结束时的速度和位置决定最终高度
    final velocity = details.velocity.pixelsPerSecond.dy;

    if (velocity > 500) {
      // 快速向下拖动，收起
      _animateToHeight(_minHeight);
    } else if (velocity < -500) {
      // 快速向上拖动，展开
      _animateToHeight(_maxHeight);
    } else {
      // 根据当前位置决定
      if (_currentHeight < _minHeight + _dismissThreshold) {
        _animateToHeight(_minHeight);
      } else if (_currentHeight > _maxHeight - 100) {
        _animateToHeight(_maxHeight);
      } else {
        // 回到原始高度
        _animateToHeight(widget.panelHeight.w);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _currentHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              topRight: Radius.circular(20.w),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(51),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // 可拖动的顶部横线
              GestureDetector(
                onVerticalDragUpdate: _handleVerticalDragUpdate,
                onVerticalDragEnd: _handleVerticalDragEnd,
                child: Container(
                  height: 40.w,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Container(
                    width: 60.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                ),
              ),
              // 评论标题栏
              Container(
                height: 80.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '共 ${widget.comments.length} 条评论',
                      style: TextStyle(
                        fontSize: 32.w,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 40.w,
                        color: Colors.grey,
                      ),
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),
              // 评论列表
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.comments.length,
                  itemBuilder: (context, index) {
                    return _buildCommentItem(widget.comments[index]);
                  },
                ),
              ),
              // 评论输入框（可选）
              if (widget.showInput)
                Container(
                  height: 100.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(25.w),
                          ),
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: '说点什么...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 28.w,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8.w),
                            ),
                            style: TextStyle(
                              fontSize: 28.w,
                              color: Colors.black,
                            ),
                            onSubmitted: (_) => _sendComment(),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      GestureDetector(
                        onTap: _sendComment,
                        child: Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 40.w,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建单条评论
  Widget _buildCommentItem(CommentData data) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.w,
            backgroundImage: NetworkImage(data.avatarUrl),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.username,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 26.w,
                  ),
                ),
                SizedBox(height: 8.w),
                Text(
                  data.content,
                  style: TextStyle(
                    fontSize: 28.w,
                    color: Colors.black87,
                  ),
                ),
                if (data.imageUrl != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: Image.network(
                        data.imageUrl!,
                        height: 120.w,
                        width: 120.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(height: 8.w),
                Text(
                  '${data.timestamp} · ${data.location}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24.w,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            children: [
              Icon(
                Icons.favorite_border,
                color: Colors.grey,
                size: 30.w,
              ),
              SizedBox(height: 4.w),
              Text(
                data.likes.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
