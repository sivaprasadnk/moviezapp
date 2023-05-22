import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';

class BackdropImageMobile extends StatelessWidget {
  const BackdropImageMobile({
    super.key,
    required this.imageUrl,
    this.isMovie = true,
    required this.id,
  });

  final String imageUrl;
  final bool isMovie;
  final int id;

  @override
  Widget build(BuildContext context) {
    var cacheKey = isMovie ? "movie_" : "show_";
    cacheKey += "backdrop_$id";
    return SizedBox(
      width: double.infinity,
      child: CustomCacheImage(
        imageUrl: imageUrl,
        height: context.height * 0.4,
        width: double.infinity,
        cacheKey: cacheKey,
        borderRadius: 0,
      ),
    );
  }
}
