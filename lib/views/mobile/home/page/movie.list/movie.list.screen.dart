import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/section/movie.section.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/section/tvshow.section.mobile.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/content.selection.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/country.select.container.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/trending.movie.carousal.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50),
            child: Row(
              children: const [
                ContentSelection(),
                Spacer(),
                CountrySelectContainer(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const TrendingMovieCarousal(),
          const SizedBox(height: 20),
          Consumer<MoviesProvider>(builder: (_, provider, __) {
            var selected = provider.selectedContentType;
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  if (selected == Content.movie) const MovieSectionMobile(),
                  if (selected == Content.tvShow) const TvShowSectionMobile(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
