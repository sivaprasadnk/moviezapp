import 'package:moviezapp/repo/movie/end.points.dart';

enum MovieType {
  trending,
  nowPlaying,
  topRated,
  upcoming,
  similar,
  search,
  bookmarks,
  filmography,
}

class Movie {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<int>? genreIdList;
  double voteAverage;
  MovieType movieType;
  String releaseDate;
  String? character;
  Movie({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdList,
    required this.voteAverage,
    required this.movieType,
    required this.releaseDate,
    this.character,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

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
    List genreIds = json['genre_ids'] ?? [];
    List<int> genreIdIntList = [];
    if (genreIds.isNotEmpty) {
      genreIdIntList =
          (json['genre_ids'] as List).map((e) => e as int).toList();
    } else {
      genreIdIntList = <int>[];
    }

    return Movie(
      id: json['id'],
      backdropPath: backdropImage,
      posterPath: posterImage,
      genreIdList: genreIdIntList,
      title: json['title'] ?? "",
      voteAverage: vote,
      movieType: type,
      releaseDate: json['release_date'] ?? "",
      character: json['character'] ?? "",
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
  List<Movie> limittedList(int limit) {
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
      if (i.genreIdList != null && i.genreIdList!.isNotEmpty) {
        for (var id in i.genreIdList!) {
          idList.add(id);
        }
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

  List<Movie> filmographyMovies([int limit = 0]) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.filmography) {
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

  List<Movie> uniqueList(MovieType type) {
    final set = <Movie>{};
    final uniqueList = <Movie>[];

    for (var obj in this) {
      if (set.add(obj)) {
        if (obj.movieType == type) {
          uniqueList.add(obj);
        }
      }
    }
    // uniqueList.sort(((a, b) => a.id.compareTo(b.id)));

    return uniqueList;
  }
}
