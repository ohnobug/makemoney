// G:\t\detection\aiproject\lib\screens\discovery\widgets\viga_ins_component.dart
// 独立瀑布流组件 - 可在其他页面中复用

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ins_style_row.dart';

/// 独立瀑布流组件 - 提供可复用的瀑布流展示
class VigaInsComponent extends StatefulWidget {
  final bool enableScroll; // 是否启用滚动

  const VigaInsComponent({super.key, this.enableScroll = true});

  @override
  State<VigaInsComponent> createState() => _VigaInsComponentState();
}

class _VigaInsComponentState extends State<VigaInsComponent> {
  late List<List<MediaItem>> _mediaRows; // 媒体数据

  @override
  void initState() {
    super.initState();
    _mediaRows = _generateMockData(); // 生成模拟数据
  }

  /// 生成模拟数据 - 只包含图片，不包含视频
  List<List<MediaItem>> _generateMockData() {
    return List.generate(10, (rowIndex) {
      // 只生成图片，不生成视频
      return List.generate(5, (itemIndex) {
        final seed = rowIndex * 5 + itemIndex;
        return MediaItem(
          isVideo: false, // 只展示图片
          thumbnailUrl: 'https://picsum.photos/seed/$seed/300/500',
          mediaUrl: 'https://picsum.photos/seed/$seed/600/1000',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.enableScroll
          ? const BouncingScrollPhysics() // 启用滚动
          : const NeverScrollableScrollPhysics(), // 禁用滚动
      shrinkWrap: !widget.enableScroll, // 禁用滚动时需要自适应高度
      itemCount: _mediaRows.length * 2 - 1, // 总项目数（包含间距）
      itemBuilder: (context, index) {
        if (index.isOdd) return SizedBox(height: 2.w); // 奇数索引为行间距
        final rowIndex = index ~/ 2; // 计算行索引
        if (rowIndex >= _mediaRows.length) return null;

        return InsStyleRow(
          items: _mediaRows[rowIndex],
          layoutType: RowLayoutType.values[rowIndex % 3], // 保持三种样式循环
          canPlay: false, // 不播放视频
          onItemTap: null, // 不处理点击事件
        );
      },
    );
  }
}