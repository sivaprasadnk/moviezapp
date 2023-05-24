import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/carousal.indicator.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/movie.details.screen.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/tv.show.details.screen.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:provider/provider.dart';

class TrendingMovieCarousal extends StatelessWidget {
  const TrendingMovieCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          child: provider.selectedContentType == Content.movie
              ? provider.moviesListLoading
                  ? Center(
                      child: LoadingShimmer(
                        child: Container(
                          color: Colors.black,
                          height: context.height * 0.27,
                          width: double.infinity,
                        ),
                      ),
                    )
                  : Center(
                      child: Stack(
                        children: [
                          FlutterCarousel(
                            items: provider.moviesList
                                .trendingMovies(10)
                                .map((movie) {
                              return GestureDetector(
                                onTap: () {
                                  // Dialogs.showLoader(context: context);
                                  // provider
                                  //     .getMovieDetails(movie.id)
                                  //     .then((value) async {
                                  //   var isbookmarked = false;
                                  //   if (!context.isGuestUser) {
                                  //     isbookmarked = await context.userProvider
                                  //         .checkIfMovieBookmarked(movie.id);
                                  //   }
                                  //   if (context.mounted) {
                                  //     context.pop();

                                  //     Navigator.pushNamed(
                                  //       context,
                                  //       MovieDetailsScreen.routeName,
                                  //       arguments: isbookmarked,
                                  //     );
                                  //   }
                                  // });
                                  provider.updateMovie(movie);
                                  debugPrint('@@ 1');

                                  Navigator.pushNamed(
                                    context,
                                    MovieDetailsScreen.routeName,
                                    arguments: movie.id,
                                  );
                                },
                                child: CarousalMovieItem(
                                  backdropImage: movie.backdropPath,
                                  id: movie.id.toString(),
                                  title: movie.title,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              aspectRatio: 1.777,
                              enableInfiniteScroll: true,
                              showIndicator: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                provider.updateCarousalIndex(index);
                              },
                            ),
                          ),
                          CarousalIndicator(
                            carousalIndex: provider.carousalIndex,
                            movieList: provider.moviesList.trendingMovies(10),
                            isMovie: true,
                          )
                        ],
                      ),
                    )
              : provider.tvShowListLoading
                  ? Center(
                      child: LoadingShimmer(
                        child: Container(
                          color: Colors.black,
                          height: context.height * 0.27,
                          width: double.infinity,
                        ),
                      ),
                    )
                  : Center(
                      child: Stack(
                        children: [
                          FlutterCarousel(
                            items: provider.tvShowsList
                                .trendingShows(10)
                                .map((movie) {
                              return GestureDetector(
                                onTap: () {
                                  Dialogs.showLoader(context: context);

                                  provider
                                      .getTvShowDetails(movie.id)
                                      .then((value) {
                                    context.pop();

                                    Navigator.pushNamed(
                                        context, TvShowDetailsScreen.routeName);
                                  });
                                },
                                child: CarousalMovieItem(
                                  backdropImage: movie.backdropPath,
                                  id: movie.id.toString(),
                                  title: movie.name,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              aspectRatio: 1.777,
                              enableInfiniteScroll: true,
                              showIndicator: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                provider.updateCarousalIndex(index);
                              },
                            ),
                          ),
                          CarousalIndicator(
                            carousalIndex: provider.carousalIndex,
                            showList: provider.tvShowsList.trendingShows(10),
                            isMovie: false,
                          )
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
