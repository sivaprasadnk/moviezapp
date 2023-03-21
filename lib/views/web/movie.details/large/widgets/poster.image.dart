import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';

class MoviePosterImage extends StatelessWidget {
  const MoviePosterImage({super.key, required this.movie});

  final MovieDetails movie;

  Future<Size> _getImageSize(String imageUrl) {
    Completer<Size> completer = Completer();
    NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(
              Size(info.image.width.toDouble(), info.image.height.toDouble()));
        },
      ),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var cacheKey1 = 'movie_${movie.id}poster';

    return Positioned.fill(
      left: context.width * 0.1,
      top: 20,
      bottom: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FutureBuilder(
          future: _getImageSize(movie.posterPath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              double aspectRatio = snapshot.data!.width / snapshot.data!.height;
              return AspectRatio(
                aspectRatio: aspectRatio,
                child: CustomCacheImageWithoutSize(
                  imageUrl: movie.posterPath,
                  borderRadius: 10,
                  cacheKey: cacheKey1,
                ),
              );
            } else {
              return LoadingShimmer(
                child: AspectRatio(
                  aspectRatio: 0.667,
                  child: Container(
                    width: 500,
                    height: 750,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
