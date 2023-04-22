import 'package:flutter/material.dart';
import 'package:moviezapp/provider/user.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:moviezapp/views/common/page.title.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/empty.bookmark.list.container.dart';
import 'package:provider/provider.dart';

class BookmarkListScreen extends StatefulWidget {
  const BookmarkListScreen({super.key});

  static const routeName = "/bookmarksMobile";

  @override
  State<BookmarkListScreen> createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Dialogs.showLoader(context: context);
      await context.userProvider
          .getBookmarkedMovies(context)
          .then((value) async {
        await context.userProvider.getBookmarkedShows(context).then((value) {
          context.pop();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<UserProvider>(builder: (_, provider, __) {
            var moviesList = provider.bookMarkMoviesList;
            var shows = provider.bookMarkShowsList;
            return Column(
              children: [
                const PageTitle(
                  title: 'Bookmark List',
                  showLeadingIcon: true,
                ),
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
                            const SectionTitle(title: 'Movies'),
                          const SizedBox(height: 20),
                          if (!provider.bookmarkListLoading)
                            SizedBox(
                              height: 210,
                              width: double.infinity,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 10);
                                },
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: moviesList.length,
                                itemBuilder: (context, index) {
                                  var movie = moviesList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: index == 4 ? 20 : 0),
                                    child: MovieCard(
                                      name: movie.title,
                                      poster: movie.posterPath,
                                      vote: movie.voteAverage,
                                      id: movie.id,
                                      imageHeight: 180,
                                      imageWidth: 120,
                                      withSize: true,
                                      releaseDate: movie.releaseDate,
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 30),
                          if (!provider.bookmarkShowsListLoading)
                            if (shows.isNotEmpty)
                              const SectionTitle(title: 'Tv Shows'),
                          const SizedBox(height: 20),
                          if (!provider.bookmarkShowsListLoading)
                            SizedBox(
                              height: 210,
                              width: double.infinity,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 10);
                                },
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: shows.length,
                                itemBuilder: (context, index) {
                                  var show = shows[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: index == 4 ? 20 : 0),
                                    child: MovieCard(
                                      name: show.name,
                                      poster: show.posterPath,
                                      vote: show.voteAverage,
                                      id: show.id,
                                      imageHeight: 180,
                                      imageWidth: 120,
                                      withSize: true,
                                      releaseDate: show.releaseDate,
                                    ),
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    )
              ],
            );
          }),
        ),
      ),
    );
  }
}
