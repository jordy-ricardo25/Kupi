import 'package:easy_debounce/easy_debounce.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucide_icons/lucide_icons.dart';

import 'package:kupi/core/extensions/state.dart';

import 'package:uuid/uuid.dart';

final class NameFormField extends ConsumerStatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final String? hintText;
  final String? labelText;

  const NameFormField({
    super.key,
    this.controller,
    this.validator,
    this.backgroundColor,
    this.hintText,
    this.labelText,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NameFormFieldState();
  }
}

class _NameFormFieldState extends ConsumerState<NameFormField> {
  late final TextEditingController controller;
  final focusNode = FocusNode();
  final uuid = const Uuid().v4();

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
      controller: controller,
      focusNode: focusNode,

      validator: widget.validator,
      onChanged: (value) {
        EasyDebounce.debounce(uuid, Durations.medium4, () {
          safeSetState(() {});
        });
      },

      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.transparent,

        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: hintStyle(),

        prefixIcon: Icon(
          LucideIcons.user,
          color: Theme.of(context).colorScheme.outline,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  controller.clear();
                  safeSetState(() {});
                },
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                child: const Icon(LucideIcons.x),
              )
            : null,
      ),

      keyboardType: TextInputType.text,
    );
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
      borderRadius: BorderRadius.circular(12.0),
    );
  }

  TextStyle? hintStyle() {
    return Theme.of(
      context,
    ).inputDecorationTheme.hintStyle?.copyWith(fontSize: 14.0);
  }
}
