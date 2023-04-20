import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/social.media.links.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookMarkButton extends StatelessWidget {
  const BookMarkButton({
    super.key,
    this.movie,
    required this.width,
    required this.isBookmarked,
    this.isMovie = true,
    this.tvShow,
  });

  final MovieDetails? movie;
  final TvShowDetails? tvShow;
  final double width;
  final bool isBookmarked;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    double topPadding = context.isMobileApp ? 20 : 150;

    return Consumer<AuthProvider>(
      builder: (_, authProvider, __) {
        return Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: Row(
                children: [
                  SizedBox(
                    width: width,
                    child: authProvider.isGuestUser
                        ? CommonButton(
                            callback: () {
                              context.showErrorToast('Login to Bookmark !');
                            },
                            title: 'Bookmark ')
                        : !isBookmarked
                            ? CommonButton(
                                callback: () {
                                  if (isMovie) {
                                    context.userProvider
                                        .addMovieToBookmarks(movie!, context)
                                        .then((value) async {
                                      context.userProvider
                                          .getBookmarkedMovies(context);
                                    });
                                  } else {
                                    context.userProvider
                                        .addTvShowToBookmarks(tvShow!, context)
                                        .then((value) async {
                                      context.userProvider
                                          .getBookmarkedShows(context);
                                    });
                                  }
                                },
                                title: 'Add to Bookmarks ')
                            : CommonButton(
                                callback: () {
                                  if (isMovie) {
                                    context.userProvider
                                        .removeMovieFromBookmarks(
                                            movie!, context)
                                        .then((value) async {
                                      context.userProvider
                                          .getBookmarkedMovies(context);
                                    });
                                  } else {
                                    context.userProvider
                                        .removeTvShowFromBookmarks(
                                            tvShow!, context)
                                        .then((value) async {
                                      context.userProvider
                                          .getBookmarkedShows(context);
                                    });
                                  }
                                },
                                title: 'Remove from Bookmarks '),
                  ),
                  if (!context.isMobileApp && isMovie)
                    const SizedBox(width: 15),
                  if (!context.isMobileApp && isMovie)
                    GestureDetector(
                      onTap: () {
                        showDetailsDialog(movie!, context);
                      },
                      child: const Icon(
                        Icons.info,
                        size: 30,
                        color: Colors.red,
                      ),
                    ).addMousePointer,
                ],
              ),
            ));
      },
    );
  }

  showDetailsDialog(MovieDetails movie, BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          // backgroundColor: context.bgColor,
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
            color: context.bgColor,
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
              ).addMousePointer,
            )
          ],
        );
      },
    );
  }
}
