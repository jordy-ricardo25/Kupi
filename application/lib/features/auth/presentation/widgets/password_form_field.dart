import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucide_icons/lucide_icons.dart';

import 'package:kupi/core/extensions/state.dart';

final class PasswordFormField extends ConsumerStatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final String? hintText;
  final String? labelText;

  const PasswordFormField({
    super.key,
    this.controller,
    this.validator,
    this.backgroundColor,
    this.hintText,
    this.labelText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PasswordFormFieldState();
  }
}

class _PasswordFormFieldState extends ConsumerState<PasswordFormField> {
  late final TextEditingController controller;
  final focusNode = FocusNode();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // If no controller is provided, dispose of the local controller
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !showPassword,
      controller: widget.controller,
      focusNode: focusNode,

      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            widget.backgroundColor ?? Colors.grey.withValues(alpha: 0.15),

        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: hintStyle(),

        prefixIcon: Icon(
          LucideIcons.lock,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        suffixIcon: InkWell(
          onTap: () {
            safeSetState(() => showPassword = !showPassword);
          },
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          child: Icon(showPassword ? LucideIcons.eye : LucideIcons.eyeOff),
        ),
      ),

      keyboardType: TextInputType.visiblePassword,
    );
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(50.0),
    );
  }

  TextStyle? hintStyle() {
    return Theme.of(
      context,
    ).inputDecorationTheme.hintStyle?.copyWith(fontSize: 14.0);
  }
}
