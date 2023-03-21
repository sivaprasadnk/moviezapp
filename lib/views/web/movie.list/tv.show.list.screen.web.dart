import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/genre.list.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class TvShowListScreenWeb extends StatelessWidget {
  const TvShowListScreenWeb({
    Key? key,
    this.isMobileWeb = false,
    required this.title,
    required this.genreList,
    required this.showType,
  }) : super(key: key);

  final bool isMobileWeb;
  final String title;
  final List<Genre> genreList;
  final TvShowType showType;

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
                    isMovie: false,
                  );
                },
              ),
              const SizedBox(height: 20),
              GenreOptionsList(
                genreList: genreList,
                isMovie: false,
                tvShowType: showType,
              ),
              const SizedBox(height: 20),
              Consumer<MoviesProvider>(builder: (_, provider, __) {
                return MovieGrid(
                  isLoading: false,
                  tvShowsList: provider.filteredTvShowsList,
                  isWeb: true,
                  isMovie: false,
                  limit: provider.filteredTvShowsList.length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
