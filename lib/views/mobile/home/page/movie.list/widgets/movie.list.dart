import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:provider/provider.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.isLoading,
    required this.movieList,
    this.isWeb = false,
  });

  final bool isLoading;
  final List<Movie> movieList;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return AnimatedSwitcher(
          duration: const Duration(
            seconds: 1,
          ),
          child: isLoading
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
                  height: 210,
                  width: double.infinity,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      var movie = movieList[index];
                      return Padding(
                        padding: EdgeInsets.only(right: index == 4 ? 20 : 0),
                        child: MovieCard(
                          name: movie.title,
                          movie: movie,
                          poster: movie.posterPath,
                          vote: movie.voteAverage,
                          id: movie.id,
                          isWeb: isWeb,
                          imageHeight: 180,
                          imageWidth: 120,
                          withSize: true,
                          releaseDate: movie.releaseDate,
                        ),
                      ).animate(
                        effects: [
                          ScaleEffect(duration: 500.ms),
                        ],
                      ).scale(
                        duration: const Duration(milliseconds: 800),
                        delay: Duration(seconds: (index)),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
