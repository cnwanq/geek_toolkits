class NetworkResponse<T> {
  final T? data;
  final int? statusCode;
  final String? message;
  final bool success;

  NetworkResponse({
    this.data,
    this.statusCode,
    this.message,
    this.success = false,
  });
}