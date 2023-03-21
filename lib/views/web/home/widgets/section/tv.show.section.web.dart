import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/list/tv.show.list.web.dart';
import 'package:moviezapp/views/web/movie.list/tv.show.list.screen.web.dart';

class TvShowSectionWeb extends StatelessWidget {
  const TvShowSectionWeb({
    super.key,
    required this.isMobileWeb,
  });

  final bool isMobileWeb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.1,
        right: context.width * 0.1,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SectionTitle(
            title: 'Airing Today',
            withSeeMore:
                context.moviesProvider.tvShowsList.airingTodayShows(10).length >
                    context.gridCrossAxisCount,
            seeMoreCallBack: () {
              context.moviesProvider.updateTvShowGenre(
                Genre(id: 0, name: 'All'),
                TvShowType.airingToday,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return TvShowListScreenWeb(
                      isMobileWeb: isMobileWeb,
                      genreList: context.moviesProvider.tvGenreList.tvGenres(
                          context.moviesProvider.tvShowsList
                              .airingTodayShows(20)),
                      title: 'Airing Today',
                      showType: TvShowType.airingToday,
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const TvShowListWeb(
            type: TvShowType.airingToday,
          ),
          const SizedBox(height: 20),
          SectionTitle(
            title: 'Top Rated',
            withSeeMore:
                context.moviesProvider.tvShowsList.topRatedShows(10).length >
                    context.gridCrossAxisCount,
            seeMoreCallBack: () {
              context.moviesProvider.updateTvShowGenre(
                Genre(id: 0, name: 'All'),
                TvShowType.topRated,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return TvShowListScreenWeb(
                      isMobileWeb: isMobileWeb,
                      genreList: context.moviesProvider.tvGenreList.tvGenres(
                          context.moviesProvider.tvShowsList.topRatedShows(20)),
                      title: 'Top Rated',
                      showType: TvShowType.topRated,
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const TvShowListWeb(
            type: TvShowType.topRated,
          ),
          const SizedBox(height: 20),
          SectionTitle(
            title: 'Popular',
            withSeeMore:
                context.moviesProvider.tvShowsList.popularShows(10).length >
                    context.gridCrossAxisCount,
            seeMoreCallBack: () {
              context.moviesProvider.updateTvShowGenre(
                Genre(id: 0, name: 'All'),
                TvShowType.popular,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return TvShowListScreenWeb(
                      isMobileWeb: isMobileWeb,
                      genreList: context.moviesProvider.tvGenreList.tvGenres(
                          context.moviesProvider.tvShowsList.popularShows(20)),
                      title: 'Popular',
                      showType: TvShowType.popular,
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const TvShowListWeb(
            type: TvShowType.popular,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
