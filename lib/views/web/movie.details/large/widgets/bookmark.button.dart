import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
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

class BookMarkButton extends StatefulWidget {
  const BookMarkButton({super.key, this.movie, required this.width});

  final MovieDetails? movie;
  final double width;

  @override
  State<BookMarkButton> createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  bool isVisible = false;
  bool isbookmarked = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        isVisible = true;
        if (!context.authProvider.isGuestUser) {
          isbookmarked = await context.userProvider
              .checkIfMovieBookmarked(widget.movie!.id);
          if (mounted) {
            setState(() {});
          }
        } else {
          if (mounted) {
            setState(() {});
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = context.isMobileApp ? 20 : 150;

    return Consumer<AuthProvider>(
      builder: (_, authProvider, __) {
        return Padding(
          padding: const EdgeInsets.only(right: 0),
          child: isVisible
              ? Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: Row(
                    children: [
                      SizedBox(
                        width: widget.width,
                        child: authProvider.isGuestUser
                            ? CommonButton(
                                callback: () {
                                  context.showErrorToast('Login to Bookmark !');
                                },
                                title: 'Bookmark ')
                            : !isbookmarked
                                ? CommonButton(
                                        callback: () {
                                          context.userProvider
                                              .addMovieToBookmarks(
                                                  widget.movie!, context);
                                        },
                                        title: 'Add to Bookmarks ')
                                    .addMousePointer
                                : CommonButton(
                                        callback: () {
                                          context.userProvider
                                              .removeMovieFromBookmarks(
                                                  widget.movie!, context);
                                        },
                                        title: 'Remove from Bookmarks ')
                                    .addMousePointer,
                      ),
                      if (!context.isMobileApp)
                        const SizedBox(width: 15),
                      if (!context.isMobileApp)
                        GestureDetector(
                          onTap: () {
                            showDetailsDialog(widget.movie!, context);
                          },
                          child: const Icon(
                            Icons.info,
                            size: 30,
                            color: Colors.red,
                          ),
                        ).addMousePointer,
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        );
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
