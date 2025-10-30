import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';

class LocationItem {
  final String name;
  final String address;
  final String distance;

  const LocationItem(this.name, this.address, this.distance);
}

class VigaGeolocatorPage extends StatefulWidget {
  const VigaGeolocatorPage({super.key});

  @override
  State<VigaGeolocatorPage> createState() => _VigaGeolocatorPageState();
}

class _VigaGeolocatorPageState extends State<VigaGeolocatorPage> {
  // 模拟顶部的城市/标签数据
  final List<String> cities = const ["深圳", "广州", "东莞", "湛江", "茂名", "阳江", "云浮"];

  // 模拟列表数据
  final List<LocationItem> locations = const [
    LocationItem("上围艺术村", "广东省深圳市龙华区上围村东区95号", "109m"),
    LocationItem("双汇生鲜(上围路店)", "广东省深圳市龙华区樟坑径村宝业路4号", "375m"),
    LocationItem("樟坑径公园", "广东省深圳市龙华区上围路104号附近", "152m"),
    LocationItem("诗和远方", "广东省深圳市龙华区下围南三巷5-2", "844m"),
    LocationItem("樟坑径中心广场", "广东省深圳市龙华区宝业路88号", "558m"),
    LocationItem("樟坑径水库", "广东省深圳市龙华区樟坑径水库", "766m"),
    LocationItem("上围电影博物馆", "广东省深圳市龙华区上围村东区95-1号", "143m"),
    LocationItem("兴万和广场(樟坑径店)", "广东省深圳市龙华区观湖街道樟溪社区五和大道327号", "681m"),
    LocationItem("光明农场大观园", "广东省深圳市光明区", "1.5km"),
    LocationItem("深圳北站", "广东省深圳市龙华区致远中路", "5.2km"),
    LocationItem("上围艺术村", "广东省深圳市龙华区上围村东区95号", "109m"),
    LocationItem("双汇生鲜(上围路店)", "广东省深圳市龙华区樟坑径村宝业路4号", "375m"),
    LocationItem("樟坑径公园", "广东省深圳市龙华区上围路104号附近", "152m"),
    LocationItem("诗和远方", "广东省深圳市龙华区下围南三巷5-2", "844m"),
    LocationItem("樟坑径中心广场", "广东省深圳市龙华区宝业路88号", "558m"),
    LocationItem("樟坑径水库", "广东省深圳市龙华区樟坑径水库", "766m"),
    LocationItem("上围电影博物馆", "广东省深圳市龙华区上围村东区95-1号", "143m"),
    LocationItem("兴万和广场(樟坑径店)", "广东省深圳市龙华区观湖街道樟溪社区五和大道327号", "681m"),
    LocationItem("光明农场大观园", "广东省深圳市光明区", "1.5km"),
    LocationItem("深圳北站", "广东省深圳市龙华区致远中路", "5.2km"),
  ];

  int _selectedTabIndex = 0;
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 10;
  List<LocationItem> _currentLocationList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentLocationList = locations.sublist(
        0, locations.length > _pageSize ? _pageSize : locations.length);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (_currentLocationList.length >= locations.length) {
      return;
    }
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 1000), () {
      final startIndex = _currentPage * _pageSize;
      final endIndex = (startIndex + _pageSize) > locations.length
          ? locations.length
          : (startIndex + _pageSize);
      final newItems = locations.sublist(startIndex, endIndex);
      setState(() {
        _currentLocationList.addAll(newItems);
        _currentPage++;
        _isLoading = false;
      });
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
      _currentPage = 0;
      _currentLocationList = [];
      _isLoading = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        _currentLocationList = locations.sublist(
            0, locations.length > _pageSize ? _pageSize : locations.length);
        _currentPage = 1;
        _isLoading = false;
        _scrollController.jumpTo(0);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: cities.length,
      initialIndex: _selectedTabIndex,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainer,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surfaceContainer,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: theme.colorScheme.onSurface, size: 40.0.w), // 20 * 2
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '添加位置',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 36.0.w, // 18 * 2
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildCityTabs(),
            _buildSearchBar(),
            Expanded(
              child: _buildLocationList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityTabs() {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 80.0.w, // 40 * 2
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 32.0.w), // 16 * 2
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        onTap: _onTabTapped,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 6.0.w, color: theme.colorScheme.primary), // 3 * 2
          insets: EdgeInsets.only(bottom: 10.0.w), // 5 * 2
          borderRadius: BorderRadius.all(Radius.circular(6.0.w)), // 3 * 2
        ),
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.0.w), // 8 * 2
        tabs: cities.asMap().entries.map((entry) {
          final index = entry.key;
          final city = entry.value;
          final isSelected = index == _selectedTabIndex;
          return Tab(
            child: Text(
              city,
              style: TextStyle(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                fontSize: 36.0.w, // 18 * 2
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchBar() {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(24.0.w), // 12 * 2
      child: TextField(
        style: TextStyle(
          fontSize: 28.w,
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_outlined,
            color: theme.colorScheme.onSurfaceVariant,
            size: 40.0.w,
          ), // 20 * 2
          hintText: '搜索位置',
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 28.w,
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 20.0.w,
          ), // 10 * 2
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0.w), // 25 * 2
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0.w), // 25 * 2
            borderSide: BorderSide(
              color: theme.dividerColor,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0.w), // 25 * 2
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationList() {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _currentLocationList.length + 2,
      separatorBuilder: (context, index) {
        if (index == 0) return const SizedBox.shrink();
        return Divider(
          height: 2.0.w, // 1 * 2
          indent: 32.0.w, // 16 * 2
          endIndent: 32.0.w, // 16 * 2
          color: const Color(0xFFF0F0F0),
        );
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildCurrentLocationItem();
        }
        if (index == _currentLocationList.length + 1) {
          return _isLoading
              ? Padding(
                  padding: EdgeInsets.all(16.0.w), // 8 * 2
                  child: Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 4.0.w)), // 2 * 2
                )
              : _currentLocationList.length == locations.length
                  ? Center(
                      child: Padding(
                          padding: EdgeInsets.all(32.0.w), // 16 * 2
                          child: const Text("没有更多了")))
                  : const SizedBox.shrink();
        }
        final item = _currentLocationList[index - 1];
        return _buildLocationListItem(item);
      },
    );
  }

  Widget _buildCurrentLocationItem() {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
      padding: EdgeInsets.symmetric(
          horizontal: 32.0.w, vertical: 24.0.w), // 16*2, 12*2
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10.w,
            offset: Offset(0, 2.w),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.brandGreenVibrant5.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.brandGreenVibrant5,
              size: 32.w,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '深圳市',
                  style: TextStyle(
                    fontSize: 32.0.w, // 16 * 2
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.0.w), // 4 * 2
                Text(
                  '中国 广东省 深圳市',
                  style: TextStyle(
                    fontSize: 26.0.w, // 13 * 2
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationListItem(LocationItem item) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.03 * 255).toInt()),
            blurRadius: 8.w,
            offset: Offset(0, 2.w),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // 选择位置事件
        },
        borderRadius: BorderRadius.circular(20.w),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 32.0.w, vertical: 20.0.w), // 16*2, 10*2
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 32.0.w, // 16 * 2
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.0.w), // 4 * 2
                    Text(
                      item.address,
                      style: TextStyle(
                        fontSize: 26.0.w, // 13 * 2
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withAlpha((0.3 * 255).toInt()),
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: Text(
                  item.distance,
                  style: TextStyle(
                    fontSize: 24.0.w, // 12 * 2
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
