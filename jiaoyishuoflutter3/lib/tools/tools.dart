import 'dart:io';

import 'package:flutter/foundation.dart';

String assetPath(String path) {
  if (kIsWeb) {
    return path;
  }

  if (Platform.isAndroid) {
    return 'assets/$path';
  }

  return 'assets/$path';
}
