import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/screens/arts/widgets/viga_video_data.dart';

class VigaArtInfoModalContent extends StatelessWidget {
  final ScrollController scrollController;
  final VideoData currentVideoData;
  final SystemState systemState;

  const VigaArtInfoModalContent({
    super.key,
    required this.scrollController,
    required this.currentVideoData,
    required this.systemState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xCC000000),
            Color(0xE6000000),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ListView(
            controller: scrollController,
            padding: EdgeInsets.only(top: 120.w + systemState.statusHeight),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildInfoCard(
                      icon: Icons.info_outline,
                      title: '基本信息',
                      children: [
                        _buildInfoItem('作品名称', currentVideoData.userName),
                        _buildInfoItem('作者', currentVideoData.userName),
                        _buildInfoItem('发布时间', '2024-10-20 15:30:00'),
                        _buildInfoItem('地点', '中国·广州'),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.description,
                      title: '作品内容',
                      children: [
                        _buildDescriptionItem(
                            '作品描述', currentVideoData.description),
                        _buildTagsItem('作品标签', [
                          '#懒人救星',
                          '#居家办公',
                          '#电竞',
                          '#游戏',
                          '#男生房间',
                          '#INGREM',
                          '#治愈',
                          '#生活'
                        ]),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.storage,
                      title: '技术信息',
                      children: [
                        _buildInfoItem('文件大小', '2.3 MB'),
                        _buildInfoItem('文件格式', 'MP4'),
                        _buildInfoItem('分辨率', '1080x1920'),
                        _buildInfoItem('时长', '15秒'),
                        _buildInfoItem('IPFS地址',
                            'https://ipfs.io/ipfs/Qm${currentVideoData.videoPath.hashCode.toRadixString(16)}'),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.analytics,
                      title: '互动数据',
                      children: [
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 12.w,
                          children: [
                            _buildStatsItem(
                                '点赞',
                                currentVideoData.likeCount.toString(),
                                Icons.favorite),
                            _buildStatsItem(
                                '评论',
                                currentVideoData.commentCount.toString(),
                                Icons.comment),
                            _buildStatsItem(
                                '转发',
                                currentVideoData.shareCount.toString(),
                                Icons.share),
                            _buildStatsItem(
                                '收藏',
                                currentVideoData.collectionCount.toString(),
                                Icons.bookmark),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _buildInfoCard(
                      icon: Icons.copyright,
                      title: '版权信息',
                      children: [
                        _buildInfoItem('版权状态', '原创作品'),
                        _buildInfoItem('授权方式', 'CC BY-NC 4.0'),
                        _buildInfoItem('区块链哈希',
                            '0x${currentVideoData.videoPath.hashCode.toRadixString(16)}'),
                      ],
                    ),
                    SizedBox(height: 100.w),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 14, 14, 10),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.w + systemState.statusHeight,
                  bottom: 20.w,
                  left: 20.w,
                  right: 20.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '作品信息',
                      style: TextStyle(
                        fontSize: 36.w,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 32.w,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(
          color: Colors.white.withAlpha(51),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white.withAlpha(204),
                  size: 32.w,
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.w,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.white.withAlpha(204),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 26.w,
              color: Colors.white.withAlpha(204),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.w),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 26.w,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsItem(String label, List<String> tags) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 26.w,
              color: Colors.white.withAlpha(204),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.w),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            children: tags
                .map((tag) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(20.w),
                        border: Border.all(color: Colors.white.withAlpha(80)),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 22.w,
                          color: Colors.white,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsItem(String label, String value, IconData icon) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32.w,
          ),
          SizedBox(height: 8.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.w,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 20.w,
              color: Colors.white.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}
