import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigaviga/tools/viga_logger.dart';

// 跨平台存储服务
class VigaStorageService {
  static const String _userStateKey = 'user_state';

  // 保存用户状态
  static Future<void> saveUserState(Map<String, dynamic> stateMap) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stateJson = _encodeState(stateMap);
      await prefs.setString(_userStateKey, stateJson);
    } catch (e) {
      logger.warning('保存用户状态失败: $e');
    }
  }

  // 加载用户状态
  static Future<Map<String, dynamic>?> loadUserState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedState = prefs.getString(_userStateKey);

      if (savedState != null) {
        return _decodeState(savedState);
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