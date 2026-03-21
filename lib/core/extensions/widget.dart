import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget dismissKeyboard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: this,
    );
  }

  Widget expand({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  Widget sized({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  Widget centered() {
    return Center(child: this);
  }

  Widget padded(EdgeInsets margin) {
    return Padding(padding: margin, child: this);
  }

  Widget aligned(AlignmentGeometry aligment) {
    return Align(alignment: aligment, child: this);
  }
}
