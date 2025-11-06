import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigaviga/tools/viga_logger.dart';

// 跨平台存储服务
class VigaStorageService {
  static const String _userStateKey = 'user_state';

  // 保存用户状态
  static Future<void> saveUserState(Map<String, dynamic> stateMap) async {
    try {
      logger.info('VigaStorageService: 开始保存用户状态');
      final prefs = await SharedPreferences.getInstance();
      final stateJson = _encodeState(stateMap);
      logger.info('VigaStorageService: 编码后的状态JSON: $stateJson');
      final result = await prefs.setString(_userStateKey, stateJson);
      logger.info('VigaStorageService: 保存结果: $result');
    } catch (e) {
      logger.warning('保存用户状态失败: $e');
    }
  }

  // 加载用户状态
  static Future<Map<String, dynamic>?> loadUserState() async {
    try {
      logger.info('VigaStorageService: 开始加载用户状态');
      final prefs = await SharedPreferences.getInstance();
      final savedState = prefs.getString(_userStateKey);
      logger.info('VigaStorageService: 从存储中读取的状态: $savedState');

      if (savedState != null) {
        final decodedState = _decodeState(savedState);
        logger.info('VigaStorageService: 解码后的状态: $decodedState');
        return decodedState;
      } else {
        logger.info('VigaStorageService: 没有找到保存的状态');
      }
    } catch (e) {
      logger.warning('加载用户状态失败: $e');
    }
    return null;
  }

  // 清除用户状态
  static Future<void> clearUserState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userStateKey);
    } catch (e) {
      logger.warning('清除用户状态失败: $e');
    }
  }

  // 编码状态为JSON字符串
  static String _encodeState(Map<String, dynamic> stateMap) {
    return json.encode(stateMap);
  }

  // 解码JSON字符串为状态
  static Map<String, dynamic> _decodeState(String jsonString) {
    return json.decode(jsonString);
  }
}