import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class BackButtonMobile extends StatelessWidget {
  const BackButtonMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 0,
      left: 0,
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            context.moviesProvider.updateCarousalIndex(0);
            context.moviesProvider.updateDataStatus(false);

            context.goHome();
          },
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.only(left: 10),
            color: Colors.black,
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
