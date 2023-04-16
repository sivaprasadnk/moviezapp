import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/carousal.indicator.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:moviezapp/views/web/details/movie.details.screen.web.dart';
import 'package:moviezapp/views/web/home/widgets/carousal/left.arrow.container.dart';
import 'package:moviezapp/views/web/home/widgets/carousal/right.arrow.container.dart';
import 'package:provider/provider.dart';

class MovieCarousalWeb extends StatefulWidget {
  const MovieCarousalWeb({super.key});

  @override
  State<MovieCarousalWeb> createState() => _MovieCarousalWebState();
}

class _MovieCarousalWebState extends State<MovieCarousalWeb> {
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return provider.moviesListLoading
          ? Center(
              child: LoadingShimmer(
                child: Container(
                  color: Colors.black,
                  height: context.height * 0.6,
                  width: context.width * 0.5,
                ),
              ),
            )
          : Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: context.height * 0.6,
                    child: FlutterCarousel(
                      items:
                          provider.moviesList.trendingMovies(10).map((movie) {
                        return GestureDetector(
                          onTap: () {
                            Dialogs.showLoader(context: context);
                            provider.clearDetails();

                            provider
                                .getMovieDetails(movie.id)
                                .then((value) async {
                              context.pop();
                              var isbookmarked = false;
                              if (!context.isGuestUser) {
                                isbookmarked = await context.userProvider
                                    .checkIfMovieBookmarked(movie.id);
                              }
                              if (context.mounted) {
                                Navigator.pushNamed(
                                  context,
                                  MovieDetailsScreenWeb.routeName,
                                  arguments: isbookmarked,
                                );
                              }
                            });
                          },
                          child: CarousalMovieItem(
                            isWeb: true,
                            id: movie.id.toString(),
                            backdropImage: movie.backdropPath,
                            title: movie.title,
                          ),
                        ).addMousePointer;
                      }).toList(),
                      options: CarouselOptions(
                        controller: controller,
                        viewportFraction: 1,
                        autoPlay: true,
                        aspectRatio: 1.777,
                        enableInfiniteScroll: true,
                        showIndicator: false,
                        onPageChanged: (index, reason) {
                          provider.updateCarousalIndex(index);
                        },
                      ),
                    ),
                  ),
                  LeftArrowContainer(
                    controller: controller,
                    carousalIndex: provider.carousalIndex,
                  ),
                  RightArrowContainer(
                    controller: controller,
                    carousalIndex: provider.carousalIndex,
                  ),
                  CarousalIndicator(
                    carousalIndex: provider.carousalIndex,
                    movieList: provider.moviesList.trendingMovies(10),
                    isWeb: true,
                    isMovie: true,
                  )
                ],
              ),
            );
    });
  }
}
