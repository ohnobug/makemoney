import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:vigaviga/themes.dart';

class VigaVideoPublishPageState extends StatefulWidget {
  const VigaVideoPublishPageState({super.key});

  @override
  State<VigaVideoPublishPageState> createState() => VigaVideoPublishPage();
}

class VigaVideoPublishPage extends State<VigaVideoPublishPageState> {
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
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface, size: 40.w), // 20 * 2
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '发布作品',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 36.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surfaceContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 32.0.w), // 16 * 2
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 主内容卡片
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24.w),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withAlpha((0.05 * 255).toInt()),
                              blurRadius: 10.w,
                              offset: Offset(0, 2.w),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 预览区域
                            Container(
                              width: double.infinity,
                              height: 400.w,
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.w),
                                  topRight: Radius.circular(24.w),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.w),
                                      topRight: Radius.circular(24.w),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: theme
                                          .colorScheme.surfaceContainerHighest,
                                      child: _selectedThumbnail.isNotEmpty
                                          ? VigaAppNetworkImage(
                                              imageUrl: _selectedThumbnail,
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.image_outlined,
                                                  size: 80.w,
                                                  color: theme.colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                                SizedBox(height: 16.w),
                                                Text(
                                                  '选择素材开始创作',
                                                  style: TextStyle(
                                                    color: theme.colorScheme
                                                        .onSurfaceVariant,
                                                    fontSize: 28.w,
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 缩略图选择区域
                            Container(
                              padding: EdgeInsets.all(24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '选择素材',
                                    style: TextStyle(
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(height: 16.w),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ..._thumbnailImages.map((path) =>
                                            _buildDraggableThumbnail(path)),
                                        SizedBox(width: 16.w), // 8 * 2
                                        _buildAddThumbnailButton(theme),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.w),
                      // 标题输入区域
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24.w),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withAlpha((0.05 * 255).toInt()),
                              blurRadius: 10.w,
                              offset: Offset(0, 2.w),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: '添加标题',
                                hintStyle: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 36.w,
                                  fontWeight: FontWeight.w600,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                fontSize: 36.w,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 16.w),
                            Divider(
                              height: 1.w,
                              color: theme.dividerColor,
                            ),
                            SizedBox(height: 16.w),
                            TextField(
                              decoration: InputDecoration(
                                hintText: '添加作品描述...',
                                hintStyle: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 32.w,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                fontSize: 32.w,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.w),

                      // 位置选择区域
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24.w),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withAlpha((0.05 * 255).toInt()),
                              blurRadius: 10.w,
                              offset: Offset(0, 2.w),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                context.push('/locationPage');
                              },
                              borderRadius: BorderRadius.circular(12.w),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: theme.colorScheme.primary,
                                      size: 32.w,
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Text(
                                        _selectedLocation,
                                        style: TextStyle(
                                          fontSize: 32.w,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: theme.colorScheme.onSurfaceVariant,
                                      size: 24.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.w),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildLocationChip('上围艺术村', theme),
                                  _buildLocationChip('樟坑径公园', theme),
                                  _buildLocationChip('诗和远方', theme),
                                  _buildLocationChip('双汇生鲜(上...', theme),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.w),

                      // 可见性设置区域
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24.w),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withAlpha((0.05 * 255).toInt()),
                              blurRadius: 10.w,
                              offset: Offset(0, 2.w),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            _showVisibilityBottomSheet(context);
                          },
                          borderRadius: BorderRadius.circular(12.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.public_outlined,
                                  color: theme.colorScheme.primary,
                                  size: 32.w,
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    _selectedVisibility.replaceFirst(
                                        ': ', ' · '),
                                    style: TextStyle(
                                      fontSize: 32.w,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: theme.colorScheme.onSurfaceVariant,
                                  size: 24.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 32.w, vertical: 24.w), // 16*2, 12*2
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 20.w,
                      offset: Offset(0, -4.w),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 100.w), // 50 * 2
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50.w), // 25 * 2
                            ),
                            padding:
                                EdgeInsets.symmetric(vertical: 24.w), // 12 * 2
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_outlined,
                                size: 36.w,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                '发布作品',
                                style: TextStyle(
                                  fontSize: 32.w,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: _isDragging,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 200.0.w), // 100 * 2
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
        margin: EdgeInsets.only(right: 16.0.w), // 8 * 2
        width: 80.w, // 40 * 2
        height: 80.w, // 40 * 2
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16.w), // 8 * 2
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
          padding: EdgeInsets.only(right: 16.0.w), // 8 * 2
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
          width: 160.w, // 80 * 2
          height: 160.w, // 80 * 2
          decoration: BoxDecoration(
            color: _isDeleting
                ? Colors.red.withAlpha((0.8 * 255).toInt())
                : Colors.black.withAlpha((0.6 * 255).toInt()),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 80.w, // 40 * 2
          ),
        );
      },
    );
  }

  Widget _buildAddThumbnailButton(ThemeData theme) {
    return Container(
      width: 80.w, // 40 * 2
      height: 80.w, // 40 * 2
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.w), // 8 * 2
        border: Border.all(
          color: theme.dividerColor,
          width: 2.w,
        ),
      ),
      child: Icon(
        Icons.add,
        color: theme.colorScheme.onSurfaceVariant,
        size: 32.w,
      ),
    );
  }

  Widget _buildThumbnailImage(String imagePath,
      {bool isSelected = false, bool isDragging = false}) {
    return Opacity(
      opacity: isDragging ? 0.7 : 1.0,
      child: SizedBox(
        width: 80.w, // 40 * 2
        height: 80.w, // 40 * 2
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
              child: VigaAppNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.cover,
              ),
            ),
            if (isSelected)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
                  border: Border.all(
                    color: AppColors.brandGreenVibrant5,
                    width: 4.w, // 2 * 2
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationChip(String text, ThemeData theme) {
    final bool isSelected = _selectedLocation == text;
    return InkWell(
      borderRadius: BorderRadius.circular(40.w), // 20 * 2
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
        margin: EdgeInsets.only(right: 16.w), // 8 * 2
        padding:
            EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w), // 12*2, 6*2
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.brandGreenVibrant5.withAlpha((0.1 * 255).toInt())
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(40.w), // 20 * 2
          border: isSelected
              ? Border.all(color: AppColors.brandGreenVibrant5, width: 2.0.w)
              : null, // 1 * 2
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? AppColors.brandGreenVibrant5
                : theme.colorScheme.onSurfaceVariant,
            fontSize: 26.w,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showVisibilityBottomSheet(BuildContext context) {
    ThemeData theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        minHeight: 800.w, // 400 * 2
        maxHeight: 800.w, // 400 * 2
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0.w), // 20 * 2
              topRight: Radius.circular(40.0.w), // 20 * 2
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                blurRadius: 20.w,
                offset: Offset(0, -4.w),
              ),
            ],
          ),
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.w), // 8 * 2
                child: Container(
                  width: 80.w, // 40 * 2
                  height: 8.w, // 4 * 2
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: BorderRadius.circular(4.w), // 2 * 2
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32.0.w, vertical: 16.0.w), // 16*2, 8*2
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '以下可见权限设置只对发作品生效',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 28.w, // 14 * 2
                    ),
                  ),
                ),
              ),
              _buildVisibilityOption(context, '公开: 所有人可见', theme),
              _buildVisibilityOption(context, '私密: 仅自己可见', theme),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisibilityOption(
      BuildContext context, String title, ThemeData theme) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedVisibility = title;
        });
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12.w),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 32.0.w, vertical: 24.0.w), // 16*2, 12*2
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: theme.dividerColor, width: 1.0.w), // 0.5 * 2
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 32.w, // 16 * 2
                  fontWeight: _selectedVisibility == title
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: _selectedVisibility == title
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
            if (_selectedVisibility == title)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 32.w,
              ),
          ],
        ),
      ),
    );
  }
}
