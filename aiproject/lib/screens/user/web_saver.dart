// lib/web_saver.dart

import 'dart:html' as html; // 在这个文件中，可以安全地导入 dart:html
import 'dart:typed_data';

// 创建一个顶层函数来处理 Web 端的下载逻辑
void saveImageForWeb(Uint8List imageData) {
  final blob = html.Blob([imageData]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "my_qrcode_${DateTime.now().millisecondsSinceEpoch}.png")
    ..click(); // 触发点击，开始下载
  html.Url.revokeObjectUrl(url); // 释放 URL 对象
}