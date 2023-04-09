import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/tv.shows.dart';

class Genre {
  int id;
  String name;
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }
}

extension GenreExt on List<Genre> {
  String get stringText {
    String list = "";
    var count = 0;
    var limit = length > 3 ? 3 : length;
    for (var i in this) {
      if (count < limit) {
        list += i.name;

        if (count != limit - 1) {
          list += ",  ";
        }
        count++;
      }
    }
    list = "$list ";
    return list;
  }

  List<Genre> movieGenres(List<Movie> movieList) {
    var list = <Genre>[];
    var idList = <int>[];

    idList = movieList.uniqueIdList();
    list.add(Genre(id: 0, name: 'All'));
    for (var i in this) {
      for (var id in idList) {
        if (id == i.id) {
          list.add(Genre(id: id, name: i.name));
        }
      }
    }

    return list;
  }

  List<Genre> tvGenres(List<TvShows> movieList) {
    var list = <Genre>[];
    var idList = <int>[];

    idList = movieList.uniqueIdList();
    list.add(Genre(id: 0, name: 'All'));
    for (var i in this) {
      for (var id in idList) {
        if (id == i.id) {
          list.add(Genre(id: id, name: i.name));
        }
      }
    }

    return list;
  }
}

extension GenreExts on Genre {
  List<Movie> getFilteredList(List<Movie> movieList) {
    var list = <Movie>[];

    for (var movie in movieList) {
      if (movie.genreIdList != null &&
          movie.genreIdList!.isNotEmpty &&
          movie.genreIdList!.contains(id)) {
        list.add(movie);
      }
    }

    return list;
  }

  List<TvShows> getFilteredTvShowsList(List<TvShows> movieList) {
    var list = <TvShows>[];

    for (var movie in movieList) {
      if (movie.genreIdList.contains(id)) {
        list.add(movie);
      }
    }

    return list;
  }
}
