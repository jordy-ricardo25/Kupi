import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/core/utils/index.dart';

final resetPasswordMutationProvider = StateProvider.autoDispose<Mutation>(
  (_) => Mutation.initial(),
);

final signInMutationProvider = StateProvider.autoDispose<Mutation>(
  (_) => Mutation.initial(),
);

final signUpMutationProvider = StateProvider.autoDispose<Mutation>(
  (_) => Mutation.initial(),
);

final updatePasswordMutationProvider = StateProvider.autoDispose<Mutation>(
  (_) => Mutation.initial(),
);
