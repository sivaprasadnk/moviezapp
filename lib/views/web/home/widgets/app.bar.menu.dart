import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';

class AppbarMenu extends StatelessWidget {
  const AppbarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.scaffold.openEndDrawer();
      },
      child: const Icon(
        Icons.menu,
      ),
    ).addMousePointer;
  }
}
