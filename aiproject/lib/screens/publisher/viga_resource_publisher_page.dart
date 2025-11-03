import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/themes.dart';

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

class VigaResourceSearchPage extends StatefulWidget {
  const VigaResourceSearchPage({super.key});

  @override
  State<VigaResourceSearchPage> createState() => _ModelSearchPageState();
}

class _ModelSearchPageState extends State<VigaResourceSearchPage> {
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
              _scrollController.position.maxScrollExtent - 400.w && // 200 * 2
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
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: theme.colorScheme.onSurface, size: 40.w), // 20 * 2
          onPressed: () => context.pop(),
        ),
        title: Text('灵感库',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 36.w,
              fontWeight: FontWeight.w600,
            )), // 18 * 2
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(theme),
          Expanded(
            child: _buildContentBody(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(24.w),
      child: TextField(
        controller: _searchController,
        style: TextStyle(
            fontSize: 28.w, color: theme.colorScheme.onSurface), // 14 * 2
        decoration: InputDecoration(
          isDense: true,
          hintText: '搜索灵感模型...',
          hintStyle: TextStyle(
            fontSize: 28.w,
            color: theme.colorScheme.onSurfaceVariant,
          ), // 14 * 2
          prefixIcon: Icon(Icons.search_outlined,
              color: theme.colorScheme.onSurfaceVariant, size: 40.w), // 20 * 2
          contentPadding: EdgeInsets.symmetric(
              vertical: 24.0.w, horizontal: 20.w), // 12 * 2
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0.w)), // 25 * 2
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0.w)), // 25 * 2
            borderSide: BorderSide(
              color: theme.dividerColor,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0.w)), // 25 * 2
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2.w,
            ),
          ),
        ),
        onSubmitted: _performSearch,
      ),
    );
  }

  Widget _buildContentBody(ThemeData theme) {
    if (_modelItems.isEmpty) {
      if (_isLoading) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40.0.w), // 20 * 2
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 4.w,
            ),
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_outlined,
                size: 80.w,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: 16.w),
              Text(
                "没有找到相关模型",
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 28.w,
                ),
              ),
            ],
          ),
        );
      }
    }

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.fromLTRB(24.0.w, 0, 24.0.w, 24.0.w), // 12 * 2
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0.w, // 8 * 2
              mainAxisSpacing: 16.0.w, // 8 * 2
              childAspectRatio: 0.68, // Ratios are not adapted
            ),
            itemCount: _modelItems.length,
            itemBuilder: (context, index) {
              return _buildModelCard(_modelItems[index], theme);
            },
          ),
        ),
        if (_isLoading)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0.w), // 16 * 2
            child: Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
                strokeWidth: 4.w,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildModelCard(ModelItem item, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10.w,
            offset: Offset(0, 2.w),
          ),
        ],
        border: Border.all(
          color: theme.dividerColor.withAlpha((0.3 * 255).toInt()),
          width: 1.w,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: VigaAppNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 500),
                  ),
                ),
                Positioned(
                  top: 12.w, // 6 * 2
                  left: 12.w, // 6 * 2
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 6.w), // 6*2, 3*2
                    decoration: BoxDecoration(
                      color: AppColors.brandGreenVibrant5
                          .withAlpha((0.9 * 255).toInt()),
                      borderRadius: BorderRadius.circular(12.w), // 6 * 2
                    ),
                    child: Text('LoRA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.w,
                            fontWeight: FontWeight.w600)), // 11 * 2
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26.w,
                    color: theme.colorScheme.onSurface,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.w),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.w, // 10 * 2
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      backgroundImage: NetworkImage(item.authorAvatarUrl),
                    ),
                    SizedBox(width: 12.w), // 6 * 2
                    Expanded(
                      child: Text(
                        item.author,
                        style: TextStyle(
                          fontSize: 22.w,
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.w),
                SizedBox(
                  width: double.infinity,
                  height: 48.w, // 24 * 2
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.w), // 12 * 2
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w), // 10 * 2
                      elevation: 0,
                    ),
                    child: Text(
                      '使用',
                      style: TextStyle(
                        fontSize: 24.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
