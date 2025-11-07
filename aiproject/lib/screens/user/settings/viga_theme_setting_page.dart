import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/l10n/app_localizations.dart';

// [改动 1] 创建一个新的数据模型来表示主题选项
class ThemeOption {
  final ThemeMode mode; // 主题模式 (system, light, dark)
  final String name; // 显示给用户的名称
  final String description; // 描述信息

  const ThemeOption({
    required this.mode,
    required this.name,
    required this.description,
  });
}

class VigaThemeSettingPage extends StatefulWidget {
  const VigaThemeSettingPage({super.key});

  @override
  State<VigaThemeSettingPage> createState() => _VigaThemeSettingPageState();
}

class _VigaThemeSettingPageState extends State<VigaThemeSettingPage> {
  final List<ThemeOption> _themeOptions = const [
    ThemeOption(mode: ThemeMode.system, name: '跟随系统', description: '自动跟随系统主题'),
    ThemeOption(mode: ThemeMode.light, name: '浅色模式', description: '使用明亮的浅色主题'),
    ThemeOption(mode: ThemeMode.dark, name: '深色模式', description: '使用护眼的深色主题'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    // 使用 BlocBuilder 来监听 VigaSystemCubit 的状态变化
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: VigaAppBar(
          title: l10n.themeSetting,
        ),
        body: BlocBuilder<VigaSystemCubit, SystemState>(
          builder: (context, systemState) {
            final currentThemeMode = systemState.themeMode;

            // 直接在 Body 中构建列表，更加清晰
            return Container(
              margin: EdgeInsets.only(top: 50.w, left: 30.w, right: 30.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12.w,
                    offset: Offset(0, 4.w),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _themeOptions.length,
                  itemBuilder: (context, index) {
                    final themeOption = _themeOptions[index];

                    // 简化选中状态的判断逻辑
                    final bool isSelected = themeOption.mode == currentThemeMode;

                    // --- 原 _buildThemeTile 的内容直接在此处构建 ---
                    return Material(
                      color: isSelected
                          ? AppColors.brandGreenVibrant1.withValues(alpha: 0.1)
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // 点击时，调用 Cubit 更新主题状态
                          context
                              .read<VigaSystemCubit>()
                              .updateThemeMode(themeOption.mode);
                        },
                        highlightColor:
                            AppColors.brandGreenVibrant7.withValues(alpha: 0.1),
                        splashColor:
                            AppColors.brandGreenVibrant7.withValues(alpha: 0.2),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 20.w),
                          child: Row(
                            children: [
                              // 主题名称和描述
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      themeOption.name,
                                      style: TextStyle(
                                        fontSize: 34.w,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.brandGreenVibrant7
                                            : theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(height: 4.w),
                                    Text(
                                      themeOption.description,
                                      style: TextStyle(
                                        fontSize: 26.w,
                                        color: isSelected
                                            ? AppColors.brandGreenVibrant7
                                                .withValues(alpha: 0.8)
                                            : AppColors.neutralGrey41,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // 选中的对勾图标
                              if (isSelected)
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.brandGreenVibrant7,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.brandGreenVibrant7
                                            .withValues(alpha: 0.4),
                                        blurRadius: 8.w,
                                        offset: Offset(0, 2.w),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 40.w,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.neutralGrey7,
                    indent: 32.w,
                    endIndent: 32.w,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
