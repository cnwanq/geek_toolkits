// packages/router_kit/lib/src/router_exceptions.dart
class RouterException implements Exception {
  final String message;
  final dynamic error;

  RouterException(this.message, [this.error]);

  @override
  String toString() => 'RouterException: $message${error != null ? ' ($error)' : ''}';
}