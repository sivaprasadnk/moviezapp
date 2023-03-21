import 'package:flutter/material.dart';

class BgBradientContainerMobile extends StatelessWidget {
  const BgBradientContainerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 250.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [
                Colors.white,
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
