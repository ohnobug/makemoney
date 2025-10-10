// 文件路径: /lib/widgets/ljn_discovery.dart

import 'package:flutter/material.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';
import 'package:cached_network_image/cached_network_image.dart'; // 使用 CachedNetworkImage 提升体验

// Data model for trend items
class TrendItem {
  final String title;
  final String views;
  final IconData icon;

  TrendItem({
    required this.title,
    required this.views,
    required this.icon,
  });
}

// 【新增】Data model for hot categories
class HotCategory {
  final String title;
  final String imageUrl;

  HotCategory({
    required this.title,
    required this.imageUrl,
  });
}

class LJNDiscovery extends StatefulWidget {
  const LJNDiscovery({super.key});

  @override
  State<LJNDiscovery> createState() => _LJNDiscoveryState();
}

class _LJNDiscoveryState extends State<LJNDiscovery> {
  // Mock data for trending topics
  final List<TrendItem> trendingTopics = [
    TrendItem(
        title: "#夏日Vlog",
        views: "1.2亿次播放",
        icon: Icons.local_fire_department_rounded),
    TrendItem(
      title: "#美食探店",
      views: "8876万次播放",
      icon: Icons.fastfood_rounded,
    ),
    TrendItem(
      title: "#萌宠日常",
      views: "5432万次播放",
      icon: Icons.pets_rounded,
    ),
    TrendItem(
      title: "#旅行攻略",
      views: "4888万次播放",
      icon: Icons.flight_takeoff_rounded,
    ),
  ];

  // 【新增】为“热门分类”创建新的模拟数据
  final List<HotCategory> hotCategories = [
    HotCategory(
        title: "科技", imageUrl: "https://picsum.photos/300/400?random=201"),
    HotCategory(
        title: "时事", imageUrl: "https://picsum.photos/300/400?random=202"),
    HotCategory(
        title: "军事", imageUrl: "https://picsum.photos/300/400?random=203"),
    HotCategory(
        title: "游戏", imageUrl: "https://picsum.photos/300/400?random=204"),
    HotCategory(
        title: "旅行", imageUrl: "https://picsum.photos/300/400?random=205"),
    HotCategory(
        title: "美食", imageUrl: "https://picsum.photos/300/400?random=206"),
    HotCategory(
        title: "穿搭", imageUrl: "https://picsum.photos/300/400?random=207"),
    HotCategory(
        title: "影视", imageUrl: "https://picsum.photos/300/400?random=208"),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LJNSystemCubit>().updateMainpage2isload(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      buildWhen: (previous, current) =>
          previous.mainpage2isload != current.mainpage2isload,
      builder: (context, systemState) {
        if (systemState.mainpage2isload!) {
          return _buildPageContent(context, systemState);
        } else {
          return const LJNPageLoading();
        }
      },
    );
  }

  Widget _buildPageContent(BuildContext context, SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      primary: false,
      appBar: null,
      // 使用 SafeArea 来确保内容不会被系统UI（如状态栏）遮挡
      body: SafeArea(
        // 使用 ListView 来组织页面内容
        child: ListView(
          padding: EdgeInsets.only(bottom: 50.w), // 底部留出一些空间
          children: [
            // 搜索框
            _buildSearchBar(theme),
            // Banner
            _buildBanner(),
            // 服务与功能
            _buildServicesSection(theme, l10n, systemState),
            // 【间距调整】
            SizedBox(height: 50.w),
            // 热门趋势
            _buildTrendingSection(theme),
            // 【间距调整】
            SizedBox(height: 50.w),
            // 【核心改动】调用新的“热门分类”构建方法
            _buildHotCategoriesSection(theme),
          ],
        ),
      ),
    );
  }

  // --- UI 构建辅助方法 ---

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
        child: Container(
          height: 70.w,
          decoration: BoxDecoration(
            color: theme.dividerColor.withAlpha(128),
            borderRadius: BorderRadius.circular(35.w),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Icon(
                  const IconData(0xe612, fontFamily: 'Iconfont'),
                  color: theme.hintColor,
                  size: 36.w,
                ),
              ),
              Text(
                "搜索你感兴趣的内容",
                style: TextStyle(
                  fontSize: 28.w,
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection(
      ThemeData theme, AppLocalizations l10n, SystemState systemState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("服务与功能", theme),
        // SizedBox(height: 20.w), // 标题和内容之间的间距
        LJNFunctionList(
          children: [
            LJNFunctionItem(
              title: "心情时刻",
              icon: "images/icon/discovery_icon1.png",
              link: '/friendmoments',
              underline: true,
            ),
            LJNFunctionItem(
              title: "图片墙",
              icon: "images/icon/discovery_icon2.png",
              link: '/ins',
              underline: true,
            ),
            LJNFunctionItem(
              title: "小程序",
              icon: "images/icon/discovery_icon5.png",
              link: '/miniprogram_list',
              underline: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.w),
          child: Image.asset(
            assetPath('images/imgs/i.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme,
      {bool showMore = true}) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 32.w,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          if (showMore)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "查看全部",
                    style: TextStyle(fontSize: 24.w, color: theme.hintColor),
                  ),
                  WidgetSpan(child: SizedBox(width: 10.w)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      const IconData(0xed9d, fontFamily: 'Iconfont'),
                      size: 20.0.w,
                      color: theme.colorScheme.onSurface.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection(ThemeData theme) {
    return Column(
      children: [
        _buildSectionHeader("热门趋势", theme),
        SizedBox(height: 20.w),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              children: trendingTopics.map((item) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.dividerColor.withAlpha(204),
                    child: Icon(item.icon,
                        color: theme.colorScheme.primary, size: 40.w),
                  ),
                  title: Text(item.title,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(item.views,
                      style: TextStyle(color: theme.hintColor, fontSize: 24.w)),
                  trailing: Icon(Icons.chevron_right, color: theme.hintColor),
                  onTap: () {},
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // --- 【核心改动】 ---
  // 这是新的“热门分类”构建方法
  Widget _buildHotCategoriesSection(ThemeData theme) {
    return Column(
      children: [
        // 1. 修改标题
        _buildSectionHeader("热门分类", theme, showMore: false),
        SizedBox(height: 20.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: hotCategories.length, // 使用新的数据源
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.w,
              childAspectRatio: 16 / 9, // 调整宽高比以适应标题
            ),
            itemBuilder: (context, index) {
              final category = hotCategories[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                // 使用 Stack 来堆叠图片、遮罩和文字
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 背景图片
                    CachedNetworkImage(
                      imageUrl: category.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade300),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade300,
                        child: Icon(Icons.error),
                      ),
                    ),
                    // 半透明黑色遮罩
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(90), // 调整透明度
                      ),
                    ),
                    // 居中的分类标题
                    Center(
                      child: Text(
                        category.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.w,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 8.0,
                              color: Colors.black.withAlpha(192),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 添加一个 InkWell 使其可以被点击
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // 在这里处理点击事件，例如导航到分类页面
                          logger.info("Tapped on ${category.title}");
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
