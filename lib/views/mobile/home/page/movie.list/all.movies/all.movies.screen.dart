import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/genre.list.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({
    super.key,
    this.title = 'Popular Movies',
    required this.type,
    required this.genreList,
  });

  final String title;
  final MovieType type;
  final List<Genre> genreList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.bgColor,
          elevation: 0,
          leadingWidth: 50,
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: context.highlightColor,
            ),
          ),
          title: SectionTitle(title: title),
          actions: [
            GestureDetector(
              onTap: () {
                Dialogs.showSortByDialog(
                  context,
                  context.moviesProvider.selectedSort,
                );
              },
              child: Icon(
                Icons.settings,
                color: context.highlightColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GenreOptionsList(
                  genreList: genreList,
                  movieType: type,
                ),
                const SizedBox(height: 20),
                Consumer<MoviesProvider>(
                  builder: (_, provider, __) {
                    if (type != MovieType.search) {
                      return MovieGrid(
                        isLoading: false,
                        movieGrid: provider.filteredMoviesList,
                        isWeb: false,
                        limit: provider.filteredMoviesList.length,
                      );
                    } else {
                      return MovieGrid(
                        isLoading: false,
                        movieGrid: provider.filteredSearchMoviesList,
                        isWeb: false,
                        limit: provider.filteredSearchMoviesList.length,
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
