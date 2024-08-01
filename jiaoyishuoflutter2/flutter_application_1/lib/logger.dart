import 'package:logging/logging.dart';

// 创建一个全局 Logger 实例
final Logger logger = Logger('GlobalLogger');

void setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.time}: [${record.level}] ${record.loggerName}: ${record.message}');
  });
}
