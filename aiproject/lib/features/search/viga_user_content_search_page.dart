// 用户内容搜索页面 - 专门用于搜索作品、收藏、点赞

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

// 定义页面主体应该显示的三种模式
enum _UserContentSearchBodyMode { hotTrends, suggestions, results }

class _SearchItemData {
  final String text;
  final bool isHot;
  const _SearchItemData({required this.text, this.isHot = false});
}

class VigaUserContentSearchPage extends StatefulWidget {
  const VigaUserContentSearchPage({super.key});

  @override
  State<VigaUserContentSearchPage> createState() => _VigaUserContentSearchPageState();
}

class _VigaUserContentSearchPageState extends State<VigaUserContentSearchPage>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  _UserContentSearchBodyMode _currentBody = _UserContentSearchBodyMode.hotTrends;
  String _searchQuery = '';
  String _activeSearchKeyword = '';

  late TabController _resultsTabController;

  final List<String> _mockSuggestions = [
    '我的作品1',
    '我的作品2',
    '点赞的视频',
    '收藏的内容',
    '最近发布',
    '热门作品',
    '私密作品',
    '草稿箱',
    '已删除',
  ];

  final List<_SearchItemData> staticHistoryData = const [
    _SearchItemData(text: "我的第一个作品"),
    _SearchItemData(text: "点赞的视频合集"),
    _SearchItemData(text: "收藏的美景"),
    _SearchItemData(text: "最近浏览"),
  ];

  final List<_SearchItemData> staticSuggestionsData = const [
    _SearchItemData(text: "最近发布的作品", isHot: true),
    _SearchItemData(text: "热门点赞内容", isHot: true),
    _SearchItemData(text: "收藏的美食视频"),
    _SearchItemData(text: "浏览过的教程"),
    _SearchItemData(text: "私密作品"),
    _SearchItemData(text: "草稿箱内容"),
    _SearchItemData(text: "已删除作品"),
    _SearchItemData(text: "分享过的内容"),
  ];

  @override
  void initState() {
    super.initState();
    _resultsTabController = TabController(length: 3, vsync: this); // 3个tab: 作品、收藏、点赞
    _searchController = TextEditingController();
    _focusNode = FocusNode();

    _searchController.addListener(() {
      final newQuery = _searchController.text;
      if (_searchQuery != newQuery) {
        setState(() {
          _searchQuery = newQuery;
          if (newQuery.isNotEmpty) {
            if (_currentBody != _UserContentSearchBodyMode.results) {
              _currentBody = _UserContentSearchBodyMode.suggestions;
            }
          } else {
            _currentBody = _UserContentSearchBodyMode.hotTrends;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _resultsTabController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _resetToHotTrends() {
    _searchController.clear();
    _focusNode.unfocus();
    setState(() {
      _currentBody = _UserContentSearchBodyMode.hotTrends;
    });
  }

  void _executeSearch(String keyword) {
    if (keyword.isEmpty) return;
    _focusNode.unfocus();
    _searchController.value = TextEditingValue(
      text: keyword,
      selection: TextSelection.collapsed(offset: keyword.length),
    );
    setState(() {
      _activeSearchKeyword = keyword;
      _currentBody = _UserContentSearchBodyMode.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        AppLocalizations l10n = AppLocalizations.of(context)!;
        ThemeData theme = Theme.of(context);

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            primary: false,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: _buildAppBar(systemState, theme, l10n),
            body: _buildBody(theme, l10n),
          ),
        );
      },
    );
  }

  Widget _buildBody(ThemeData theme, AppLocalizations l10n) {
    switch (_currentBody) {
      case _UserContentSearchBodyMode.hotTrends:
        return _buildInitialContent(l10n);
      case _UserContentSearchBodyMode.suggestions:
        return _buildSuggestionsContent(theme);
      case _UserContentSearchBodyMode.results:
        return _buildResultsContent(theme);
    }
  }

  PreferredSizeWidget _buildAppBar(
      SystemState systemState, ThemeData theme, AppLocalizations l10n) {
    bool hasText = _searchQuery.isNotEmpty;

    return PreferredSize(
      preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(top: systemState.statusHeight),
        height: 90.w,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_currentBody != _UserContentSearchBodyMode.hotTrends)
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 40.w, color: Colors.black),
                onPressed: _resetToHotTrends,
              ),
            Expanded(
              child: Container(
                height: 68.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onTap: () {
                    if (!_focusNode.hasFocus) {
                      _focusNode.requestFocus();
                    }
                    if (_currentBody == _UserContentSearchBodyMode.results) {
                      setState(() {
                        _currentBody = _UserContentSearchBodyMode.suggestions;
                      });
                    }
                  },
                  style: TextStyle(fontSize: 30.w),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.w),
                    border: InputBorder.none,
                    hintText: "搜索我的内容",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 30.w),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.grey.shade400, size: 40.w),
                    suffixIcon: hasText
                        ? IconButton(
                            icon: Icon(Icons.cancel,
                                color: Colors.grey.shade400, size: 36.w),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            if (hasText)
              IconButton(
                icon: Icon(Icons.search, color: Color(0xFFFE2C55), size: 48.w),
                onPressed: () => _executeSearch(_searchQuery),
              )
            else
              IconButton(
                icon:
                    Icon(Icons.close, color: Colors.grey.shade600, size: 48.w),
                onPressed: () => context.pop(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsContent(ThemeData theme) {
    return Column(
      children: [
        TabBar(
          controller: _resultsTabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          indicatorWeight: 3.0,
          labelStyle: TextStyle(
            fontSize: 28.w,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 28.w,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          tabs: const [
            Tab(text: '作品'),
            Tab(text: '收藏'),
            Tab(text: '点赞'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _resultsTabController,
            children: [
              _buildWorksResults(),
              _buildCollectionsResults(),
              _buildLikesResults(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorksResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20.w),
          Text(
            '搜索作品: $_activeSearchKeyword',
            style: TextStyle(
              fontSize: 28.w,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20.w),
          Text(
            '搜索收藏: $_activeSearchKeyword',
            style: TextStyle(
              fontSize: 28.w,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikesResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.thumb_up,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20.w),
          Text(
            '搜索点赞内容: $_activeSearchKeyword',
            style: TextStyle(
              fontSize: 28.w,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialContent(AppLocalizations l10n) {
    return ListView(
      children: [
        buildSection(
          title: '搜索历史',
          data: staticHistoryData,
          l10n: l10n,
          actionIcon: Icons.delete_outline,
        ),
        buildSection(
          title: '猜你想搜',
          data: staticSuggestionsData,
          l10n: l10n,
          actionIcon: Icons.refresh,
        ),
      ],
    );
  }

  Widget _buildSuggestionsContent(ThemeData theme) {
    final filteredSuggestions = _mockSuggestions
        .where((suggestion) =>
            suggestion.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return ListView.separated(
      itemCount: filteredSuggestions.length,
      separatorBuilder: (context, index) => Divider(
          height: 1, thickness: 1, color: Colors.grey.shade100, indent: 90.w),
      itemBuilder: (context, index) {
        final suggestion = filteredSuggestions[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 30.w),
          leading: Icon(Icons.search, color: Colors.grey.shade400, size: 40.w),
          title: _buildHighlightedText(suggestion, _searchQuery),
          trailing:
              Icon(Icons.north_west, color: Colors.grey.shade400, size: 30.w),
          onTap: () => _executeSearch(suggestion),
        );
      },
    );
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(text, style: TextStyle(color: Colors.black, fontSize: 30.w));
    }
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfQuery;
    while ((indexOfQuery = lowerText.indexOf(lowerQuery, start)) != -1) {
      if (indexOfQuery > start) {
        spans.add(TextSpan(
            text: text.substring(start, indexOfQuery),
            style: TextStyle(color: Colors.black, fontSize: 30.w)));
      }
      final endOfQuery = indexOfQuery + query.length;
      spans.add(TextSpan(
          text: text.substring(indexOfQuery, endOfQuery),
          style: TextStyle(color: Color(0xFFFE2C55), fontSize: 30.w)));
      start = endOfQuery;
    }
    if (start < text.length) {
      spans.add(TextSpan(
          text: text.substring(start),
          style: TextStyle(color: Colors.black, fontSize: 30.w)));
    }
    return RichText(text: TextSpan(children: spans));
  }

  Widget buildSection({
    required String title,
    required List<_SearchItemData> data,
    required AppLocalizations l10n,
    IconData? actionIcon,
  }) {
    if (data.isEmpty) return const SizedBox.shrink();
    return Container(
      width: 750.w,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(30.w, 20.w, 30.w, 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 28.w, color: Colors.grey.shade500)),
              if (actionIcon != null)
                Icon(actionIcon, color: Colors.grey.shade500, size: 44.w),
            ],
          ),
          SizedBox(height: 20.w),
          Wrap(
            spacing: 15.w,
            runSpacing: 15.w,
            children: data.map((item) {
              return GestureDetector(
                onTap: () => _executeSearch(item.text),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30.w)),
                  child: Text(item.text,
                      style: TextStyle(fontSize: 28.w, color: Colors.black87)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}