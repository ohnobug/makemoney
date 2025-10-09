// lib/follow/following_list.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'ljn_user_model.dart';

class LJNFollowingListPage extends StatefulWidget {
  const LJNFollowingListPage({super.key});

  @override
  State<LJNFollowingListPage> createState() => _LJNFollowingListPageState();
}

class _LJNFollowingListPageState extends State<LJNFollowingListPage> {
  final List<User> _following = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _fetchFollowing();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading) {
        _fetchFollowing();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchFollowing() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    List<User> newUsers = List.generate(15, (index) {
      int userId = _page * 15 + index;
      FollowStatus status;
      String extraInfo = '';
      if (userId % 4 == 0) {
        status = FollowStatus.mutual;
        extraInfo = '进橱窗 >';
      } else if (userId % 4 == 1) {
        status = FollowStatus.following;
        extraInfo = '4个作品未看 | 看作品 >';
      } else if (userId % 4 == 2) {
        status = FollowStatus.following;
        extraInfo = '1个群聊 | 去加群 >';
      } else {
        status = FollowStatus.notFollowing;
        extraInfo = '正在直播 | 进橱窗 >';
      }
      return User(
        id: 'following_$userId',
        avatarUrl: 'https://i.pravatar.cc/150?u=following$userId',
        name: '柒哥看电影 $userId',
        extraInfo: extraInfo,
        status: status,
      );
    });

    setState(() {
      _following.addAll(newUsers);
      _page++;
      _isLoading = false;
    });
  }

  void _onFollowButtonPressed(User user) {
    setState(() {
      if (user.status == FollowStatus.notFollowing) {
        user.status = FollowStatus.following;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('我的关注 (474人)',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              Row(
                children: [
                  Text('综合排序',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  Icon(Icons.unfold_more, size: 16, color: Colors.grey[600]),
                ],
              ),
            ],
          ),
        ),
        /* Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildFilterChip('全部', isSelected: true),
              _buildFilterChip('互相关注'),
              _buildFilterChip('店铺/橱窗'),
            ],
          ),
        ), */
        // 【改动点 4】新增和粉丝列表一样的搜索框
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
          child: SizedBox(
            height: 36,
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索用户备注或名字',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey[500], size: 20),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 0),
            itemCount: _following.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _following.length) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2.0)),
                );
              }
              final user = _following[index];
              return _buildUserTile(user);
            },
          ),
        ),
      ],
    );
  }

  /* Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[200] : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: Colors.grey[300]!),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.grey[600], fontSize: 13)),
    );
  } */

  Widget _buildUserTile(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 24, backgroundImage: NetworkImage(user.avatarUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                if (user.extraInfo != null && user.extraInfo!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(user.extraInfo!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ],
            ),
          ),
          _buildFollowButton(user),
        ],
      ),
    );
  }

  Widget _buildFollowButton(User user) {
    Widget button;
    switch (user.status) {
      case FollowStatus.mutual:
        button = OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey[300]!),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Text('互相关注',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        );
        break;
      case FollowStatus.following:
        button = ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.grey[800],
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: const Text('已关注', style: TextStyle(fontSize: 13)),
        );
        break;
      case FollowStatus.notFollowing:
        button = ElevatedButton(
          onPressed: () => _onFollowButtonPressed(user),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFE2C55),
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: const Text('关注',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        );
        break;
      default:
        button = const SizedBox.shrink();
    }
    // 【改动点 1】加宽 SizedBox 防止 "已关注" 文字换行
    return SizedBox(width: 92, height: 30, child: button);
  }
}
