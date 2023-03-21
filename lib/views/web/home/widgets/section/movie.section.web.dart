import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/list/movie.list.web.dart';
import 'package:moviezapp/views/web/movie.list/movie.list.screen.web.dart';
import 'package:provider/provider.dart';

class MovieSectionWeb extends StatelessWidget {
  const MovieSectionWeb({super.key, required this.isMobileWeb});

  final bool isMobileWeb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.1,
        right: context.width * 0.1,
      ),
      child: Consumer<MoviesProvider>(builder: (_, provider, __) {
        return Column(
          children: [
            const SizedBox(height: 20),
            SectionTitle(
              title: 'Now Playing',
              withSeeMore:
                  context.moviesProvider.moviesList.popularMovies(10).length >
                      context.gridCrossAxisCount,
              seeMoreCallBack: () {
                context.moviesProvider.updateMovieGenre(
                  Genre(id: 0, name: 'All'),
                  MovieType.nowPlaying,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MovieListScreenWeb(
                        isMobileWeb: isMobileWeb,
                        title: 'Now Playing',
                        genreList: context.moviesProvider.movieGenreList
                            .movieGenres(context.moviesProvider.moviesList
                                .nowPlayingMovies(20)),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const MovieListWeb(
              type: MovieType.nowPlaying,
            ),
            const SizedBox(height: 20),
            SectionTitle(
              title: 'Upcoming',
              withSeeMore:
                  context.moviesProvider.moviesList.upcomingMovies(10).length >
                      context.gridCrossAxisCount,
              seeMoreCallBack: () {
                context.moviesProvider.updateMovieGenre(
                  Genre(id: 0, name: 'All'),
                  MovieType.upcoming,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MovieListScreenWeb(
                        isMobileWeb: isMobileWeb,
                        title: 'Upcoming',
                        movieType: MovieType.upcoming,
                        genreList: context.moviesProvider.movieGenreList
                            .movieGenres(context.moviesProvider.moviesList
                                .upcomingMovies(20)),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const MovieListWeb(
              type: MovieType.upcoming,
            ),
            const SizedBox(height: 20),
            SectionTitle(
              title: 'Top Rated',
              withSeeMore:
                  context.moviesProvider.moviesList.popularMovies(10).length >
                      context.gridCrossAxisCount,
              seeMoreCallBack: () {
                context.moviesProvider.updateMovieGenre(
                  Genre(id: 0, name: 'All'),
                  MovieType.topRated,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MovieListScreenWeb(
                        isMobileWeb: isMobileWeb,
                        movieType: MovieType.topRated,
                        title: 'Top Rated Movies',
                        genreList: context.moviesProvider.movieGenreList
                            .movieGenres(context.moviesProvider.moviesList
                                .popularMovies(20)),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const MovieListWeb(
              type: MovieType.topRated,
            ),
          ],
        );
      }),
    );
  }
}
