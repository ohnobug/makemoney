import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_chatlist_item.dart';

class VigaSearchFriendPage extends StatefulWidget {
  final List<ChatListItem>? recentContacts; // 传入的近期联系人数据

  const VigaSearchFriendPage({
    super.key,
    this.recentContacts,
  });

  @override
  State<VigaSearchFriendPage> createState() => _VigaSearchFriend();
}

class _VigaSearchFriend extends State<VigaSearchFriendPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<ChatListItem> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    // 添加搜索输入监听
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    _performSearch(query);
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty || widget.recentContacts == null) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });

    // 模拟搜索延迟
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchResults = widget.recentContacts!.where((chatItem) {
            return chatItem.friendName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                chatItem.message.toLowerCase().contains(query.toLowerCase());
          }).toList();
          _isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: null,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          color: theme.colorScheme.surfaceContainer,
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  90.w -
                  systemState.statusHeight),
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              // 搜索框区域
              Container(
                padding: EdgeInsets.only(bottom: 20.w),
                margin: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: systemState.statusHeight + 10.w,
                ),
                height: 95.w,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.dividerColor,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        cursorHeight: 35.w,
                        cursorWidth: 3.w,
                        autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            const IconData(
                              0xe612,
                              fontFamily: 'Iconfont',
                            ),
                            color: theme.colorScheme.onSurface,
                            size: 40.w,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 70.w, // 控制图标与文字的最小宽度
                            // minHeight: 36.w,
                          ),
                          hintText: l10n.searchHintAccountOrPhone,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 30.w,
                            color: AppColors.neutralDarkGrey14,
                          ),
                          filled: true,
                          fillColor: AppColors.neutralWhite,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20).w,
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20.0,
                          ).w,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 60.w,
                        child: Icon(
                          Icons.close,
                          size: 36.w,
                          color: AppColors.brandBluePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 搜索结果区域
              Expanded(
                child: _buildSearchResults(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    if (_isSearching) {
      return Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.primary,
        ),
      );
    }

    if (!_hasSearched) {
      return Container(); // 还没有搜索，显示空白
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80.w,
              color: theme.hintColor,
            ),
            SizedBox(height: 20.w),
            Text(
              '没有找到相关联系人',
              style: TextStyle(
                fontSize: 28.w,
                color: theme.hintColor,
              ),
            ),
            SizedBox(height: 10.w),
            Text(
              '试试其他关键词',
              style: TextStyle(
                fontSize: 24.w,
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        // 创建新的ChatListItem，修改onPressed逻辑
        final originalItem = _searchResults[index];
        return ChatListItem(
          avatar: originalItem.avatar,
          avatarRadius: originalItem.avatarRadius,
          friendName: originalItem.friendName,
          message: originalItem.message,
          notice: originalItem.notice,
          underline: index < _searchResults.length - 1, // 只有最后一项不显示下划线
          lastedTime: originalItem.lastedTime,
          badge: originalItem.badge,
          onPressed: () {
            context.push(
              '/chat',
              extra: <String, String>{
                'title': originalItem.friendName,
                'icon': originalItem.avatar,
              },
            );
          },
        );
      },
    );
  }
}
