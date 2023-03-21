import 'package:flutter/material.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:provider/provider.dart';

class TvShowList extends StatelessWidget {
  const TvShowList({
    Key? key,
    this.isGrid = false,
    this.limit = 0,
  }) : super(key: key);
  final bool isGrid;
  final int limit;
  @override
  Widget build(BuildContext context) {
    // final limit = isWeb ? 10 : 5;
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.tvShowListLoading
            ? SizedBox(
                height: 170,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return LoadingShimmer(
                      child: Container(
                        height: 150,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              )
            : SizedBox(
                height: 205,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: provider.tvShowsList.popularShows(5).length,
                  itemBuilder: (context, index) {
                    var movie = provider.tvShowsList.popularShows(5)[index];
                    return MovieCard(
                      name: movie.name,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                      id: movie.id,
                      isMovie: false,
                      withSize: true,
                      imageHeight: 180,
                      imageWidth: 120,
                      releaseDate: '',
                    );
                  },
                ),
              );
      },
    );
  }
}
