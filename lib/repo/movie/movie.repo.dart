import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviezapp/model/actor.details.model.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/credits.model.dart';
import 'package:moviezapp/model/crew.model.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/related.video.model.dart';
import 'package:moviezapp/model/social.media.model.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/repo/movie/api.key.dart';
import 'package:moviezapp/repo/movie/end.points.dart';

class MovieRepo {
  ///
  ///  get genres
  ///
  static Future<List<Genre>> getGenreList(String show) async {
    List<Genre> list = [];
    try {
      String kGenreUrl = "${kBaseUrl}genre/$show/list?api_key=$apiKey";

      // debugPrint(kGenreUrl);

      final response = await http.get(
        Uri.parse(kGenreUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var genreList = item['genres'] as List;
        if (genreList.isNotEmpty) {
          for (var i in genreList) {
            // list.add(MovieGenre(id: id, name: name))
            list.add(Genre.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return list;
  }

  ///
  ///  get movieResults
  ///

  static Future getMovieResultsList(String url, MovieType type) async {
    List<Movie> list = [];
    try {
      // debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            if (i['backdrop_path'] != null &&
                i['poster_path'] != null &&
                i['genre_ids'] != null) {
              list.add(Movie.fromJson(i, type));
            }
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
      return <Movie>[];
    }
    return list;
  }

  /// movies

  static Future getTrendingMovieList(String region, int page) async {
    return await getMovieResultsList(
        "$kTrendingMoviesUrl&region=$region&page=$page", MovieType.trending);
  }

  static Future getPopularMoviesList(String region, int page) async {
    return await getMovieResultsList(
        "$kTopRatedMoviesUrl&region=$region&page=$page", MovieType.topRated);
  }

  static Future getUpcomingMoviesList(String region, int page) async {
    return await getMovieResultsList(
        "$kUpcomingMoviesUrl&region=$region&page=$page", MovieType.upcoming);
  }

  static Future getNowPlayingMoviesList(String region, int page) async {
    return await getMovieResultsList(
        "$kNowPlayingMoviesUrl&region=$region&page=$page",
        MovieType.nowPlaying);
  }

  static Future getSimilarMoviesList(int id) async {
    var url = "${kBaseUrl}movie/$id/similar?api_key=$apiKey";

    return await getMovieResultsList(url, MovieType.similar);
  }

  static Future<MovieDetails?> getMovieDetails(int id) async {
    MovieDetails? movie;
    try {
      var url = "${kBaseUrl}movie/$id?api_key=$apiKey";
      // debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);r
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        movie = MovieDetails.fromJson(item);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return movie;
  }

  ///
  ///  tvshows
  ///

  static Future getTvShowsResultsList(String url, TvShowType type) async {
    List<TvShows> list = [];
    try {
      // debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            if (i['backdrop_path'] != null && i['poster_path'] != null) {
              list.add(TvShows.fromJson(i, type));
            }
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
      return <TvShows>[];
    }
    return list;
  }

  static Future getTrendingTvShowList(String region) async {
    return await getTvShowsResultsList(
        "$kTrendingTvShowsUrl&region=$region", TvShowType.trending);
  }

  static Future getPopularTvShowList(String region) async {
    return await getTvShowsResultsList(
        "$kPopularTvShowsUrl&region=$region", TvShowType.popular);
  }

  static Future getTopRatedTvShowList(String region) async {
    return await getTvShowsResultsList(
        "$kTopRatedTvShowsUrl&region=$region", TvShowType.topRated);
  }

  static Future getAiringTodayTvShowList(String region) async {
    return await getTvShowsResultsList(
        "$kAiringTodayTvShowsUrl&region=$region", TvShowType.airingToday);
  }

  static Future getSimilarTvShowList(int id) async {
    var url = "${kBaseUrl}tv/$id/similar?api_key=$apiKey";

    return await getTvShowsResultsList(url, TvShowType.similar);
  }

  // static Future getOnTvList() async {
  //   List<TvShows> finalList = [];
  //   try {
  //     debugPrint(kPopularTvShowsUrl);

  //     final response = await http.get(
  //       Uri.parse(kPopularTvShowsUrl),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       },
  //     );
  //     // debugPrint(response.body);
  //     if (response.statusCode == 200) {
  //       final item = json.decode(response.body);
  //       var movieList = item['results'] as List;
  //       if (movieList.isNotEmpty) {
  //         for (var i in movieList) {
  //           finalList.add(TvShows.fromJson(i));
  //         }
  //       }
  //     }
  //   } catch (err) {
  //     debugPrint(err.toString());
  //   }
  //   return finalList;
  // }

  static Future<TvShowDetails?> getTvShowDetails(int id) async {
    TvShowDetails? show;
    try {
      var url = "${kBaseUrl}tv/$id?api_key=$apiKey";
      // debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        show = TvShowDetails.fromJson(item);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return show;
  }

  static Future<CreditsModel> getCreditsList(int id, String show) async {
    List<Actor> actorsList = [];
    List<Crew> crewList = [];

    try {
      var url = "$kBaseUrl$show/$id/credits?api_key=$apiKey";
      // debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var castList = item['cast'] as List;
        if (castList.isNotEmpty) {
          for (var i in castList) {
            actorsList.add(Actor.fromJson(i));
          }
        }
        var crewsList = item['crew'] as List;
        if (crewsList.isNotEmpty) {
          for (var i in crewsList) {
            crewList.add(Crew.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return CreditsModel(actors: actorsList, crew: crewList);
  }

  static Future<List<RelatedVideoModel>> getRelatedVideos(
      int movieId, String show) async {
    List<RelatedVideoModel> videoList = [];
    var url = "$kBaseUrl$show/$movieId/videos?api_key=$apiKey";
    // debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      var videos = item['results'] as List;
      if (videos.isNotEmpty) {
        for (var i in videos) {
          videoList.add(RelatedVideoModel.fromJson(i));
        }
      }
    }

    return videoList;
  }

  static Future<SocialMediaModel> getSocialMedia(int id, String show) async {
    SocialMediaModel socialMediaModel;
    var url = "$kBaseUrl$show/$id/external_ids?api_key=$apiKey";
    // debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      final item = json.decode(response.body) as Map<String, dynamic>;
      socialMediaModel = SocialMediaModel.fromJson(item);
      return socialMediaModel;
    }
    return SocialMediaModel(
      fbId: '',
      imdbId: "",
      instaId: "",
      twitterId: "",
      wikipediaId: "",
      isLoading: false,
    );
  }

  static Future getMoviesList(String region, int page) async {
    List<Movie> finalList = [];
    var trendingList = await getTrendingMovieList(region, page);
    var nowPlayingList = await getNowPlayingMoviesList(region, page);
    var popularMoviesList = await getPopularMoviesList(region, page);
    var upcomingList = await getUpcomingMoviesList(region, page);

    for (var movie in trendingList) {
      finalList.add(movie);
    }

    for (var movie in nowPlayingList) {
      finalList.add(movie);
    }

    for (var movie in popularMoviesList) {
      finalList.add(movie);
    }

    for (var movie in upcomingList) {
      finalList.add(movie);
    }

    return finalList;
  }

  static Future getTvShowsList(String region) async {
    List<TvShows> finalList = [];
    var trendingList = await getTrendingTvShowList(region);
    var airingTodayList = await getAiringTodayTvShowList(region);
    var popularList = await getPopularTvShowList(region);
    var topRatedList = await getTopRatedTvShowList(region);

    for (var movie in trendingList) {
      finalList.add(movie);
    }

    for (var movie in airingTodayList) {
      finalList.add(movie);
    }

    for (var movie in popularList) {
      finalList.add(movie);
    }

    for (var movie in topRatedList) {
      finalList.add(movie);
    }

    return finalList;
  }

  static Future searchMovie(String query) async {
    var url = "${kBaseUrl}search/movie?api_key=$apiKey&query=$query";

    return await getMovieResultsList(url, MovieType.search);
  }

  static Future searchTvShow(String query) async {
    var url = "${kBaseUrl}search/tv?api_key=$apiKey&query=$query";

    return await getTvShowsResultsList(url, TvShowType.search);
  }

  static Future<ActorDetailsModel?> getActorDetails(int id) async {
    var url = "${kBaseUrl}person/$id?api_key=$apiKey";
    ActorDetailsModel? actor;
    // debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      final item = json.decode(response.body) as Map<String, dynamic>;
      actor = ActorDetailsModel.fromJson(item);
      return actor;
    }
    return actor;
  }

  static Future<ActorDetailsModel?> getActorFilms(int id) async {
    var url = '${kBaseUrl}person/$id/movie_credits?api_key=$apiKey';

    ActorDetailsModel? actor;
    // debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      final item = json.decode(response.body) as Map<String, dynamic>;
      actor = ActorDetailsModel.fromJson(item);
      return actor;
    }
    return actor;
  }
}
