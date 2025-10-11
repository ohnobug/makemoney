// lib/config/app_config.dart

class AppConfig {
  static const appEnv = String.fromEnvironment('APP_ENV', defaultValue: 'uat');
  static const Map urlMap = {
    'dev':'xxx1',
    'uat':'xxx2',
    'prod':'xxx3'
  };

  // 使用 getter 动态获取对应的 base URL
  static String get baseUrl {
    final url = urlMap[appEnv];
    if (url == null) {
      throw Exception('No URL configured for environment: $appEnv');
    }
    return url;
  }
}