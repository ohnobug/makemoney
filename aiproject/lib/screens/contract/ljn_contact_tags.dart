import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_search.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 关键改动 1: 创建一个数据模型来存储静态数据
class _TagInfoData {
  final String title;
  final String icon;
  final bool underline;

  const _TagInfoData({
    required this.title,
    required this.icon,
    this.underline = true,
  });
}

class LJNContactTags extends StatefulWidget {
  const LJNContactTags({super.key});

  @override
  State<LJNContactTags> createState() => _LJNContactTagsState();
}

class _LJNContactTagsState extends State<LJNContactTags> {
  // 关键改动 2: tagDataList 只存储不依赖 context 的静态数据模型
  // 列表现在包含了所有原始数据，未经省略。
  final List<_TagInfoData> tagDataList = const [
    _TagInfoData(title: "天空飘来五个字那都不是事", icon: "images/avatar_webp/chat_1.webp"),
    _TagInfoData(title: "本因", icon: "images/avatar_webp/chat_10.webp"),
    _TagInfoData(title: "赵洵", icon: "images/avatar_webp/chat_11.webp"),
    _TagInfoData(title: "定静师太", icon: "images/avatar_webp/chat_12.webp"),
    _TagInfoData(title: "李秋水", icon: "images/avatar_webp/chat_13.webp"),
    _TagInfoData(title: "谭婆", icon: "images/avatar_webp/chat_14.webp"),
    _TagInfoData(title: "李傀儡", icon: "images/avatar_webp/chat_15.webp"),
    _TagInfoData(title: "貂禅", icon: "images/avatar_webp/chat_16.webp"),
    _TagInfoData(title: "何三七", icon: "images/avatar_webp/chat_17.webp"),
    _TagInfoData(title: "孔融", icon: "images/avatar_webp/chat_18.webp"),
    _TagInfoData(title: "齐堂主", icon: "images/avatar_webp/chat_19.webp"),
    _TagInfoData(title: "博尔术", icon: "images/avatar_webp/chat_20.webp"),
    _TagInfoData(title: "王语嫣", icon: "images/avatar_webp/chat_21.webp"),
    _TagInfoData(title: "秦红棉", icon: "images/avatar_webp/chat_22.webp"),
    _TagInfoData(
        title: "天竺僧人",
        icon: "images/avatar_webp/chat_23.webp",
        underline: false), // 假设天竺僧人没有头像icon，这里可以传空字符串或默认值
    _TagInfoData(title: "段延庆", icon: "images/avatar_webp/chat_33.webp"),
    _TagInfoData(title: "令狐冲", icon: "images/avatar_webp/chat_34.webp"),
    _TagInfoData(title: "英白罗", icon: "images/avatar_webp/chat_35.webp"),
    _TagInfoData(title: "黄药师", icon: "images/avatar_webp/chat_36.webp"),
    _TagInfoData(title: "李煜", icon: "images/avatar_webp/chat_37.webp"),
    _TagInfoData(title: "云中鹤", icon: "images/avatar_webp/chat_38.webp"),
    _TagInfoData(title: "劳德诺", icon: "images/avatar_webp/chat_39.webp"),
    _TagInfoData(title: "包惜弱", icon: "images/avatar_webp/chat_40.webp"),
    _TagInfoData(title: "游驹", icon: "images/avatar_webp/chat_41.webp"),
    _TagInfoData(title: "钟万仇", icon: "images/avatar_webp/chat_42.webp"),
    _TagInfoData(title: "渔人", icon: "images/avatar_webp/chat_43.webp"),
    _TagInfoData(title: "单叔山", icon: "images/avatar_webp/chat_44.webp"),
    _TagInfoData(title: "段誉", icon: "images/avatar_webp/chat_45.webp"),
    _TagInfoData(title: "林震南", icon: "images/avatar_webp/chat_46.webp"),
    _TagInfoData(title: "商鞅", icon: "images/avatar_webp/chat_47.webp"),
  ];

  @override
  void initState() {
    super.initState();
  }

  // 关键改动 3: 移除整个 didChangeDependencies 方法

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  Widget _buildPage(SystemState systemState) {
    // 关键改动 4: 在 build 方法内部获取最新的 l10n 实例
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.contactTags, // 使用 l10n 获取标题
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  AppColors.neutralWhite
                ],
                stops: [0.3, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                LJNSearch(
                  link: '/search_friend',
                  title: l10n.search, // 使用 l10n 获取搜索提示
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      primary: false,
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: tagDataList.length + 1, // +1 用于底部的统计行
                      itemBuilder: (context, index) {
                        // 关键改动 5: 在 itemBuilder 中动态构建 UI
                        if (index < tagDataList.length) {
                          final tagData = tagDataList[index];
                          return TagInformation(
                            title: tagData.title,
                            underline: tagData.underline,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/contact_tag_group',
                                arguments: <String, String>{
                                  'title': tagData.title,
                                  'icon': tagData.icon,
                                },
                              );
                            },
                          );
                        } else {
                          // 构建底部的统计行
                          return Container(
                            width: 750.w,
                            height: 105.0.w,
                            color: AppColors.neutralWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.tagCount(
                                      tagDataList.length), // 使用 l10n 和动态数量
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(30.w),
                                    color: AppColors.neutralGrey67,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  height: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  decoration: BoxDecoration(
                    color: AppColors.neutralGrey2,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.neutralGrey20,
                        width: 1.5.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.newAction, // 使用 l10n
                        style: TextStyle(
                            fontSize: 30.w,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      Text(
                        l10n.edit, // 使用 l10n
                        style: TextStyle(
                            fontSize: 30.w,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TagInformation extends StatefulWidget {
  final String title;
  final bool underline;
  final int? showStyle;
  final Function()? onPressed;

  const TagInformation({
    super.key,
    required this.title,
    required this.underline,
    this.showStyle,
    this.onPressed,
  });

  @override
  State<TagInformation> createState() => _TagInformationState();
}

class _TagInformationState extends State<TagInformation> {
  late Color containerColor =
      Theme.of(context).listTileTheme.tileColor!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tapDownDetails) {
        if (widget.onPressed == null) return;
        setState(() => containerColor =
            Theme.of(context).listTileTheme.selectedTileColor!);
      },
      onTapCancel: () {
        if (widget.onPressed == null) return;
        setState(
            () => containerColor = Theme.of(context).listTileTheme.tileColor!);
      },
      onTapUp: (tapDownDetails) {
        if (widget.onPressed == null) return;
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            if (mounted) {
              // 检查 widget 是否还在树中
              setState(() =>
                  containerColor = Theme.of(context).listTileTheme.tileColor!);
              widget.onPressed?.call();
            }
          },
        );
      },
      child: Container(
        height: 120.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        color: containerColor,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 115.w, // 稍小于父容器高度以显示下划线
                width: 400.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? BorderSide(
                            color: Theme.of(context)
                                .listTileTheme
                                .selectedTileColor!,
                            width: 1.5.w,
                            style: BorderStyle.solid,
                          )
                        : BorderSide.none,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(33.0.w),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 8.0.w),
                        Text(
                          '(10)', // 注意：这个数字是硬编码的
                          style: TextStyle(
                            fontSize: fontSizeScale(24.0.w),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0.w),
                    Text(
                      '刘浩，牛人', // 注意：这个子标题是硬编码的
                      style: TextStyle(
                        fontSize: fontSizeScale(24.0.w),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
