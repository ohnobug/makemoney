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
    return Column(
      children: [
        Expanded(
          child: ColoredBox(
            color: Colors.white,
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                // 🚀 [核心修正]: 使用 SliverAppBar 替代 SliverToBoxAdapter 来固定头部
                SliverAppBar(
                  // 关键属性：将 AppBar 固定在顶部
                  pinned: true,
                  // 移除 AppBar 左侧默认的返回按钮或空间
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0, // 移除默认阴影
                  // 当内容滚动到 AppBar 下方时，显示一个细微的阴影，增加层次感
                  scrolledUnderElevation: 0.5,
                  shadowColor: Colors.grey.shade300,
                  // titleSpacing: 0, // 如果需要完全自定义布局，可以移除默认间距

                  // 将标题内容放入 title 属性
                  title: Text(
                    '共 ${widget.comments.length} 条评论',
                    style: TextStyle(
                      fontSize: 30.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  centerTitle: true, // 标题居中

                  // 将关闭按钮放入 actions 列表
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 40.w,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: widget.onClose,
                    ),
                  ],

                  // 将分割线放入 bottom 属性，它也会被固定
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1.0),
                    child: Container(
                      color: const Color(0xFFEFEFEF),
                      height: 1.0,
                    ),
                  ),
                ),

                // 评论列表部分保持不变
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildCommentItem(widget.comments[index]);
                    },
                    childCount: widget.comments.length,
                  ),
                ),
              ],
            ),
          ),
        ),

        // 输入框保持不变
        if (widget.showInput) _buildCommentInput(),
      ],
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
