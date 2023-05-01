import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class MovieListWeb extends StatelessWidget {
  const MovieListWeb({
    Key? key,
    this.isSearch = false,
    this.type = MovieType.nowPlaying,
  }) : super(key: key);
  final MovieType type;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return MovieGrid(
          isLoading: !isSearch ? provider.moviesListLoading : false,
          movieGrid: type == MovieType.topRated
              ? provider.moviesList.popularMovies(10)
              : type == MovieType.nowPlaying
                  ? provider.moviesList.nowPlayingMovies(10)
                  : type == MovieType.upcoming
                      ? provider.moviesList.upcomingMovies(10)
                      : type == MovieType.filmography
                          ? provider.moviesList.filmographyMovies(100)
                          : provider.searchMoviesList,
          isWeb: true,
          limit: type == MovieType.topRated
              ? provider.moviesList
                  .popularMovies(context.gridCrossAxisCount)
                  .length
              : type == MovieType.nowPlaying
                  ? provider.moviesList
                      .nowPlayingMovies(context.gridCrossAxisCount)
                      .length
                  : type == MovieType.upcoming
                      ? provider.moviesList
                          .upcomingMovies(context.gridCrossAxisCount)
                          .length
                      : type == MovieType.filmography
                          ? provider.moviesList.filmographyMovies(0).length
                          : provider.searchMoviesList.length,
        );
      },
    );
  }
}
