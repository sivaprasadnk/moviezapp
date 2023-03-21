import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/tv.shows.list.dart';
import 'package:provider/provider.dart';

class SimilarShowsList extends StatelessWidget {
  const SimilarShowsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return TvShowList(
          isLoading: provider.similarTvShowsLoading,
          showList: provider.similarTvShowList,
        );
      },
    );
  }
}
