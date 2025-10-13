import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LJNVideoPublishPageState extends StatefulWidget {
  const LJNVideoPublishPageState({super.key});

  @override
  State<LJNVideoPublishPageState> createState() => LJNVideoPublishPage();
}

class LJNVideoPublishPage extends State<LJNVideoPublishPageState> {
  String _selectedVisibility = '公开: 所有人可见';
  String _selectedThumbnail = 'assets/images/avatar/chat_2.jpg';
  String _selectedLocation = '你在哪里';

  final List<String> _thumbnailImages = [
    'assets/images/avatar/chat_2.jpg',
    'assets/images/avatar/chat_3.jpg',
    'assets/images/avatar/chat_4.jpg',
  ];

  bool _isDragging = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                child: _selectedThumbnail.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: _selectedThumbnail,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(child: Text('没有素材了')),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ..._thumbnailImages.map(
                                  (path) => _buildDraggableThumbnail(path)),
                              const SizedBox(width: 8),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    const Icon(Icons.add, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: '添加标题',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: '添加作品描述...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      const Divider(height: 1),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(),
                        leading: const Icon(Icons.location_on,
                            color: Colors.black54),
                        title: Text(_selectedLocation,
                            style: const TextStyle(fontSize: 16)),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 16),
                        onTap: () {
                          Navigator.pushNamed(context, '/locationPage');
                        },
                      ),
                      const Divider(height: 1),
                      const SizedBox(height: 16),
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
                      const Divider(height: 1),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(),
                        leading:
                            const Icon(Icons.public, color: Colors.black54),
                        title: Text(
                          _selectedVisibility.replaceFirst(': ', ' · '),
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 16),
                        onTap: () {
                          _showVisibilityBottomSheet(context);
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
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
          Visibility(
            visible: _isDragging,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: _buildDeleteTarget(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableThumbnail(String imagePath) {
    bool isSelected = (_selectedThumbnail == imagePath);
    return Draggable<String>(
      data: imagePath,
      feedback: _buildThumbnailImage(imagePath,
          isDragging: true, isSelected: isSelected),
      childWhenDragging: Container(
        margin: const EdgeInsets.only(right: 8.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onDragStarted: () {
        setState(() {
          _isDragging = true;
        });
      },
      onDragEnd: (details) {
        setState(() {
          _isDragging = false;
          _isDeleting = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedThumbnail = imagePath;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _buildThumbnailImage(imagePath, isSelected: isSelected),
        ),
      ),
    );
  }

  Widget _buildDeleteTarget() {
    return DragTarget<String>(
      onWillAcceptWithDetails: (data) {
        setState(() {
          _isDeleting = true;
        });
        return true;
      },
      onLeave: (data) {
        setState(() {
          _isDeleting = false;
        });
      },
      onAcceptWithDetails: (details) {
        if (_thumbnailImages.length > 1) {
          setState(() {
            if (_selectedThumbnail == details.data) {
              _thumbnailImages.remove(details.data);
              _selectedThumbnail = _thumbnailImages.first;
            } else {
              _thumbnailImages.remove(details.data);
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('至少保留一个素材'),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 2),
            ),
          );
        }
        setState(() {
          _isDeleting = false;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: _isDeleting
                ? Colors.red.withAlpha((0.8 * 255).toInt())
                : Colors.black.withAlpha((0.6 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 40,
          ),
        );
      },
    );
  }

  Widget _buildThumbnailImage(String imagePath,
      {bool isSelected = false, bool isDragging = false}) {
    return Opacity(
      opacity: isDragging ? 0.7 : 1.0,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.cover,
              ),
            ),
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationChip(String text) {
    final bool isSelected = _selectedLocation == text;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedLocation = '你在哪里';
          } else {
            _selectedLocation = text;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.red.withAlpha((0.1 * 255).toInt())
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.red, width: 1.0) : null,
        ),
        child: Text(text,
            style: TextStyle(color: isSelected ? Colors.red : Colors.black54)),
      ),
    );
  }

  void _showVisibilityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        minHeight: 400,
        maxHeight: 400,
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              SizedBox(height: MediaQuery.of(context).padding.bottom),
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
        Navigator.pop(context);
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
                  color:
                      _selectedVisibility == title ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (_selectedVisibility == title)
              const Icon(Icons.check, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
