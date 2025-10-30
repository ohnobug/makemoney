import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/tools/viga_tools.dart';
// import 'package:vigaviga/tools/tools.dart';
import 'package:video_player/video_player.dart';

class VigaVideoPage extends StatefulWidget {
  const VigaVideoPage({super.key});

  @override
  State<VigaVideoPage> createState() => _VigaVideoState();
}

class _VigaVideoState extends State<VigaVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(assetPath('images/ins/test.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: _controller.value.isPlaying
            ? Icon(
                const IconData(
                  0xea81,
                  fontFamily: 'Iconfont',
                ), // 使用的图标
                color: colorScheme.onSurface, // 图标颜色
                size: 36.w, // 图标大小
              )
            : Icon(
                const IconData(
                  0xea82,
                  fontFamily: 'Iconfont',
                ), // 使用的图标
                color: colorScheme.onSurface, // 图标颜色
                size: 36.w, // 图标大小
              ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
