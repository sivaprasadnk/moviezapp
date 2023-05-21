import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({
    super.key,
    required this.id,
    this.isMovie = true,
    required this.posterPath,
  });

  final int id;
  final bool isMovie;
  final String posterPath;

  // Future<Size> _getImageSize(String imageUrl) {
  //   Completer<Size> completer = Completer();
  //   NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
  //     ImageStreamListener(
  //       (ImageInfo info, bool _) {
  //         completer.complete(
  //             Size(info.image.width.toDouble(), info.image.height.toDouble()));
  //       },
  //     ),
  //   );
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    var cacheKey = 'movie_';
    if (!isMovie) {
      cacheKey = "show_";
    }
    cacheKey += '${id}poster';

    return Positioned.fill(
      left: context.width * 0.1,
      top: 20,
      bottom: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: AspectRatio(
          aspectRatio: 0.667,
          child: CustomCacheImageWithoutSize(
            imageUrl: posterPath,
            borderRadius: 10,
            cacheKey: cacheKey,
            aspectRatio: 0.667,
          ),
        ),
      ),

    );
  }
}
