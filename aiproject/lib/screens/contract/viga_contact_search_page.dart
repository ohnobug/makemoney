import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/tools/viga_logger.dart';

// 联系人数据模型
class ContactItem {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String time;
  final bool isOnline;
  final String? status;

  ContactItem({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    this.isOnline = false,
    this.status,
  });
}

class VigaContactSearchPage extends StatefulWidget {
  final List<ContactItem>? recentContacts; // 传入的最近联系人数据

  const VigaContactSearchPage({
    super.key,
    this.recentContacts,
  });

  @override
  State<VigaContactSearchPage> createState() => _VigaContactSearchPageState();
}

class _VigaContactSearchPageState extends State<VigaContactSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<ContactItem> _allContacts = [];

  @override
  void initState() {
    super.initState();
    _generateMockContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _generateMockContacts() {
    // 如果传入了最近联系人数据，使用传入的数据
    if (widget.recentContacts != null && widget.recentContacts!.isNotEmpty) {
      _allContacts = List.from(widget.recentContacts!);
    } else {
      // 否则生成模拟数据
      final names = [
        '张三', '李四', '王五', '赵六', '陈七', '刘八', '周九', '吴十',
        '郑十一', '孙十二', '钱十三', '冯十四', '陈十五', '褚十六',
        '卫十七', '蒋十八', '沈十九', '韩二十', '杨二一', '朱二二',
      ];

      final lastMessages = [
        '在吗？最近怎么样？',
        '有空聊聊吗？',
        '周末有什么安排？',
        '工作忙吗？',
        '晚上一起吃饭？',
        '好久不见了',
        '最近还好吗？',
        '有空吗？',
        '明天见！',
        '收到，谢谢！',
        '好的，知道了',
        '没问题',
        '稍后联系',
        '明天再聊',
        '晚安！',
        '早安！',
        '周末愉快！',
        '祝你好运！',
        '加油！',
        '太棒了！'
      ];

      _allContacts = List.generate(20, (index) {
        final random = Random();
        final nameIndex = random.nextInt(names.length);
        final messageIndex = random.nextInt(lastMessages.length);

        return ContactItem(
          id: 'contact_$index',
          name: names[nameIndex],
          avatar: 'https://picsum.photos/100/100?random=${index + 1000}',
          lastMessage: lastMessages[messageIndex],
          time: _generateRandomTime(),
          isOnline: random.nextBool(),
          status: random.nextBool()
              ? ['工作中', '忙碌中', '会议中', '外出中', '休息中'][random.nextInt(5)]
              : null,
        );
      });
    }
  }

  String _generateRandomTime() {
    final random = Random();
    final hours = random.nextInt(24);
    final minutes = random.nextInt(60);

    if (hours == 0) {
      return '$minutes分钟前';
    } else if (hours < 24) {
      return '$hours小时前';
    } else {
      return '昨天';
    }
  }

  void _navigateToSearchResults(String searchKeyword) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VigaContactSearchResultsPage(
          searchKeyword: searchKeyword,
          allContacts: _allContacts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: VigaAppBar(
        title: '搜索好友',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 40.w,
            color: theme.appBarTheme.titleTextStyle?.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          width: 600.w,
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10.w,
                offset: Offset(0, 5.w),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 搜索图标
              Icon(
                Icons.search,
                size: 80.w,
                color: theme.hintColor,
              ),
              SizedBox(height: 30.w),

              // 搜索输入框
              TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.w,
                ),
                decoration: InputDecoration(
                  hintText: '搜索好友',
                  hintStyle: TextStyle(
                    color: theme.hintColor,
                    fontSize: 32.w,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.w,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    _navigateToSearchResults(value);
                  }
                },
              ),

              SizedBox(height: 30.w),

              // 确认按钮
              SizedBox(
                width: double.infinity,
                height: 80.w,
                child: ElevatedButton(
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      _navigateToSearchResults(query);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '搜索',
                    style: TextStyle(
                      fontSize: 28.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 联系人搜索结果页面
class VigaContactSearchResultsPage extends StatefulWidget {
  final String searchKeyword;
  final List<ContactItem> allContacts;

  const VigaContactSearchResultsPage({
    super.key,
    required this.searchKeyword,
    required this.allContacts,
  });

  @override
  State<VigaContactSearchResultsPage> createState() => _VigaContactSearchResultsPageState();
}

class _VigaContactSearchResultsPageState extends State<VigaContactSearchResultsPage> {
  List<ContactItem> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _performSearch(widget.searchKeyword);
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // 模拟搜索延迟
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchResults = widget.allContacts.where((contact) {
            return contact.name.toLowerCase().contains(query.toLowerCase()) ||
                   (contact.status?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
                   contact.lastMessage.toLowerCase().contains(query.toLowerCase());
          }).toList();
          _isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          '搜索结果',
          style: TextStyle(
            fontSize: 32.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 40.w,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // 显示搜索关键词
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(25.w),
              border: Border.all(color: theme.dividerColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: theme.hintColor,
                  size: 40.w,
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Text(
                    '搜索: ${widget.searchKeyword}',
                    style: TextStyle(
                      fontSize: 28.w,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 搜索结果
          Expanded(
            child: _isSearching
                ? Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ),
                  )
                : _searchResults.isEmpty
                    ? _buildEmptyState(theme)
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return _buildContactItem(_searchResults[index], theme);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 100.w,
            color: theme.hintColor,
          ),
          SizedBox(height: 20.w),
          Text(
            '没有找到相关联系人',
            style: TextStyle(
              fontSize: 28.w,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            '试试其他关键词',
            style: TextStyle(
              fontSize: 24.w,
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(ContactItem contact, ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      child: InkWell(
        onTap: () {
          // 可以在这里添加联系人详情页面跳转或聊天页面跳转
          logger.info('点击联系人: ${contact.name}');
          Navigator.pop(context); // 返回到聊天列表
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12.w),
            border: Border.all(color: theme.dividerColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              // 头像
              Stack(
                children: [
                  CircleAvatar(
                    radius: 35.w,
                    backgroundImage: NetworkImage(contact.avatar),
                  ),
                  if (contact.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.w),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 15.w),

              // 联系人信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          contact.name,
                          style: TextStyle(
                            fontSize: 28.w,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        if (contact.status != null) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(30),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              contact.status!,
                              style: TextStyle(
                                fontSize: 18.w,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 5.w),
                    Text(
                      contact.lastMessage,
                      style: TextStyle(
                        fontSize: 24.w,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // 时间
              Text(
                contact.time,
                style: TextStyle(
                  fontSize: 22.w,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}