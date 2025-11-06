// Viga_search.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/screens/discovery/widgets/viga_ins_component.dart';
import 'package:vigaviga/widgets/viga_chatlist_item.dart';

// 定义页面主体应该显示的三种模式
enum _SearchBodyMode { hotTrends, suggestions, results }

class _SearchItemData {
  final String text;
  final bool isHot;
  const _SearchItemData({required this.text, this.isHot = false});
}

class VigaSearchPage extends StatefulWidget {
  final Map<String, dynamic>? extra;

  const VigaSearchPage({super.key, this.extra});

  @override
  State<VigaSearchPage> createState() => _VigaSearch();
}

class _VigaSearch extends State<VigaSearchPage> with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  _SearchBodyMode _currentBody = _SearchBodyMode.hotTrends;
  String _searchQuery = '';
  String _activeSearchKeyword = '';

  late TabController _hotTrendsTabController;
  late TabController _resultsTabController;

  // 用户搜索相关状态
  List<ChatListItem> _userSearchResults = [];
  bool _isSearchingUsers = false;
  bool _hasSearchedUsers = false;

  // 自动聚焦状态
  bool _shouldAutoFocus = false;

  final List<String> _mockSuggestions = [
    '牛逼老外原版视频',
    '牛逼',
    '牛逼姐',
    '牛逼酱',
    '牛逼表情包',
    '牛逼一词的来源',
    '牛逼克拉斯',
    '牛逼图片',
    '牛逼class',
    '牛逼的网名',
  ];

  final int _hotListItemCount = 10;
  final List<_SearchItemData> staticHistoryData = const [
    _SearchItemData(text: "俄公开恐怖分子被捕的画面"),
    _SearchItemData(text: "微软宣布将终止对Windows10的支持"),
    _SearchItemData(text: "唐尚珺是弱智的吗 考了那么多次高考"),
    _SearchItemData(text: "美国大选最新消息"),
  ];
  final List<_SearchItemData> staticSuggestionsData = const [
    _SearchItemData(text: "李小龙标志性打耳光动作", isHot: true),
    _SearchItemData(text: "向佐扇自己一耳光", isHot: true),
    _SearchItemData(text: "美国大选最新消息"),
    _SearchItemData(text: "两任市委书记的“政绩工程”将被拆"),
    _SearchItemData(text: "习近平在湖北考察调研"),
    _SearchItemData(text: "宝妈吃瑞士卷被质疑剧本 网信办回应"),
    _SearchItemData(text: "进博新老朋友如约而至"),
    _SearchItemData(text: "美国大选选举结果或延迟公布"),
  ];
  final List<String> staticHotListTitleKeys = const [
    'douyinHotTrends',
    'cityHotTrends',
    'liveHotTrends',
    'groupBuyHotTrends',
    'brandHotTrends',
    'musicHotTrends',
    'techHotTrends',
    'autoHotTrends',
    'idiotList',
    'richList',
    'prankList',
    'horrorList',
    'kidsList',
    'goodPersonList',
    'badPersonList',
    'rockList',
    'movieList',
    'tvSeriesList'
  ];
  final List<_SearchItemData> staticHotData = const [
    _SearchItemData(text: "上海世茂等被强制执行17.6亿", isHot: true),
    _SearchItemData(text: "特朗普痛骂佩洛西时差点爆粗口"),
    _SearchItemData(text: "睡光板床可治腰椎病？不准确"),
    _SearchItemData(text: "美国选举日首个投票点结果出炉"),
    _SearchItemData(text: "#美国大选结果对全世界有什么影响#"),
    _SearchItemData(text: "国际专家解读2024美国大选"),
    _SearchItemData(text: "美国大选今日投票 世界瞩目"),
    _SearchItemData(text: "产妇急需剖腹产却被家属要求卡点生"),
    _SearchItemData(text: "河南固始县一男子杀害妻子被抓获"),
    _SearchItemData(text: "红-19地空导弹将首次展出"),
    _SearchItemData(text: "男生偶遇七胞胎逛商场大呼震撼"),
    _SearchItemData(text: "刘晓庆前男友报警"),
    _SearchItemData(text: "3娃打闹家长先指挥后互殴 警方通报"),
    _SearchItemData(text: "王传君交罚款为女儿摘柿子"),
    _SearchItemData(text: "女大学生夜骑开封失败让妈妈开车接"),
  ];

  @override
  void initState() {
    super.initState();
    _hotTrendsTabController =
        TabController(length: staticHotListTitleKeys.length, vsync: this);
    _resultsTabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
    _focusNode = FocusNode();

    // 处理传入的参数
    _handleExtraParams();

    // 如果设置了自动聚焦，在下一帧请求焦点
    if (_shouldAutoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _focusNode.requestFocus();
        }
      });
    }

    _searchController.addListener(() {
      final newQuery = _searchController.text;
      if (_searchQuery != newQuery) {
        setState(() {
          _searchQuery = newQuery;
          if (newQuery.isNotEmpty) {
            if (_currentBody != _SearchBodyMode.results) {
              _currentBody = _SearchBodyMode.suggestions;
            }
          } else {
            _currentBody = _SearchBodyMode.hotTrends;
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

  void _handleExtraParams() {
    final extra = widget.extra;
    if (extra != null) {
      final searchMode = extra['searchMode'] as String?;
      final searchType = extra['searchType'] as String?;
      final initialTab = extra['initialTab'] as int?;
      final autoFocus = extra['autoFocus'] as bool? ?? false;

      // 处理初始tab设置
      if (initialTab != null && initialTab >= 0 && initialTab < _resultsTabController.length) {
        _resultsTabController.index = initialTab;
      }

      // 处理自动聚焦
      if (autoFocus) {
        _shouldAutoFocus = true;
      }

      if (searchMode == 'user_content' && searchType != null) {
        // 用户内容搜索模式，直接进入结果页面
        setState(() {
          _currentBody = _SearchBodyMode.results;
          // 根据搜索类型设置对应的tab
          switch (searchType) {
            case 'works':
              _resultsTabController.index = 0;
              break;
            case 'collections':
              _resultsTabController.index = 0; // 收藏也显示在作品tab
              break;
            case 'praised':
              _resultsTabController.index = 0; // 点赞也显示在作品tab
              break;
          }
        });
      } else if (searchMode == 'author_search') {
        // 作者搜索模式，直接进入结果页面并设置搜索关键词
        final authorName = extra['authorName'] as String?;
        if (authorName != null) {
          _searchController.text = authorName;
          setState(() {
            _currentBody = _SearchBodyMode.results;
          });
        }
      }
    }
  }

  void _resetToHotTrends() {
    _searchController.clear();
    _focusNode.unfocus();
    setState(() {
      _currentBody = _SearchBodyMode.hotTrends;
    });
  }

  void _executeSearch(String keyword) {
    if (keyword.isEmpty) return;
    _focusNode.unfocus();
    _searchController.value = TextEditingValue(
      text: keyword,
      selection: TextSelection.collapsed(offset: keyword.length),
    );

    // 检测是否是用户搜索
    bool isUserSearch = _isUserRelatedSearch(keyword);

    setState(() {
      _activeSearchKeyword = keyword;
      _currentBody = _SearchBodyMode.results;

      // 如果是用户相关搜索，自动切换到用户tab
      if (isUserSearch && _resultsTabController.index != 1) {
        _resultsTabController.animateTo(1);
      }
    });

    // 执行用户搜索
    if (isUserSearch) {
      _performUserSearch(keyword);
    }
  }

  bool _isUserRelatedSearch(String keyword) {
    // 检测搜索关键词是否包含用户相关词汇
    final userKeywords = ['用户', '好友', '朋友', '联系人', '@', 'id:', 'uid:'];
    return userKeywords.any((userKeyword) =>
        keyword.toLowerCase().contains(userKeyword.toLowerCase()));
  }

  void _performUserSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _userSearchResults = [];
        _hasSearchedUsers = false;
      });
      return;
    }

    setState(() {
      _isSearchingUsers = true;
      _hasSearchedUsers = true;
    });

    // 模拟搜索延迟和结果
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          // 创建模拟的用户搜索结果
          _userSearchResults = _createMockUserResults(query);
          _isSearchingUsers = false;
        });
      }
    });
  }

  List<ChatListItem> _createMockUserResults(String query) {
    // 创建模拟的用户数据
    final mockUsers = [
      ChatListItem(
        avatar: 'https://picsum.photos/100/100?random=1',
        avatarRadius: 25.w,
        friendName: '用户_${query}_001',
        message: '这是关于 $query 的用户',
        notice: false,
        underline: true,
        lastedTime: '刚刚',
        badge: null,
        onPressed: () {},
      ),
      ChatListItem(
        avatar: 'https://picsum.photos/100/100?random=2',
        avatarRadius: 25.w,
        friendName: '$query达人',
        message: '专注于 $query 的内容创作',
        notice: false,
        underline: true,
        lastedTime: '1小时前',
        badge: null,
        onPressed: () {},
      ),
      ChatListItem(
        avatar: 'https://picsum.photos/100/100?random=3',
        avatarRadius: 25.w,
        friendName: '$query爱好者',
        message: '热爱分享 $query 相关内容',
        notice: false,
        underline: false,
        lastedTime: '2小时前',
        badge: null,
        onPressed: () {},
      ),
    ];

    return mockUsers;
  }

  String _getHotTitleFromKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'douyinHotTrends':
        return l10n.douyinHotTrends;
      case 'cityHotTrends':
        return l10n.cityHotTrends;
      case 'liveHotTrends':
        return l10n.liveHotTrends;
      case 'groupBuyHotTrends':
        return l10n.groupBuyHotTrends;
      case 'brandHotTrends':
        return l10n.brandHotTrends;
      case 'musicHotTrends':
        return l10n.musicHotTrends;
      case 'techHotTrends':
        return l10n.techHotTrends;
      case 'autoHotTrends':
        return l10n.autoHotTrends;
      case 'idiotList':
        return l10n.idiotList;
      case 'richList':
        return l10n.richList;
      case 'prankList':
        return l10n.prankList;
      case 'horrorList':
        return l10n.horrorList;
      case 'kidsList':
        return l10n.kidsList;
      case 'goodPersonList':
        return l10n.goodPersonList;
      case 'badPersonList':
        return l10n.badPersonList;
      case 'rockList':
        return l10n.rockList;
      case 'movieList':
        return l10n.movieList;
      case 'tvSeriesList':
        return l10n.tvSeriesList;
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

        // 在构建时也检查参数，确保参数被正确处理
        if (widget.extra != null && !_shouldAutoFocus) {
          final autoFocus = widget.extra!['autoFocus'] as bool? ?? false;
          if (autoFocus) {
            _shouldAutoFocus = true;
          }
        }

        // Handle auto-focus after build
        if (_shouldAutoFocus) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _focusNode.requestFocus();
              setState(() {
                _shouldAutoFocus = false;
              });
            }
          });
        }

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
      case _SearchBodyMode.hotTrends:
        return _buildInitialContent(l10n);
      case _SearchBodyMode.suggestions:
        return _buildSuggestionsContent(theme);
      case _SearchBodyMode.results:
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
            if (_currentBody != _SearchBodyMode.hotTrends)
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
                    if (_currentBody == _SearchBodyMode.results) {
                      setState(() {
                        _currentBody = _SearchBodyMode.suggestions;
                      });
                    }
                  },
                  style: TextStyle(fontSize: 30.w),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.w),
                    border: InputBorder.none,
                    hintText: "搜索",
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
            fontSize: 28.w, // 选中时字体变小
            fontWeight: FontWeight.normal, // 选中时字体变粗
            color: Colors.black, // 选中时字体变黑
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 28.w, // 未选中时字体稍大
            fontWeight: FontWeight.normal, // 未选中时字体正常
            color: Colors.grey, // 未选中时字体灰色
          ),
          tabs: const [
            Tab(text: '作品'),
            Tab(text: '用户'),
            Tab(text: '小程序'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _resultsTabController,
            children: [
              VigaInsComponent(
                key: ValueKey(_activeSearchKeyword),
                searchMode: widget.extra?['searchMode'],
                searchType: widget.extra?['searchType'],
              ),
              _buildUserSearchResults(),
              const Center(child: Text('小程序搜索结果占位')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInitialContent(AppLocalizations l10n) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: buildSection(
              title: l10n.searchHistory,
              data: staticHistoryData,
              l10n: l10n,
              actionIcon: Icons.delete_outline,
            ),
          ),
          SliverToBoxAdapter(
            child: buildSection(
              title: l10n.guessYouWantToSearch,
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
          // [CORRECTED AND FINALIZED] The TabBarView for hot trends is now here
          SliverToBoxAdapter(
            child: SizedBox(
              // Calculate height for a non-scrolling view
              height: (92.w * _hotListItemCount) +
                  122.w, // (item height + margin) * count + button height
              child: TabBarView(
                controller: _hotTrendsTabController,
                children: staticHotListTitleKeys.map((_) {
                  return hotListWidget(staticHotData, Theme.of(context), l10n);
                }).toList(),
              ),
            ),
          ),
          // [CORRECTED AND FINALIZED] Added the spacing back
          SliverToBoxAdapter(
            child: SizedBox(height: 20.w),
          ),
        ];
      },
      body: VigaInsComponent(enableScroll: false),
    );
  }

  Widget _buildUserSearchResults() {
    if (_isSearchingUsers) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    if (!_hasSearchedUsers) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80.w,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 20.w),
            Text(
              '搜索用户、好友或联系人',
              style: TextStyle(
                fontSize: 28.w,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    if (_userSearchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80.w,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 20.w),
            Text(
              '没有找到相关用户',
              style: TextStyle(
                fontSize: 28.w,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 10.w),
            Text(
              '试试其他关键词',
              style: TextStyle(
                fontSize: 24.w,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _userSearchResults.length,
      itemBuilder: (context, index) {
        final userItem = _userSearchResults[index];
        return ChatListItem(
          avatar: userItem.avatar,
          avatarRadius: 25.w,
          friendName: userItem.friendName,
          message: userItem.message,
          notice: false,
          underline: index < _userSearchResults.length - 1,
          lastedTime: '',
          badge: null,
          onPressed: () {
            // 跳转到用户详情页
            context.push(
              '/user/detail',
              extra: <String, String>{
                'title': userItem.friendName,
                'avatar': userItem.avatar,
              },
            );
          },
        );
      },
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

  // [CORRECTED AND FINALIZED] Restored the "View Full List" button and its logic.
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
            text: l10n.viewFullList,
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

