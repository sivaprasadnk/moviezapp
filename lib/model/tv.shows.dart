import 'package:moviezapp/repo/movie/end.points.dart';

enum TvShowType { trending, popular, airingToday, similar, topRated, search }

class TvShow {
  String name;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdList;
  double voteAverage;
  TvShowType tvShowType;
  TvShow({
    required this.name,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdList,
    required this.voteAverage,
    required this.tvShowType,
  });

  factory TvShow.fromJson(Map<String, dynamic> json, TvShowType type) {
    var vote = json['vote_average'];
    if (vote.runtimeType == int) {
      vote = (vote as int).toDouble();
    }
    return TvShow(
      id: json['id'],
      backdropPath: kOriginalImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreIdList: (json['genre_ids'] as List).map((e) => e as int).toList(),
      name: json['name'] ?? "",
      voteAverage: vote,
      tvShowType: type,
      // voteAverage: json['vote_average'],
    );
  }
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'name': name});
    result.addAll({'vote_average': voteAverage});
    result.addAll({'tvshow_type': tvShowType});

    return result;
  }
}

extension TvShowExtension on List<TvShow> {
  List<TvShow> homeScreenList(int limit) {
    List<TvShow> list = [];
    for (var show in this) {
      if (list.length < limit) {
        list.add(show);
      }
    }
    return list;
  }

  List<int> uniqueIdList() {
    List<int> idList = [];
    for (var i in this) {
      for (var id in i.genreIdList) {
        idList.add(id);
      }
    }
    return idList.toSet().toList();
  }

  List<TvShow> trendingShows([int limit = 0]) {
    List<TvShow> list = [];
    for (var show in this) {
      if (show.tvShowType == TvShowType.trending) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(show);
          }
        } else {
          list.add(show);
        }
      }
    }
    return list;
  }

  List<TvShow> airingTodayShows([int limit = 0]) {
    List<TvShow> list = [];
    for (var show in this) {
      if (show.tvShowType == TvShowType.airingToday) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(show);
          }
        } else {
          list.add(show);
        }
      }
    }
    return list;
  }

  List<TvShow> popularShows([int limit = 0]) {
    List<TvShow> list = [];
    for (var show in this) {
      if (show.tvShowType == TvShowType.popular) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(show);
          }
        } else {
          list.add(show);
        }
      }
    }
    return list;
  }

  List<TvShow> topRatedShows([int limit = 0]) {
    List<TvShow> list = [];
    for (var show in this) {
      if (show.tvShowType == TvShowType.topRated) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(show);
          }
        } else {
          list.add(show);
        }
      }
    }
    return list;
  }
}
