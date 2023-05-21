import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/widgets/backdop.image.dart';
import 'package:moviezapp/views/web/details/large/widgets/bg.gradient.dart';
import 'package:moviezapp/views/web/details/large/widgets/poster.image.dart';

class LoadingMovieHeaderDetails extends StatelessWidget {
  const LoadingMovieHeaderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var movie = context.moviesProvider.selectedMovie;

    return Stack(
      children: [
        Container(
          color: const Color.fromRGBO(26, 26, 26, 1),
          height: context.height * 0.6 + 55,
          width: double.infinity,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Stack(
              children: [
                BackdropImage(
                  backdropPath: movie.backdropPath,
                  id: movie.id,
                ),
                const BgGradient(),
              ],
            ),
          ),
        ),
        PosterImage(
          id: movie.id,
          posterPath: movie.posterPath,
        ),
        Positioned.fill(
          left: context.width * 0.1 + 335,
          top: 50,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              movie.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
