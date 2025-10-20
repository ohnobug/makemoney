// G:\t\detection\aiproject\lib\widgets\ljn_comment_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 数据模型
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
  final bool showInput;
  final ScrollController? scrollController;

  const LJNCommentPanel({
    super.key,
    required this.comments,
    this.onClose,
    this.showInput = true,
    this.scrollController,
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
    // 根 Widget 负责所有装饰效果 (背景、圆角)
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // 1. 固定的头部
          _buildHeader(),
          const Divider(height: 1, color: Color(0xFFEFEFEF)),

          // 2. 伸缩的列表区域
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              padding: EdgeInsets.zero,
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                return _buildCommentItem(widget.comments[index]);
              },
            ),
          ),

          // 3. 固定的输入框
          if (widget.showInput) _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 48), // 占位
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: Text(
              '共 ${widget.comments.length} 条评论',
              style: TextStyle(
                fontSize: 30.w,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 40.w, color: Colors.grey.shade600),
            onPressed: widget.onClose,
          ),
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
