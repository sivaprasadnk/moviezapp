import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/int.extensions.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/social.media.links.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/back.button.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/backdrop.image.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/bg.gradient.container.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/genre.details.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.name.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.rating.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/similar.movies.list.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});
  static const routeName = "/MovieDetails";
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.moviesProvider.updateCarousalIndex(0);
        context.moviesProvider.updateDataStatus(false);
        context.goHome();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Consumer<MoviesProvider>(
              builder: (_, provider, __) {
                var movie = provider.selectedMovie!;
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
                        Positioned.fill(
                          bottom: 40,
                          right: 20,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  showDetailsDialog(movie);
                                },
                                child: const Icon(
                                  Icons.info,
                                  size: 30,
                                ),
                              )),
                        ),
                        GenreDetails(
                          duration: movie.runtime.durationInHrs,
                          genreList: movie.genreList.stringText,
                          releaseDate: movie.releaseDate.split('-').first,
                        ),
                        MovieRatingDetailsMobile(
                          voteAverage: movie.voteAverage,
                          voteCount: movie.voteCount.toString(),
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
                          const SizedBox(height: 20),
                          const SectionTitle(title: 'Story'),
                          const SizedBox(height: 20),
                          Text(movie.overview),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading)
                            const SectionTitle(title: 'Cast'),
                          const SizedBox(height: 20),
                          AnimatedSwitcher(
                            duration: const Duration(
                              seconds: 1,
                            ),
                            child: !provider.actorsListLoading
                                ? const ActorsList(
                                    size: 120,
                                    height: 190,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 40),
                          if (!provider.videosLoading)
                            if (provider.videoList.isNotEmpty)
                              const SectionTitle(title: 'Related Videos'),
                          const SizedBox(height: 20),
                          AnimatedSwitcher(
                            duration: const Duration(
                              seconds: 1,
                            ),
                            child: !provider.videosLoading
                                ? const VideoList()
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading)
                            if (provider.similarMovieList.isNotEmpty)
                              const SectionTitle(title: 'Similar'),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading)
                            const SimilarMovieList(),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading &&
                              !provider.similarMovieListLoading)
                            Consumer<AuthProvider>(
                                builder: (_, authProvider, __) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: CommonButton(
                                    callback: () {
                                      if (!authProvider.isGuestUser) {
                                        context.userProvider
                                            .addMovieToBookmarks(
                                                movie, context);
                                      } else {
                                        context.scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Login to Bookmark !")));
                                      }
                                    },
                                    title: 'Bookmark '),
                              );
                            }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
          backgroundColor: Colors.white,
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
          content: Container(
            width: context.width * 0.2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (movie.releaseDate.isNotEmpty)
                  Text(
                    "Release Date : ${movie.releaseDate.formatedDateString}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                if (movie.releaseDate.isNotEmpty) const SizedBox(height: 25),
                if (movie.language.isNotEmpty)
                  Text(
                    "Language : ${movie.language}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                if (movie.language.isNotEmpty) const SizedBox(height: 25),
                if (movie.homepage.isNotEmpty) const Text('Website :'),
                if (movie.homepage.isNotEmpty) const SizedBox(height: 5),
                if (movie.homepage.isNotEmpty)
                  GestureDetector(
                    onTap: () async {
                      try {
                        if (await canLaunchUrl(Uri.parse(movie.homepage))) {
                          launchUrl(Uri.parse(movie.homepage));
                        }
                      } catch (err) {
                        context.scaffoldMessenger.showSnackBar(const SnackBar(
                            content: Text('Cannot launch url!')));
                      }
                    },
                    child: Text(
                      movie.homepage,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
                              const Text('Follow on :'),
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
                child: const Text('Close'),
              ),
            )
          ],
        );
      },
    );
  }
}
