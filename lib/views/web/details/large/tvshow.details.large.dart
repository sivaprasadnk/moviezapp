import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/bookmark.button.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:moviezapp/views/web/details/large/widgets/play.trailer.text.button.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class TvShowDetailsLarge extends StatefulWidget {
  const TvShowDetailsLarge({
    super.key,
  });


  @override
  State<TvShowDetailsLarge> createState() => _TvShowDetailsLargeState();
}

class _TvShowDetailsLargeState extends State<TvShowDetailsLarge> {
  bool isBookmarked = false;
  bool _isVisible = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (context.isGuestUser) {
        _isVisible = true;
        setState(() {});
      } else {
        await context.userProvider
            .checkIfMovieBookmarked(context.movieId)
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
    var show = context.moviesProvider.selectedShow!;

    var cacheKey = 'movie_${show.id}details';
    var cacheKey1 = 'movie_${show.id}poster';


    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: const Color.fromRGBO(26, 26, 26, 1),
              height: context.height * 0.6,
              width: double.infinity,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    SizedBox(
                      width: context.width > 800
                          ? context.width * 0.6
                          : double.infinity,
                      child: CustomCacheImage(
                        imageUrl: show.backdropPath,
                        height: context.height * 0.6,
                        width: double.infinity,
                        cacheKey: cacheKey,
                        borderRadius: 0,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: context.height * 0.6,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(26, 26, 26, 1),
                            gradient: LinearGradient(
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                              colors: [
                                Color.fromRGBO(26, 26, 26, 1),
                                Colors.transparent,
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1,
              top: 20,
              bottom: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  future: _getImageSize(show.posterPath),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      double aspectRatio =
                          snapshot.data!.width / snapshot.data!.height;
                      return AspectRatio(
                        aspectRatio: aspectRatio,
                        child: CustomCacheImageWithoutSize(
                          imageUrl: show.posterPath,
                          borderRadius: 10,
                          cacheKey: cacheKey1,
                          aspectRatio: aspectRatio,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1 + 335,
              top: 50,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  show.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1 + 335,
              top: 100,
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      show.genreList.stringText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (show.releaseDate.isNotEmpty)
                      Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1 + 335,
              top: 150,
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.red.shade500,
                      size: 40,
                    ),
                    const SizedBox(width: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${((show.voteAverage) * 10).ceilToDouble()}/ 100",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${show.voteCount} votes",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1 + 335,
              top: 200,
              child: const Align(
                alignment: Alignment.topLeft,
                child: PlayTrailerTextButton(
                  isMobile: false,
                ),
              ),
            ),
            if (show.networks.isNotEmpty && show.networkPath.isNotEmpty)
              Positioned.fill(
                left: context.width * 0.1 + 335,
                top: 250,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 100,
                    child: CustomCacheImageWithoutSize(
                      imageUrl: show.networkPath,
                      loadingHeight: 100,
                      cacheKey: 'show_${show.id}network',
                      borderRadius: 8,
                      showPlaceHolder: false,
                    ),
                  ),
                ),
              ),
            Positioned.fill(
              left: context.width * 0.1 + 335,
              bottom: 40,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _isVisible ? 1 : 0,
                  child: BookMarkButton(
                    tvShow: show,
                    isMovie: false,
                    width: context.width * 0.2,
                    isBookmarked: isBookmarked,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
          child: Consumer<MoviesProvider>(builder: (_, provider, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                if (show.overview.isNotEmpty)
                  const SectionTitle(title: 'Story'),
                if (show.overview.isNotEmpty) const SizedBox(height: 20),
                if (show.overview.isNotEmpty) Text(show.overview),
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
                      ? const VideoList(
                          isWeb: true,
                        )
                      : const SizedBox.shrink(),
                ),
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
                      ? const ActorsList()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 40),
                if (!provider.actorsListLoading)
                  if (provider.similarTvShowList.isNotEmpty)
                    const SectionTitle(
                      title: 'Similar',
                    ),
                const SizedBox(height: 20),
                if (!provider.actorsListLoading)
                  if (provider.similarTvShowList.isNotEmpty)
                    MovieGrid(
                      isLoading: provider.similarTvShowsLoading,
                      tvShowsList: provider.similarTvShowList,
                      isWeb: true,
                      isMovie: false,
                      limit: context.gridCrossAxisCount,
                    ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Future<Size> _getImageSize(String imageUrl) {
    Completer<Size> completer = Completer();
    NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(
              Size(info.image.width.toDouble(), info.image.height.toDouble()));
        },
      ),
    );
    return completer.future;
  }
}
