class Result<T> {
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

// class PaginatedResult<T> {
//   final int currentPage;
//   final int totalPages;
//   final List<T>? data;
//   final String? error;

//   const PaginatedResult._({
//     this.currentPage = 0,
//     this.totalPages = 0,
//     this.data,
//     this.error,
//   });

//   bool get isSuccess => data != null;
//   bool get isFailure => error != null;

//   static PaginatedResult<T> success<T>({
//     required int currentPage,
//     required int totalPages,
//     required List<T> data,
//   }) => PaginatedResult._(
//     currentPage: currentPage,
//     totalPages: totalPages,
//     data: data,
//   );

//   static PaginatedResult<T> failure<T>(String message) =>
//       PaginatedResult._(error: message);

//   R fold<R>(
//     R Function(String error) onFailure,
//     R Function(List<T> data) onSuccess,
//   ) {
//     if (isFailure) return onFailure(error!);
//     // ignore: null_check_on_nullable_type_parameter
//     return onSuccess(data!);
//   }
// }
