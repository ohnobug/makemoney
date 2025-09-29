// /lib/widgets/ljn_discovery.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:vigaviga/widgets/ljn_function_item.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart'; // 确保 LJNPageLoading 的路径正确

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
      // 性能优化：仅在 mainpage2isload 变化时才重建
      buildWhen: (previous, current) =>
          previous.mainpage2isload != current.mainpage2isload,
      builder: (context, systemState) {
        // [核心修复] 添加加载状态判断
        if (systemState.mainpage2isload!) {
          // 如果已加载，则构建页面内容
          return _buildPageContent(context, systemState);
        } else {
          // 如果未加载，则显示加载动画
          return const LJNPageLoading();
        }
      },
    );
  }

  // 将页面内容构建逻辑提取到一个单独的方法中，使代码更清晰
  Widget _buildPageContent(BuildContext context, SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      primary: false,
      appBar: null,
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: 90.w + systemState.statusHeight),
        child: ListView(
          children: [
            _buildSearchBar(theme),
            _buildServicesSection(theme, l10n, systemState),
            _buildBanner(),
            _buildTrendingSection(theme),
            _buildRecommendedSection(theme),
          ],
        ),
      ),
    );
  }

  // --- 以下是 UI 构建辅助方法，无需修改 ---

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        30.w,
        20.w,
        30.w,
        0,
      ),
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
    );
  }

  Widget _buildServicesSection(
      ThemeData theme, AppLocalizations l10n, SystemState systemState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            30.w,
            40.w,
            30.w,
            0,
          ),
          child: _buildSectionHeader("服务与功能", theme),
        ),
        SizedBox(height: 20.w),
        LJNFunctionList(
          children: [
            LJNFunctionItem(
              title: l10n.moments,
              icon: "images/icon/discovery_icon1.png",
              link: '/friendmoments',
              underline: true,
            ),
            LJNFunctionItem(
              title: "看看",
              icon: "images/icon/discovery_icon2.png",
              link: '/ins',
              underline: true,
            ),
            LJNFunctionItem(
              title: l10n.scan,
              icon: "images/icon/discovery_icon4.png",
              link: '/qrcode_scanner',
              underline: false,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 40.w,
      ),
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

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Row(
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
        Text(
          "查看全部 >",
          style: TextStyle(
            fontSize: 26.w,
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        30.w,
        0,
        30.w,
        0,
      ),
      child: Column(
        children: [
          _buildSectionHeader("热门趋势", theme),
          SizedBox(height: 20.w),
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              children: trendingTopics.map((item) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.dividerColor.withAlpha(204),
                    child: Icon(
                      item.icon,
                      color: theme.colorScheme.primary,
                      size: 40.w,
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    item.views,
                    style: TextStyle(
                      color: theme.hintColor,
                      fontSize: 24.w,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: theme.hintColor,
                  ),
                  onTap: () {},
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.w, 50.w, 30.w, 30.w),
      child: Column(
        children: [
          _buildSectionHeader("为你推荐", theme),
          SizedBox(height: 20.w),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.w,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.w),
                child: Container(
                  color: Theme.of(context).dividerColor,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://picsum.photos/300/400?random=$index',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withAlpha(153),
                                Colors.transparent
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 28.w,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '${(index * 1.2 * 100).toInt()}k',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.w,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
