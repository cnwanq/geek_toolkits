import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? code;
  NetworkException(this.message, {this.code});
  @override
  String toString() => 'NetworkException($code): $message';
}

// 在 dio_client.dart 的 catch 里统一封装

// on DioException catch (e) {
//   if (CancelToken.isCancel(e)) {
//     throw NetworkException('Request cancelled', code: -1);
//   }
//   // 其他异常类型判断
//   throw NetworkException(e.message ?? 'Network error', code: e.response?.statusCode);
// }