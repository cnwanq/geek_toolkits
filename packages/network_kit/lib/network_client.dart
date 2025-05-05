import 'package:dio/dio.dart';
import 'network_config.dart';
import 'network_response.dart';
import 'network_exception.dart';

class NetworkClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: NetworkConfig.baseUrl,
    connectTimeout: NetworkConfig.connectTimeout,
    receiveTimeout: NetworkConfig.receiveTimeout,
    headers: NetworkConfig.defaultHeaders,
    responseType: ResponseType.json,
  ));

  /// 添加拦截器
  static void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// 通用请求方法
  static Future<NetworkResponse<T>> request<T>(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    T Function(dynamic data)? parser,
    Options? options,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options(method: method, headers: headers)),
        cancelToken: cancelToken,
      );
      return NetworkResponse<T>(
        data: parser != null ? parser(response.data) : response.data,
        statusCode: response.statusCode,
        message: response.statusMessage,
        success: response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300,
      );
    } on DioException catch (e) {
      throw NetworkException(
        e.message ?? 'Network error',
        code: e.response?.statusCode,
      );
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  /// 便捷 GET
  static Future<NetworkResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    T Function(dynamic data)? parser,
    Options? options,
  }) =>
      request<T>(
        path,
        method: 'GET',
        queryParameters: queryParameters,
        headers: headers,
        cancelToken: cancelToken,
        parser: parser,
        options: options,
      );

  /// 便捷 POST
  static Future<NetworkResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    T Function(dynamic data)? parser,
    Options? options,
  }) =>
      request<T>(
        path,
        method: 'POST',
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        cancelToken: cancelToken,
        parser: parser,
        options: options,
      );

  // 你可以继续添加 put、delete、patch 等方法

static Future<NetworkResponse<T>> upload<T>(
  String path, {
  required String filePath,
  String fileField = 'file',
  Map<String, dynamic>? data,
  ProgressCallback? onSendProgress,
  T Function(dynamic data)? parser,
}) async {
  final formData = FormData.fromMap({
    ...?data,
    fileField: await MultipartFile.fromFile(filePath),
  });
  final response = await _dio.post(
    path,
    data: formData,
    onSendProgress: onSendProgress,
  );
  return NetworkResponse<T>(
    data: parser != null ? parser(response.data) : response.data,
    statusCode: response.statusCode,
    message: response.statusMessage,
    success: response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300,
  );
  }
}