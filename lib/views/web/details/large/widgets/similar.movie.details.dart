import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';

class SimilarMovieDetails extends StatelessWidget {
  const SimilarMovieDetails({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        if (movies.isNotEmpty)
                const SectionTitle(
                  title: 'Similar',
                ),
        const SizedBox(height: 20),
                MovieGrid(
          isLoading: false,
          movieGrid: movies,
                  isWeb: true,
          limit: movies
                      .filteredList(context.gridCrossAxisCount)
                      .length,
                ),
          ],
        );

    // return Consumer<MoviesProvider>(
    //   builder: (_, provider, __) {
    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         if (!provider.actorsListLoading)
    //           if (provider.similarMovieList.isNotEmpty)
    //             const SectionTitle(
    //               title: 'Similar',
    //             ),
    //         const SizedBox(height: 20),
    //         if (!provider.actorsListLoading)
    //           if (provider.similarMovieList.isNotEmpty)
    //             MovieGrid(
    //               isLoading: provider.similarMovieListLoading,
    //               movieGrid: provider.similarMovieList,
    //               isWeb: true,
    //               limit: provider.similarMovieList
    //                   .filteredList(context.gridCrossAxisCount)
    //                   .length,
    //             ),
    //       ],
    //     );
    //   },
    // );
  }
}
