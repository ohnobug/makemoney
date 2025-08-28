import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

// 关键改动 1: 创建一个数据模型来存储静态数据
class _SearchItemData {
  final String text;
  final bool isHot; // For "suggestions" and "hot list" items
  const _SearchItemData({required this.text, this.isHot = false});
}

class LJNSearch extends StatefulWidget {
  const LJNSearch({super.key});

  @override
  State<LJNSearch> createState() => _LJNSearch();
}

class _LJNSearch extends State<LJNSearch> {
  // 关键改动 2: 将所有列表数据转换为不依赖 context 的静态数据模型
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

  PageController pageController = PageController();
  double pageControllerOffset = 0;

  GlobalKey historyKey = GlobalKey();
  double historyHeight = 0;

  int lastedTapHotTitleKey = -1;

  int hotListCurrentPage = 0;
  PageController hotListController = PageController();
  final Map<int, GlobalKey> hotListTitlesKeys = {};
  GlobalKey hotTitleBoxKey = GlobalKey();
  ScrollController hotTitleBoxController = ScrollController();

  double hotTitleBoxTop = 0;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      if (mounted) {
        setState(() => pageControllerOffset = pageController.offset);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final historyKeyContext = historyKey.currentContext;
      if (historyKeyContext != null) {
        final renderBox = historyKeyContext.findRenderObject() as RenderBox?;
        if (renderBox != null && mounted) {
          setState(() => historyHeight = renderBox.size.height);
        }
      }
    });

    staticHotListTitleKeys.asMap().forEach((key, _) {
      hotListTitlesKeys[key] = GlobalKey();
    });
  }

  // 关键改动 3: 移除整个 didChangeDependencies 方法

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

  bool isItemVisibleAndMove(int index) {
    // This logic remains the same as it deals with layout, not data.
    final GlobalKey? itemKey = hotListTitlesKeys[index];
    if (itemKey != null &&
        itemKey.currentContext != null &&
        hotTitleBoxKey.currentContext != null) {
      final RenderBox? parentRenderBox =
          hotTitleBoxKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? childRenderBox =
          itemKey.currentContext?.findRenderObject() as RenderBox?;
      if (parentRenderBox != null && childRenderBox != null) {
        final childOffset = childRenderBox.localToGlobal(Offset.zero,
            ancestor: parentRenderBox);
        final scrollOffset = hotTitleBoxController.offset;
        final parentWidth = parentRenderBox.size.width;
        final childWidth = childRenderBox.size.width;

        final childLeft = childOffset.dx;
        final childRight = childLeft + childWidth;

        if (childLeft < scrollOffset) {
          hotTitleBoxController.animateTo(childLeft,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        } else if (childRight > scrollOffset + parentWidth) {
          hotTitleBoxController.animateTo(childRight - parentWidth,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      double mytop = 0;
      if (pageControllerOffset > historyHeight) {
        mytop = -1.w;
      } else {
        mytop = historyHeight - pageControllerOffset;
      }

      // 关键改动 4: 在 build 方法内部获取最新的 l10n 实例
      final l10n = AppLocalizations.of(context)!;

      return Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
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
                    color: AppColors.transparent,
                    child: Icon(const IconData(0xed9e, fontFamily: 'Iconfont'),
                        color: AppColors.neutralDarkGrey1, size: 36.w),
                  ),
                ),
                Expanded(
                  flex: 1,
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
                            color: AppColors.neutralBlack,
                            size: 40.w),
                        prefixIconConstraints: BoxConstraints(minWidth: 70.w),
                        hintText: l10n.search,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 30.w,
                            color: AppColors.neutralDarkGrey14),
                        filled: true,
                        fillColor: AppColors.neutralGrey14,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0.w, horizontal: 20.0.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                primary: false,
                controller: pageController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Column(
                      key: historyKey,
                      children: [
                        // History
                        buildSection(
                            l10n.searchHistory, staticHistoryData, l10n),
                        // Suggestions for you
                        buildSection(l10n.guessYouWantToSearch,
                            staticSuggestionsData, l10n),
                      ],
                    ),
                    SizedBox(height: 110.w),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: (staticHotData.length * (72.w + 15.w) + 90.w),
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: hotListController,
                        onPageChanged: (index) {
                          setState(() {
                            hotListCurrentPage = index;
                            if (lastedTapHotTitleKey == -1) {
                              isItemVisibleAndMove(index);
                            }
                          });
                        },
                        // 关键改动 5: 动态构建 PageView 的 children
                        children: staticHotListTitleKeys.map((_) {
                          return hotListWidget(staticHotData);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: mytop,
              child: Container(
                color: AppColors.neutralWhite,
                key: hotTitleBoxKey,
                alignment: Alignment.center,
                height: 110.w,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller: hotTitleBoxController,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: staticHotListTitleKeys.asMap().entries.map((e) {
                      return GestureDetector(
                        onTap: () {
                          if (lastedTapHotTitleKey != -1) return;
                          lastedTapHotTitleKey = e.key;
                          hotListController
                              .animateToPage(e.key,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear)
                              .then((_) {
                            if (mounted) {
                              setState(() {
                                lastedTapHotTitleKey = -1;
                                int pageIndex = hotListController.page!.round();
                                isItemVisibleAndMove(pageIndex);
                              });
                            }
                          });
                        },
                        // 关键改动 6: 动态构建标题
                        child: hotListTitleBuild(
                            hotListTitlesKeys[e.key]!,
                            _getHotTitleFromKey(l10n, e.value),
                            hotListCurrentPage == e.key),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper widget for History and Suggestions sections
  Widget buildSection(
      String title, List<_SearchItemData> data, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.neutralGrey8, width: 1.0.w))),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(30.w, 10.w, 30.w, 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      height: 1.08,
                      fontSize: 28.w,
                      color: AppColors.neutralDarkGrey16)),
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
                        Text(l10n.changeBatch,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.neutralDarkGrey16,
                                fontSize: 28.w,
                                height: 1.08)),
                      ],
                    ),
                    Container(
                        color: AppColors.neutralGrey23,
                        height: 24.w,
                        width: 2.w),
                    Icon(const IconData(0xe657, fontFamily: 'Iconfont'),
                        color: AppColors.neutralDarkGrey16, size: 28.w),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              children: data.map((item) {
                return SizedBox(
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
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget hotListWidget(List<_SearchItemData> hotData) {
    final locale = Localizations.localeOf(context).toString();
    final double number = 12012000;
    final compactFormatter = NumberFormat.compact(locale: locale);
    final formattedNumber = compactFormatter.format(number);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          ...hotData.asMap().entries.map(
            (e) {
              final item = e.value;
              return Container(
                height: 72.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      e.key < 3
                          ? AppColors.neutralOffWhitePink
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
                            Icon(const IconData(0xe649, fontFamily: 'Iconfont'),
                                color: AppColors.accentYellowDark2, size: 37.w),
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
                                        fontSize: 32.w, height: 1.08)),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.w),
                                    child: Icon(
                                        const IconData(0xe71e,
                                            fontFamily: 'Iconfont'),
                                        color: AppColors.accentRedPure,
                                        size: 30.w),
                                  ),
                                ),
                              ]),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          : Text(
                              item.text,
                              style: TextStyle(fontSize: 32.w, height: 1.08),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                    ),
                    Text(formattedNumber,
                        style: TextStyle(
                            fontSize: 25.w, color: AppColors.neutralGrey56)),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 90.w,
            child: Center(
              child: Text(
                l10n.viewFullList,
                style: TextStyle(color: AppColors.accentRedPure),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget hotListTitleBuild(GlobalKey key, String title, bool selected) {
    return Container(
      key: key,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        title,
        style: TextStyle(
          height: 1.08,
          fontSize: selected ? 32.w : 30.w,
          fontFamily: "AlibabaPuHuiTi-Medium",
          color: selected ? const Color(0xFF151515) : const Color(0xFF747474),
        ),
      ),
    );
  }
}
