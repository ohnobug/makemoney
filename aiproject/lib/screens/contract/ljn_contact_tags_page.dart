import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/api_manager/api.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/ljn_search.dart';

class LJNContactTagsPage extends StatefulWidget {
  const LJNContactTagsPage({super.key});

  @override
  State<LJNContactTagsPage> createState() => _LJNContactTagsState();
}

class _LJNContactTagsState extends State<LJNContactTagsPage> {
  // 列表包含了所有原始数据
  final List<TagInfoData> tagDataList = getTagInfoData();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  Widget _buildPage(SystemState systemState) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      primary: false,
      appBar: LJNAppBar(
        title: l10n.contactTags,
      ),
      body: Stack(
        children: [
          Container(
            width: 750.w,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.surface, AppColors.neutralWhite],
                stops: [0.3, 0.5],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                LJNSearch(
                  link: '/search_friend',
                  title: l10n.search,
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
                                  l10n.tagCount(tagDataList.length),
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
                        color: theme.dividerColor,
                        width: 1.0.w,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.newAction,
                        style: TextStyle(
                            fontSize: 30.w, color: theme.colorScheme.onSurface),
                      ),
                      Text(
                        l10n.edit,
                        style: TextStyle(
                            fontSize: 30.w, color: theme.colorScheme.onSurface),
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
  // 唯一的内部状态：只记录该项是否被用户按下。
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 核心修正：在 build 方法内部获取所有依赖于外部环境（如 Theme）的值。
    ThemeData theme = Theme.of(context);

    final Color normalColor = theme.listTileTheme.tileColor!;
    final Color pressedColor = theme.listTileTheme.selectedTileColor!;

    // 根据内部状态 _isPressed，动态地计算出当前应该显示的背景颜色。
    final Color currentColor = _isPressed ? pressedColor : normalColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (tapDownDetails) {
        if (widget.onPressed == null) return;
        setState(() {
          _isPressed = true;
        });
      },
      onTapCancel: () {
        if (widget.onPressed == null) return;

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapUp: (tapDownDetails) {
        if (widget.onPressed == null) return;

        // 2. 延迟执行回调
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            setState(() {
              _isPressed = false;
            });
            if (mounted) {
              widget.onPressed?.call();
            }
          },
        );
      },
      child: Container(
        height: 120.0.w,
        padding: const EdgeInsets.only(left: 30.0, right: 0.0).w,
        // 使用在 build 方法开头计算出的正确颜色
        color: currentColor,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 115.w,
                width: 400.w,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: widget.underline
                        ? (theme.listTileTheme.shape as RoundedRectangleBorder)
                            .side
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
