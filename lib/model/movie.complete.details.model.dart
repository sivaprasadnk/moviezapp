import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/crew.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/movie.watch.provider.dart';
import 'package:moviezapp/model/related.video.model.dart';

class MovieCompleteDetailsModel {
  MovieDetails movie;
  List<Actor> actorsList;
  List<Crew> crewList;
  String overview;
  List<RelatedVideoModel> videoList;
  List<Movie> similarMoviesList;
  bool isFavourite;
  MovieWatchProvider? provider;
  MovieCompleteDetailsModel({
    required this.movie,
    required this.actorsList,
    required this.crewList,
    required this.overview,
    required this.videoList,
    required this.similarMoviesList,
    required this.isFavourite,
    this.provider,
  });
}
