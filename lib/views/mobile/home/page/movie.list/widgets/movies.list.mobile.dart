import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/movie.list.dart';
import 'package:provider/provider.dart';

class MoviesListMobile extends StatelessWidget {
  const MoviesListMobile({
    super.key,
    this.isWeb = false,
    required this.movieType,
  });
  final bool isWeb;
  final MovieType movieType;

  @override
  Widget build(BuildContext context) {
    var limit = isWeb ? 10 : 5;

    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return MovieList(
          isLoading: provider.moviesListLoading,
          movieList: movieType == MovieType.topRated
              ? provider.moviesList.popularMovies(limit)
              : movieType == MovieType.upcoming
                  ? provider.moviesList.upcomingMovies(limit)
                  : provider.moviesList.nowPlayingMovies(limit),
        );
      },
    );
  }
}
