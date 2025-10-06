import 'package:flutter/material.dart';

class VideoPublishPageState extends StatefulWidget {
  const VideoPublishPageState({super.key});

  @override
  State<VideoPublishPageState> createState() => VideoPublishPage();
}

class VideoPublishPage extends State<VideoPublishPageState> {
  String _selectedVisibility = '公开: 所有人可见';
  String _selectedThumbnail = 'assets/images/avatar/chat_2.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
            // Handle back button press
          },
        ),
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        /* actions: [
          TextButton(
            onPressed: () {
              // Handle preview button press
            },
            child: const Text(
              '预览',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ], */
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video thumbnail section
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.width * 0.8,
                            color: Colors.grey[300],
                            child: Image.asset(
                              _selectedThumbnail,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Add cover image and plus button
                  Row(
                    children: [
                      _buildThumbnailImage('assets/images/avatar/chat_2.jpg'),
                      _buildThumbnailImage('assets/images/avatar/chat_3.jpg'),
                      _buildThumbnailImage('assets/images/avatar/chat_4.jpg'),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Title and description fields
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '添加标题',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: '添加作品描述...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  // Location section
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(),
                    leading:
                        const Icon(Icons.location_on, color: Colors.black54),
                    title: const Text('你在哪里', style: TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 16),
                    onTap: () {
                      Navigator.pushNamed(context, '/locationPage');
                      // Handle location tap
                    },
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 16),

                  // Location tags
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildLocationChip('上围艺术村'),
                          _buildLocationChip('樟坑径公园'),
                          _buildLocationChip('诗和远方'),
                          _buildLocationChip('双汇生鲜(上...'),
                          _buildLocationChip('双汇生鲜111(上...'),
                        ],
                      )),
                  const SizedBox(height: 16),

                  // Other settings
                  const Divider(height: 1),
                  /* ListTile(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(),
                    leading:
                        const Icon(Icons.label_outline, color: Colors.black54),
                    title: const Text('添加标签', style: TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 16),
                    onTap: () {
                      // Handle add tags tap
                    },
                  ),
                  const Divider(height: 1), */
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(),
                    leading: const Icon(Icons.public, color: Colors.black54),
                    title: const Text('公开 · 所有人可见',
                        style: TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 16),
                    onTap: () {
                      /* showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MyHomePage();
                  },
                ); */
                      _showVisibilityBottomSheet(context);
                      // Handle visibility setting tap
                    },
                  ),
                  const Divider(height: 1),
                  /* const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(),
                    leading: const Icon(Icons.settings, color: Colors.black54),
                    title: const Text('高级设置', style: TextStyle(fontSize: 16)),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.grey, size: 16),
                    onTap: () {
                      // Handle advanced settings tap
                    },
                  ), */
                ],
              ),
            ),
          ),

          // Bottom action bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                /* Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle save as draft
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      '存草稿',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ), */
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle publish
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      '发作品',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnailImage(String imagePath) {
    bool isSelected = (_selectedThumbnail == imagePath);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedThumbnail = imagePath;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Image.asset(
              imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black54)),
    );
  }

  void _showVisibilityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 允许内容超出屏幕高度并滚动
      backgroundColor: Colors.transparent, // 背景透明，以便自定义圆角
      constraints: BoxConstraints(
        minHeight: 400, // 最小高度
        maxHeight: 400, // 最大高度
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white, // 弹窗背景色
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 0), // 留出底部安全区域
          child: Column(
            mainAxisSize: MainAxisSize.min, // 内容决定高度
            children: [
              // 顶部的拖动指示器
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '以下可见权限设置只对发作品生效',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              _buildVisibilityOption(context, '公开: 所有人可见'),
              _buildVisibilityOption(context, '私密: 仅自己可见'),
              SizedBox(height: MediaQuery.of(context).padding.bottom), // 底部安全区域
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisibilityOption(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedVisibility = title;
        });
        Navigator.pop(context); // 点击后关闭弹窗
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]!, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedVisibility == title
                      ? Colors.red
                      : Colors.black, // 根据选中状态改变颜色
                ),
              ),
            ),
            if (_selectedVisibility == title)
              const Icon(Icons.check, color: Colors.red), // 选中时显示对勾
          ],
        ),
      ),
    );
  }
}
