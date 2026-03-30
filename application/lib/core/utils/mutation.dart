import 'package:kupi/core/utils/index.dart';

final class Mutation implements Copyable {
  final bool isLoading;
  final bool hasError;
  final String? error;

  const Mutation({this.isLoading = false, this.hasError = false, this.error});

  @override
  Mutation copyWith({bool? isLoading, bool? hasError, String? error}) {
    return Mutation(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error,
    );
  }

  factory Mutation.initial() => const Mutation();
}
