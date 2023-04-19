import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';

class CarousalMovieItem extends StatelessWidget {
  const CarousalMovieItem({
    super.key,
    this.isWeb = false,
    required this.id,
    required this.title,
    required this.backdropImage,
  });

  final bool isWeb;
  final String id;
  final String title;
  final String backdropImage;

  @override
  Widget build(BuildContext context) {
    var cacheKey = "carousal$id$title";
    var height = context.height * 0.12;
    if (context.width < 500) {
      height = context.height * 0.2;
    }
    return Stack(
      children: [
        CustomCacheImageWithoutSize(
          imageUrl: backdropImage,
          cacheKey: cacheKey,
          borderRadius: 0,
          loadingHeight: context.height * 0.6,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
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
        ),
        Positioned.fill(
          bottom: 30,
          left: 20,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
