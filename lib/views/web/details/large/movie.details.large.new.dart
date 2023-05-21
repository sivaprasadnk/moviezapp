import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/widgets/credit.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/movie.header.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/similar.movie.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/story.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/video.details.dart';
import 'package:moviezapp/views/web/home/widgets/copyright.text.dart';

class MovieDetailsLargeNew extends StatelessWidget {
  const MovieDetailsLargeNew({
    super.key,
    required this.movieDetails,
  });
  final MovieCompleteDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieHeaderDetails(
          movieDetails: movieDetails,
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
                  OverviewDetails(overview: movieDetails.overview),
                  const SizedBox(height: 40),
                  CreditDetails(
                    actorsList: movieDetails.actorsList,
                    crewList: movieDetails.crewList,
                  ),
                  const SizedBox(height: 40),
                  VideoDetails(
                    videosList: movieDetails.videoList,
                  ),
                  const SizedBox(height: 40),
                  SimilarMovieDetails(
                    movies: movieDetails.similarMoviesList,
                  ),
                  const CopyrightText(),
                ],
              ),
            );
          },
          // child: Padding(
          //   padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 15),
          //       OverviewDetails(overview: movieDetails.overview),
          //       const SizedBox(height: 40),
          //       CreditDetails(
          //         actorsList: movieDetails.actorsList,
          //         crewList: movieDetails.crewList,
          //       ),
          //       const SizedBox(height: 40),
          //       VideoDetails(
          //         videosList: movieDetails.videoList,
          //       ),
          //       const SizedBox(height: 40),
          //       SimilarMovieDetails(
          //         movies: movieDetails.similarMoviesList,
          //       ),
          //       const CopyrightText(),
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}
