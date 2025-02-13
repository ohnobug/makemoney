import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:jiaoyishuoflutter3/logger.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/user/cubit/user_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'package:get_thumbnail_video/video_thumbnail.dart';

class LJNVideoMessage extends StatefulWidget {
  const LJNVideoMessage({
    super.key,
    required this.video,
    required this.showName,
    this.name,
    this.onTap,
    required this.width,
    required this.height,
  });

  final Function(Offset, Size)? onTap;
  final String? name;
  final bool showName;
  final String video;
  final double width;
  final double height;

  @override
  State<LJNVideoMessage> createState() => _LJNVideoMessage();
}

class _LJNVideoMessage extends State<LJNVideoMessage> {
  VideoPlayerController? _controller;
  GlobalKey videoContainerKey = GlobalKey();
  late double videoWidth;
  late double videoHeight;
  String? picPath;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();

    double aspectRatio = widget.width / widget.height;
    if (aspectRatio > 1) {
      videoWidth = 300.w;
      videoHeight = videoWidth / aspectRatio;
    } else {
      videoHeight = 700.w * aspectRatio;
      if (videoHeight > 906.w) {
        videoHeight = 906.w;
      }
      videoWidth = videoHeight * aspectRatio;
    }

    // videoWidth /= 2.5;
    // videoHeight /= 2.5;

    // _controller ??= VideoPlayerController.asset(assetPath(widget.video))
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });

    _getFirstFrame(assetPath(widget.video));
  }

  Future<void> _getFirstFrame(String filepath) async {
    WidgetsFlutterBinding.ensureInitialized();
    String filehash = await generateStringChunkHash(filepath);
    String tempFile = filehash.substring(0, 16);

    if (!Platform.isWindows) {
      final List<Directory>? tempDir = await getExternalCacheDirectories();

      // 提取首帧并保存为图片
      final String outputImagePath = '${tempDir?[0].path}/$tempFile.png';

      var imageFile = File(outputImagePath);
      if (imageFile.existsSync() && await _isValidImage(imageFile)) {
        setState(() {
          picPath = outputImagePath;
        });
        return;
      } else {
        if (imageFile.existsSync()) {
          imageFile.deleteSync();
        }

        // 获取应用的文档目录
        final directory = await getApplicationDocumentsDirectory();
        String filename = path.basename(filepath);

        // 拼接本地存储的文件路径
        final videoPath = '${directory.path}/$filename';
        // =========================================================================
        // 从 assets 加载视频文件
        ByteData byteData = await rootBundle.load(filepath);
        // logger.info('ByteData length: ${byteData.lengthInBytes}');
        if (byteData.lengthInBytes == 0) {
          throw Exception('Failed to load video file.');
        }
        List<int> bytes = byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
        final file = File(videoPath);
        await file.writeAsBytes(bytes);
        // =========================================================================

        final fileName = await VideoThumbnail.thumbnailFile(
          video: videoPath,
          thumbnailPath: outputImagePath,
          imageFormat: ImageFormat.PNG,
          quality: 100,
        );

        setState(() {
          picPath = fileName.path;
        });
      }
    }
  }

  Future<bool> _isValidImage(File file) async {
    if (file.lengthSync() <= 4) {
      return false;
    }

    logger.info("file length: ${file.lengthSync()}");

    final bytes = await file.openRead(0, 4).first;
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      logger.info("This is a valid PNG file.");
      return true;
    } else if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      logger.info("This is a valid JPG file.");
      return true;
    } else {
      logger.info("Unknown file format.");
      return false;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return Container(
        padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 姓名与消息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 姓名
                  if (widget.showName)
                    Container(
                      padding:
                          const EdgeInsets.only(right: 23, top: 0, bottom: 3).w,
                      // height: 33.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name ??
                                context.read<UserCubit>().state.userinfoName!,
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(20.w),
                              color: const Color.fromARGB(255, 130, 130, 130),
                            ),
                          )
                        ],
                      ),
                    ),

                  // 消息
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // 消息
                      GestureDetector(
                          onTap: () {
                            final RenderBox renderBox = videoContainerKey
                                .currentContext
                                ?.findRenderObject() as RenderBox;

                            Offset position =
                                renderBox.localToGlobal(Offset.zero);
                            Size size = renderBox.size;

                            widget.onTap!(position, size);
                          },
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              key: videoContainerKey,
                              width: videoWidth,
                              height: videoHeight,
                              // color: Colors.grey,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 158, 236, 114),
                                  borderRadius: BorderRadius.circular(8).w),
                              child: picPath != null
                                  ? Stack(
                                      children: [
                                        Image.file(
                                          File(picPath!),
                                          width: videoWidth,
                                          height: videoHeight,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          width: videoWidth,
                                          height: videoHeight,
                                          alignment: Alignment.center,
                                          color: const Color.fromARGB(
                                              105, 0, 0, 0),
                                          child: Icon(
                                            const IconData(
                                              0xe6c5,
                                              fontFamily: 'Iconfont',
                                            ),
                                            color: Colors.white,
                                            size: 78.w,
                                          ),
                                        ),
                                        // const Text(
                                        //   "缓存",
                                        //   style: TextStyle(
                                        //       color: Colors.white),
                                        // ),
                                      ],
                                    )
                                  : Container()
                              // AspectRatio(
                              //   aspectRatio: _controller!.value.aspectRatio,
                              //   child: VideoPlayer(_controller!),
                              // ),
                              )),
                      // 箭头
                      SizedBox(
                        width: 20.w,
                        // padding: const EdgeInsets.only(top: 32).w,
                        // child: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 头像
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/friendprofile',
                      arguments: <String, String>{
                        'name': context.read<UserCubit>().state.userinfoName!,
                        'avatar':
                            context.read<UserCubit>().state.userinfoAvatar!,
                        'nickname':
                            context.read<UserCubit>().state.userinfoName!,
                        'account':
                            context.read<UserCubit>().state.userinfoAccount!,
                      });
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8).w,
                    child: Image.asset(
                      assetPath(
                          context.read<UserCubit>().state.userinfoAvatar!),
                      cacheWidth: 156.w.toInt(),
                      cacheHeight: 156.w.toInt(),
                      width: 78.w,
                      height: 78.w,
                      fit: BoxFit.cover,
                    )))
          ],
        ),
      );
    });
  }
}
