import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class SimilarShowDetails extends StatelessWidget {
  const SimilarShowDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!provider.actorsListLoading)
              if (provider.similarTvShowList.isNotEmpty)
                const SectionTitle(
                  title: 'Similar',
                ),
            const SizedBox(height: 20),
            if (!provider.actorsListLoading)
              if (provider.similarTvShowList.isNotEmpty)
                MovieGrid(
                  isLoading: provider.similarTvShowsLoading,
                  tvShowsList: provider.similarTvShowList,
                  isWeb: true,
                  isMovie: false,
                  limit: context.gridCrossAxisCount,
                ),
          ],
        );
      },
    );
  }
}
