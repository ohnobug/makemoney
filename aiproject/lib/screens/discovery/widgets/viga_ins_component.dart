// G:\t\detection\aiproject\lib\screens\discovery\widgets\viga_ins_component.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ins_style_row.dart';

class VigaInsComponent extends StatefulWidget {
  const VigaInsComponent({super.key});

  @override
  State<VigaInsComponent> createState() => _VigaInsComponentState();
}

class _VigaInsComponentState extends State<VigaInsComponent> {
  late List<List<MediaItem>> _mediaRows;

  @override
  void initState() {
    super.initState();
    _mediaRows = _generateMockData();
  }

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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _mediaRows.length * 2 - 1,
      itemBuilder: (context, index) {
        if (index.isOdd) return SizedBox(height: 2.w);
        final rowIndex = index ~/ 2;
        if (rowIndex >= _mediaRows.length) return null;

        return InsStyleRow(
          items: _mediaRows[rowIndex],
          layoutType: RowLayoutType.values[rowIndex % 3], // 保持三种样式
          canPlay: false, // 不播放视频
          onItemTap: null, // 不处理点击事件
        );
      },
    );
  }
}