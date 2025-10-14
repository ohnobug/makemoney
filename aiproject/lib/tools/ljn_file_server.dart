import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:path_provider/path_provider.dart';

/// Represents parameters for the file server.
class FileServerParams {
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;
  final int port;

  FileServerParams({
    required this.sendPort,
    required this.rootIsolateToken,
    required this.port,
  });
}

Future<void> startFileServer(FileServerParams params) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(params.rootIsolateToken);

  final SendPort sendPort = params.sendPort;

  final HttpServer server =
      await HttpServer.bind(InternetAddress.loopbackIPv4, params.port);
  sendPort.send(
      'File server running on http://${server.address.host}:${server.port}');

  // Get the application sandbox storage path
  final Directory directory = await getApplicationDocumentsDirectory();

  await for (final HttpRequest request in server) {
    try {
      // Set response headers
      request.response.headers.contentType =
          ContentType("text", "html", charset: "utf-8");

      String filePath = '${directory.path}/${request.uri.path}';


      if (request.uri.path == "/") {
        filePath = '${directory.path}/index.html';
      }

      // Check if the file exists, return 404 if not found
      if (FileSystemEntity.typeSync(filePath) ==
          FileSystemEntityType.notFound) {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write("404 Not Found");
        return;
      }

      final File file = File(filePath);
      final String fileContent = await file.readAsString();

      request.response
        ..statusCode = HttpStatus.ok
        ..write(fileContent);
    } finally {
      await request.response.close();
    }
  }
}

/// Starts the web server.
void startWebServer() async {
  final int port = 9413;

  // Check if the port is available
  final bool isPortAvailable = await ljnIsPortOpen(port);
  if (!isPortAvailable) {
    logger.info('Port $port is already in use, unable to start the server');
    return; // Stop server startup if port is occupied
  }

  final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  final Directory directory = await getApplicationDocumentsDirectory();

  copyFiles("assets/web/index.html", '${directory.path}/index.html');
  copyFiles("assets/web/code.html", '${directory.path}/code.html');

  // Start the web server
  final ReceivePort receivePort = ReceivePort();

  // Create parameters for the file server isolate
  final FileServerParams params = FileServerParams(
    sendPort: receivePort.sendPort,
    rootIsolateToken: rootIsolateToken,
    port: port,
  );

  await Isolate.spawn(startFileServer, params);
  receivePort.listen((final dynamic message) {
    logger.info(message); // Log server startup message
  });
}

Future<void> copyFiles(String source, target) async {
  // Read the file content from the package assets
  final ByteData byteData = await rootBundle.load(source);
  final List<int> bytes = byteData.buffer.asUint8List();
  final String fileContent = utf8.decode(bytes);

  // Write the content to the phone's storage
  final String filePath = target;
  final File file = File(filePath);
  await file.writeAsString(fileContent);
}

/// Checks if a port can be bound (useful before starting a service)
Future<bool> ljnIsPortOpen(int port) async {
  try {
    final ServerSocket server =
        await ServerSocket.bind(InternetAddress.loopbackIPv4, port);
    await server.close();
    return true;
  } catch (_) {
    return false;
  }
}
