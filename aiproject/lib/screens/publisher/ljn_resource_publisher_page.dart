import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

// 数据模型
class ModelItem {
  final String imageUrl;
  final String title;
  final String author;
  final String authorAvatarUrl;

  ModelItem({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.authorAvatarUrl,
  });
}

class LJNResourceSearchPage extends StatefulWidget {
  const LJNResourceSearchPage({super.key});

  @override
  State<LJNResourceSearchPage> createState() => _ModelSearchPageState();
}

class _ModelSearchPageState extends State<LJNResourceSearchPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<ModelItem> _modelItems = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _fetchModels();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchModels();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchModels({String query = ''}) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    List<ModelItem> newItems = List.generate(_itemsPerPage, (index) {
      final id = (_currentPage - 1) * _itemsPerPage + index;
      return ModelItem(
        imageUrl: 'https://picsum.photos/seed/${id + 1}/300/450',
        title: _getMockTitle(id),
        author: '作者${id + 1}',
        authorAvatarUrl: 'https://i.pravatar.cc/50?u=$id',
      );
    });

    if (_currentPage >= 5) {
      newItems = [];
    }

    if (!mounted) return;

    setState(() {
      if (newItems.isNotEmpty) {
        _modelItems.addAll(newItems);
        _currentPage++;
      } else {
        _hasMore = false;
      }
      _isLoading = false;
    });
  }

  String _getMockTitle(int index) {
    const titles = [
      'Nano-Banana_爆款手办一键...',
      'F.1版nano-banana手办爆款...',
      'krea-童趣/白色团子/治愈系插画',
      'Flux-设计草图',
      '电商美妆kv医美科研风',
      '超_Flux.1 商业摄影大模型1.1_...',
      '国风水墨画模型',
      '赛博朋克城市夜景'
    ];
    return titles[index % titles.length];
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _modelItems.clear();
      _currentPage = 1;
      _hasMore = true;
      _isLoading = false;
    });

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    await _fetchModels(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black54, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('模型',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildContentBody(),
          ),
        ],
      ),
    );
  }

  // [MODIFIED] 这是唯一被修改的方法
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      // 移除外层Container的固定高度，让TextField自适应
      child: TextField(
        controller: _searchController,
        style: const TextStyle(fontSize: 14), // 确保输入文字大小和提示文字大小一致
        decoration: const InputDecoration(
          // 1. isDense设为true，使输入框更紧凑
          isDense: true,
          hintText: '搜索模型名称',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
          // 2. 设置对称的垂直内边距，以实现完美的垂直居中对齐
          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          filled: true,
          fillColor: Color(0xFFF5F5F5), // 使用一个具体的浅灰色
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide.none, // 无边框
          ),
        ),
        onSubmitted: _performSearch,
      ),
    );
  }

  Widget _buildContentBody() {
    if (_modelItems.isEmpty) {
      if (_isLoading) {
        return const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const Center(child: Text("没有找到相关模型"));
      }
    }

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.68,
            ),
            itemCount: _modelItems.length,
            itemBuilder: (context, index) {
              return _buildModelCard(_modelItems[index]);
            },
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildModelCard(ModelItem item) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 500),
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[200]),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('LORA',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
            child: Text(item.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(item.authorAvatarUrl)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.author,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.withAlpha(25),
                      foregroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    child: const Text('使用', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
