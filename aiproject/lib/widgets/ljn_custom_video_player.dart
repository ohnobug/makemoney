// /lib/widgets/custom_video_player.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

// 自定义视频播放器组件 (UI层)
class LJNCustomVideoPlayer extends StatefulWidget {
  final bool? canPlay;
  final VideoPlayerController controller;
  final double videoHeight;

  const LJNCustomVideoPlayer({
    super.key,
    this.canPlay,
    required this.controller,
    required this.videoHeight,
  });

  @override
  State<LJNCustomVideoPlayer> createState() => _LJNCustomVideoPlayerState();
}

class _LJNCustomVideoPlayerState extends State<LJNCustomVideoPlayer> {
  // 我们直接控制这个状态，不再依赖监听器
  bool _showPlayIcon = false;

  @override
  void initState() {
    super.initState();
    // 初始状态下，不显示任何图标
    _showPlayIcon = false;
  }

  @override
  void didUpdateWidget(LJNCustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 当 canPlay 状态改变时 (即用户上下滑动切换视频)
    if (oldWidget.canPlay != widget.canPlay) {
      if (widget.controller.value.isInitialized) {
        if (widget.canPlay == true) {
          // 新视频滑入，开始播放
          widget.controller.play();
        } else {
          // 旧视频滑出，暂停播放
          widget.controller.pause();
        }
        // [核心逻辑] 无论滑入还是滑出，都确保图标是隐藏的，因为这不是用户主动暂停
        setState(() {
          _showPlayIcon = false;
        });
      }
    }
  }

  // [关键改动] 移除了 _onControllerUpdate 监听器，这是解决问题的关键

  // _togglePlaying 现在是唯一能改变 _showPlayIcon 状态的地方
  void _togglePlaying() {
    if (!mounted || !widget.controller.value.isInitialized) return;

    setState(() {
      if (widget.controller.value.isPlaying) {
        // 如果正在播放，用户点击了 -> 暂停，并显示播放图标
        widget.controller.pause();
        _showPlayIcon = true;
      } else {
        // 如果已暂停，用户点击了 -> 播放，并隐藏播放图标
        widget.controller.play();
        _showPlayIcon = false;
      }
    });
  }

  // dispose 中不再需要移除监听器
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 750.w,
      height: widget.videoHeight,
      child: widget.controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: widget.controller.value.size.width,
                      height: widget.controller.value.size.height,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _togglePlaying,
                  behavior: HitTestBehavior.opaque,
                  child: Container(color: Colors.transparent),
                ),
                AnimatedOpacity(
                  opacity: _showPlayIcon ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white.withAlpha(200),
                      size: 140.w,
                    ),
                  ),
                ),
              ],
            )
          : Container(
              width: 750.w,
              height: widget.videoHeight,
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white54,
                ),
              ),
            ),
    );
  }
}
