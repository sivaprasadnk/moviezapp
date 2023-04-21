import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget get addMousePointer => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: this,
      );

  // Widget withHoverIncreaseSize(double scaleFactor) {
  //   bool isHovered = false;
  //   return StatefulBuilder(
  //     builder: (context, setState) {
  //       return MouseRegion(
  //         cursor: SystemMouseCursors.click,
  //         onEnter: (event) {
  //           setState(() {
  //             isHovered = true;
  //           });
  //         },
  //         onExit: (event) {
  //           setState(() {
  //             isHovered = false;
  //           });
  //         },
  //         child: AnimatedContainer(
  //           duration: const Duration(seconds: 1),
  //           curve: Curves.easeInOut,
  //           transformAlignment: Alignment.center,
  //           transform: isHovered
  //               ? Matrix4.diagonal3Values(scaleFactor, scaleFactor, 1.0)
  //               : Matrix4.diagonal3Values(1.0, 1.0, 1.0),
  //           child: this,
  //         ),
  //       );
  //     },
  //   );
  // }
}
