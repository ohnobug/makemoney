import 'dart:io';
import 'dart:isolate';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/main.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:jiaoyishuoflutter3/tools/tools.dart';
// import 'package:path/path.dart';

Future<void> startFileServer(FileServerParams params) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(params.rootIsolateToken);

  SendPort sendPort = params.sendPort;

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, params.port);
  sendPort.send(
      'File server running on http://${server.address.host}:${server.port}');

  // 获取应用沙盒存储的路径
  final directory = await getApplicationDocumentsDirectory();
  // String sandboxWebPath = join(params.directoryPath, 'web');

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
