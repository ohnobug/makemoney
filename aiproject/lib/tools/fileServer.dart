import 'dart:io';
import 'dart:isolate';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
import 'package:jiaoyishuoflutter3/main.dart';
// import 'package:jiaoyishuoflutter3/tools/tools.dart';
// import 'package:path/path.dart';

Future<void> startFileServer(FileServerParams params) async {
  // String sandboxWebPath = join(params.directoryPath, 'web');

  SendPort sendPort = params.sendPort;

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, params.port);
  sendPort.send(
      'File server running on http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    try {
      // 设置响应头
      request.response.headers.contentType =
          ContentType("text", "html", charset: "utf-8");

      request.response
        ..statusCode = HttpStatus.notFound
        ..write(params.defaultPages);

//       ByteData data = await rootBundle.load('assets/web/pages.html');
//       List<int> bytes =
//           data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// // 设置响应状态码
//       request.response.statusCode = HttpStatus.ok;

// // 使用 Stream.fromFuture 将 Future<List<int>> 转换为 Stream<List<int>>
//       await request.response.addStream(Stream.fromFuture(Future.value(bytes)));

      // ByteData data = await rootBundle.load('assets/web/pages.html');
      // List<int> bytes =
      //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // request.response
      //   ..statusCode = HttpStatus.notFound
      //   ..write(bytes.toString());
      // // 获取请求的路径并去掉前导"/"
      // String requestedPath = Uri.decodeFull(request.uri.path).substring(1);

      // // 获取沙盒存储中 web 目录的路径
      // var dbPath = join(sandboxWebPath, requestedPath);

      // // 如果文件不存在，则返回 404 错误
      // if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      //   request.response
      //     ..statusCode = HttpStatus.notFound
      //     ..write("404 Not Found");
      //   return;
      // }

      // // 如果请求的是文件，返回文件内容
      // File file = File(dbPath);
      // if (await file.exists()) {
      //   request.response.headers.contentType = ContentType.binary;
      //   await file.openRead().pipe(request.response);
      // } else {
      //   // 如果请求的是目录，列出该目录下的文件
      //   Directory dir = Directory(dbPath);
      //   if (await dir.exists()) {
      //     request.response.headers.contentType =
      //         ContentType("text", "html", charset: "utf-8");

      //     List<FileSystemEntity> entries = dir.listSync();
      //     String fileListHtml = entries.map((entry) {
      //       String name = entry.uri.pathSegments.last;
      //       return '<li><a href="${request.uri.path}/$name">$name</a></li>';
      //     }).join();

      //     String html = """
      //     <html>
      //     <body>
      //     <h1>Index of ${request.uri.path}</h1>
      //     <ul>$fileListHtml</ul>
      //     </body>
      //     </html>
      //     """;

      //     request.response.write(html);
      //   } else {
      //     // 处理 404 错误
      //     request.response
      //       ..statusCode = HttpStatus.notFound
      //       ..write("404 Not Found");
      //   }
      // }
    } finally {
      await request.response.close();
    }
  }
}
