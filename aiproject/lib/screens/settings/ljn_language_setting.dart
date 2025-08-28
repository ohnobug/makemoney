import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';

// 数据模型，用于表示一个语言选项
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

class LJNLanguageSetting extends StatefulWidget {
  const LJNLanguageSetting({super.key});

  @override
  State<LJNLanguageSetting> createState() => _LJNLanguageSettingState();
}

class _LJNLanguageSettingState extends State<LJNLanguageSetting> {
  // 定义所有支持的语言列表
  final List<LanguageOption> _allLanguages = const [
    LanguageOption(code: 'en', name: '英文', nativeName: 'English'),
    LanguageOption(code: 'zh', name: '简体中文', nativeName: '简体中文'),
    LanguageOption(code: 'zh_TW', name: '繁體中文', nativeName: '繁體中文'),
    // 您可以在这里添加更多语言
  ];

  // 建议语言列表
  final List<LanguageOption> _suggestedLanguages = const [
    LanguageOption(code: 'en', name: '英文', nativeName: 'English'),
    LanguageOption(code: 'zh', name: '简体中文', nativeName: '简体中文'),
  ];

  @override
  Widget build(BuildContext context) {
    // 使用 BlocBuilder 来监听 LJNSystemCubit 的状态变化
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        // 获取当前选中的语言
        final currentLocale = systemState.currentLocale;

        // 假设“已添加语言”就是当前选中的语言
        final List<LanguageOption> addedLanguages = _allLanguages
            .where((lang) =>
                lang.code == currentLocale.languageCode ||
                (lang.code == 'zh' && currentLocale.languageCode == 'zh_TW') ||
                (lang.code == 'zh_TW' && currentLocale.languageCode == 'zh'))
            .toList();

        // 如果当前语言不在列表里（比如默认的'en'），则默认显示简体中文
        if (addedLanguages.isEmpty) {
          addedLanguages
              .add(_allLanguages.firstWhere((lang) => lang.code == 'zh'));
        }

        return Scaffold(
          appBar: const LJNAppBar(
            title: '添加语言',
            // l10n.addLanguage, // 建议使用国际化
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.w),
            children: [
              // 1. 搜索框
              _buildSearchBar(),
              SizedBox(height: 40.w),

              // 2. 建议语言
              _buildSectionTitle('建议语言'),
              _buildLanguageCard(_suggestedLanguages, currentLocale),
              SizedBox(height: 40.w),

              // 3. 所有语言
              _buildSectionTitle('所有语言'),
              _buildLanguageCard(_allLanguages, currentLocale),
            ],
          ),
        );
      },
    );
  }

  /// 构建搜索框
  Widget _buildSearchBar() {
    return Container(
      height: 72.w,
      decoration: BoxDecoration(
        color: AppColors.neutralGrey7,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '搜索语言...',
          hintStyle: TextStyle(color: AppColors.neutralGrey41, fontSize: 30.w),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.neutralGrey41,
            size: 40.w,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.w),
        ),
        // 在这里可以添加搜索逻辑
        onChanged: (value) {
          // TODO: 实现语言搜索过滤
        },
      ),
    );
  }

  /// 构建分组标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w, left: 16.w),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.neutralGrey41,
          fontSize: 28.w,
        ),
      ),
    );
  }

  /// 构建包含语言列表的卡片
  /// 构建一个语言选择卡片，展示可用的语言选项。
///
/// 参数：
///   - `languages`: 语言选项列表，包含每种语言的名称和代码。
///   - `currentLocale`: 当前选中的语言区域。
///
/// 返回值：
///   - 返回一个 [Card] 组件，内部使用 [ListView.separated] 展示语言选项，
///     每个选项之间用分隔线隔开。
///
/// 功能说明：
///   - 卡片无阴影（`elevation: 0`），边距为零（`margin: EdgeInsets.zero`）。
///   - 卡片背景为白色（`Colors.white`）。
///   - 列表项不可滚动（`physics: const NeverScrollableScrollPhysics()`）。
///   - 每个语言选项会根据当前语言区域判断是否被选中。
///   - 分隔线高度为 1，颜色为中性灰色（`AppColors.neutralGrey7`）。
///
/// 注意：
///   - 中文（`zh`）和繁体中文（`zh_TW`）会被视为同一种语言。
Widget _buildLanguageCard(
      List<LanguageOption> languages, Locale currentLocale) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      color: Colors.white, // 或者 systemState.themeData.cardColor
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          // 检查当前语言是否被选中
          final isSelected = language.code == currentLocale.languageCode ||
              (language.code == 'zh' && currentLocale.toString() == 'zh_TW');

          return _buildLanguageTile(language, isSelected);
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.neutralGrey7,
          indent: 20,
          endIndent: 20,
        ),
      ),
    );
  }

  /// 构建单个语言条目
  Widget _buildLanguageTile(LanguageOption language, bool isSelected) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.w),
      title: Text(
        language.nativeName,
        style: TextStyle(
          fontSize: 32.w,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralBlack,
        ),
      ),
      subtitle: Text(
        language.name,
        style: TextStyle(
          fontSize: 26.w,
          color: AppColors.neutralGrey41,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: AppColors.brandGreenVibrant7, // 使用主题色
              size: 40.w,
            )
          : null,
      onTap: () {
        // 当用户点击时，调用 Cubit 更新语言状态
        context.read<LJNSystemCubit>().updateLanguage(language.code);
      },
    );
  }
}
