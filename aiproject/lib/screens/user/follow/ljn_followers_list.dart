import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vigaviga/widgets/loading.dart';
import 'ljn_user_model.dart';

class LJNFollowersListPage extends StatefulWidget {
  const LJNFollowersListPage({super.key});

  @override
  State<LJNFollowersListPage> createState() => _LJNFollowersListPageState();
}

class _LJNFollowersListPageState extends State<LJNFollowersListPage> {
  final List<User> _followers = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _fetchFollowers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading) {
        _fetchFollowers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchFollowers() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    List<User> newUsers = List.generate(15, (index) {
      int userId = _page * 15 + index;
      bool isMutual = userId % 3 == 0;
      return User(
        id: 'follower_$userId',
        avatarUrl: 'https://i.pravatar.cc/150?u=follower$userId',
        name: isMutual ? '晚点遇到你，余生都是你' : '用户936465651548',
        description: isMutual ? '假如我年少有为, 不自卑, 懂的...' : null,
        status: isMutual ? FollowStatus.mutual : FollowStatus.followedBy,
      );
    });

    setState(() {
      _followers.addAll(newUsers);
      _page++;
      _isLoading = false;
    });
  }

  void _onFollowButtonPressed(User user) {
    setState(() {
      if (user.status == FollowStatus.followedBy) {
        user.status = FollowStatus.mutual;
      } else if (user.status == FollowStatus.mutual) {
        user.status = FollowStatus.followedBy;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          child: Text('我的粉丝 (4人)',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          // 【关键改动】在这里处理首次加载的居中状态
          child: _isLoading && _followers.isEmpty
              ? const Center(child: VigaLoadingIndicator())
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: _followers.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _followers.length) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: VigaLoadingIndicator()),
                      );
                    }
                    final user = _followers[index];
                    return _buildUserTile(user);
                  },
                ),
        ),
      ],
    );
  }

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
                if (user.description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    user.description!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
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
    switch (user.status) {
      case FollowStatus.mutual:
        return SizedBox(
          width: 92,
          height: 30,
          child: OutlinedButton(
            onPressed: () => _onFollowButtonPressed(user),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
            child: Text('互相关注',
                style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          ),
        );
      case FollowStatus.followedBy:
        return SizedBox(
          width: 92,
          height: 30,
          child: ElevatedButton(
            onPressed: () => _onFollowButtonPressed(user),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE2C55),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
            child: const Text('回关',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
