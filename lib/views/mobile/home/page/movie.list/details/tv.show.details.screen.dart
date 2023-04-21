import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/bookmark.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/back.button.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/backdrop.image.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/bg.gradient.container.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/genre.details.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.name.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/movie.rating.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/widgets/similar.shows.list.dart';
import 'package:provider/provider.dart';

class TvShowDetailsScreen extends StatefulWidget {
  const TvShowDetailsScreen({super.key});
  static const routeName = "/TvShowDetails";
  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  bool _isVisible = false;

  bool isBookmarked = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (context.isGuestUser) {
        _isVisible = true;
        setState(() {});
      } else {
        await context.userProvider
            .checkIfTvShowBookmarked(context.tvShowId)
            .then((value) {
          isBookmarked = value;
          _isVisible = true;
          setState(() {});
        });
      }
    });
    super.initState();
  }

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
          extendBody: true,
          bottomNavigationBar: AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: _isVisible ? Offset.zero : const Offset(0, 2),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _isVisible ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, bottom: 10),
                child: BookMarkButton(
                  width: context.width * 0.8,
                  isBookmarked: isBookmarked,
                  isMovie: false,
                  tvShow: context.moviesProvider.selectedShow,
                ),
              ),
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
              child: Consumer<MoviesProvider>(
                builder: (_, provider, __) {
                  var show = provider.selectedShow!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          BackdropImageMobile(
                            id: show.id,
                            isMovie: false,
                            imageUrl: show.backdropPath,
                          ),
                          const BgBradientContainerMobile(),
                          MovieName(name: show.name),
                          GenreDetails(
                            releaseDate: show.releaseDate.formatedDateString,
                            genreList: show.genreList.stringText,
                            duration: '',
                          ),
                          MovieRatingDetailsMobile(
                            voteAverage: show.voteAverage,
                            voteCount: show.voteCount.toString(),
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
                            Text(show.overview),
                            const SizedBox(height: 20),
                            if (!provider.actorsListLoading)
                              if (provider.actorsList.isNotEmpty)
                                const SectionTitle(title: 'Cast'),
                            const SizedBox(height: 20),
                            AnimatedSwitcher(
                              duration: const Duration(
                                seconds: 1,
                              ),
                              child: !provider.actorsListLoading
                                  ? const ActorsList(
                                      size: 120,
                                      height: 180,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            const SizedBox(height: 20),
                            if (!provider.actorsListLoading)
                              if (provider.similarTvShowList.isNotEmpty)
                                const SectionTitle(title: 'Similar'),
                            const SizedBox(height: 20),
                            if (!provider.actorsListLoading)
                              const SimilarShowsList(),
                            const SizedBox(height: 20),
                            // if (!provider.actorsListLoading &&
                            //     !provider.similarMovieListLoading)
                            //   BookMarkButton(
                            //     width: context.width * 0.9,
                            //     isMovie: false,
                            //     tvShow: show,
                            //     isBookmarked: isBookmarked,
                            //   ),
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
      ),
    );
  }
}
