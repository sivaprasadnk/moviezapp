import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/widgets/credit.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/movie.header.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/similar.movie.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/story.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/video.details.dart';
import 'package:provider/provider.dart';

class MovieDetailsLarge extends StatelessWidget {
  const MovieDetailsLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MovieHeaderDetails(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Consumer<MoviesProvider>(builder: (_, provider, __) {
                var movie = provider.selectedMovie!;

                return OverviewDetails(
                  overview: movie.overview,
                );
              }),
              const SizedBox(height: 40),
              const CreditDetails(),
              const SizedBox(height: 40),
              const VideoDetails(),
              const SizedBox(height: 40),
              const SimilarMovieDetails(),
            ],
          ),
        ),
      ],
    );
  }
}
