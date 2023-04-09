import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/social.media.links.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:moviezapp/views/web/home/widgets/grid/movie.grid.dart';
import 'package:moviezapp/views/web/movie.details/large/widgets/play.trailer.text.button.dart';
import 'package:provider/provider.dart';

class TvShowDetailsLarge extends StatelessWidget {
  const TvShowDetailsLarge({super.key, required this.show});

  final TvShowDetails show;

  @override
  Widget build(BuildContext context) {
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
              left: context.width * 0.1 + 350,
              top: 50,
              bottom: 20,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      show.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
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
                    const SizedBox(height: 20),
                    Row(
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
                              "${show.voteAverage}/ 10",
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
                    const SizedBox(height: 20),
                    const PlayTrailerTextButton(
                      isMobile: false,
                    ),
                    const SizedBox(height: 20),
                    Consumer<MoviesProvider>(
                      builder: (_, provider, __) {
                        var social = provider.socialMediaModel;
                        return social.isLoading
                            ? const SizedBox.shrink()
                            : SocialMediaLinks(model: social);
                      },
                    )
                  ],
                ),
              ),
            )
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
