import 'package:flutter/material.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:provider/provider.dart';

class TvShowList extends StatelessWidget {
  const TvShowList({
    super.key,
    required this.isLoading,
    required this.showList,
  });

  final bool isLoading;
  final List<TvShows> showList;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return isLoading
            ? const SizedBox(
                height: 75,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 205,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: showList.length,
                  itemBuilder: (context, index) {
                    var movie = showList[index];
                    return Padding(
                      padding: EdgeInsets.only(right: index == 4 ? 20 : 0),
                      child: MovieCard(
                        name: movie.name,
                        poster: movie.posterPath,
                        vote: movie.voteAverage,
                        id: movie.id,
                        isMovie: false,
                        withSize: true,
                        imageHeight: 180,
                        imageWidth: 120,
                        releaseDate: '',
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
