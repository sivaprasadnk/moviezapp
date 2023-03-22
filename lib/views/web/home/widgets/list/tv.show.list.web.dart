import 'package:flutter/material.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/home/widgets/grid/tv.show.grid.web.dart';
import 'package:provider/provider.dart';

class TvShowListWeb extends StatelessWidget {
  const TvShowListWeb({
    Key? key,
    this.isSearch = false,
    this.type = TvShowType.airingToday,
  }) : super(key: key);
  final TvShowType type;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        debugPrint(
            '@ searchTvShowList.length : ${provider.searchTvShowList.length}');
        return TvShowGridWeb(
          isSearch: isSearch,
          showList: type == TvShowType.airingToday
              ? provider.tvShowsList.airingTodayShows(10)
              : type == TvShowType.popular
                  ? provider.tvShowsList.popularShows(10)
                  : type == TvShowType.topRated
                      ? provider.tvShowsList.topRatedShows(10)
                      : provider.searchTvShowList,
          limit: type == TvShowType.airingToday
              ? provider.tvShowsList
                  .airingTodayShows(context.gridCrossAxisCount)
                  .length
              : type == TvShowType.popular
                  ? provider.tvShowsList
                      .popularShows(context.gridCrossAxisCount)
                      .length
                  : type == TvShowType.topRated
                      ? provider.tvShowsList
                          .topRatedShows(context.gridCrossAxisCount)
                          .length
                      : provider.searchTvShowList.length,
        );
      },
    );
  }
}
