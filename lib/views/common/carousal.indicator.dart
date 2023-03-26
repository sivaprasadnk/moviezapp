import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class CarousalIndicator extends StatelessWidget {
  const CarousalIndicator({
    super.key,
    required this.carousalIndex,
    this.movieList = const [],
    this.showList = const [],
    this.isWeb = false,
    required this.isMovie,
  });

  final int carousalIndex;
  final List<Movie> movieList;
  final List<TvShows> showList;
  final bool isWeb;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: isWeb ? 20 : 20,
      bottom: 10,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: isMovie
            ? Row(
                children: movieList.map((movie) {
                  var i = movieList.indexOf(movie);
                  return Container(
                    width: carousalIndex == i ? 15 : 6.0,
                    height: carousalIndex == i ? 7 : 6.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: carousalIndex == i
                          ? context.primaryColor
                          : context.primaryColor.withOpacity(0.4),
                    ),
                  );
                }).toList(),
              )
            : Row(
                children: showList.map((movie) {
                  var i = showList.indexOf(movie);
                  return Container(
                    width: carousalIndex == i ? 15 : 6.0,
                    height: carousalIndex == i ? 7 : 6.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: carousalIndex == i
                          ? context.primaryColor
                          : context.primaryColor.withOpacity(0.4),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
