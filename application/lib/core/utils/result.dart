final class Result<T> {
  final T? data;
  final String? error;

  const Result._({this.data, this.error});

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  static Result<T> success<T>(T data) => Result._(data: data);

  static Result<T> failure<T>(String message) => Result._(error: message);

  R fold<R>(R Function(String error) onFailure, R Function(T data) onSuccess) {
    if (isFailure) return onFailure(error!);
    // ignore: null_check_on_nullable_type_parameter
    return onSuccess(data as T);
  }
}
