import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class SignUpPage extends ConsumerStatefulWidget {
  static const routePath = '/signup';

  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: const Center(child: Text('Sign Up Page')),
    );
  }
}
