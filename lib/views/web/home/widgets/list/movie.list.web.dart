import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class MovieListWeb extends StatelessWidget {
  const MovieListWeb({
    Key? key,
    this.type = MovieType.nowPlaying,
  }) : super(key: key);
  final MovieType type;
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        // var limit =
        return MovieGrid(
          isLoading: provider.moviesListLoading,
          movieGrid: type == MovieType.topRated
              ? provider.moviesList.popularMovies(10)
              : type == MovieType.nowPlaying
                  ? provider.moviesList.nowPlayingMovies(10)
                  : provider.moviesList.upcomingMovies(10),
          isWeb: true,
          limit: type == MovieType.topRated
              ? provider.moviesList
                  .popularMovies(context.gridCrossAxisCount)
                  .length
              : type == MovieType.nowPlaying
                  ? provider.moviesList
                      .nowPlayingMovies(context.gridCrossAxisCount)
                      .length
                  : provider.moviesList
                      .upcomingMovies(context.gridCrossAxisCount)
                      .length,
        );
      },
    );
  }
}
