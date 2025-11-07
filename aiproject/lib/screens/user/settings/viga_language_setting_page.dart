import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/l10n/app_localizations.dart';

// 数据模型，用于表示一个语言选项 (保持不变)
class LanguageOption {
  final String code; // 语言代码, e.g., 'zh', 'en'
  final String name; // 语言的中文名称, e.g., '简体中文'
  final String nativeName; // 语言的本地名称, e.g., '简体中文', 'English'

  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

class VigaLanguageSettingPage extends StatefulWidget {
  const VigaLanguageSettingPage({super.key});

  @override
  State<VigaLanguageSettingPage> createState() =>
      _VigaLanguageSettingPageState();
}

class _VigaLanguageSettingPageState extends State<VigaLanguageSettingPage> {
  // 定义所有支持的语言列表
  final List<LanguageOption> _allLanguages = const [
    LanguageOption(code: 'en', name: '英文', nativeName: 'English'),
    LanguageOption(code: 'zh', name: '简体中文', nativeName: '简体中文'),
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
          title: l10n.languageSetting,
        ),
        body: BlocBuilder<VigaSystemCubit, SystemState>(
          builder: (context, systemState) {
            final currentLocale = systemState.currentLocale;

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
                  itemCount: _allLanguages.length,
                  itemBuilder: (context, index) {
                    final language = _allLanguages[index];

                    // 简化选中状态的判断逻辑
                    final bool isSelected = (language.code == 'zh')
                        ? currentLocale.languageCode.startsWith('zh')
                        : language.code == currentLocale.languageCode;

                    // --- 原 _buildLanguageTile 的内容直接在此处构建 ---
                    return Material(
                      color: isSelected
                          ? AppColors.brandGreenVibrant1.withValues(alpha: 0.1)
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // 点击时，调用 Cubit 更新语言状态
                          context
                              .read<VigaSystemCubit>()
                              .updateLanguage(language.code);
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
                              // 语言名称
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      language.nativeName,
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
                                      language.name,
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
