import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_whip/flutter_whip.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class LJNVideoCall extends StatefulWidget {
  const LJNVideoCall({super.key});

  @override
  State<LJNVideoCall> createState() => _LJNVideoCallState();
}

class _LJNVideoCallState extends State<LJNVideoCall> {
  MediaStream? _localStream;
  final _localRenderer = RTCVideoRenderer();
  String stateStr = 'init';
  bool _connecting = false;
  late WHIP _whip;

  final TextEditingController _serverController = TextEditingController();
  late SharedPreferences _preferences;

  // 音频播放器
  late dynamic _voiceController;

  @override
  void initState() {
    super.initState();

    _voiceController =
        VideoPlayerController.asset(assetPath("sounds/scan_success.mp3"))
          ..initialize().then((_) {
            setState(() {});
          });

    initRenderers();
    _loadSettings();
    _connect();
  }

  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _serverController.text = _preferences.getString('pushserver') ??
          'http://129.226.152.191:1985/rtc/v1/whip/?app=live&stream=livestream';
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    _localRenderer.dispose();
  }

  void _saveSettings() {
    _preferences.setString('pushserver', _serverController.text);
  }

  void initRenderers() async {
    await _localRenderer.initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _connect() async {
    final url = _serverController.text;

    if (url.isEmpty) {
      return;
    }

    _saveSettings();

    _whip = WHIP(url: url);

    _whip.onState = (WhipState state) {
      setState(() {
        switch (state) {
          case WhipState.kNew:
            stateStr = 'New';
            break;
          case WhipState.kInitialized:
            stateStr = 'Initialized';
            break;
          case WhipState.kConnecting:
            stateStr = 'Connecting';
            break;
          case WhipState.kConnected:
            stateStr = 'Connected';
            break;
          case WhipState.kDisconnected:
            stateStr = 'Closed';
            break;
          case WhipState.kFailure:
            stateStr = 'Failure: \n${_whip.lastError.toString()}';
            break;
        }
      });
    };

    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth': '1280',
          'minHeight': '720',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };

    try {
      var stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localStream = stream;
      _localRenderer.srcObject = _localStream;
      await _whip.initlize(mode: WhipMode.kSend, stream: _localStream);
      await _whip.connect();
    } catch (e) {
      logger.info('connect: error => $e');
      _localRenderer.srcObject = null;
      _localStream?.dispose();
      return;
    }
    if (!mounted) return;

    setState(() {
      _connecting = true;
    });
  }

  void _disconnect() async {
    try {
      if (kIsWeb) {
        _localStream?.getTracks().forEach(
              (track) => track.stop(),
            );
      }
      await _localStream?.dispose();
      _localRenderer.srcObject = null;
      _whip.close();
      setState(() {
        _connecting = false;
      });
    } catch (e) {
      logger.info(
        e.toString(),
      );
    }
  }

  void _toggleCamera() async {
    if (_localStream == null) throw Exception('Stream is not initialized');
    final videoTrack = _localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');
    await Helper.switchCamera(videoTrack);
  }

  @override
  void dispose() {
    _disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      primary: false,
      body: Container(
        color: Colors.black54,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            if (_connecting)
              RTCVideoView(
                _localRenderer,
                mirror: true,
                filterQuality: FilterQuality.high,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              )
            else
              // 填入Whip URI地址
              Container(
                padding: EdgeInsets.only(top: 100.w),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0).w,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('WHIP URI:'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0).w,
                      child: TextFormField(
                        controller: _serverController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            // 三个按钮
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _toggleCamera,
                    child: SizedBox(
                      width: 140.w,
                      height: 242.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 麦克风开关按钮
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(140.w),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              const IconData(
                                0xec8c,
                                fontFamily: 'Iconfont',
                              ),
                              color: Colors.black,
                              size: 64.w,
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            "麦克风已开",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.w),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 77.w,
                  ),

                  // 取消按钮
                  GestureDetector(
                    onTap: _disconnect,
                    child: SizedBox(
                      width: 140.w,
                      height: 242.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // 播放音乐
                              if (!Platform.isWindows) {
                                await _voiceController.play();
                              }

                              // 等待一会再跳转
                              await Future.delayed(Duration(milliseconds: 600),
                                  () {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              });
                            },
                            child: Container(
                              width: 140.w,
                              height: 140.w,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 217, 79, 77),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(140.w),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(
                                  0xe781,
                                  fontFamily: 'Iconfont',
                                ),
                                color: Colors.white,
                                size: 64.w,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            "取消",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.w),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 77.w,
                  ),

                  // 扬声器开关按钮
                  GestureDetector(
                    onTap: () {
                      _connect();
                    },
                    child: SizedBox(
                      width: 140.w,
                      height: 242.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 13, 13, 11),
                              borderRadius: BorderRadius.all(
                                Radius.circular(140.w),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              const IconData(
                                0xe69c,
                                fontFamily: 'Iconfont',
                              ),
                              color: Colors.white,
                              size: 64.w,
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            "扬声器已关",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.w),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
