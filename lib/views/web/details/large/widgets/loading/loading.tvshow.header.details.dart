import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/widgets/backdop.image.dart';
import 'package:moviezapp/views/web/details/large/widgets/bg.gradient.dart';
import 'package:moviezapp/views/web/details/large/widgets/poster.image.dart';

class LoadingTvShowHeaderDetails extends StatelessWidget {
  const LoadingTvShowHeaderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var show = context.moviesProvider.selectedTvShow;
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
                  backdropPath: show.backdropPath,
                  id: show.id,
                  isMovie: false,
                ),
                const BgGradient(),
              ],
            ),
          ),
        ),
        PosterImage(
          id: show.id,
          posterPath: show.posterPath,
          isMovie: false,
        ),
        Positioned.fill(
          left: context.width * 0.1 + 335,
          top: 50,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              show.name,
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
