import 'package:flutter/material.dart';
import 'package:moviezapp/provider/user.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:moviezapp/views/common/page.title.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/empty.bookmark.list.container.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      var moviesList = provider.bookMarkMoviesList;
      var shows = provider.bookMarkShowsList;
      var moviesCount = moviesList.length > 2 ? 2 : moviesList.length;
      var showsCount = shows.length > 2 ? 2 : shows.length;
      return SingleChildScrollView(
        child: Column(
          children: [
            const PageTitle(
              title: 'Favourites',
              showLeadingIcon: false,
            ),
            if (!context.isGuestUser)
              if (!provider.bookmarkListLoading &&
                  !provider.bookmarkShowsListLoading)
                if (moviesList.isEmpty)
                  const Center(
                    child: EmptyBookmarkListContainer(),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        if (!provider.bookmarkListLoading)
                          SectionTitle(
                            title: 'Movies',
                            withSeeMore: moviesList.length > 2,
                            seeMoreCallBack: () {},
                          ),
                        const SizedBox(height: 10),
                        if (!provider.bookmarkListLoading)
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: context.gridCrossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.6,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: moviesCount,
                            itemBuilder: (context, index) {
                              var movie = moviesList[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: MovieCard(
                                  isMovie: true,
                                  name: movie.title,
                                  poster: movie.posterPath,
                                  vote: movie.voteAverage,
                                  id: movie.id,
                                  isWeb: false,
                                  withSize: false,
                                  releaseDate: movie.releaseDate,
                                ),
                              );
                            },
                          ),

                        const SizedBox(height: 0),
                        if (!provider.bookmarkShowsListLoading)
                          if (shows.isNotEmpty)
                            const SectionTitle(title: 'Tv Shows'),
                        const SizedBox(height: 20),
                        if (!provider.bookmarkShowsListLoading)
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: context.gridCrossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.6,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: showsCount,
                            itemBuilder: (context, index) {
                              var movie = shows[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: MovieCard(
                                  isMovie: false,
                                  name: movie.name,
                                  poster: movie.posterPath,
                                  vote: movie.voteAverage,
                                  id: movie.id,
                                  isWeb: false,
                                  withSize: false,
                                  releaseDate: movie.releaseDate,
                                ),
                              );
                            },
                          ),

                      ],
                    ),
                  )
              else
                const SizedBox.shrink()
            else
              const Center(
                child: EmptyBookmarkListContainer(),
              )
          ],
        ),
      );
    });
  }
}
