import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_work_search_widget.dart';

class VigaHomeSearchResultsPage extends StatefulWidget {
  final String initialSearchType;
  final List<String> works;
  final List<String> collections;
  final List<String> praised;
  final String? searchKeyword;

  const VigaHomeSearchResultsPage({
    super.key,
    required this.initialSearchType,
    required this.works,
    required this.collections,
    required this.praised,
    this.searchKeyword,
  });

  @override
  State<VigaHomeSearchResultsPage> createState() => _VigaHomeSearchResultsPageState();
}

class _VigaHomeSearchResultsPageState extends State<VigaHomeSearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          // 显示搜索关键词
          if (widget.searchKeyword != null)
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
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: theme.hintColor,
                      size: 36.w,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VigaHomeSearchResultsPage(
                            initialSearchType: widget.initialSearchType,
                            works: widget.works,
                            collections: widget.collections,
                            praised: widget.praised,
                            searchKeyword: null, // 清除搜索关键词
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          // 搜索组件
          Expanded(
            child: VigaWorkSearchWidget(
              searchSources: _buildSearchSources(),
              initialSourceId: widget.initialSearchType == 'author_search' ? 'works' : 'works',
              searchHint: _getSearchHint(),
            ),
          ),
        ],
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

    // 作品搜索源
    sources.add(SearchSource(
      id: 'works',
      name: '作品',
      items: _generateWorksData(),
      suggestionsBuilder: () => ['风景', '人像', '街拍', '建筑', '美食', '旅行', '艺术', '黑白', '夜景', '微距'],
    ));

    // 作者搜索源
    sources.add(SearchSource(
      id: 'authors',
      name: '作者',
      items: _generateAuthorsData(),
      suggestionsBuilder: () => ['摄影师', '美食博主', '旅行达人', '健身教练', '音乐人', '游戏主播', '时尚达人', '手工艺人'],
    ));

    // 小程序搜索源
    sources.add(SearchSource(
      id: 'miniprograms',
      name: '小程序',
      items: _generateMiniprogramsData(),
      suggestionsBuilder: () => ['工具类', '游戏类', '教育类', '生活类', '娱乐类', '购物类', '社交类', '新闻类'],
    ));

    return sources;
  }

  String _getSearchHint() {
    switch (widget.initialSearchType) {
      case 'home_search':
        return '搜索作品、作者或小程序';
      case 'author_search':
        return '搜索该作者的作品';
      default:
        return '搜索作品、作者或小程序';
    }
  }

  // 生成作品数据
  List<WorkItem> _generateWorksData() {
    if (widget.works.isNotEmpty) {
      return widget.works.map((url) => WorkItem.fromUrl(url)).toList();
    }

    // 如果没有传入数据，生成模拟数据
    return List.generate(200, (i) => WorkItem(
      id: 'home_work_$i',
      imageUrl: 'https://picsum.photos/400/600?random=${i + 20000}',
      viewCount: Random().nextInt(50000) + 1000,
      title: _getRandomWorkTitle(i),
      author: _getRandomAuthor(i),
      createTime: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    ));
  }

  // 生成作者数据
  List<WorkItem> _generateAuthorsData() {
    return List.generate(150, (i) => WorkItem(
      id: 'home_author_$i',
      imageUrl: 'https://picsum.photos/400/400?random=${i + 30000}',
      viewCount: Random().nextInt(100000) + 5000,
      title: _getRandomAuthorName(i),
      author: _getRandomAuthorName(i),
      createTime: DateTime.now().subtract(Duration(days: Random().nextInt(90))),
    ));
  }

  // 生成小程序数据
  List<WorkItem> _generateMiniprogramsData() {
    return List.generate(100, (i) => WorkItem(
      id: 'home_miniprogram_$i',
      imageUrl: 'https://picsum.photos/200/200?random=${i + 40000}',
      viewCount: Random().nextInt(80000) + 2000,
      title: _getRandomMiniprogramName(i),
      author: _getRandomDeveloperName(i),
      createTime: DateTime.now().subtract(Duration(days: Random().nextInt(60))),
    ));
  }

  String _getRandomWorkTitle(int index) {
    final titles = [
      '绝美风景摄影作品', '城市夜景延时摄影', '创意美食制作过程',
      '萌宠日常记录', '手工制作教程', '旅行vlog分享',
      '健身运动指南', '音乐翻唱作品', '舞蹈表演视频',
      '游戏精彩瞬间', '科技产品评测', '时尚穿搭分享',
      '家居装修设计', '绘画创作过程', '烹饪美食教程',
      '户外探险记录', '日常vlog', '美妆教程', '数码开箱'
    ];
    return titles[index % titles.length];
  }

  String _getRandomAuthor(int index) {
    final authors = [
      '摄影师小王', '旅行达人', '美食博主', '健身教练',
      '音乐人', '游戏主播', '时尚达人', '手工艺人',
      '绘画艺术家', '生活记录者', '科技测评师', '萌宠博主',
      '户外探险家', '美妆达人', '数码博主', '生活分享家'
    ];
    return authors[index % authors.length];
  }

  String _getRandomAuthorName(int index) {
    final authorNames = [
      '创意摄影师', '旅行记录者', '美食制作家', '生活美学家',
      '运动达人', '音乐创作者', '时尚搭配师', '手工艺术家',
      '视觉设计师', '内容创作者', '科技爱好者', '宠物护理师',
      '户外探险家', '美妆专家', '数码评测师', '生活分享家'
    ];
    return authorNames[index % authorNames.length];
  }

  String _getRandomMiniprogramName(int index) {
    final miniprogramNames = [
      '图片处理工具', '天气查询助手', '备忘录管理器', '计算器plus',
      '番茄工作法', '二维码扫描器', '文件管理器', '音乐播放器',
      '视频剪辑工具', '图片编辑器', '笔记应用', '待办事项管理',
      '汇率换算器', '翻译助手', '密码管理器', '日历应用',
      '计时器', '单位转换器', '思维导图工具', '习惯养成助手'
    ];
    return miniprogramNames[index % miniprogramNames.length];
  }

  String _getRandomDeveloperName(int index) {
    final developers = [
      '创意工作室', '技术开发团队', '设计实验室', '数字创新公司',
      '互联网科技', '移动应用开发', '软件开发组', '创意设计团队',
      '科技创新工作室', '数字产品设计', '应用开发公司', '技术工作室'
    ];
    return developers[index % developers.length];
  }
}