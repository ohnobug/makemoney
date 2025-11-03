import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

// 作品数据模型
class WorkItem {
  final String id;
  final String imageUrl;
  final int viewCount;
  final String? title;
  final String? author;
  final DateTime? createTime;

  WorkItem({
    required this.id,
    required this.imageUrl,
    required this.viewCount,
    this.title,
    this.author,
    this.createTime,
  });

  // 从字符串URL创建WorkItem的便捷构造函数
  factory WorkItem.fromUrl(String imageUrl, {int? viewCount}) {
    return WorkItem(
      id: imageUrl.hashCode.toString(),
      imageUrl: imageUrl,
      viewCount: viewCount ?? (Random().nextInt(10) * 1.2 * 1000).toInt(),
    );
  }
}

// 搜索源配置
class SearchSource {
  final String id;
  final String name;
  final List<WorkItem> items;
  final String? Function(String)? searchTitleBuilder;
  final List<String> Function()? suggestionsBuilder;

  SearchSource({
    required this.id,
    required this.name,
    required this.items,
    this.searchTitleBuilder,
    this.suggestionsBuilder,
  });
}

class VigaWorkSearchWidget extends StatefulWidget {
  final List<SearchSource> searchSources;
  final String initialSourceId;
  final String? searchHint;
  final bool showFilterButton;
  final Function(WorkItem)? onWorkTap;
  final Widget? emptyStateWidget;
  final Widget? loadingWidget;

  const VigaWorkSearchWidget({
    super.key,
    required this.searchSources,
    required this.initialSourceId,
    this.searchHint,
    this.showFilterButton = true,
    this.onWorkTap,
    this.emptyStateWidget,
    this.loadingWidget,
  });

  @override
  State<VigaWorkSearchWidget> createState() => _VigaWorkSearchWidgetState();
}

