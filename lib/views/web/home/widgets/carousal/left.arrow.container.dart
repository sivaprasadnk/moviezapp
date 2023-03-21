import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';

class LeftArrowContainer extends StatelessWidget {
  const LeftArrowContainer({
    super.key,
    required this.controller,
    required this.carousalIndex,
  });

  final CarouselController controller;
  final int carousalIndex;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            controller.animateToPage(carousalIndex - 1);
          },
          child: Container(
            height: context.height * 0.12,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                colors: [
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0.0, 1.0],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_left,
                color: Colors.white,
              ),
            ),
          ),
        ).addMousePointer,
      ),
    );
  }
}
