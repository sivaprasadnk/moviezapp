import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/crew.model.dart';
import 'package:moviezapp/model/related.video.model.dart';
import 'package:moviezapp/model/tv.show.details.dart';

class TvShowCompleteDetailsModel {
  TvShowDetails tvShow;
  List<Actor> actorsList;
  List<Crew> crewList;
  String overview;
  List<RelatedVideoModel> videoList;
  List<TvShowDetails> similarTvShowsList;
  bool isFavourite;
  TvShowCompleteDetailsModel({
    required this.tvShow,
    required this.actorsList,
    required this.crewList,
    required this.overview,
    required this.videoList,
    required this.similarTvShowsList,
    required this.isFavourite,
  });
}
