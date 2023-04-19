import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:provider/provider.dart';

class GenreOptionsList extends StatelessWidget {
  const GenreOptionsList({
    super.key,
    required this.genreList,
    this.isMovie = true,
    this.movieType = MovieType.nowPlaying,
    this.tvShowType = TvShowType.airingToday,
  });

  final List<Genre> genreList;
  final bool isMovie;
  final MovieType movieType;
  final TvShowType tvShowType;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        var selectedId = isMovie
            ? provider.selectedMovieGenre.id
            : provider.selectedTvGenre.id;
        return Wrap(
          direction: Axis.horizontal,
          children: genreList.map((genre) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (isMovie) {
                    // provider.updateFilteredMoviesList([]);
                    provider.updateMovieGenre(genre, movieType);
                  } else {
                    provider.updateTvShowGenre(genre, tvShowType);
                  }
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: genre.id == selectedId
                        ? context.primaryColor
                        : Colors.white,
                    border: Border.all(
                      color: context.primaryColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      genre.name,
                      style: TextStyle(
                        color: genre.id != selectedId
                            ? context.primaryColor
                            : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ).addMousePointer,
            );
          }).toList(),
        );
      },
    );
  }
}
