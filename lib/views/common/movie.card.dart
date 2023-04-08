import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/rating.progress.container.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/movie.details.screen.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/details/tv.show.details.screen.dart';
import 'package:moviezapp/views/web/movie.details/movie.details.screen.web.dart';
import 'package:moviezapp/views/web/movie.details/tvshow.details.screen.web.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    Key? key,
    required this.poster,
    required this.name,
    required this.vote,
    required this.id,
    required this.withSize,
    required this.releaseDate,
    this.isMovie = true,
    this.isWeb = false,
    this.imageHeight = 155,
    this.imageWidth = 100,
    // required this.voteAverage,
  }) : super(key: key);

  final String poster;
  final String name;
  final String releaseDate;
  final double vote;
  final int id;
  final bool isMovie;
  final bool isWeb;
  final double imageHeight;
  final double imageWidth;
  final bool withSize;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool showRating = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        if (mounted) {
          setState(() {
            showRating = true;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cacheKey = "movie${widget.id}${widget.name}";
    if (!widget.isMovie) {
      cacheKey = "tvshow${widget.id}${widget.name}";
    }

    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return GestureDetector(
        onTap: () {
          Dialogs.showLoader(context: context);
          provider.clearActorsAndSimilarList();
          if (!widget.isWeb) {
            if (widget.isMovie) {
              provider.getMovieDetails(widget.id).then((value) {
                context.pop();
                Navigator.pushNamed(context, MovieDetailsScreen.routeName);
              });
            } else {
              provider.getTvShowDetails(widget.id).then((value) {
                context.pop();
                Navigator.pushNamed(context, TvShowDetailsScreen.routeName);
              });
            }
          } else {
            if (widget.isMovie) {
              debugPrint('id :: ${widget.id}');
              provider.getMovieDetails(widget.id).then((value) {
                Navigator.pushNamed(
                  context,
                  MovieDetailsScreenWeb.routeName,
                );
              });
            } else {
              provider.getTvShowDetails(widget.id).then((value) {
                context.pop();
                Navigator.pushNamed(context, TvShowDetailsScreenWeb.routeName);
              });
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.withSize
                ? Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: CustomCacheImage(
                          borderRadius: 8,
                          height: widget.imageHeight,
                          width: widget.imageWidth,
                          imageUrl: widget.poster,
                          cacheKey: cacheKey,
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: showRating && widget.vote != 0.0
                              ? RatingProgressContainer(
                                  vote: widget.vote,
                                  isWeb: widget.isWeb,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomCacheImageWithoutSize(
                          borderRadius: 8,
                          imageUrl: widget.poster,
                          cacheKey: cacheKey,
                          aspectRatio: 0.667,
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: showRating && widget.vote != 0.0
                                ? RatingProgressContainer(
                                    vote: widget.vote,
                                    isWeb: widget.isWeb,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 5),
            if (showRating)
              if (widget.releaseDate.isNotEmpty)
                Flexible(
                  child: Text(
                    "  ${widget.releaseDate.formatedDateString}",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )
          ],
        ),
      );
    });
  }
}
