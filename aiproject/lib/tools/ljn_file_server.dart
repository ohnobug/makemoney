import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/main.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_logger.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:jiaoyishuoflutter3/tools/tools.dart';
// import 'package:path/path.dart';

Future<void> ljnStartFileServer(FileServerParams params) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(params.rootIsolateToken);

  SendPort sendPort = params.sendPort;

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, params.port);
  sendPort.send(
      'File server running on http://${server.address.host}:${server.port}');

  // 获取应用沙盒存储的路径
  final directory = await getApplicationDocumentsDirectory();

  await for (HttpRequest request in server) {
    try {
      // 设置响应头
      request.response.headers.contentType =
          ContentType("text", "html", charset: "utf-8");

      final filePath = '${directory.path}/shapages.html';

      // 如果文件不存在，则返回 404 错误
      if (FileSystemEntity.typeSync(filePath) ==
          FileSystemEntityType.notFound) {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write("404 Not Found");
        return;
      }

      File file = File(filePath);
      String fileContent = await file.readAsString();

      request.response
        ..statusCode = HttpStatus.ok
        ..write(fileContent);
    } finally {
      await request.response.close();
    }
  }
}

// 启动web服务器
void ljnStartWebServer() async {
  int port = 9413;

  // 检查端口是否被占用
  bool isPortAvailable = await ljnIsPortOpen(port);
  if (!isPortAvailable) {
    logger.info('端口 $port 已被占用，无法启动服务器');
    return; // 端口被占用，停止启动服务器
  }

  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

  ByteData byteData = await rootBundle.load("assets/web/pages.html");
  List<int> bytes = byteData.buffer.asUint8List();
  String fileContent = utf8.decode(bytes);

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/shapages.html';
  final file = File(filePath);
  await file.writeAsString(fileContent);

  // 启动web服务器
  final receivePort = ReceivePort();

  // 创建参数对象
  var params = FileServerParams(
    sendPort: receivePort.sendPort,
    rootIsolateToken: rootIsolateToken,
    port: port,
  );

  await Isolate.spawn(ljnStartFileServer, params);
  receivePort.listen((message) {
    logger.info(message); // 打印服务器启动消息
  });
}

// 检查端口是否可绑定（推荐用于启动服务前）
Future<bool> ljnIsPortOpen(int port) async {
  try {
    final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, port);
    await server.close();
    return true;
  } catch (_) {
    return false;
  }
}
