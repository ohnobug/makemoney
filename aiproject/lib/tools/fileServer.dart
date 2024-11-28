import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<void> startFileServer(SendPort sendPort) async {
  // 获取应用沙盒存储的路径
  Directory directory = await getApplicationDocumentsDirectory();
  String sandboxWebPath = join(directory.path, 'web');

  // 复制 assets/web 目录到沙盒存储
  await _copyAssetsToSandbox(sandboxWebPath, sendPort);

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 9413);
  sendPort.send(
      'File server running on http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    try {
      // 获取请求的路径并去掉前导"/"
      String requestedPath = Uri.decodeFull(request.uri.path).substring(1);

      // 获取沙盒存储中 web 目录的路径
      var dbPath = join(sandboxWebPath, requestedPath);

      // 如果文件不存在，则返回 404 错误
      if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write("404 Not Found");
        return;
      }

      // 如果请求的是文件，返回文件内容
      File file = File(dbPath);
      if (await file.exists()) {
        request.response.headers.contentType = ContentType.binary;
        await file.openRead().pipe(request.response);
      } else {
        // 如果请求的是目录，列出该目录下的文件
        Directory dir = Directory(dbPath);
        if (await dir.exists()) {
          request.response.headers.contentType =
              ContentType("text", "html", charset: "utf-8");

          List<FileSystemEntity> entries = dir.listSync();
          String fileListHtml = entries.map((entry) {
            String name = entry.uri.pathSegments.last;
            return '<li><a href="${request.uri.path}/$name">$name</a></li>';
          }).join();

          String html = """
          <html>
          <body>
          <h1>Index of ${request.uri.path}</h1>
          <ul>$fileListHtml</ul>
          </body>
          </html>
          """;

          request.response.write(html);
        } else {
          // 处理 404 错误
          request.response
            ..statusCode = HttpStatus.notFound
            ..write("404 Not Found");
        }
      }
    } finally {
      await request.response.close();
    }
  }
}

// 复制 assets/web 目录中的所有文件到沙盒存储
Future<void> _copyAssetsToSandbox(
    String sandboxWebPath, SendPort sendPort) async {
  // 获取 assets/web 目录下的所有文件
  const assetWebDir = 'assets/web/';

  // 获取沙盒 web 目录，确保目录存在
  Directory webDir = Directory(sandboxWebPath);
  if (!await webDir.exists()) {
    await webDir.create(recursive: true);
  }

  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assetFiles = assetManifest
      .listAssets()
      .where((string) => string.startsWith("assets/web/"))
      .toList();

  // 复制每个文件
  for (var assetPath in assetFiles) {
    sendPort.send("filepath: $assetPath");

    if (assetPath.contains(assetWebDir)) {
      // 读取文件数据
      ByteData data = await rootBundle.load(assetPath);
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // 计算文件在沙盒中的路径
      String targetPath =
          join(sandboxWebPath, assetPath.replaceFirst(assetWebDir, ''));

      // 确保目标路径的目录存在
      Directory targetDir = Directory(dirname(targetPath));
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }

      // 将文件数据写入沙盒目录
      await File(targetPath).writeAsBytes(bytes);
    }
  }
  sendPort.send("Assets copied from 'assets/web' to sandbox storage.");
}
