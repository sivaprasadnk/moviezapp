import 'package:flutter/material.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/int.extensions.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/play.trailer.text.button.dart';
import 'package:moviezapp/views/common/social.media.links.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsContainer extends StatelessWidget {
  const MovieDetailsContainer({super.key, required this.movie});

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: context.width * 0.1 + 315,
      top: 50,
      bottom: 20,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              movie.title,
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
                  movie.genreList.stringText,
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
                Text(
                  movie.runtime.durationInHrs,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (movie.releaseDate.isNotEmpty)
              Text(
                "Release Date : ${movie.releaseDate.formatedDateString}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            if (movie.releaseDate.isNotEmpty) const SizedBox(height: 20),
            if (movie.language.isNotEmpty)
              Text(
                "Language : ${movie.language}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            if (movie.language.isNotEmpty) const SizedBox(height: 20),
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
                      "${((movie.voteAverage) * 10).ceilToDouble()}/ 100",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${movie.voteCount} votes",
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
            if (movie.homepage.isNotEmpty)
              GestureDetector(
                onTap: () async {
                  try {
                    if (await canLaunchUrl(Uri.parse(movie.homepage))) {
                      launchUrl(Uri.parse(movie.homepage));
                    }
                  } catch (err) {
                    context.scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Cannot launch url!')));
                  }
                },
                child: Text(
                  movie.homepage,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ).addMousePointer,
            if (movie.homepage.isNotEmpty) const SizedBox(height: 20),
            Consumer<MoviesProvider>(
              builder: (_, provider, __) {
                var social = provider.socialMediaModel;
                return social.isLoading
                    ? const SizedBox.shrink()
                    : SocialMediaLinks(model: social);
              },
            ),
          ],
        ),
      ),
    );
  }
}
