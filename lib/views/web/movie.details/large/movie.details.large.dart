import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:moviezapp/views/web/movie.details/large/widgets/back.dop.image.dart';
import 'package:moviezapp/views/web/movie.details/large/widgets/bg.gradient.dart';
import 'package:moviezapp/views/web/movie.details/large/widgets/details.container.dart';
import 'package:moviezapp/views/web/movie.details/large/widgets/poster.image.dart';
import 'package:provider/provider.dart';

class MovieDetailsLarge extends StatelessWidget {
  const MovieDetailsLarge({
    super.key,
  });

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
                height: context.height * 0.6,
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
              MovieDetailsContainer(movie: movie)
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
                      const SectionTitle(title: 'Cast'),
                  const SizedBox(height: 20),
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
