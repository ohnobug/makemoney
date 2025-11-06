// =========================================================================
// 用户作品分享面板组件
// =========================================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/screens/arts/widgets/viga_video_data.dart';
import 'package:vigaviga/tools/viga_logger.dart';

class VigaUserWorksSharePanel extends StatelessWidget {
  final VideoData videoData;

  const VigaUserWorksSharePanel({
    super.key,
    required this.videoData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 顶部标题栏
          Container(
            height: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '分享作品',
                  style: TextStyle(
                    fontSize: 32.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.close,
                    size: 40.w,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // 分享选项网格
          Padding(
            padding: EdgeInsets.all(20.w),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
              children: [
                _buildShareOption(
                  icon: const IconData(0xe60f, fontFamily: 'Iconfont'),
                  label: '微信',
                  onTap: () => _handleShareAction(context, '微信'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe610, fontFamily: 'Iconfont'),
                  label: '朋友圈',
                  onTap: () => _handleShareAction(context, '朋友圈'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe611, fontFamily: 'Iconfont'),
                  label: 'QQ',
                  onTap: () => _handleShareAction(context, 'QQ'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe612, fontFamily: 'Iconfont'),
                  label: 'QQ空间',
                  onTap: () => _handleShareAction(context, 'QQ空间'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe613, fontFamily: 'Iconfont'),
                  label: '微博',
                  onTap: () => _handleShareAction(context, '微博'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe614, fontFamily: 'Iconfont'),
                  label: '抖音',
                  onTap: () => _handleShareAction(context, '抖音'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe615, fontFamily: 'Iconfont'),
                  label: '快手',
                  onTap: () => _handleShareAction(context, '快手'),
                ),
                _buildShareOption(
                  icon: const IconData(0xe616, fontFamily: 'Iconfont'),
                  label: '复制链接',
                  onTap: () => _handleShareAction(context, '复制链接'),
                ),
              ],
            ),
          ),

          // 底部操作按钮
          Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Divider(
                  height: 1.w,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 20.w),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: const IconData(0xe617, fontFamily: 'Iconfont'),
                        label: '保存到相册',
                        onTap: () => _handleAction(context, '保存到相册'),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: _buildActionButton(
                        icon: const IconData(0xe618, fontFamily: 'Iconfont'),
                        label: '举报',
                        onTap: () => _handleAction(context, '举报'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(45.w),
            ),
            child: Icon(
              icon,
              size: 45.w,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 24.w,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32.w,
              color: Colors.black87,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleShareAction(BuildContext context, String platform) {
    logger.info('分享到 $platform: ${videoData.description}');
    context.pop();
  }

  void _handleAction(BuildContext context, String action) {
    logger.info('执行操作: $action - ${videoData.description}');
    context.pop();
  }
}
