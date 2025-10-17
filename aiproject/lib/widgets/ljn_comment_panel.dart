// G:\t\detection\aiproject\lib\widgets\ljn_comment_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 数据模型（通常会放在独立的文件中）
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

class LJNCommentPanel extends StatefulWidget {
  final List<CommentData> comments;
  final VoidCallback? onClose;
  final double panelHeight;
  final bool showInput;

  // [新增] 用于处理下拉关闭的回调
  final ValueChanged<double>? onOverScroll;
  final VoidCallback? onOverScrollEnd;

  const LJNCommentPanel({
    super.key,
    required this.comments,
    this.onClose,
    required this.panelHeight,
    this.showInput = true,
    this.onOverScroll,
    this.onOverScrollEnd,
  });

  @override
  State<LJNCommentPanel> createState() => _LJNCommentPanelState();
}

class _LJNCommentPanelState extends State<LJNCommentPanel> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.panelHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      clipBehavior: Clip.antiAlias, // 确保子元素不会超出圆角边界
      child: Column(
        children: [
          // 评论标题栏
          Container(
            height: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(), // 占位，使标题居中
                Text(
                  '共 ${widget.comments.length} 条评论',
                  style: TextStyle(
                    fontSize: 30.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close,
                      size: 40.w, color: Colors.grey.shade600),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEFEFEF)),

          // 评论列表
          Expanded(
            // [核心交互] 使用 NotificationListener 监听列表滚动
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // 当用户拖动列表时
                if (notification is ScrollUpdateNotification) {
                  // 如果列表在顶部，并且用户继续向下拖动（overscroll）
                  if (notification.metrics.pixels < 0) {
                    // 通知主页面发生了拖动，并传递拖动的距离
                    widget.onOverScroll?.call(notification.scrollDelta ?? 0);
                    // 返回 true，阻止列表本身产生 overscroll 效果（如蓝色辉光）
                    return true;
                  }
                }
                // 当用户停止拖动时
                else if (notification is ScrollEndNotification) {
                  // 如果是在 overscroll 状态下停止的
                  if (notification.metrics.pixels < 0) {
                    // 通知主页面拖动已结束
                    widget.onOverScrollEnd?.call();
                  }
                }
                // 返回 false，允许其他正常的滚动通知继续传递
                return false;
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.comments.length,
                itemBuilder: (context, index) {
                  return _buildCommentItem(widget.comments[index]);
                },
              ),
            ),
          ),

          // 评论输入框
          if (widget.showInput) _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(25.w, 15.w, 25.w, 25.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: '留下你的精彩评论...',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.w),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(CommentData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 35.w, backgroundImage: NetworkImage(data.avatarUrl)),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.username,
                    style: TextStyle(color: Colors.grey, fontSize: 26.w)),
                SizedBox(height: 8.w),
                Text(data.content,
                    style: TextStyle(fontSize: 28.w, color: Colors.black87)),
                if (data.imageUrl != null)
                  Padding(
                    padding: EdgeInsets.only(top: 12.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: Image.network(data.imageUrl!,
                          height: 150.w, width: 150.w, fit: BoxFit.cover),
                    ),
                  ),
                SizedBox(height: 12.w),
                Text('${data.timestamp} · ${data.location}',
                    style: TextStyle(color: Colors.grey, fontSize: 24.w)),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            children: [
              Icon(Icons.favorite_border, color: Colors.grey, size: 35.w),
              SizedBox(height: 4.w),
              Text(data.likes.toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 22.w)),
            ],
          ),
        ],
      ),
    );
  }
}
