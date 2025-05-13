
class NetworkException implements Exception {
  final String message;
  final int? code;
  NetworkException(this.message, {this.code});
  @override
  String toString() => 'NetworkException($code): $message';
}
