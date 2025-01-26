import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_whip/flutter_whip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhipSubscribeSample extends StatefulWidget {
  static String tag = 'whip_subscribe_sample';

  const WhipSubscribeSample({super.key});

  @override
  State<WhipSubscribeSample> createState() => _WhipSubscribeSampleState();
}

class _WhipSubscribeSampleState extends State<WhipSubscribeSample> {
  final _remoteRenderer = RTCVideoRenderer();
  bool _connecting = false;
  late WHIP _whip;
  String stateStr = 'init';

  final TextEditingController _serverController = TextEditingController();
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    initRenderers();
    _loadSettings();
  }

  void _loadSettings() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _serverController.text = _preferences.getString('pullserver') ??
          'http://129.226.152.191:1985/rtc/v1/whip/?app=live&stream=livestream';
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    _remoteRenderer.dispose();
  }

  void _saveSettings() {
    _preferences.setString('pullserver', _serverController.text);
  }

  void initRenderers() async {
    await _remoteRenderer.initialize();
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
    try {
      await _whip.initlize(mode: WhipMode.kReceive);
      _whip.onTrack = (event) {
        if (event.track.kind == 'video') {
          _remoteRenderer.srcObject = event.streams[0];
        }
      };
      await _whip.connect();
    } catch (e) {
      if (kDebugMode) {
        print('connect: error => $e');
      }
      return;
    }
    if (!mounted) return;

    setState(() {
      _connecting = true;
    });
  }

  void _disconnect() async {
    try {
      _remoteRenderer.srcObject = null;
      _whip.close();
      setState(() {
        _connecting = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WHIP Subscribe Sample'), actions: <Widget>[]),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(children: <Widget>[
            Column(children: <Widget>[
              FittedBox(
                child: Text(
                  stateStr,
                  textAlign: TextAlign.left,
                ),
              ),
              if (!_connecting)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('WHIP URI:'),
                  ),
                ),
              if (!_connecting)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: TextFormField(
                    controller: _serverController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12)),
                    ),
                  ),
                )
            ]),
            if (_connecting)
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 110,
                  decoration: BoxDecoration(color: Colors.black54),
                  child: RTCVideoView(_remoteRenderer,
                      mirror: false,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                ),
              )
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _connecting ? _disconnect : _connect,
        tooltip: _connecting ? 'Hangup' : 'Call',
        child: Icon(_connecting ? Icons.stop : Icons.play_arrow_sharp),
      ),
    );
  }
}
