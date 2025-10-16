// G:\t\detection\aiproject\lib\screens\discovery\ljn_ins_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/ins_style_row.dart'; // 确保这个路径是正确的

class LJNInsPage extends StatefulWidget {
  const LJNInsPage({super.key});
  @override
  State<LJNInsPage> createState() => _LJNInsPageState();
}

class _LJNInsPageState extends State<LJNInsPage> {
  late List<List<MediaItem>> _mediaRows;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarLight = false;

  @override
  void initState() {
    super.initState();
    _mediaRows = _generateMockData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    const threshold = 100.0;
    final bool shouldBeLight = _scrollController.offset >= threshold;
    if (shouldBeLight != _isAppBarLight) {
      setState(() {
        _isAppBarLight = shouldBeLight;
      });
    }
  }

  List<List<MediaItem>> _generateMockData() {
    return List.generate(100, (rowIndex) {
      final isVideo = (rowIndex % 5 == 0);
      return List.generate(5, (itemIndex) {
        final seed = rowIndex * 5 + itemIndex;
        if (itemIndex == 0) {
          return MediaItem(
            isVideo: isVideo,
            thumbnailUrl: 'https://picsum.photos/seed/$seed/300/500',
            mediaUrl: isVideo
                ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
                : 'https://picsum.photos/seed/$seed/600/1000',
          );
        }
        return MediaItem(
          isVideo: false,
          thumbnailUrl: 'https://picsum.photos/seed/$seed/300/250',
          mediaUrl: 'https://picsum.photos/seed/$seed/600/500',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: const Text("Ins-Style Page (Optimized)"),
            floating: true,
            snap: true,
            systemOverlayStyle: _isAppBarLight
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index.isOdd) return const SizedBox(height: 2);
                final rowIndex = index ~/ 2;
                if (rowIndex >= _mediaRows.length) return null;
                return InsStyleRow(
                  items: _mediaRows[rowIndex],
                  layoutType: RowLayoutType.values[rowIndex % 3],
                );
              },
              childCount: _mediaRows.length * 2 - 1,
            ),
          ),
        ],
      ),
    );
  }
}
