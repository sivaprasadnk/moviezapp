import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/int.extensions.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/bookmark.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/social.media.links.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/back.button.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/backdrop.image.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/bg.gradient.container.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/genre.details.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/loading/loading.movie.details.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.name.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.rating.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/widgets/movie.list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});
  static const routeName = "/MovieDetails";
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isVisible = false;
  bool isLoading = true;
  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 1)).then((value) async {
  //     if (context.isGuestUser) {
  //       _isVisible = true;
  //       setState(() {});
  //     } else {
  //       await context.userProvider
  //           .checkIfMovieBookmarked(context.movieId)
  //           .then((value) {
  //         isBookmarked = value;
  //         _isVisible = true;
  //         setState(() {});
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  MovieCompleteDetailsModel? movieDetails;
  MovieDetails? movie;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var id = ModalRoute.of(context)!.settings.arguments as int;
      await context.moviesProvider
          .getCompleteMovieDetails(id, !context.isMobileApp)
          .then((value) {
        isLoading = false;
        _isVisible = true;
        movieDetails = value;
        movie = movieDetails!.movie;
        debugPrint('value :${movieDetails!.movie.id}');
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('isVisible : $_isVisible');
    return WillPopScope(
      onWillPop: () async {
        context.moviesProvider.updateCarousalIndex(0);
        context.moviesProvider.updateDataStatus(false);
        // context.goHome();
        context.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: _isVisible ? Offset.zero : const Offset(0, 2),
            child: Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 10),
              child: movieDetails != null
                  ? BookMarkButton(
                      width: context.width * 0.8,
                      isBookmarked: movieDetails!.isFavourite,
                      completeDetails: movieDetails,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              setState(() {
                if (direction == ScrollDirection.reverse) {
                  _isVisible = false;
                } else if (direction == ScrollDirection.forward) {
                  _isVisible = true;
                }
              });
              return true;
            },
            child: SingleChildScrollView(
              child: isLoading
                  ? LoadingMovieDetails(
                      movie: context.moviesProvider.selectedMovie,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            BackdropImageMobile(
                              id: movie!.id,
                              imageUrl: movie!.backdropPath,
                            ),
                            const BgBradientContainerMobile(),
                            MovieName(name: movie!.title),
                            Positioned.fill(
                              bottom: 40,
                              right: 20,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    showDetailsDialog(movie!);
                                  },
                                  child: const Icon(
                                    Icons.info,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GenreDetails(
                              duration: movie!.runtime.durationInHrs,
                              genreList: movie!.genreList.displayText,
                              releaseDate: movie!.releaseDate.split('-').first,
                            ),
                            MovieRatingDetailsMobile(
                              voteAverage: movie!.voteAverage,
                              voteCount: movie!.voteCount.toString(),
                            ),
                            const BackButtonMobile(),
                          ],
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (movieDetails!.overview.isNotEmpty)
                                const SizedBox(height: 20),
                              if (movieDetails!.overview.isNotEmpty)
                                const SectionTitle(title: 'Story'),
                              if (movieDetails!.overview.isNotEmpty)
                                const SizedBox(height: 20),
                              if (movieDetails!.overview.isNotEmpty)
                                Text(movieDetails!.overview),
                              const SizedBox(height: 20),
                              const SectionTitle(title: 'Cast'),
                              const SizedBox(height: 20),
                              AnimatedSwitcher(
                                duration: const Duration(
                                  seconds: 1,
                                ),
                                child: ActorsList(
                                  size: 120,
                                  height: 190,
                                  actorsList: movieDetails!.actorsList,
                                ),
                              ),

                              const SizedBox(height: 40),
                              if (movieDetails!.videoList.isNotEmpty)
                                const SectionTitle(title: 'Related Videos'),
                              if (movieDetails!.videoList.isNotEmpty)
                                const SizedBox(height: 20),
                              if (movieDetails!.videoList.isNotEmpty)
                                AnimatedSwitcher(
                                  duration: const Duration(
                                    seconds: 1,
                                  ),
                                  child: VideoList(
                                    videoList: movieDetails!.videoList,
                                  ),
                                ),
                              const SizedBox(height: 20),
                              if (movieDetails!.similarMoviesList.isNotEmpty)
                                const SectionTitle(title: 'Similar'),
                              if (movieDetails!.similarMoviesList.isNotEmpty)
                                const SizedBox(height: 20),
                              if (movieDetails!.similarMoviesList.isNotEmpty)
                                MovieList(
                                  isLoading: false,
                                  movieList: movieDetails!.similarMoviesList,
                                ),
                              const SizedBox(height: 20),
                              // if (!provider.actorsListLoading &&
                              //     !provider.similarMovieListLoading)
                              //   BookMarkButton(
                              //     width: context.width * 0.9,
                              //     movie: movie,
                              //     isBookmarked: isBookmarked,
                              //   ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  showDetailsDialog(MovieDetails movie) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          title: Column(
            children: const [
              SectionTitle(
                title: 'More details',
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
            ],
          ),
          content: SizedBox(
            width: context.width * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (movie.releaseDate.isNotEmpty)
                  Text(
                    "Release Date : ${movie.releaseDate.formatedDateString}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: context.highlightColor.withOpacity(0.6),
                    ),
                  ),
                if (movie.releaseDate.isNotEmpty) const SizedBox(height: 25),
                if (movie.language.isNotEmpty)
                  Text(
                    "Language : ${movie.language}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: context.highlightColor.withOpacity(0.6),
                    ),
                  ),
                if (movie.language.isNotEmpty) const SizedBox(height: 25),
                if (movie.homepage.isNotEmpty)
                  Text(
                    'Website :',
                    style: TextStyle(
                      color: context.highlightColor.withOpacity(0.6),
                    ),
                  ),
                if (movie.homepage.isNotEmpty) const SizedBox(height: 5),
                if (movie.homepage.isNotEmpty)
                  GestureDetector(
                    onTap: () async {
                      try {
                        if (await canLaunchUrl(Uri.parse(movie.homepage))) {
                          launchUrl(Uri.parse(movie.homepage));
                        }
                      } catch (err) {
                        context.showSnackbar('Cannot launch Url !');
                      }
                    },
                    child: Text(
                      movie.homepage,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: context.highlightColor.withOpacity(0.6),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                if (movie.homepage.isNotEmpty) const SizedBox(height: 25),
                Consumer<MoviesProvider>(
                  builder: (_, provider, __) {
                    var social = provider.socialMediaModel;
                    return social.isLoading
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Follow on :',
                                style: TextStyle(
                                  color:
                                      context.highlightColor.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SocialMediaLinks(
                                model: social,
                                isMobile: true,
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: context.highlightColor,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
