import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class BgGradient extends StatelessWidget {
  const BgGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: context.height * 0.6,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(26, 26, 26, 1),
            gradient: LinearGradient(
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
              colors: [
                Color.fromRGBO(26, 26, 26, 1),
                Colors.transparent,
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
