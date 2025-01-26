import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:jiaoyishuoflutter3/logger.dart';

Future<Map> getTurnCredential(String host, int port) async {
    HttpClient client = HttpClient(context: SecurityContext());
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      logger.info('getTurnCredential: Allow self-signed certificate => $host:$port. ');
      return true;
    };
    var url = 'https://$host:$port/api/turn?service=turn&username=flutter-webrtc';
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    logger.info('getTurnCredential:response => $responseBody.');
    Map data = JsonDecoder().convert(responseBody);
    return data;
  }
