import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class SimilarMovieDetails extends StatelessWidget {
  const SimilarMovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!provider.actorsListLoading)
              if (provider.similarMovieList.isNotEmpty)
                const SectionTitle(
                  title: 'Similar',
                ),
            const SizedBox(height: 20),
            if (!provider.actorsListLoading)
              if (provider.similarMovieList.isNotEmpty)
                MovieGrid(
                  isLoading: provider.similarMovieListLoading,
                  movieGrid: provider.similarMovieList,
                  isWeb: true,
                  limit: provider.similarMovieList
                      .filteredList(context.gridCrossAxisCount)
                      .length,
                ),
          ],
        );
      },
    );
  }
}
