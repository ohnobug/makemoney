import 'package:flutter/material.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/widgets/viga_comment_panel.dart';

// 详情页面数据模型
class PostDetailData {
  final String id;
  final String username;
  final String avatarUrl;
  final List<String> imageUrls;
  final String title;
  final List<String> tags;
  final String timestamp;
  final String location;
  final int likes;
  final int favorites;
  final int comments;
  final bool isFollowed;

  PostDetailData({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.imageUrls,
    required this.title,
    required this.tags,
    required this.timestamp,
    required this.location,
    required this.likes,
    required this.favorites,
    required this.comments,
    this.isFollowed = false,
  });
}


// 主页面 Widget
class VigaPostDetailPage extends StatefulWidget {
  final PostDetailData postData;

  const VigaPostDetailPage({
    super.key,
    required this.postData,
  });

  @override
  State<VigaPostDetailPage> createState() => _VigaPostDetailPageState();
}

class _VigaPostDetailPageState extends State<VigaPostDetailPage> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final List<CommentData> _comments = [];
  bool _isLoadingMore = false;
  bool _hasMoreComments = true;

  @override
  void initState() {
    super.initState();
    _loadInitialComments();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMoreComments();
    }
  }

  void _loadInitialComments() {
    // 模拟初始评论数据
    _comments.addAll([
      CommentData(
        username: '小红薯6514199C',
        avatarUrl: 'https://picsum.photos/seed/user2/100/100',
        content: '广州算接地气了，你看深圳。不过为啥粤语系城市的城中村都乱糟糟的，不论是广州，深圳还是香港都有点这种影子。',
        timestamp: '2小时前',
        location: '北京',
        likes: 20,
      ),
      CommentData(
        username: '高能小作坊',
        avatarUrl: 'https://picsum.photos/seed/user3/100/100',
        content: '高能小作坊',
        timestamp: '昨天 23:04',
        location: '广东',
        likes: 8,
        imageUrl: 'https://images.pexels.com/photos/162031/dubai-tower-arab-khalifa-162031.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
      CommentData(
        username: '烟熏威士忌',
        avatarUrl: 'https://picsum.photos/seed/user4/100/100',
        content: '朋友带我去的广州塔🙋‍♀️',
        timestamp: '昨天 19:03',
        location: '广东',
        likes: 37,
      ),
      CommentData(
        username: 'momo',
        avatarUrl: 'https://picsum.photos/seed/user5/100/100',
        content: '我家庭年收入4-50w也只能看右边',
        timestamp: '昨天 13:24',
        location: '广东',
        likes: 37,
      ),
    ]);
  }

  Future<void> _loadMoreComments() async {
    if (_isLoadingMore || !_hasMoreComments) return;

    setState(() {
      _isLoadingMore = true;
    });

    // 模拟异步加载
    await Future.delayed(const Duration(seconds: 1));

    // 模拟加载更多评论数据
    final newComments = [
      CommentData(
        username: '用户${_comments.length + 1}',
        avatarUrl: 'https://picsum.photos/seed/user${_comments.length + 1}/100/100',
        content: '这是第${_comments.length + 1}条评论，测试异步加载功能',
        timestamp: '刚刚',
        location: '北京',
        likes: 5,
      ),
      CommentData(
        username: '用户${_comments.length + 2}',
        avatarUrl: 'https://picsum.photos/seed/user${_comments.length + 2}/100/100',
        content: '这是第${_comments.length + 2}条评论，测试异步加载功能',
        timestamp: '刚刚',
        location: '上海',
        likes: 3,
      ),
    ];

    setState(() {
      _comments.addAll(newComments);
      _isLoadingMore = false;
      // 模拟没有更多数据的情况（例如加载到第20条评论时停止）
      if (_comments.length >= 20) {
        _hasMoreComments = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  // 构建顶部应用栏
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(widget.postData.avatarUrl),
          ),
          const SizedBox(width: 12),
          Text(
            widget.postData.username,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
            onPressed: () {
              setState(() {
                // 切换关注状态
                // widget.postData.isFollowed = !widget.postData.isFollowed;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: widget.postData.isFollowed ? Colors.grey : Colors.red,
              backgroundColor: widget.postData.isFollowed ? Colors.grey.shade200 : Colors.red.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              widget.postData.isFollowed ? '已关注' : '关注',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.share, color: Colors.black),
        ),
      ],
    );
  }

  // 构建页面主体内容
  Widget _buildBody() {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildImageGallery(),
        const SizedBox(height: 16),
        _buildPostDetails(),
        const SizedBox(height: 20),
        _buildCommentsSection(),
        // 加载更多指示器
        if (_isLoadingMore)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        if (!_hasMoreComments && _comments.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '没有更多评论了',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // 构建图片画廊
  Widget _buildImageGallery() {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.postData.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                child: VigaAppNetworkImage(
                  imageUrl: widget.postData.imageUrls[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        if (widget.postData.imageUrls.length > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.postData.imageUrls.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index
                      ? Colors.blue.shade600
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // 构建帖子详情（标题、标签、时间）
  Widget _buildPostDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.postData.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.postData.tags.map((tag) => Text(
            tag,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 15,
            ),
          )).toList(),
        ),
        const SizedBox(height: 10),
        Text(
          '${widget.postData.timestamp} · ${widget.postData.location}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // 构建评论区
  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.black12, height: 1),
        const SizedBox(height: 16),
        Text(
          '共 ${_comments.length} 条评论',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://picsum.photos/seed/myuser/100/100'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '爱评论的人运气都不差',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // 在详情页直接显示评论列表，跟随页面滚动
        Column(
          children: _comments.map((comment) => _buildCommentItem(comment)).toList(),
        ),
      ],
    );
  }

  // 构建单条评论
  Widget _buildCommentItem(CommentData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(data.avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.username,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                if (data.imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        data.imageUrl!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 6),
                Text(
                  '${data.timestamp} · ${data.location}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Icon(
                Icons.favorite_border,
                color: Colors.grey,
                size: 18,
              ),
              const SizedBox(height: 2),
              Text(
                data.likes.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // 构建底部操作栏
  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF0F0F0),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '说点什么...',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            _buildActionBarIcon(Icons.favorite_border, widget.postData.likes.toString()),
            _buildActionBarIcon(Icons.star_border, widget.postData.favorites.toString()),
            _buildActionBarIcon(Icons.chat_bubble_outline, widget.postData.comments.toString()),
          ],
        ),
      ),
    );
  }

  // 操作栏图标
  Widget _buildActionBarIcon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: 22),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}