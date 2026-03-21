// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

// import 'package:paralelo/app/index.dart';

// @immutable
// final class EditProfileButton extends ConsumerWidget {
//   const EditProfileButton({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);

//     return FilledButton(
//       onPressed: () async {
//         await ref.read(goRouterProvider).push('/update-account');
//       },

//       style: theme.elevatedButtonTheme.style?.copyWith(
//         padding: WidgetStateProperty.all(
//           const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
//         ),
//         shape: WidgetStateProperty.all(
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
//         ),
//         minimumSize: WidgetStateProperty.all(Size.zero),
//         elevation: WidgetStateProperty.all(1.0),
//       ),

//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         spacing: 4.0,

//         children: [
//           const Icon(TablerIcons.pencil, size: 16.0),
//           Text(
//             'Editar perfil',
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onPrimary,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
