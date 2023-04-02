import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/common.button.dart';
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
                var show = provider.selectedShow!;
                // var year = show.releaseDate.split('-').first;
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
                          if (!provider.actorsListLoading &&
                              !provider.similarTvShowsLoading)
                            Consumer<AuthProvider>(
                                builder: (_, authProvider, __) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: CommonButton(
                                    callback: () {
                                      if (!authProvider.isGuestUser) {
                                        context.userProvider
                                            .addTvShowToBookmarks(
                                                show, context);
                                      } else {
                                        context.showSnackbar(
                                            'Login to Bookmark !');
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
}
