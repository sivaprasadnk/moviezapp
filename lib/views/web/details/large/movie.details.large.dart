import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/int.extensions.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/bookmark.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:moviezapp/views/web/details/large/widgets/back.dop.image.dart';
import 'package:moviezapp/views/web/details/large/widgets/bg.gradient.dart';
import 'package:moviezapp/views/web/details/large/widgets/play.trailer.text.button.dart';
import 'package:moviezapp/views/web/details/large/widgets/poster.image.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class MovieDetailsLarge extends StatelessWidget {
  const MovieDetailsLarge({
    super.key,
    this.isBookmarked = false,
  });

  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      var movie = provider.selectedMovie!;
      return Column(
        children: [
          Stack(
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
                      MovieBackdropImage(movie: movie),
                      const BgGradient(),
                    ],
                  ),
                ),
              ),
              MoviePosterImage(movie: movie),
              Positioned.fill(
                left: context.width * 0.1 + 335,
                top: 50,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    movie.title,
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
                        movie.genreList.stringText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (movie.runtime > 0)
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      if (movie.runtime > 0) const SizedBox(width: 8),
                      if (movie.runtime > 0)
                        Text(
                          movie.runtime.durationInHrs,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (movie.releaseDate.isNotEmpty)
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
                            "${((movie.voteAverage) * 10).ceilToDouble()}/ 100",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${movie.voteCount} votes",
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
              Positioned.fill(
                left: context.width * 0.1 + 335,
                top: 200,
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: PlayTrailerTextButton(
                    isMobile: false,
                  ),
                ),
              ),
              Positioned.fill(
                left: context.width * 0.1 + 335,
                bottom: 40,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: BookMarkButton(
                    movie: movie,
                    width: context.width * 0.2,
                    isBookmarked: isBookmarked,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
            child: Consumer<MoviesProvider>(builder: (_, provider, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  if (movie.overview.isNotEmpty)
                    const SectionTitle(title: 'Story'),
                  if (movie.overview.isNotEmpty) const SizedBox(height: 20),
                  Text(movie.overview),
                  const SizedBox(height: 40),
                  if (!provider.actorsListLoading)
                    if (provider.actorsList.isNotEmpty)
                      Text(
                        'Cast',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: context.primaryColor,
                        ),
                      ),
                  // const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: !provider.actorsListLoading
                        ? const ActorsList()
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 40),
                  if (!provider.videosLoading)
                    if (provider.videoList.isNotEmpty)
                      const SectionTitle(title: 'Related Videos'),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: !provider.videosLoading
                        ? const VideoList(
                            isWeb: true,
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 40),
                  if (!provider.actorsListLoading)
                    if (provider.similarMovieList.isNotEmpty)
                      const SectionTitle(
                        title: 'Similar',
                      ),
                  const SizedBox(height: 20),
                  if (!provider.actorsListLoading)
                    if (provider.similarMovieList.isNotEmpty)
                      MovieGrid(
                        isLoading: provider.similarMovieListLoading,
                        movieGrid: provider.similarMovieList,
                        isWeb: true,
                        limit: context.gridCrossAxisCount,
                      ),
                ],
              );
            }),
          ),
        ],
      );
    });
  }

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
}
