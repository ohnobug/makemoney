// G:\t\detection\aiproject\lib\widgets\viga_comment_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_appbar_inner.dart';
import 'package:vigaviga/features/viewer/viga_photo_viewer_page.dart';
import 'viga_comment_input_page.dart';

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

class VigaCommentPanel extends StatefulWidget {
  final List<CommentData> comments;
  final VoidCallback? onClose;
  final bool showInput;
  final ScrollController? scrollController;
  final Function(String)? onCommentSubmitted;
  final SystemState systemState;

  const VigaCommentPanel({
    super.key,
    required this.comments,
    this.onClose,
    this.showInput = true,
    this.scrollController,
    this.onCommentSubmitted,
    required this.systemState,
  });

  @override
  State<VigaCommentPanel> createState() => _VigaCommentPanelState();
}

class _VigaCommentPanelState extends State<VigaCommentPanel> {
  final TextEditingController _commentController = TextEditingController();
  final Map<int, GlobalKey> _imageKeys = {};

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ListView.builder(
            controller: widget.scrollController,
            padding: EdgeInsets.only(
              top: widget.systemState.appbarHeight,
            ),
            itemBuilder: (context, index) {
              if (widget.comments.length == index) {
                return SizedBox(
                  height: 200.w,
                );
              } else {
                return _buildCommentItem(widget.comments[index]);
              }
            },
            itemCount: widget.comments.length + 1,
          ),

          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: PreferredSize(
                preferredSize: Size.fromHeight(widget.systemState.appbarHeight),
                child: Container(
                  color: theme.appBarTheme.backgroundColor,
                  height: widget.systemState.appbarHeight,
                  child: VigaAppBarInner(
                    context: context,
                    title: '共 ${widget.comments.length} 条评论',
                    leading: SizedBox(),
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 40.w,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: widget.onClose,
                      )
                    ],
                  ),
                ),
              )),

          // 输入框保持不变
          if (widget.showInput)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildCommentInput(),
            ),
        ],
      ),
    );
  }

  void _showCommentInputPage() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withAlpha(128),
      builder: (BuildContext context) {
        return VigaCommentInputPage(
          initialText: _commentController.text,
          onCommentSubmitted: (comment) {
            _commentController.clear();
            widget.onCommentSubmitted?.call(comment);
          },
        );
      },
    );
  }

  void _showImageViewer(String imageUrl, int index) {
    // 通过 key 获取图片在屏幕中的精确位置和大小
    final RenderBox? renderBox = _imageKeys[index]
        ?.currentContext
        ?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final initialRect = Rect.fromLTWH(
        position.dx, position.dy, size.width, size.height);

    Navigator.push(
      context,
      PageRouteBuilder(
        // 核心：页面本身不绘制背景，让路由的过渡动画处理
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) {
          return VigaPhotoViewerPage(
            imageSources: [imageUrl],
            initialIndex: 0,
            initialRect: initialRect, // 传递精确的初始位置
          );
        },
        // 使用路由自带的动画来实现背景的淡入淡出，这是最稳定可靠的方式
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          // animation 由路由管理, push时 0->1, pop时 1->0
          // 我们用它来包裹整个查看器页面，实现完美的淡入淡出
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(25.w, 15.w, 25.w, 25.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _showCommentInputPage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _commentController.text.isEmpty
                              ? '留下你的精彩评论...'
                              : _commentController.text,
                          style: TextStyle(
                            fontSize: 28.w,
                            color: _commentController.text.isEmpty
                                ? Colors.grey.shade600
                                : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
    final index = widget.comments.indexOf(data);

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
                    child: GestureDetector(
                      onTap: () {
                        _showImageViewer(data.imageUrl!, index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: Hero(
                          tag: data.imageUrl!,
                          child: Image.network(data.imageUrl!,
                              height: 150.w, width: 150.w, fit: BoxFit.cover,
                              key: _imageKeys.putIfAbsent(index, () => GlobalKey())),
                        ),
                      ),
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
