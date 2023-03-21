import 'package:moviezapp/repo/movie/end.points.dart';

enum MovieType { trending, nowPlaying, topRated, upcoming, similar }

class Movie {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdList;
  double voteAverage;
  MovieType movieType;
  String releaseDate;
  Movie({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdList,
    required this.voteAverage,
    required this.movieType,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json, MovieType type) {
    var vote = json['vote_average'];
    if (vote.runtimeType == int) {
      vote = (vote as int).toDouble();
    }
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

    return Movie(
      id: json['id'],
      backdropPath: backdropImage,
      posterPath: posterImage,
      genreIdList: (json['genre_ids'] as List).map((e) => e as int).toList(),
      title: json['title'] ?? "",
      voteAverage: vote,
      movieType: type,
      releaseDate: json['release_date'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'title': title});
    result.addAll({'vote_average': voteAverage});
    result.addAll({'movie_type': movieType});
    result.addAll({'release_date': releaseDate});

    return result;
  }
}

extension MovieExtension on List<Movie> {
  List<Movie> homeScreenList(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (list.length < limit) {
        list.add(movie);
      }
    }
    return list;
  }

  List<Movie> filteredList(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (list.length < limit) {
        list.add(movie);
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

  List<Movie> trendingMovies([int limit = 0]) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.trending) {
        if (list.length < limit) {
          if (limit != 0) {
            if (list.length < limit) {
              list.add(movie);
            }
          } else {
            list.add(movie);
          }
        }
      }
    }
    return list;
  }

  List<Movie> nowPlayingMovies([int limit = 0]) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.nowPlaying) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(movie);
          }
        } else {
          list.add(movie);
        }
      }
    }
    return list;
  }

  List<Movie> popularMovies([int limit = 0]) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.topRated) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(movie);
          }
        } else {
          list.add(movie);
        }
      }
    }
    return list;
  }

  List<Movie> upcomingMovies([int limit = 0]) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.upcoming) {
        if (limit != 0) {
          if (list.length < limit) {
            list.add(movie);
          }
        } else {
          list.add(movie);
        }
      }
    }
    return list;
  }
}
