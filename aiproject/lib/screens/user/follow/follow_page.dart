// lib/follow/follow_page.dart

import 'package:flutter/material.dart';
import 'followers_list.dart';
import 'following_list.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44.0),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                // 返回按钮，放置在 Stack 的左侧
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 20, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                // 居中的 TabBar
                Center(
                  child: IntrinsicWidth(
                    child: TabBar(
                      // 移除了 SizedBox
                      controller: _tabController,
                      // isScrollable: true, // 确保 isScrollable 为 true，让 TabBar 适应内容宽度
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey[600],
                      labelPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(fontSize: 16),
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerHeight: 0, 
                     /*  indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.5, color: Colors.black),
                        insets: EdgeInsets.zero,
                      ), */
                      tabs: const [
                        Tab(text: '关注'), // Following
                        Tab(text: '粉丝'), // Followers
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFEFEFEF)),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                FollowingListPage(),
                FollowersListPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
