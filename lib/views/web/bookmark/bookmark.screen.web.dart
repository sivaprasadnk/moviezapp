import 'package:flutter/material.dart';
import 'package:moviezapp/provider/user.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/empty.bookmark.list.container.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';
import 'package:provider/provider.dart';

class BookmarkScreenWeb extends StatefulWidget {
  const BookmarkScreenWeb({super.key});

  static const routeName = '/bookmarks';

  @override
  State<BookmarkScreenWeb> createState() => _BookmarkScreenWebState();
}

class _BookmarkScreenWebState extends State<BookmarkScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.1,
            right: context.width * 0.1,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SectionTitle(
                title: 'Bookmarks',
                withSeeMore: false,
                withSettings: true,
                settingsCallBack: () {
                  // Dialogs.showSortByDialog(
                  //   context,
                  //   context.moviesProvider.selectedSort,
                  // );
                },
              ),
              const SizedBox(height: 20),
              Consumer<UserProvider>(
                builder: (_, provider, __) {
                  var moviesList = provider.bookMarkMoviesList;
                  // var shows = provider.bookMarkShowsList;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (moviesList.isEmpty)
                        const Center(
                          child: EmptyBookmarkListContainer(),
                        )
                      else
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: context.gridCrossAxisCount,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 1,
                            childAspectRatio: 0.6,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: moviesList.length,
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
                                isWeb: true,
                                withSize: false,
                                releaseDate: movie.releaseDate,
                              ),
                            ).addMousePointer;
                          },
                        )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
