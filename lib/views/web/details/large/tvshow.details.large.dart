import 'package:flutter/material.dart';
import 'package:moviezapp/model/tvshow.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/widgets/credit.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/similar.show.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/story.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/streaming.network.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/tvshow.header.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/video.details.dart';
import 'package:moviezapp/views/web/home/widgets/copyright.text.dart';

class TvShowDetailsLarge extends StatelessWidget {
  const TvShowDetailsLarge({
    super.key,
    required this.tvShowDetails,
  });

  final TvShowCompleteDetailsModel tvShowDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TvShowHeaderDetails(
          tvShowDetails: tvShowDetails,
        ),
        FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  StreamingNetworkDetails(
                    id: tvShowDetails.tvShow.id,
                    networkPath: tvShowDetails.tvShow.networkPath,
                    networks: tvShowDetails.tvShow.networks,
                  ),
                  const SizedBox(height: 40),
                  OverviewDetails(
                    overview: tvShowDetails.overview,
                  ),
                  const SizedBox(height: 40),
                  CreditDetails(
                    actorsList: tvShowDetails.actorsList,
                    crewList: tvShowDetails.crewList,
                  ),
                  const SizedBox(height: 40),
                  const VideoDetails(
                    videosList: [],
                  ),
                  const SizedBox(height: 20),
                  const SimilarShowDetails(),
                  const CopyrightText(),
                ],
              ),
            );
          },
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
