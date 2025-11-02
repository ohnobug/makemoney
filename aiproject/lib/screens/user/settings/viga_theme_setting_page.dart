import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

// [改动 1] 创建一个新的数据模型来表示主题选项
class ThemeOption {
  final ThemeMode mode; // 主题模式 (system, light, dark)
  final String name; // 显示给用户的名称

  const ThemeOption({
    required this.mode,
    required this.name,
  });
}

class VigaThemeSettingPage extends StatefulWidget {
  const VigaThemeSettingPage({super.key});

  @override
  State<VigaThemeSettingPage> createState() => _VigaThemeSettingPageState();
}

class _VigaThemeSettingPageState extends State<VigaThemeSettingPage> {
  final List<ThemeOption> _themeOptions = const [
    ThemeOption(mode: ThemeMode.system, name: '跟随系统'),
    ThemeOption(mode: ThemeMode.light, name: '浅色模式'),
    ThemeOption(mode: ThemeMode.dark, name: '深色模式'),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 使用 BlocBuilder 来监听 VigaSystemCubit 的状态变化
    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        // [改动 3] 获取当前选中的主题模式
        final currentThemeMode = systemState.themeMode;

        return Scaffold(
          // 使用当前主题的背景色
          backgroundColor: theme.colorScheme.surfaceContainer,
          appBar: const VigaAppBar(
            title: '外观', // AppBar 标题更新
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.w),
            children: [
              // [改动 4] UI 结构简化，直接显示主题选项卡片
              _buildThemeCard(_themeOptions, currentThemeMode),
            ],
          ),
        );
      },
    );
  }

  /// 构建包含主题列表的卡片
  Widget _buildThemeCard(List<ThemeOption> options, ThemeMode currentMode) {
    ThemeData theme = Theme.of(context);

    return Card(
      // 使用当前主题的卡片颜色
      color: theme.cardTheme.color ?? theme.colorScheme.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          // [改动 5] 检查当前主题是否被选中，逻辑更简单
          final isSelected = option.mode == currentMode;
          return _buildThemeTile(option, isSelected);
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 1,
          color: theme.dividerColor.withAlpha(25),
          indent: 32.w,
          endIndent: 32.w,
        ),
      ),
    );
  }

  /// 构建单个主题条目
  Widget _buildThemeTile(ThemeOption option, bool isSelected) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      title: Text(
        option.name,
        style: TextStyle(
          fontSize: 32.w,
          fontWeight: FontWeight.w500,
          // 使用当前主题的文本颜色
          color: theme.colorScheme.onSurface,
        ),
      ),
      // [改动 6] UI 简化，移除了副标题
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded, // 使用一个更现代的图标
              // 使用当前主题的主色
              color: theme.colorScheme.primary,
              size: 44.w,
            )
          : Icon(
              Icons.circle_outlined, // 未选中时显示空心圆
              color: theme.colorScheme.onSurface.withAlpha(75),
              size: 44.w,
            ),
      onTap: () {
        // [改动 7] 当用户点击时，调用 Cubit 更新主题模式
        context.read<VigaSystemCubit>().updateThemeMode(option.mode);
      },
    );
  }
}
