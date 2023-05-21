import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/back.button.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/backdrop.image.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/bg.gradient.container.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/loading/loading.actors.list.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.name.dart';

class LoadingMovieDetails extends StatelessWidget {
  const LoadingMovieDetails({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            BackdropImageMobile(
              id: movie.id,
              imageUrl: movie.backdropPath,
            ),
            const BgBradientContainerMobile(),
            MovieName(name: movie.title),
            LoadingShimmer(
                child: Container(
              height: 8,
              width: double.infinity,
              color: Colors.black,
            )),
            const BackButtonMobile(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const SectionTitle(title: 'Story'),
              const SizedBox(height: 20),
              LoadingShimmer(
                child: Container(
                  height: 7,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              LoadingShimmer(
                child: Container(
                  height: 7,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              LoadingShimmer(
                child: Container(
                  height: 7,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Actors'),
              const SizedBox(height: 20),
              const LoadingActorsList(),
              const SectionTitle(title: 'Crew'),
              const SizedBox(height: 20),
              const LoadingActorsList(),
            ],
          ),
        ),
      ],
    );
  }
}
