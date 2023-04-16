import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/int.extensions.dart';
import 'package:moviezapp/views/common/section.title.dart';

import '../../../common/custom.cache.image.dart';

class MovieDetailsSmall extends StatelessWidget {
  const MovieDetailsSmall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movie = context.moviesProvider.selectedMovie!;

    var cacheKey1 = 'movie_${movie.id}poster';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            movie.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          CustomCacheImage(
            imageUrl: movie.backdropPath,
            borderRadius: 6,
            height: 250,
            width: double.infinity,
            cacheKey: cacheKey1,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star_rounded,
                color: Colors.red.shade500,
                size: 40,
              ),
              const SizedBox(width: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${movie.voteAverage}/ 10",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${movie.voteCount} votes",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.genreList.stringText,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 5,
                width: 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                movie.runtime.durationInHrs,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const SectionTitle(title: 'Story'),
          const SizedBox(height: 15),
          Text(movie.overview),
        ],
      ),
    );
  }
}
