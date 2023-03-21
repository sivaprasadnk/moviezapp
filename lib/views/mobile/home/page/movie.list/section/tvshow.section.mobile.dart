import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/all.movies/all.tv.shows.screen.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/tv.show.list.mobile.dart';

class TvShowSectionMobile extends StatelessWidget {
  const TvShowSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Airing Today',
          withSeeMore: true,
          seeMoreCallBack: () {
            context.moviesProvider.updateTvShowGenre(
              Genre(id: 0, name: 'All'),
              TvShowType.airingToday,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AllTvShowsScreen(
                  title: 'Now Playing',
                  type: TvShowType.airingToday,
                  genreList: context.moviesProvider.tvGenreList.tvGenres(
                      context.moviesProvider.tvShowsList.airingTodayShows(20)),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const TvShowsListMobile(
          showType: TvShowType.airingToday,
        ),
        const SizedBox(height: 20),
        SectionTitle(
          title: 'Top Rated',
          withSeeMore: true,
          seeMoreCallBack: () {
            context.moviesProvider.updateTvShowGenre(
              Genre(id: 0, name: 'All'),
              TvShowType.topRated,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AllTvShowsScreen(
                  title: 'Top Rated',
                  type: TvShowType.topRated,
                  genreList: context.moviesProvider.tvGenreList.tvGenres(
                      context.moviesProvider.tvShowsList.topRatedShows(20)),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const TvShowsListMobile(
          showType: TvShowType.topRated,
        ),
        const SizedBox(height: 20),
        SectionTitle(
          title: 'Popular',
          withSeeMore: true,
          seeMoreCallBack: () {
            context.moviesProvider.updateTvShowGenre(
              Genre(id: 0, name: 'All'),
              TvShowType.popular,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AllTvShowsScreen(
                  title: 'Popular',
                  type: TvShowType.popular,
                  genreList: context.moviesProvider.tvGenreList.tvGenres(
                      context.moviesProvider.tvShowsList.popularShows(20)),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const TvShowsListMobile(
          showType: TvShowType.popular,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
