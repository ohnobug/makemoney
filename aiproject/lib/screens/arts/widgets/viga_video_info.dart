import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/tools/viga_logger.dart';
import 'package:vigaviga/tools/viga_tools.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart';

class VigaVideoInfoSection extends StatefulWidget {
  final String userName;
  final String avatarUrl;
  final String description;
  const VigaVideoInfoSection({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.description,
  });
  @override
  State<VigaVideoInfoSection> createState() => VigaVideoInfoSectionState();
}

class VigaVideoInfoSectionState extends State<VigaVideoInfoSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  final int _descriptionThreshold = 60;
  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.description.length > _descriptionThreshold;
    final descriptionStyle = TextStyle(
      height: 1.4,
      fontSize: fontSizeScale(28.w),
      color: AppColors.neutralWhite,
    );
    return Container(
      width: 620.w,
      padding: EdgeInsets.all(25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/author/detail', extra: {
                'author_id': widget.userName,
                'author_name': widget.userName,
                'author_avatar': widget.avatarUrl,
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 5.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: VigaAppNetworkImage(
                      imageUrl: widget.avatarUrl,
                      width: 64.w,
                      height: 64.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    widget.userName,
                    style: TextStyle(
                      fontSize: fontSizeScale(30.w),
                      color: AppColors.neutralWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  GestureDetector(
                    onTap: () => logger.info("点击了关注按钮"),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.accentRedVibrant1.withAlpha(230),
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: Text(
                        "关注",
                        style: TextStyle(
                          color: AppColors.neutralWhite,
                          fontSize: fontSizeScale(26.w),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.w),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                if (isLongText) setState(() => _isExpanded = !_isExpanded);
              },
              child: _isExpanded
                  ? _buildExpandedDescription(descriptionStyle)
                  : _buildCollapsedDescription(isLongText, descriptionStyle),
            ),
          )
        ],
      ),
    );
  }

  // 更多面板
  Widget _buildCollapsedDescription(
      bool isLongText, TextStyle descriptionStyle) {
    String displayedText = isLongText
        ? widget.description.substring(0, _descriptionThreshold)
        : widget.description;
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: descriptionStyle,
        children: [
          TextSpan(text: displayedText),
          if (isLongText)
            TextSpan(
              text: "... 更多",
              style: descriptionStyle.copyWith(
                color: Colors.white.withAlpha(180),
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildExpandedDescription(TextStyle descriptionStyle) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 350.w),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                child: Text(widget.description, style: descriptionStyle),
              ),
            ),
          ),
          Positioned(
            bottom: 15.w,
            right: 15.w,
            child: GestureDetector(
              onTap: () => setState(() => _isExpanded = false),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8.w)),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 5.w,
                ),
                child: Text(
                  "收起",
                  textAlign: TextAlign.center,
                  style: descriptionStyle.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