class _VigaWorkSearchWidgetState extends State<VigaWorkSearchWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final Map<String, List<WorkItem>> _searchResults = {};
  final Map<String, bool> _isSearching = {};
  final Map<String, String> _searchQueries = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.searchSources.length,
      vsync: this,
    );

    // 设置初始选中的搜索源
    final initialIndex = widget.searchSources.indexWhere(
      (source) => source.id == widget.initialSourceId,
    );
    if (initialIndex != -1) {
      _tabController.index = initialIndex;
    }

    // 初始化状态
    for (final source in widget.searchSources) {
      _searchResults[source.id] = [];
      _isSearching[source.id] = false;
      _searchQueries[source.id] = '';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        _buildSearchBar(theme),
        if (widget.searchSources.length > 1) _buildTabBar(theme),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.searchSources.map((source) {
              return _buildSearchContent(source);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      margin: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(25.w),
        border: Border.all(color: theme.dividerColor.withAlpha(50)),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: (value) {
          _performSearch(_getCurrentSource().id, value);
        },
        onSubmitted: (value) {
          _performSearch(_getCurrentSource().id, value);
        },
        decoration: InputDecoration(
          hintText: widget.searchHint ?? '搜索${_getCurrentSource().name}...',
          hintStyle: TextStyle(color: theme.hintColor),
          prefixIcon: Icon(Icons.search, color: theme.hintColor),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear, color: theme.hintColor),
                  onPressed: () {
                    _searchController.clear();
                    _clearSearchResults(_getCurrentSource().id);
                  },
                ),
              if (widget.showFilterButton)
                IconButton(
                  icon: Icon(Icons.filter_list, color: theme.hintColor),
                  onPressed: _showFilterDialog,
                ),
            ],
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.w,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          // 切换标签时，如果有搜索词，自动搜索
          if (_searchController.text.isNotEmpty) {
            _performSearch(
                widget.searchSources[index].id, _searchController.text);
          }
        },
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.textTheme.bodyMedium?.color,
        indicatorColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(
          fontSize: 26.w,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 26.w,
          fontWeight: FontWeight.normal,
        ),
        tabs: widget.searchSources.asMap().entries.map((entry) {
          final index = entry.key;
          final source = entry.value;
          return Tab(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.w),
              decoration: BoxDecoration(
                color: _tabController.index == index
                    ? theme.colorScheme.primary.withAlpha(20)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Text(source.name),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchContent(SearchSource source) {
    final theme = Theme.of(context);
    final currentQuery = _searchQueries[source.id] ?? '';
    final results = _searchResults[source.id] ?? [];
    final isSearching = _isSearching[source.id] ?? false;

    if (currentQuery.isEmpty) {
      return _buildSearchSuggestions(theme, source);
    }

    if (isSearching) {
      return _buildLoadingState();
    }

    if (results.isEmpty) {
      return _buildEmptySearchResult(theme);
    }

    return Column(
      children: [
        // 搜索统计
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
          child: Row(
            children: [
              Text(
                '找到 ${results.length} 个结果',
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color,
                  fontSize: 24.w,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  _sortByDate(source.id);
                },
                icon: Icon(Icons.sort, size: 28.w),
                label: Text(
                  '排序',
                  style: TextStyle(fontSize: 24.w),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // 搜索结果网格
        Expanded(
          child: _buildSearchResultsGrid(results),
        ),
      ],
    );
  }

  Widget _buildSearchSuggestions(ThemeData theme, SearchSource source) {
    final suggestions =
        source.suggestionsBuilder?.call() ?? _getDefaultSuggestions(source);

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '热门搜索',
            style: TextStyle(
              fontSize: 28.w,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 20.w),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.w,
            children: suggestions.map((suggestion) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = suggestion;
                  _performSearch(source.id, suggestion);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.w),
                    border: Border.all(color: theme.dividerColor.withAlpha(50)),
                  ),
                  child: Text(
                    suggestion,
                    style: TextStyle(
                      fontSize: 24.w,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3.w,
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          SizedBox(height: 20.w),
          Text(
            '搜索中...',
            style: TextStyle(
              fontSize: 26.w,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchResult(ThemeData theme) {
    if (widget.emptyStateWidget != null) {
      return widget.emptyStateWidget!;
    }

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
            '没有找到相关内容',
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
          SizedBox(height: 30.w),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              _clearSearchResults(_getCurrentSource().id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
            ),
            child: Text(
              '清除搜索',
              style: TextStyle(fontSize: 24.w),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsGrid(List<WorkItem> results) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      itemCount: results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
        childAspectRatio: 9 / 14,
      ),
      itemBuilder: (context, index) {
        final workItem = results[index];

        return GestureDetector(
          onTap: () {
            if (widget.onWorkTap != null) {
              widget.onWorkTap!(workItem);
            } else {
              _defaultWorkTap(workItem, index, results);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: '${workItem.id}_search_${_getCurrentSource().id}',
                child: VigaAppNetworkImage(
                  imageUrl: workItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withAlpha(156),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        const IconData(0xe643, fontFamily: 'Iconfont'),
                        color: Colors.white,
                        size: 32.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${workItem.viewCount}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.w,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black.withAlpha(128),
                                offset: const Offset(0, 1),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  SearchSource _getCurrentSource() {
    return widget.searchSources[_tabController.index];
  }

  List<String> _getDefaultSuggestions(SearchSource source) {
    switch (source.id) {
      case 'works':
        return ['风景', '人像', '街拍', '建筑', '美食', '旅行', '艺术', '黑白', '夜景', '微距'];
      case 'collections':
        return ['设计', '摄影', '插画', '创意', '灵感', '配色', '构图', '品牌', 'UI', '海报'];
      case 'praised':
        return ['精彩', '优质', '推荐', '热门', '精选', '优秀', 'trending', 'viral'];
      case 'author_works':
        return ['最新', '热门', '精选', '推荐', '原创', '优质'];
      default:
        return ['热门', '最新', '推荐', '精选'];
    }
  }

  void _performSearch(String sourceId, String query) {
    if (query.trim().isEmpty) {
      _clearSearchResults(sourceId);
      return;
    }

    setState(() {
      _searchQueries[sourceId] = query;
      _isSearching[sourceId] = true;
    });

    // 获取搜索源
    final searchSource = widget.searchSources.firstWhere(
      (source) => source.id == sourceId,
    );

    // 模拟搜索延迟
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchResults[sourceId] = searchSource.items.where((item) {
            // 搜索逻辑：标题、作者等匹配
            return _isWorkMatched(item, query);
          }).toList();
          _isSearching[sourceId] = false;
        });
      }
    });
  }

  bool _isWorkMatched(WorkItem item, String query) {
    final lowerQuery = query.toLowerCase();

    // 匹配标题
    if (item.title != null && item.title!.toLowerCase().contains(lowerQuery)) {
      return true;
    }

    // 匹配作者
    if (item.author != null &&
        item.author!.toLowerCase().contains(lowerQuery)) {
      return true;
    }

    // 模拟匹配（用于演示）
    return _randomSearchMatch(query);
  }

  bool _randomSearchMatch(String query) {
    final random = Random();
    return random.nextDouble() < 0.3; // 30%的几率匹配
  }

  void _clearSearchResults(String sourceId) {
    setState(() {
      _searchQueries[sourceId] = '';
      _searchResults[sourceId] = [];
      _isSearching[sourceId] = false;
    });
  }

  void _sortByDate(String sourceId) {
    setState(() {
      _searchResults[sourceId] = List.from(_searchResults[sourceId] ?? [])
        ..sort((a, b) {
          if (a.createTime == null && b.createTime == null) return 0;
          if (a.createTime == null) return 1;
          if (b.createTime == null) return -1;
          return b.createTime!.compareTo(a.createTime!);
        });
    });
  }

  void _defaultWorkTap(WorkItem workItem, int index, List<WorkItem> results) {
    final imageUrls = results.map((item) => item.imageUrl).toList();

    context.push('/photo_viewer', extra: {
      'imageSources': imageUrls,
      'initialIndex': index,
      'initialRect': Rect.zero,
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('筛选条件'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('按时间排序'),
              leading: Icon(Icons.access_time),
              onTap: () {
                context.pop();
                _sortByDate(_getCurrentSource().id);
              },
            ),
            ListTile(
              title: Text('按热度排序'),
              leading: Icon(Icons.local_fire_department),
              onTap: () {
                context.pop();
                _sortByPopularity();
              },
            ),
            ListTile(
              title: Text('只看原创'),
              leading: Icon(Icons.verified),
              onTap: () {
                context.pop();
                _filterOriginal();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text('取消'),
          ),
        ],
      ),
    );
  }

  void _sortByPopularity() {
    final sourceId = _getCurrentSource().id;
    setState(() {
      _searchResults[sourceId] = List.from(_searchResults[sourceId] ?? [])
        ..sort((a, b) => b.viewCount.compareTo(a.viewCount));
    });
  }

  void _filterOriginal() {
    // 实现原创筛选逻辑
    // 这里可以根据实际需求实现
  }
}
