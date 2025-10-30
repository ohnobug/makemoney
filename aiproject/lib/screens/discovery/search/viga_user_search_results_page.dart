import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_work_search_widget.dart';

class VigaSearchResultsPage extends StatefulWidget {
  final String initialSearchType;
  final List<String> works;
  final List<String> collections;
  final List<String> praised;

  const VigaSearchResultsPage({
    super.key,
    required this.initialSearchType,
    required this.works,
    required this.collections,
    required this.praised,
  });

  @override
  State<VigaSearchResultsPage> createState() => _VigaSearchResultsPageState();
}

class _VigaSearchResultsPageState extends State<VigaSearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme),
      body: VigaWorkSearchWidget(
        searchSources: _buildSearchSources(),
        initialSourceId: widget.initialSearchType,
        searchHint: _getSearchHint(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        '搜索',
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
    );
  }

  List<SearchSource> _buildSearchSources() {
    final sources = <SearchSource>[];

    // 根据搜索类型添加搜索源
    switch (widget.initialSearchType) {
      case 'works':
      case 'collections':
      case 'praised':
        // 用户个人内容搜索
        if (widget.works.isNotEmpty) {
          sources.add(SearchSource(
            id: 'works',
            name: '作品',
            items: widget.works.map((url) => WorkItem.fromUrl(url)).toList(),
            suggestionsBuilder: () => ['风景', '人像', '街拍', '建筑', '美食', '旅行', '艺术', '黑白'],
          ));
        }
        if (widget.collections.isNotEmpty) {
          sources.add(SearchSource(
            id: 'collections',
            name: '收藏',
            items: widget.collections.map((url) => WorkItem.fromUrl(url)).toList(),
            suggestionsBuilder: () => ['设计', '摄影', '插画', '创意', '灵感', '配色', '构图'],
          ));
        }
        if (widget.praised.isNotEmpty) {
          sources.add(SearchSource(
            id: 'praised',
            name: '赞过',
            items: widget.praised.map((url) => WorkItem.fromUrl(url)).toList(),
            suggestionsBuilder: () => ['精彩', '优质', '推荐', '热门', '精选', '优秀'],
          ));
        }
        break;

      case 'author_works':
        // 作者作品搜索
        if (widget.works.isNotEmpty) {
          sources.add(SearchSource(
            id: 'author_works',
            name: '作品',
            items: widget.works.map((url) => WorkItem.fromUrl(url)).toList(),
            suggestionsBuilder: () => ['最新', '热门', '精选', '推荐', '原创', '优质'],
          ));
        }
        break;
    }

    return sources;
  }

  String _getSearchHint() {
    switch (widget.initialSearchType) {
      case 'works':
        return '搜索我的作品';
      case 'collections':
        return '搜索我的收藏';
      case 'praised':
        return '搜索我赞过的内容';
      case 'author_works':
        return '搜索作者作品';
      default:
        return '搜索作品';
    }
  }
}