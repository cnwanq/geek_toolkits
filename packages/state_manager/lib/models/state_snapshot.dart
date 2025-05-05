/// 异步状态快照
class StateSnapshot<T> {
  final T? data;
  final dynamic error;
  final bool isLoading;
  final bool hasError;

  StateSnapshot._({
    this.data,
    this.error,
    this.isLoading = false,
    this.hasError = false,
  });

  factory StateSnapshot.waiting() => StateSnapshot._(isLoading: true);
  factory StateSnapshot.loading() => StateSnapshot._(isLoading: true);
  factory StateSnapshot.withData(T data) => StateSnapshot._(data: data);
  factory StateSnapshot.withError(dynamic error) =>
      StateSnapshot._(error: error, hasError: true);
} 