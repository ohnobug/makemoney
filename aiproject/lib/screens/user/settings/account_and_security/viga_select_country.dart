import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azlistview/azlistview.dart';
import 'package:go_router/go_router.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_logger.dart';

/// 数据模型 (保持不变)
class CountryInfo extends ISuspensionBean {
  String name; // 中文名 (或当前语言名称)
  String englishName; // 英文名
  String code; // 国际电话区号
  String isoCode; // ISO 3166-1 alpha-2 代码
  late String tag; // 首字母索引标签

  CountryInfo({
    required this.name,
    required this.englishName,
    required this.code,
    required this.isoCode,
  });

  @override
  String getSuspensionTag() => tag;
}

/// 主页面
class VigaSelectCountryPage extends StatefulWidget {
  const VigaSelectCountryPage({super.key});

  @override
  State<VigaSelectCountryPage> createState() => _SelectCountryPageState();
}

class _SelectCountryPageState extends State<VigaSelectCountryPage> {
  final List<CountryInfo> _countryList = [];
  List<CountryInfo> _filteredCountryList = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isDataProcessed = false; // 添加一个标志位，防止重复处理数据

  @override
  void initState() {
    super.initState();
    _loadDataFromLibrary(); // 从库加载原始数据
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 确保只在数据未处理时执行，避免不必要的重复计算
    if (!_isDataProcessed) {
      _processDataWithLocalization();
      _isDataProcessed = true;
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // [!!] 2. 从 country_code_picker 库加载原始数据
  void _loadDataFromLibrary() {
    // 清空旧数据
    _countryList.clear();
    // `codes` 是 country_code_picker 库暴露出的原始国家数据列表
    for (var countryData in codes) {
      _countryList.add(
        CountryInfo(
          // 暂时将中英文名都设为英文，后续在 _processDataWithLocalization 中更新
          name: countryData['name']!,
          englishName: countryData['name']!,
          code: countryData['dial_code']!,
          isoCode: countryData['code']!,
        ),
      );
    }
    logger.info(codes);
  }

  // [!!] 3. 使用库的本地化功能来处理数据，生成多语言名称和Tag
  void _processDataWithLocalization() {
    final locale = Localizations.localeOf(context);
    final isChinese = locale.languageCode == 'zh';

    // 获取 country_code_picker 的本地化实例
    // final countryLocalizations = CountryLocalizations.of(context);

    for (var country in _countryList) {
      // 使用库的本地化功能获取当前语言的名称
      // 如果没有翻译，则回退到英文名
      //country.name = countryLocalizations?.nameOf(country.isoCode) ?? country.englishName;

      // 根据当前语言环境，选择用于生成Tag的名称
      String nameForTag = isChinese ? country.name : country.englishName;

      String pinyin = PinyinHelper.getPinyinE(nameForTag);
      String tag = pinyin.substring(0, 1).toUpperCase();
      if (RegExp(r'[A-Z]').hasMatch(tag)) {
        country.tag = tag;
      } else {
        country.tag = '#';
      }
    }

    // 排序和设置悬浮头
    SuspensionUtil.sortListBySuspensionTag(_countryList);
    SuspensionUtil.setShowSuspensionStatus(_countryList);

    // 触发UI更新
    if (mounted) {
      _onSearchChanged();
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountryList = _countryList;
      } else {
        _filteredCountryList = _countryList
            .where((country) =>
                country.name.toLowerCase().contains(query) ||
                country.englishName.toLowerCase().contains(query) ||
                country.code.contains(query))
            .toList();
      }
      SuspensionUtil.setShowSuspensionStatus(_filteredCountryList);
    });
  }

  // [!!] UI部分几乎不需要修改，因为逻辑已经解耦
  @override
  Widget build(BuildContext context) {
    // ... Build 方法完全保持不变 ...
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "选择国家和地区",
          style: TextStyle(
              color: Colors.black, fontSize: 36.w, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _filteredCountryList.isEmpty
                ? _buildEmptyState()
                : AzListView(
                    data: _filteredCountryList,
                    itemCount: _filteredCountryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final locale = Localizations.localeOf(context);
                      final isChinese = locale.languageCode == 'zh';
                      return _buildListItem(
                          _filteredCountryList[index], isChinese);
                    },
                    indexBarOptions: IndexBarOptions(
                      textStyle: TextStyle(
                          color: Colors.grey.shade600, fontSize: 26.w),
                      needRebuild: true,
                      selectTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      selectItemDecoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                    indexHintBuilder: (context, hint) {
                      return Container(
                        alignment: Alignment.center,
                        width: 120.0.w,
                        height: 120.0.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          shape: BoxShape.circle,
                        ),
                        child: Text(hint,
                            style: TextStyle(
                                color: Colors.white, fontSize: 60.0.w)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(CountryInfo model, bool isChinese) {
    // [!!] 这里不再需要判断，因为 country.name 已经是本地化后的名称
    final displayName = model.name;

    return Column(
      children: <Widget>[
        Offstage(
          offstage: !model.isShowSuspension,
          child: _buildSuspension(model.getSuspensionTag()),
        ),
        ListTile(
          title: Text(displayName, style: TextStyle(fontSize: 32.w)),
          trailing: Text(model.code,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 30.w)),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "选择了 $displayName (${model.isoCode}) - ${model.code}")),
            );
          },
        )
      ],
    );
  }

  // 其他 build 方法保持不变
  Widget _buildSearchBar() {
    /* ... */ return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "搜索",
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey.shade500),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.all(16.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    /* ... */ return const Center(
      child: Text(
        "未找到相关结果",
        style: TextStyle(fontSize: 32, color: Colors.grey),
      ),
    );
  }

  Widget _buildSuspension(String tag) {
    /* ... */ return Container(
      height: 60.0.w,
      width: double.infinity,
      padding: EdgeInsets.only(left: 32.0.w),
      color: const Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        style: TextStyle(fontSize: 28.0.w, color: Color(0xff999999)),
      ),
    );
  }
}
