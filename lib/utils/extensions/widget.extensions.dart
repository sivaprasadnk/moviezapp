import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget get addMousePointer => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: this,
      );
}
