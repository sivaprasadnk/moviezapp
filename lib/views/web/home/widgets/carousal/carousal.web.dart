import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/web/home/widgets/carousal/movie.carousal.web.dart';
import 'package:moviezapp/views/web/home/widgets/carousal/tv.show.carousal.web.dart';
import 'package:provider/provider.dart';

class CarousalWeb extends StatelessWidget {
  const CarousalWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        var selected = provider.selectedContentType;

        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: selected == Content.movie
              ? const MovieCarousalWeb()
              : const TvShowCarousalWeb(),
        );
      },
    );
  }
}
