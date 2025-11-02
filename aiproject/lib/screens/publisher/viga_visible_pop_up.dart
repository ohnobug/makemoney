import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaVisiblePopUp extends StatefulWidget {
  const VigaVisiblePopUp({super.key});

  @override
  State<VigaVisiblePopUp> createState() => _VigaVisiblePopUpState();
}

class _VigaVisiblePopUpState extends State<VigaVisiblePopUp> {
  String _selectedVisibility = '公开: 所有人可见'; // 初始选中的可见性

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      appBar: AppBar(
        title: Text(
          '发布作品',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 36.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: theme.colorScheme.surfaceContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).toInt()),
                      blurRadius: 15.w,
                      offset: Offset(0, 4.w),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 80.w,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(height: 24.w),
                    Text(
                      '当前可见性设置',
                      style: TextStyle(
                        fontSize: 28.w,
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withAlpha((0.3 * 255).toInt()),
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text(
                        _selectedVisibility,
                        style: TextStyle(
                          fontSize: 32.w,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.w), // 20 * 2
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showVisibilityBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.w),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 24.w),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_outlined, size: 32.w),
                      SizedBox(width: 12.w),
                      Text(
                        '打开可见性设置',
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
    );
  }

  void _showVisibilityBottomSheet(BuildContext context) {
    ThemeData theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部的拖动指示器
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
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 28.w,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '以下可见权限设置只对发作品生效',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 28.w, // 14 * 2
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildVisibilityOption(context, '公开: 所有人可见', theme),
              _buildVisibilityOption(context, '互相关注的人可见', theme),
              _buildVisibilityOption(context, '私密: 仅自己可见', theme),
              _buildComplexOption(context, '部分可见', Icons.chevron_right, theme),
              _buildComplexOption(context, '不给谁看', Icons.chevron_right, theme),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisibilityOption(BuildContext context, String title, ThemeData theme) {
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
                  fontWeight: _selectedVisibility == title ? FontWeight.w600 : FontWeight.normal,
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

  Widget _buildComplexOption(
      BuildContext context, String title, IconData? trailingIcon, ThemeData theme) {
    return InkWell(
      onTap: () {},
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
                  fontSize: 32.w,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.normal,
                ), // 16 * 2
              ),
            ),
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: theme.colorScheme.onSurfaceVariant,
                size: 24.w,
              ),
          ],
        ),
      ),
    );
  }
}
