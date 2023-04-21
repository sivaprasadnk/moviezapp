import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/all.movies/all.movies.screen.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/movies.list.mobile.dart';
import 'package:provider/provider.dart';

class MovieSectionMobile extends StatelessWidget {
  const MovieSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return Column(
        children: [
          SectionTitle(
            title: 'Now Playing',
            withSeeMore: provider.moviesList.nowPlayingMovies(6).length > 5,
            seeMoreCallBack: () {
              provider.updateMovieGenre(
                Genre(id: 0, name: 'All'),
                MovieType.nowPlaying,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllMoviesScreen(
                    title: 'Now Playing',
                    type: MovieType.nowPlaying,
                    genreList: provider.movieGenreList
                        .movieGenres(provider.moviesList.nowPlayingMovies(20)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const MoviesListMobile(
            movieType: MovieType.nowPlaying,
          ),
          const SizedBox(height: 20),
          SectionTitle(
            title: 'Upcoming',
            withSeeMore: provider.moviesList.upcomingMovies(6).length > 5,
            seeMoreCallBack: () {
              provider.updateMovieGenre(
                Genre(id: 0, name: 'All'),
                MovieType.upcoming,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllMoviesScreen(
                    title: 'Upcoming',
                    type: MovieType.upcoming,
                    genreList: provider.movieGenreList
                        .movieGenres(provider.moviesList.upcomingMovies(20)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const MoviesListMobile(
            movieType: MovieType.upcoming,
          ),
          const SizedBox(height: 20),
          SectionTitle(
            title: 'Popular Movies',
            withSeeMore: provider.moviesList.popularMovies(6).length > 5,
            seeMoreCallBack: () {
              provider.updateMovieGenre(
                Genre(id: 0, name: 'All'),
                MovieType.topRated,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllMoviesScreen(
                    title: 'Popular Movies',
                    type: MovieType.topRated,
                    genreList: provider.movieGenreList
                        .movieGenres(provider.moviesList.popularMovies(20)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const MoviesListMobile(
            movieType: MovieType.topRated,
          ),
        ],
      );
    });
  }
}
