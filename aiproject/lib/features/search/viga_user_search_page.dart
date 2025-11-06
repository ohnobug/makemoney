// 用户页面搜索 - 基于 viga_search_page.dart 修改

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/screens/discovery/widgets/viga_ins_component.dart';

// 定义页面主体应该显示的三种模式
enum _UserSearchBodyMode { hotTrends, suggestions, results }

class _SearchItemData {
  final String text;
  final bool isHot;
  const _SearchItemData({required this.text, this.isHot = false});
}

class VigaUserSearchPage extends StatefulWidget {
  const VigaUserSearchPage({super.key});

  @override
  State<VigaUserSearchPage> createState() => _VigaUserSearch();
}

class _VigaUserSearch extends State<VigaUserSearchPage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  _UserSearchBodyMode _currentBody = _UserSearchBodyMode.hotTrends;
  String _searchQuery = '';
  String _activeSearchKeyword = '';

  late TabController _hotTrendsTabController;
  late TabController _resultsTabController;

  final List<String> _mockSuggestions = [
    '我的作品1',
    '我的作品2',
    '点赞的视频',
    '收藏的内容',
    '浏览历史',
    '最近发布',
    '热门作品',
    '私密作品',
    '草稿箱',
    '已删除',
  ];

  final int _hotListItemCount = 10;
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
  final List<String> staticHotListTitleKeys = const [
    'recentWorks',
    'hotLikes',
    'collections',
    'viewHistory',
    'drafts',
    'privateWorks',
    'deletedWorks',
    'sharedWorks'
  ];
  final List<_SearchItemData> staticHotData = const [
    _SearchItemData(text: "最近发布的旅行视频", isHot: true),
    _SearchItemData(text: "点赞最多的美食教程", isHot: true),
    _SearchItemData(text: "收藏的摄影作品"),
    _SearchItemData(text: "最近浏览的教程"),
    _SearchItemData(text: "草稿箱的未完成作品"),
    _SearchItemData(text: "私密的个人作品"),
    _SearchItemData(text: "已删除的旧作品"),
    _SearchItemData(text: "分享给朋友的内容"),
    _SearchItemData(text: "热门评论的作品"),
    _SearchItemData(text: "置顶展示的内容"),
  ];

  @override
  void initState() {
    super.initState();
    _hotTrendsTabController =
        TabController(length: staticHotListTitleKeys.length, vsync: this);
    _resultsTabController = TabController(length: 4, vsync: this); // 4个tab: 作品、点赞、收藏、查看历史
    _searchController = TextEditingController();
    _focusNode = FocusNode();

    _searchController.addListener(() {
      final newQuery = _searchController.text;
      if (_searchQuery != newQuery) {
        setState(() {
          _searchQuery = newQuery;
          if (newQuery.isNotEmpty) {
            if (_currentBody != _UserSearchBodyMode.results) {
              _currentBody = _UserSearchBodyMode.suggestions;
            }
          } else {
            _currentBody = _UserSearchBodyMode.hotTrends;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _hotTrendsTabController.dispose();
    _resultsTabController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _resetToHotTrends() {
    _searchController.clear();
    _focusNode.unfocus();
    setState(() {
      _currentBody = _UserSearchBodyMode.hotTrends;
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
      _currentBody = _UserSearchBodyMode.results;
    });
  }

  String _getHotTitleFromKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'recentWorks':
        return '最近作品';
      case 'hotLikes':
        return '热门点赞';
      case 'collections':
        return '我的收藏';
      case 'viewHistory':
        return '浏览历史';
      case 'drafts':
        return '草稿箱';
      case 'privateWorks':
        return '私密作品';
      case 'deletedWorks':
        return '已删除';
      case 'sharedWorks':
        return '分享内容';
      default:
        return '';
    }
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
      case _UserSearchBodyMode.hotTrends:
        return _buildInitialContent(l10n);
      case _UserSearchBodyMode.suggestions:
        return _buildSuggestionsContent(theme);
      case _UserSearchBodyMode.results:
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
            if (_currentBody != _UserSearchBodyMode.hotTrends)
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
                    if (_currentBody == _UserSearchBodyMode.results) {
                      setState(() {
                        _currentBody = _UserSearchBodyMode.suggestions;
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
            Tab(text: '点赞'),
            Tab(text: '收藏'),
            Tab(text: '查看历史'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _resultsTabController,
            children: [
              _buildWorksResults(),
              _buildLikesResults(),
              _buildCollectionsResults(),
              _buildHistoryResults(),
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

  Widget _buildHistoryResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80.w,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20.w),
          Text(
            '搜索历史: $_activeSearchKeyword',
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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: buildSection(
              title: '搜索历史',
              data: staticHistoryData,
              l10n: l10n,
              actionIcon: Icons.delete_outline,
            ),
          ),
          SliverToBoxAdapter(
            child: buildSection(
              title: '猜你想搜',
              data: staticSuggestionsData,
              l10n: l10n,
              actionIcon: Icons.refresh,
            ),
          ),
          SliverPersistentHeader(
            pinned: false,
            delegate: _SliverTabBarDelegate(
              TabBar(
                controller: _hotTrendsTabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicator: const BoxDecoration(color: Colors.transparent),
                labelColor: Color(0xFF7859C8),
                unselectedLabelColor: Colors.grey.shade600,
                labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                labelStyle:
                    TextStyle(fontSize: 30.w, fontWeight: FontWeight.bold),
                onTap: (index) {/* Link to TabBarView controller */},
                tabs: staticHotListTitleKeys
                    .map((key) => Tab(text: _getHotTitleFromKey(l10n, key)))
                    .toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: (92.w * _hotListItemCount) +
                  122.w,
              child: TabBarView(
                controller: _hotTrendsTabController,
                children: staticHotListTitleKeys.map((_) {
                  return hotListWidget(staticHotData, Theme.of(context), l10n);
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.w),
          ),
        ];
      },
      body: VigaInsComponent(enableScroll: false),
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

  Widget hotListWidget(
      List<_SearchItemData> hotData, ThemeData theme, AppLocalizations l10n) {
    final locale = Localizations.localeOf(context).toString();
    final compactFormatter = NumberFormat.compact(locale: locale);
    final int itemsToShow =
        hotData.length < _hotListItemCount ? hotData.length : _hotListItemCount;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
      itemCount: itemsToShow + 1, // +1 for the button
      itemBuilder: (context, index) {
        if (index == itemsToShow) {
          return _ViewFullListButton(
            onTap: () {}, // Placeholder for future action
            text: '查看完整列表',
          );
        }

        final item = hotData[index];
        final rank = index + 1;
        final double number = 11900000 - (rank * 100000);
        Color rankColor;
        switch (rank) {
          case 1:
            rankColor = Color(0xFFE7B40F);
            break;
          case 2:
            rankColor = Color(0xFFE68A42);
            break;
          case 3:
            rankColor = Color(0xFFD99E6A);
            break;
          default:
            rankColor = Colors.grey.shade400;
        }
        return _HotListItem(
          item: item,
          rank: rank,
          rankColor: rankColor,
          number: number,
          compactFormatter: compactFormatter,
          onTap: () => _executeSearch(item.text),
        );
      },
    );
  }
}

class _ViewFullListButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;

  const _ViewFullListButton({
    required this.onTap,
    required this.text,
  });

  @override
  State<_ViewFullListButton> createState() => __ViewFullListButtonState();
}

class __ViewFullListButtonState extends State<_ViewFullListButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color normalColor = Color(0xFFFDEEEE);
    Color pressedColor = theme.listTileTheme.selectedTileColor ??
        Color(0xFFFDEEEE).withAlpha(150);

    Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
        });
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
            widget.onTap();
          }
        });
      },
      child: Container(
        height: 80.w,
        margin: EdgeInsets.only(top: 10.w),
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Color(0xFFEE7272),
              fontWeight: FontWeight.bold,
              fontSize: 28.w,
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar);
  final TabBar tabBar;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(color: Colors.white, child: tabBar);
  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}

class _HotListItem extends StatefulWidget {
  final _SearchItemData item;
  final int rank;
  final Color rankColor;
  final double number;
  final NumberFormat compactFormatter;
  final VoidCallback onTap;

  const _HotListItem({
    required this.item,
    required this.rank,
    required this.rankColor,
    required this.number,
    required this.compactFormatter,
    required this.onTap,
  });

  @override
  State<_HotListItem> createState() => __HotListItemState();
}

class __HotListItemState extends State<_HotListItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Color normalColor = theme.listTileTheme.tileColor!;
    Color pressedColor = theme.listTileTheme.selectedTileColor!;
    Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
        });
      },
      onTapUp: (tapDownDetails) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
            widget.onTap();
          }
        });
      },
      child: Container(
        height: 90.w,
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          gradient: _isPressed ? null : LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              widget.rank <= 3 ? Color(0xFFFDEEEE) : Colors.grey.shade50,
              Colors.white
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        margin: EdgeInsets.only(bottom: 2.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              alignment: Alignment.center,
              child: Text(
                '${widget.rank}',
                style: TextStyle(
                  fontSize: 34.w,
                  fontWeight: FontWeight.bold,
                  color: widget.rankColor,
                ),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: widget.item.text,
                    style: TextStyle(
                      fontSize: 30.w,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                  if (widget.item.isHot)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          const IconData(0xe71e, fontFamily: 'Iconfont'),
                          color: AppColors.accentRedPure,
                          size: 30.w,
                        ),
                      ),
                    ),
                ]),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Text(
              widget.compactFormatter.format(widget.number),
              style: TextStyle(
                fontSize: 25.w,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}