import 'package:dio/dio.dart';
import 'package:vigaviga/config/app_config.dart';
import 'package:vigaviga/tools/viga_logger.dart';

class ApiClient {
  late Dio _dio;

  // 基本URL，可以根据你的后端服务进行配置
  static final String _baseUrl = AppConfig.baseUrl;

  ApiClient() {
    _dio = Dio();
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10); // 连接超时时间
    _dio.options.receiveTimeout = const Duration(seconds: 10); // 接收超时时间

    // 添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 可以在这里添加请求头，例如认证token
          // String? token = await _getToken(); // 假设你有一个方法获取token
          // if (token != null) {
          //   options.headers["Authorization"] = "Bearer $token";
          // }
          logger.info("[DIO] 请求发送: ${options.method} ${options.path}");
          logger.info("[DIO] 请求头: ${options.headers}");
          logger.info("[DIO] 请求数据: ${options.data}");
          return handler.next(options); // 继续发送请求
        },
        onResponse: (response, handler) {
          logger.info(
              "[DIO] 响应接收: ${response.statusCode} ${response.requestOptions.path}");
          logger.info("[DIO] 响应数据: ${response.data}");
          return handler.next(response); // 继续处理响应
        },
        onError: (DioException e, handler) {
          logger.info(
              "[DIO] 请求错误: ${e.response?.statusCode} ${e.requestOptions.path}");
          logger.info("[DIO] 错误信息: ${e.message}");
          // 可以在这里处理各种错误，例如：
          // - 401 未授权：跳转到登录页
          // - 网络错误：显示网络不可用提示
          return handler.next(e); // 继续处理错误
        },
      ),
    );
  }

  // 通用的GET请求
  Future<dynamic> get(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: data,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // 通用的POST请求
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // 通用的PUT请求
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // 通用的DELETE请求
  Future<dynamic> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // 错误处理方法
  void _handleError(DioException error) {
    String errorMessage = "未知错误";
    if (error.response != null) {
      // 服务器返回的错误信息
      errorMessage = error.response!.data?["message"] ?? "服务器错误";
      logger.info("API Error (Status: ${error.response!.statusCode}): $errorMessage");
    } else {
      // 网络错误或其他
      if (error.type == DioExceptionType.connectionTimeout) {
        errorMessage = "连接超时，请检查网络";
      } else if (error.type == DioExceptionType.receiveTimeout) {
        errorMessage = "接收数据超时，请稍后再试";
      }
      // 在 Dio v5.x.x 中，"badConnection" 通常会被归为 "unknown" 或其他具体的超时
      // if (error.type == DioExceptionType.badConnection) { // <-- 移除或注释掉这一行
      //   errorMessage = "网络连接错误";
      // }
      else if (error.type == DioExceptionType.cancel) {
        errorMessage = "请求已被取消";
      } else if (error.type == DioExceptionType.sendTimeout) {
        errorMessage = "发送数据超时"; // 补充一个发送超时类型
      } else if (error.type == DioExceptionType.unknown) {
        // 这是处理大多数非服务器响应错误（包括网络连接断开、DNS查找失败等）的地方
        errorMessage = "网络连接错误或未知异常";
      } else {
        errorMessage = "未知错误: ${error.message}"; // 捕获其他未明确处理的错误
      }
      logger.info("Network Error: $errorMessage");
    }
    throw Exception(errorMessage); // 抛出自定义异常，方便上层捕获和处理
  }
}
