import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:jiaoyishuoflutter3/logger.dart';

Future<void> startFileServer(SendPort sendPort) async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 9413);
  logger.info(
      'File server running on http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    try {
      // 获取请求的路径并去掉前导"/"
      String requestedPath = Uri.decodeFull(request.uri.path).substring(1);
      String filePath = Directory("/assets/web/pages.html")
          .uri
          .resolve(requestedPath)
          .toFilePath();

      logger.info("aaaaaaaaaaaa $filePath");

      File file = File(filePath);

      if (await file.exists()) {
        // 如果请求的是文件，返回文件内容
        request.response.headers.contentType = ContentType.binary;
        await file.openRead().pipe(request.response);
      } else {
        // 如果请求的是目录，列出该目录下的文件
        Directory dir = Directory(filePath);
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
    } catch (e) {
      request.response
        ..statusCode = HttpStatus.internalServerError
        ..write("Error: $e");
    } finally {
      await request.response.close();
    }
  }
}
