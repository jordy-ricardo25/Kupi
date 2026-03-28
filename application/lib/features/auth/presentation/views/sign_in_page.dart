import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class SignInPage extends ConsumerStatefulWidget {
  static const routePath = '/signin';

  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: const Center(child: Text('Sign In Page')),
    );
  }
}
