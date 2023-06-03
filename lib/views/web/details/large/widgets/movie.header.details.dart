import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/int.extensions.dart';
import 'package:moviezapp/views/web/details/large/widgets/backdop.image.dart';
import 'package:moviezapp/views/web/details/large/widgets/bg.gradient.dart';
import 'package:moviezapp/views/web/details/large/widgets/poster.image.dart';

class MovieHeaderDetails extends StatefulWidget {
  const MovieHeaderDetails({
    super.key,
    required this.movieDetails,
  });
  final MovieCompleteDetailsModel movieDetails;

  @override
  State<MovieHeaderDetails> createState() => _MovieHeaderDetailsState();
}

class _MovieHeaderDetailsState extends State<MovieHeaderDetails> {
  bool isBookmarked = false;
  bool _isVisible = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (context.isGuestUser) {
        _isVisible = true;
        setState(() {});
      } else {
        await context.userProvider
            .checkIfMovieBookmarked(context.movieId)
            .then((value) {
          isBookmarked = value;
          _isVisible = true;
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromRGBO(26, 26, 26, 1),
          height: context.height * 0.6 + 55,
          width: double.infinity,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Stack(
              children: [
                BackdropImage(
                  backdropPath: widget.movieDetails.movie.backdropPath,
                  id: widget.movieDetails.movie.id,
                ),
                const BgGradient(),
              ],
            ),
          ),
        ),
        PosterImage(
          id: widget.movieDetails.movie.id,
          posterPath: widget.movieDetails.movie.posterPath,
        ),
        Positioned.fill(
          left: context.width * 0.1 + 335,
          top: 50,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.movieDetails.movie.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned.fill(
          left: context.width * 0.1 + 335,
          top: 100,
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.movieDetails.movie.genreList.displayText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.movieDetails.movie.runtime > 0)
                  Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                if (widget.movieDetails.movie.runtime > 0)
                  const SizedBox(width: 8),
                if (widget.movieDetails.movie.runtime > 0)
                  Text(
                    widget.movieDetails.movie.runtime.durationInHrs,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                const SizedBox(width: 8),
                if (widget.movieDetails.movie.releaseDate.isNotEmpty)
                  Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
        Positioned.fill(
          left: context.width * 0.1 + 335,
          top: 150,
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.red.shade500,
                  size: 40,
                ),
                const SizedBox(width: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${((widget.movieDetails.movie.voteAverage) * 10).ceilToDouble()}/ 100",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${widget.movieDetails.movie.voteCount} votes",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        // Positioned.fill(
        //   left: context.width * 0.1 + 335,
        //   top: 200,
        //   child: const Align(
        //     alignment: Alignment.topLeft,
        //     child: PlayTrailerTextButton(
        //       isMobile: false,
        //     ),
        //   ),
        // ),
        Positioned.fill(
          left: context.width * 0.1 + 335,
          bottom: 40,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _isVisible ? 1 : 0,
                child: const SizedBox.shrink()
            ),
          ),
        ),
      ],
    );
    // return Consumer<MoviesProvider>(builder: (_, provider, __) {
    //   var movie = provider.selectedMovie!;

    //   return Stack(
    //     children: [
    //       Container(
    //         color: const Color.fromRGBO(26, 26, 26, 1),
    //         height: context.height * 0.6 + 55,
    //         width: double.infinity,
    //       ),
    //       Positioned.fill(
    //         child: Align(
    //           alignment: Alignment.topRight,
    //           child: Stack(
    //             children: [
    //               BackdropImage(
    //                 backdropPath: movie.backdropPath,
    //                 id: movie.id,
    //               ),
    //               const BgGradient(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       PosterImage(
    //         id: movie.id,
    //         posterPath: movie.posterPath,
    //       ),
    //       Positioned.fill(
    //         left: context.width * 0.1 + 335,
    //         top: 50,
    //         child: Align(
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             movie.title,
    //             style: const TextStyle(
    //               fontWeight: FontWeight.w700,
    //               fontSize: 20,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned.fill(
    //         left: context.width * 0.1 + 335,
    //         top: 100,
    //         child: Align(
    //           alignment: Alignment.topLeft,
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Text(
    //                 movie.genreList.displayText,
    //                 style: const TextStyle(
    //                   fontWeight: FontWeight.w600,
    //                   fontSize: 15,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               const SizedBox(width: 8),
    //               if (movie.runtime > 0)
    //                 Container(
    //                   height: 5,
    //                   width: 5,
    //                   decoration: const BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               if (movie.runtime > 0) const SizedBox(width: 8),
    //               if (movie.runtime > 0)
    //                 Text(
    //                   movie.runtime.durationInHrs,
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 15,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               const SizedBox(width: 8),
    //               if (movie.releaseDate.isNotEmpty)
    //                 Container(
    //                   height: 5,
    //                   width: 5,
    //                   decoration: const BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               const SizedBox(width: 8),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Positioned.fill(
    //         left: context.width * 0.1 + 335,
    //         top: 150,
    //         child: Align(
    //           alignment: Alignment.topLeft,
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Icon(
    //                 Icons.star_rounded,
    //                 color: Colors.red.shade500,
    //                 size: 40,
    //               ),
    //               const SizedBox(width: 5),
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Text(
    //                     "${((movie.voteAverage) * 10).ceilToDouble()}/ 100",
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 20,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   const SizedBox(width: 5),
    //                   Text(
    //                     "${movie.voteCount} votes",
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 14,
    //                       color: Colors.white.withOpacity(0.6),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Positioned.fill(
    //         left: context.width * 0.1 + 335,
    //         top: 200,
    //         child: const Align(
    //           alignment: Alignment.topLeft,
    //           child: PlayTrailerTextButton(
    //             isMobile: false,
    //           ),
    //         ),
    //       ),
    //       Positioned.fill(
    //         left: context.width * 0.1 + 335,
    //         bottom: 40,
    //         child: Align(
    //           alignment: Alignment.bottomLeft,
    //           child: AnimatedOpacity(
    //             duration: const Duration(seconds: 1),
    //             opacity: _isVisible ? 1 : 0,
    //             child: BookMarkButton(
    //               movie: movie,
    //               width: context.width * 0.2,
    //               isBookmarked: isBookmarked,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // });
  }
}
