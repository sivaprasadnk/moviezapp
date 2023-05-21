import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/tvshow.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/bookmark.button.dart';
import 'package:moviezapp/views/web/details/large/widgets/backdop.image.dart';
import 'package:moviezapp/views/web/details/large/widgets/bg.gradient.dart';
import 'package:moviezapp/views/web/details/large/widgets/play.trailer.text.button.dart';
import 'package:moviezapp/views/web/details/large/widgets/poster.image.dart';

class TvShowHeaderDetails extends StatefulWidget {
  const TvShowHeaderDetails({super.key, required this.tvShowDetails});

  final TvShowCompleteDetailsModel tvShowDetails;

  @override
  State<TvShowHeaderDetails> createState() => _TvShowHeaderDetailsState();
}

class _TvShowHeaderDetailsState extends State<TvShowHeaderDetails> {
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
    var show = widget.tvShowDetails.tvShow;
    return Stack(
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
                BackdropImage(
                  backdropPath: show.backdropPath,
                  id: show.id,
                  isMovie: false,
                ),
                const BgGradient(),
              ],
            ),
          ),
        ),
        PosterImage(
          id: show.id,
          posterPath: show.posterPath,
          isMovie: false,
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
                  show.genreList.displayText,
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
    );
  }
}
