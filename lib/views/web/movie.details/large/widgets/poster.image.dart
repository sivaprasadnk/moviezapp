import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/play.trailer.text.button.dart';

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
      top: 50,
      bottom: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CustomCacheImage(
                  imageUrl: movie.posterPath,
                  width: 242,
                  height: 360,
                  borderRadius: 0,
                  cacheKey: cacheKey1,
                ),
              ),
            ),
            Container(
              height: 45,
              width: 242,
              color: Colors.black,
              child: const PlayTrailerTextButton(
                isMobile: false,
              ),
            )
          ],
        ),
     
        // child: FutureBuilder(
        //   future: _getImageSize(movie.posterPath),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done &&
        //         snapshot.data != null) {
        //       debugPrint('width: ${snapshot.data!.width}');
        //       double aspectRatio = snapshot.data!.width / snapshot.data!.height;
        //       return AspectRatio(
        //         aspectRatio: aspectRatio,
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Flexible(
        //               child: ClipRRect(
        //                 borderRadius: const BorderRadius.only(
        //                   topLeft: Radius.circular(10),
        //                   topRight: Radius.circular(10),
        //                 ),
        //                 child: CustomCacheImageWithoutSize(
        //                   imageUrl: movie.posterPath,
        //                   borderRadius: 0,
        //                   cacheKey: cacheKey1,
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               height: 45,
        //               margin: const EdgeInsets.only(left: 20, right: 20),
        //               width: snapshot.data!.width,
        //               color: Colors.red,
        //             )
        //           ],
        //         ),
        //       );
        //     } else {
        //       return LoadingShimmer(
        //         child: AspectRatio(
        //           aspectRatio: 0.667,
        //           child: Container(
        //             width: 500,
        //             height: 750,
        //             color: Colors.black,
        //           ),
        //         ),
        //       );
        //     }
        // },
        // ),
      ),
    );
  }
}

// Container(
                  //   width: snapshot.data!.width,
                  //   height: 45,
                  //   decoration: const BoxDecoration(
                  //     color: Colors.black,
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(10),
                  //       bottomRight: Radius.circular(10),
                  //     ),
                  //   ),
                  //   child: Center(
                  //     child: Consumer<MoviesProvider>(
                  //       builder: (_, provider, __) {
                  //         var trailerVideo = "";
                  //         if (provider.videoList.isNotEmpty &&
                  //             provider.videoList.trailer.isNotEmpty) {
                  //           trailerVideo = provider.videoList.trailer;
                  //         }
                  //         return trailerVideo.isNotEmpty
                  //             ? GestureDetector(
                  //                 onTap: () {
                  //                   // playVideo(trailerVideo, context);
                  //                 },
                  //                 child: const SizedBox(
                  //                   child: Text(
                  //                     'Play Trailer',
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 18,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ).addMousePointer
                  //             : const SizedBox.shrink();
                  //       },
                  //     ),
                  //   ),
                  // )

