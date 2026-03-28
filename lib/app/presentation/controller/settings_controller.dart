// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:paralelo/core/exceptions/index.dart';
// import 'package:paralelo/features/auth/index.dart';
// import 'package:paralelo/features/user/index.dart';

// final class SettingsController extends AutoDisposeAsyncNotifier<SettingsData> {
//   @override
//   Future<SettingsData> build() async {
//     final userId = ref.read(authStateProvider).user!.id;

//     final (user, preference) = await Future.wait([
//       ref
//           .read(userRepositoryProvider)
//           .getOne(id: userId)
//           .then((r) => r.fold((e) => throw QueryException(e), (v) => v)),
//       ref
//           .read(userPreferenceRepositoryProvider)
//           .get(userId: userId)
//           .then((r) => r.fold((e) => throw QueryException(e), (v) => v)),
//     ]).then((r) => (r[0] as User, r[1] as UserPreference));

//     return (user: user, preference: preference);
//   }
// }

// typedef SettingsData = ({User user, UserPreference preference});
