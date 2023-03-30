import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/repo/movie/end.points.dart';

class MovieDetails {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<Genre> genreList;
  double voteAverage;
  int voteCount;
  int runtime;
  String releaseDate;
  String overview;
  String language;
  String homepage;
  MovieDetails({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreList,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.releaseDate,
    required this.overview,
    required this.language,
    required this.homepage,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    var backdropImage = json['backdrop_path'];
    if (backdropImage != null) {
      backdropImage = kOriginalImageBaseUrl + backdropImage;
    } else {
      backdropImage = "";
    }

    var posterImage = json['poster_path'];
    if (posterImage != null) {
      posterImage = kImageBaseUrl + posterImage;
    } else {
      posterImage = "";
    }
    var language = "";
    List languageList = json['spoken_languages'] ?? [];
    if (languageList.isNotEmpty) {
      language = languageList[0]['english_name'] ?? "";
    }
    return MovieDetails(
      id: json['id'],
      backdropPath: backdropImage,
      posterPath: posterImage,
      genreList:
          (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      title: json['title'] ?? "",
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      runtime: json['runtime'] ?? 0,
      releaseDate: json['release_date'] ?? "",
      overview: json['overview'] ?? "",
      language: language,
      homepage: json['homepage'] ?? "",
    );
  }

  factory MovieDetails.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    var language = "";
    List languageList = json['spoken_languages'] ?? [];
    if (languageList.isNotEmpty) {
      language = languageList[0]['english_name'] ?? "";
    }
    return MovieDetails(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreList:
          (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      title: json['title'] ?? "",
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      runtime: json['runtime'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      language: language,
      homepage: json['homepage'],
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    var genreMapList = genreList.map((e) => e.toJson()).toList();
    result.addAll({'genres': genreMapList});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'title': title});
    result.addAll({'vote_average': voteAverage});
    result.addAll({'vote_count': voteCount});
    result.addAll({'runtime': runtime});
    result.addAll({'overview': overview});
    result.addAll({'release_date': releaseDate});
    result.addAll({'homepage': homepage});
    result.addAll({'spoken_language': language});

    return result;
  }
}
