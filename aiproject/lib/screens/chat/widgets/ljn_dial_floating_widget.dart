import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNDialFloatingWidget extends StatefulWidget {
  final SystemState systemState;
  const LJNDialFloatingWidget({super.key, required this.systemState});

  @override
  State<LJNDialFloatingWidget> createState() => _LJNDialFloatingWidget();
}

// 打电话浮窗
class _LJNDialFloatingWidget extends State<LJNDialFloatingWidget> {
  late dynamic _videoController;

  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();

    if (!Platform.isWindows) {
      _videoController =
          VideoPlayerController.asset(assetPath('images/ins/test.mp4'))
            ..initialize().then((_) {
              setState(() {
                if (_videoController.value.aspectRatio > 1) {
                  // 宽大于高
                  _width = 350.w;
                  _height = _width / _videoController.value.aspectRatio;
                } else {
                  _height = 622.w;
                  _width = _height * _videoController.value.aspectRatio;
                }
              });

              PictureInPicture.updatePiPParams(
                pipParams: PiPParams(
                  pipWindowHeight: _height,
                  pipWindowWidth: _width,
                ),
              );

              _videoController.setLooping(true);
              // _videoController.setVolume(0.0);
              _videoController.play();
            });
    }
  }

  @override
  void dispose() async {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blueAccent,
      child: Stack(children: [
        _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : SizedBox(),

        // 播放
        Positioned(
          bottom: 5.w,
          left: 5.w,
          child: ElevatedButton(
            onPressed: () {
              if (_videoController.value.isPlaying) {
                setState(() {
                  _videoController.pause();
                });
              } else {
                setState(() {
                  _videoController.play();
                });
              }
            },
            child:
                _videoController.value.isPlaying ? Text("Pause") : Text("Play"),
          ),
        ),

        // 退出
        Positioned(
          bottom: 5.w,
          right: 5.w,
          child: ElevatedButton(
            onPressed: () {
              PictureInPicture.stopPiP();
              widget.systemState.navigatorKey.currentState!.pushNamed('/dial');
            },
            child: Text("close"),
          ),
        ),
      ]),
    );
  }
}
