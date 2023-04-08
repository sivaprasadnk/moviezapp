import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/common/movie.card.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({
    super.key,
    required this.isLoading,
    this.movieGrid = const [],
    this.tvShowsList = const [],
    required this.limit,
    this.isWeb = false,
    this.isMovie = true,
  });

  final bool isLoading;
  final List<Movie> movieGrid;
  final List<TvShows> tvShowsList;
  final bool isWeb;
  final int limit;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    double spacing = isWeb ? 15 : 10;
    double ratio = 0.6;
    return isLoading
        ? GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.gridCrossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: 1,
              childAspectRatio: ratio,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: context.gridCrossAxisCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
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
        : movieGrid.isNotEmpty
            ? GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridCrossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: 1,
                  childAspectRatio: ratio,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: limit,
                itemBuilder: (context, index) {
                  if (isMovie) {
                    var movie = movieGrid[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        // bottom: 10,
                      ),
                      child: MovieCard(
                        isMovie: true,
                        name: movie.title,
                        poster: movie.posterPath,
                        vote: movie.voteAverage,
                        id: movie.id,
                        isWeb: isWeb,
                        withSize: false,
                        
                        releaseDate: movie.releaseDate,
                      ),
                    ).addMousePointer;
                  } else {
                    var show = tvShowsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        bottom: 10,
                      ),
                      child: MovieCard(
                        isMovie: false,
                        name: show.name,
                        poster: show.posterPath,
                        vote: show.voteAverage,
                        id: show.id,
                        isWeb: isWeb,
                        imageHeight: 200,
                        imageWidth: 150,
                        withSize: false,
                        releaseDate: '',
                      ).addMousePointer,
                    );
                  }
                },
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridCrossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: 1,
                  childAspectRatio: ratio,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: limit,
                itemBuilder: (context, index) {
                  if (isMovie) {
                    var movie = movieGrid[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: MovieCard(
                        isMovie: true,
                        name: movie.title,
                        poster: movie.posterPath,
                        vote: movie.voteAverage,
                        id: movie.id,
                        isWeb: isWeb,
                        withSize: false,
                        releaseDate: movie.releaseDate,
                      ),
                    ).addMousePointer;
                  } else {
                    var show = tvShowsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: MovieCard(
                        isMovie: false,
                        name: show.name,
                        poster: show.posterPath,
                        vote: show.voteAverage,
                        id: show.id,
                        isWeb: isWeb,
                        imageHeight: 200,
                        imageWidth: 150,
                        withSize: false,
                        releaseDate: '',
                      ).addMousePointer,
                    );
                  }
                },
              );
  }
}
