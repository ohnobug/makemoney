import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- 模拟数据模型 ---
class LocationItem {
  final String name;
  final String address;
  final String distance;

  const LocationItem(this.name, this.address, this.distance);
}

// --- 主要页面类 (StatefulWidget 用于状态管理，如 Tab 选中状态和分页数据) ---
class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  // 模拟顶部的城市/标签数据
  final List<String> cities = const ["深圳", "广州", "东莞", "湛江", "茂名", "阳江", "云浮"];

  // 模拟列表数据，实际应用中会根据选中的城市和分页加载
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
    // 更多分页数据...
  ];

  // 当前选中的 Tab 索引 (默认为“深圳”)
  int _selectedTabIndex = 0;

  // 模拟分页加载
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 10;
  List<LocationItem> _currentLocationList = [];

  // 列表滚动控制器，用于检测滑动到底部实现分页
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentLocationList = locations.sublist(
        0, locations.length > _pageSize ? _pageSize : locations.length);

    // 监听列表滚动事件
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // 滚动监听器：加载更多数据
  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _loadMoreData();
    }
  }

  // 模拟加载更多数据
  void _loadMoreData() {
    if (_currentLocationList.length >= locations.length) {
      // 已经加载所有数据
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 模拟网络延迟
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

  // Tab 切换逻辑
  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
      _currentPage = 0;
      _currentLocationList = [];
      _isLoading = true;

      // 模拟重新加载新城市的数据
      Future.delayed(const Duration(milliseconds: 500), () {
        // 实际应用中会根据 index 加载对应城市的第一页数据
        _currentLocationList = locations.sublist(
            0, locations.length > _pageSize ? _pageSize : locations.length);
        _currentPage = 1;
        _isLoading = false;
        // 确保切换城市时，滚动条回到顶部
        _scrollController.jumpTo(0);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用 DefaultTabController 来管理 TabBar 和 TabBarView
    return DefaultTabController(
      length: cities.length,
      initialIndex: _selectedTabIndex,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // 头部导航栏
          backgroundColor: Colors.white,
          elevation: 0.5,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            '添加位置',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // 1. 顶部 Footprint Bar
            // _buildFootprintBar(),

            // 2. 城市/标签选择区 (使用 TabBar)
            _buildCityTabs(),

            // 3. 搜索框
            _buildSearchBar(),

            // 4. 位置列表
            Expanded(
              // 这里用 TabBarView 也可以，但根据图片，列表内容是公共的，只需要根据选中的 Tab 重新加载数据即可，所以直接用 Expanded 和 ListView
              child: _buildLocationList(),
            ),
          ],
        ),
      ),
    );
  }

  // 构建城市/标签选择区
  Widget _buildCityTabs() {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16.0),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        // Tab 点击回调
        onTap: _onTabTapped,
        // 指示器样式定制：短横线，宽度适应文本
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 3.0, color: Colors.black),
          insets: EdgeInsets.only(bottom: 5), // 调整位置
          borderRadius: BorderRadius.all(Radius.circular(3)), // 增加圆角
        ),
        indicatorSize: TabBarIndicatorSize.label, // 宽度适应 Tab Label
        dividerColor: Colors.transparent, // 移除 TabBar 下方的分割线
        labelPadding:
            const EdgeInsets.symmetric(horizontal: 8), // 移除默认的 Tab 左右填充
        tabs: cities.asMap().entries.map((entry) {
          final index = entry.key;
          final city = entry.value;
          final isSelected = index == _selectedTabIndex;

          return Tab(
            child: Text(
              city,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey[600],
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 构建搜索框
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0), // 浅灰色背景
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: '搜索位置',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none, // 移除下划线
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
        ),
      ),
    );
  }

  // 构建位置列表 (模拟分页)
  Widget _buildLocationList() {
    return ListView.separated(
      controller: _scrollController, // 绑定滚动控制器
      itemCount: _currentLocationList.length +
          2, // +1 for "当前位置" +1 for loading indicator
      separatorBuilder: (context, index) {
        if (index == 0) return const SizedBox.shrink(); // "当前位置" 下方没有分割线
        return const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: Color(0xFFF0F0F0),
        );
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          // 渲染 “深圳市” 当前位置信息
          return _buildCurrentLocationItem();
        }

        // 列表末尾显示加载指示器
        if (index == _currentLocationList.length + 1) {
          return _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Center(child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : _currentLocationList.length == locations.length
                  ? const Center(
                      child: Padding(
                          padding: EdgeInsets.all(16.0), child: Text("没有更多了")))
                  : const SizedBox.shrink();
        }

        // 渲染具体的位置列表项
        final item = _currentLocationList[index - 1]; // -1 因为第0个是当前位置
        return _buildLocationListItem(item);
      },
    );
  }

  // 当前位置（深圳市）
  Widget _buildCurrentLocationItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '深圳市',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '中国 广东省 深圳市',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // 单个位置列表项
  Widget _buildLocationListItem(LocationItem item) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      title: Text(
        item.name,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          item.address,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ),
      trailing: Text(
        item.distance,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      onTap: () {
        // 选择位置事件
      },
    );
  }
}

// --- 运行示例 (可选) ---
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Add Location Demo',
//       home: AddLocationPage(),
//     );
//   }
// }
