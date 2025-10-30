// Viga_search.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/screens/discovery/search/viga_home_search_results_page.dart';

class _SearchItemData {
  final String text;
  final bool isHot;
  const _SearchItemData({required this.text, this.isHot = false});
}

class VigaSearchPage extends StatefulWidget {
  const VigaSearchPage({super.key});

  @override
  State<VigaSearchPage> createState() => _VigaSearch();
}

// [MODIFIED] 添加 TickerProviderStateMixin
class _VigaSearch extends State<VigaSearchPage> with TickerProviderStateMixin {
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
    _SearchItemData(text: "乌克兰称已同朝鲜军队发生交战"),
    _SearchItemData(text: "最高检：五年来帮农民工讨薪2.8亿"),
    _SearchItemData(text: "班主任在家长群催缴医保 当地回应"),
    _SearchItemData(text: "国家气候中心：我国今冬大概率偏冷"),
    _SearchItemData(text: "#2024美国大选那些事儿#"),
  ];

  // [MODIFIED] 声明控制器
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(
      length: staticHotListTitleKeys.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
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

      return Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.surfaceContainer,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.w),
            margin: EdgeInsets.only(top: systemState.statusHeight),
            height: 90.w,
            color: AppColors.neutralWhite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(
                      const IconData(0xe628, fontFamily: 'Iconfont'),
                      color: AppColors.neutralDarkGrey1,
                      size: 36.w,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 65.w,
                    child: TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      cursorHeight: 35.w,
                      cursorWidth: 3.w,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          const IconData(0xe612, fontFamily: 'Iconfont'),
                          color: theme.colorScheme.onSurface,
                          size: 40.w,
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: 70.w),
                        hintText: l10n.search,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30.w,
                          color: AppColors.neutralDarkGrey14,
                        ),
                        filled: true,
                        fillColor: AppColors.neutralGrey14,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30).w,
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0.w,
                          horizontal: 20.0.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // [MODIFIED] 使用 NestedScrollView 来创建可滚动的 Sliver 头部和固定的 TabBar
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // 第一部分：可滚动内容（历史和推荐）
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    buildSection(
                      l10n.searchHistory,
                      staticHistoryData,
                      l10n,
                    ),
                    buildSection(
                      l10n.guessYouWantToSearch,
                      staticSuggestionsData,
                      l10n,
                    ),
                  ],
                ),
              ),
              // 第二部分：固定的 TabBar
              SliverPersistentHeader(
                pinned: true, // 这是让 TabBar 固定的关键
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true, // 允许 TabBar 水平滚动
                    indicatorColor: theme.colorScheme.primary,
                    labelColor: theme.colorScheme.onSurface,
                    unselectedLabelColor: Colors.grey.shade600,
                    labelStyle: TextStyle(
                      fontSize: 32.w,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(fontSize: 30.w),
                    tabAlignment: TabAlignment.start, // 左对齐
                    // 点击 Tab 时，驱动 PageView 切换
                    onTap: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    // 动态生成所有 Tab
                    tabs: staticHotListTitleKeys.map((key) {
                      return Tab(
                        text: _getHotTitleFromKey(l10n, key),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ];
          },
          // 主体内容：PageView
          body: PageView(
            controller: _pageController,
            // 滑动 PageView 时，驱动 TabBar 切换
            onPageChanged: (index) {
              _tabController.animateTo(index);
            },
            children: staticHotListTitleKeys.map((_) {
              // 每一页都返回同样的热榜列表（根据你的原代码）
              return hotListWidget(staticHotData, theme);
            }).toList(),
          ),
        ),
      );
    });
  }

  // ... [buildSection 和 hotListWidget 方法保持不变]
  Widget buildSection(
      String title, List<_SearchItemData> data, AppLocalizations l10n) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1.0.w,
          ),
        ),
      ),
      width: 750.w,
      padding: EdgeInsets.fromLTRB(
        30.w,
        10.w,
        30.w,
        10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  height: 1.08,
                  fontSize: 28.w,
                  color: AppColors.neutralDarkGrey16,
                ),
              ),
              SizedBox(
                width: 270.w,
                height: 70.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(const IconData(0xe641, fontFamily: 'Iconfont'),
                            color: AppColors.neutralDarkGrey16, size: 28.w),
                        SizedBox(width: 5.w),
                        Text(
                          l10n.changeBatch,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.neutralDarkGrey16,
                            fontSize: 28.w,
                            height: 1.08,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColors.neutralGrey23,
                      height: 24.w,
                      width: 2.w,
                    ),
                    Icon(
                      const IconData(
                        0xe657,
                        fontFamily: 'Iconfont',
                      ),
                      color: AppColors.neutralDarkGrey16,
                      size: 28.w,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 750.w,
            child: Wrap(
              children: data.map((item) {
                return GestureDetector(
                  onTap: () {
                    // 点击搜索项跳转到搜索结果页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VigaHomeSearchResultsPage(
                          initialSearchType: 'home_search',
                          works: [], // 传入空的works列表，让搜索结果页面生成模拟数据
                          collections: [],
                          praised: [],
                          searchKeyword: item.text, // 传递搜索关键词
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 345.w,
                    height: 70.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            item.text,
                            style: TextStyle(
                              fontSize: 32.w,
                              height: 1.08,
                              color: item.isHot ? AppColors.accentRedPure : null,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget hotListWidget(List<_SearchItemData> hotData, ThemeData theme) {
    final locale = Localizations.localeOf(context).toString();
    final double number = 12012000;
    final compactFormatter = NumberFormat.compact(locale: locale);
    final formattedNumber = compactFormatter.format(number);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 为了让 PageView 里的列表可以独立滚动，我们用 SingleChildScrollView 包裹
    return SingleChildScrollView(
      child: Container(
        width: 750.w,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.w,
        ),
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            ...hotData.asMap().entries.map(
              (e) {
                final item = e.value;
                return GestureDetector(
                  onTap: () {
                    // 点击热门搜索项跳转到搜索结果页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VigaHomeSearchResultsPage(
                          initialSearchType: 'home_search',
                          works: [], // 传入空的works列表，让搜索结果页面生成模拟数据
                          collections: [],
                          praised: [],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 72.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          e.key < 3
                              ? AppColors.redTransparent76
                              : AppColors.neutralGrey4,
                          AppColors.neutralWhite
                        ],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    margin: EdgeInsets.only(bottom: 15.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 37.w,
                          width: 37.w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (e.key < 3)
                                Icon(
                                  const IconData(0xe649, fontFamily: 'Iconfont'),
                                  color: AppColors.accentYellowDark2,
                                  size: 37.w,
                                ),
                              Text(
                                (e.key + 1).toString(),
                                style: TextStyle(
                                  fontSize: e.key < 3 ? 24.w : 28.w,
                                  height: 1.08,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: e.key < 3
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                                  color: e.key < 3
                                      ? AppColors.neutralWhite
                                      : AppColors.neutralGrey62,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: item.isHot
                              ? Text.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: item.text,
                                      style: TextStyle(
                                        fontSize: 32.w,
                                        height: 1.08,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Icon(
                                          const IconData(0xe71e,
                                              fontFamily: 'Iconfont'),
                                          color: AppColors.accentRedPure,
                                          size: 30.w,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              : Text(
                                  item.text,
                                  style: TextStyle(
                                    fontSize: 32.w,
                                    height: 1.08,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                        ),
                        Text(
                          formattedNumber,
                          style: TextStyle(
                            fontSize: 25.w,
                            color: AppColors.neutralGrey56,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 750.w,
              height: 90.w,
              child: Center(
                child: Text(
                  l10n.viewFullList,
                  style: TextStyle(
                    color: AppColors.accentRedPure,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// [ADDED] 创建一个辅助类来 Delegate (委托) TabBar 的构建
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface, // 背景色
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
