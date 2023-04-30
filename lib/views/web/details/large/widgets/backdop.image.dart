import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';

class BackdropImage extends StatelessWidget {
  const BackdropImage({
    super.key,
    required this.backdropPath,
    required this.id,
    this.isMovie = true,
  });

  final String backdropPath;
  final int id;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    var cacheKey = 'movie_';
    if (!isMovie) {
      cacheKey = "show_";
    }
    cacheKey += '${id}details';

    return SizedBox(
      width: context.width > 800 ? context.width * 0.6 : double.infinity,
      child: backdropPath.isNotEmpty
          ? CustomCacheImage(
              imageUrl: backdropPath,
              height: context.height * 0.6 + 55,
              width: double.infinity,
              cacheKey: cacheKey,
              borderRadius: 0,
              showLoading: false,
            )
          : SizedBox(
              height: context.height * 0.6 + 55,
              width: double.infinity,
            ),
    );
  }
}
