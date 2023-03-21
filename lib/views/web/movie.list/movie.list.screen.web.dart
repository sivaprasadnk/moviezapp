import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/genre.list.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class MovieListScreenWeb extends StatelessWidget {
  const MovieListScreenWeb({
    Key? key,
    this.isMobileWeb = false,
    this.movieType = MovieType.nowPlaying,
    required this.title,
    required this.genreList,
  }) : super(key: key);

  final bool isMobileWeb;
  final MovieType movieType;
  final String title;
  final List<Genre> genreList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.1,
            right: context.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SectionTitle(
                title: title,
                withSeeMore: false,
                withSettings: true,
                settingsCallBack: () {
                  Dialogs.showSortByDialog(
                    context,
                    context.moviesProvider.selectedSort,
                  );
                },
              ),
              const SizedBox(height: 20),
              GenreOptionsList(
                genreList: genreList,
                movieType: movieType,
              ),
              const SizedBox(height: 20),
              Consumer<MoviesProvider>(builder: (_, provider, __) {
                return MovieGrid(
                  isLoading: false,
                  movieGrid: provider.filteredMoviesList,
                  isWeb: true,
                  limit: provider.filteredMoviesList.length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
