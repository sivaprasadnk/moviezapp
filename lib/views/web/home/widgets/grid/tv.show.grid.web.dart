import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:provider/provider.dart';

class TvShowGridWeb extends StatelessWidget {
  const TvShowGridWeb({
    Key? key,
    this.limit = 0,
    required this.showList,
    this.isSearch = false,
  }) : super(key: key);
  final int limit;
  final List<TvShow> showList;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    double spacing = 15;

    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return !isSearch
            ? provider.tvShowListLoading
                ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.gridCrossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.6,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: context.gridCrossAxisCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: LoadingShimmer(
                          child: AspectRatio(
                            aspectRatio: 0.667,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.gridCrossAxisCount,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.6,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: context.gridCrossAxisCount,
                    itemBuilder: (context, index) {
                      var movie = showList[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: MovieCard(
                          name: movie.name,
                          tvShow: movie,
                          poster: movie.posterPath,
                          vote: movie.voteAverage,
                          id: movie.id,
                          isMovie: false,
                          isWeb: true,
                          imageHeight: 200,
                          imageWidth: 150,
                          withSize: false,
                          releaseDate: '',
                        ),
                      )
                          .animate(
                            effects: [
                              ScaleEffect(duration: 500.ms),
                            ],
                          )
                          .scale(
                            duration: const Duration(milliseconds: 800),
                            delay: Duration(seconds: (index)),
                          )
                          .addMousePointer;
                    },
                  )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridCrossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.6,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: showList.length,
                itemBuilder: (context, index) {
                  var movie = showList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: MovieCard(
                      name: movie.name,
                      tvShow: movie,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                      id: movie.id,
                      isMovie: false,
                      isWeb: true,
                      imageHeight: 200,
                      imageWidth: 150,
                      withSize: false,
                      releaseDate: '',
                    ),
                  )
                      .animate(
                        effects: [
                          ScaleEffect(duration: 500.ms),
                        ],
                      )
                      .scale(
                        duration: const Duration(milliseconds: 800),
                        delay: Duration(seconds: (index)),
                      )
                      .addMousePointer;
                },
              );
      },
    );
  }
}
