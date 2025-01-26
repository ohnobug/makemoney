import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jiaoyishuoflutter3/logger.dart';

Future<Map> getTurnCredential(String host, int port) async {
  var url = 'https://$host:$port/api/turn?service=turn&username=flutter-webrtc';
  final res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    var data = json.decode(res.body);
    logger.info('getTurnCredential:response => $data.');
    return data;
  }
  return {};
}
