
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/widgets/similar.show.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/story.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/streaming.network.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/tvshow.header.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/video.details.dart';
import 'package:moviezapp/views/web/home/widgets/copyright.text.dart';

class TvShowDetailsLarge extends StatelessWidget {
  const TvShowDetailsLarge({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
    var show = context.moviesProvider.selectedShow!;

    return Column(
      children: [
        const TvShowHeaderDetails(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              StreamingNetworkDetails(
                id: show.id,
                networkPath: show.networkPath,
                networks: show.networks,
              ),
              const SizedBox(height: 40),
              OverviewDetails(
                overview: show.overview,
              ),
              const SizedBox(height: 40),
              // const CreditDetails(),
              const SizedBox(height: 40),
              const VideoDetails(
                videosList: [],
              ),
              const SizedBox(height: 20),
              const SimilarShowDetails(),
              const CopyrightText(),

            ],
          ),
        ),
      ],
    );
  }

  // Future<Size> _getImageSize(String imageUrl) {
  //   Completer<Size> completer = Completer();
  //   NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
  //     ImageStreamListener(
  //       (ImageInfo info, bool _) {
  //         completer.complete(
  //             Size(info.image.width.toDouble(), info.image.height.toDouble()));
  //       },
  //     ),
  //   );
  //   return completer.future;
  // }
}
