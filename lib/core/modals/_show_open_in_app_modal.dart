// import 'package:flutter/material.dart';
// import 'package:kupi/core/extensions/index.dart';
// import 'package:kupi/core/platform/index.dart';

// import './show_app_modal.dart';

// bool _openInAppModalShown = false;

// Future<void> showOpenInAppModal(BuildContext context) {
//   if (_openInAppModalShown) return Future.value();
//   if (!isMobileWeb) return Future.value();

//   _openInAppModalShown = true;

//   return showAppModal<bool?>(
//     context,

//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,

//       children: [
//         Center(
//           child: Container(
//             width: 72.0,
//             height: 72.0,

//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.0),
//               color: Colors.black.withAlpha(5),
//             ),

//             child: Image.asset(
//               'assets/images/icon-blue.png',
//               width: 48.0,
//               height: 48.0,
//             ).centered(),
//           ),
//         ).padded(const EdgeInsets.only(bottom: 24.0)),
//         Text(
//           'Mejor en la app',
//           textAlign: TextAlign.center,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
//         ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),

//         const SizedBox(height: 12.0),

//         Text(
//           'Disfruta de una experiencia más rápida y completa usando la aplicación móvil.',
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//             color: Theme.of(context).colorScheme.outline,
//           ),
//         ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),

//         const SizedBox(height: 12.0),

//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           spacing: 12.0,

//           children: [
//             FilledButton(
//               onPressed: () async {
//                 await createOpenApp().open();
//               },

//               style: Theme.of(context).filledButtonTheme.style?.copyWith(
//                 elevation: WidgetStateProperty.all(0.0),
//               ),

//               child: const Text('Abrir aplicación'),
//             ).expand(),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context, rootNavigator: true).pop();
//               },

//               style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
//                 elevation: WidgetStateProperty.all(0.0),
//               ),

//               child: const Text('Seguir en la web'),
//             ).expand(),
//           ],
//         ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),
//       ],
//     ),
//   );
// }
