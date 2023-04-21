import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';

class MoviePosterImage extends StatelessWidget {
  const MoviePosterImage({super.key, required this.movie});

  final MovieDetails movie;

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
    var cacheKey1 = 'movie_${movie.id}poster';
    return Positioned.fill(
      left: context.width * 0.1,
      top: 20,
      bottom: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: AspectRatio(
          aspectRatio: 0.667,
          child: CustomCacheImageWithoutSize(
            imageUrl: movie.posterPath,
            borderRadius: 10,
            cacheKey: cacheKey1,
            aspectRatio: 0.667,
          ),
        ),
      ),

      // return Positioned.fill(
      //   left: context.width * 0.1,
      //   child: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Stack(
      //       children: [
      //         CustomCacheImage(
      //           imageUrl: movie.posterPath,
      //           width: 242,
      //           height: 360,
      //           borderRadius: 10,
      //           cacheKey: cacheKey1,
      //         ),
      //         const Positioned.fill(
      //           child: Align(
      //             alignment: Alignment.bottomCenter,
      //             child: PlayTrailerTextButton(
      //               isMobile: false,
      //             ),
      //           ),
      //         )
      //       ],
      //     ),

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
