import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:moviezapp/model/actor.details.model.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/credits.model.dart';
import 'package:moviezapp/model/crew.model.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/movie.watch.provider.dart';
import 'package:moviezapp/model/related.video.model.dart';
import 'package:moviezapp/model/social.media.model.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/repo/movie/api.key.dart';
import 'package:moviezapp/repo/movie/end.points.dart';
import 'package:moviezapp/utils/extensions/movie.type.extension.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';

class MovieRepo {
  static FirebaseFunctions functions = FirebaseFunctions.instance;
  static final logger = Logger();

  ///
  ///  get genres
  ///
  static Future<List<Genre>> getGenreList(String show) async {
    List<Genre> list = [];
    try {
      HttpsCallable callable = functions.httpsCallable('getGenreList');
      final response = await callable.call();

      var genreList = response.data['genres'] as List;
      if (genreList.isNotEmpty) {
        for (var i in genreList) {
          Map<String, dynamic> data = i.cast<String, dynamic>();
          list.add(Genre.fromJson(data));
        }
      }
      // logger.i('after calling @1');
    } catch (err) {
      debugPrint(err.toString());
    }
    return list;
  }

  ///
  ///  get movieResults
  ///

  static Future getMovieResultsList(
    MovieType type, {
    String? id,
    String? region,
    String? query,
    String? sortBy,
  }) async {
    List<Movie> list = [];
    try {
      var url =
          "https://us-central1-moviezapp-spverse.cloudfunctions.net/movieResultsWithSort";
      Map<String, dynamic> params1 = {"type": type.typeValue};

      params1['id'] = id ?? "";
      params1['region'] = region ?? "";
      params1['query'] = query ?? "";
      params1['sortBy'] = sortBy ?? "";

      final response1 = await http.post(
        Uri.parse(url),
        body: params1,
      );

      if (response1.statusCode == 200) {
        final item = json.decode(response1.body);
        var movieList = item['data'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            Map<String, dynamic> data = i.cast<String, dynamic>();

            if (i['backdrop_path'] != null &&
                i['poster_path'] != null &&
                i['genre_ids'] != null) {
              list.add(Movie.fromJson(data, type));
            }
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
      return <Movie>[];
    }

    return list.uniqueList(type);
  }

  // static Future getTrendingMovieResultsList(String url, MovieType type) async {
  //   List<Movie> list = [];
  //   try {
  //     // debugPrint(url);
  //     HttpsCallable callable = functions.httpsCallable('trendingMovies');
  //     debugPrint("@@ calling function ");

  //     final item = await callable.call();
  //     // if (response.statusCode == 200) {
  //     // final item = json.decode(response.body);
  //     debugPrint("@@ response from function :$item");
  //     if (item.data != null) {
  //       var movieList = item.data['results'] as List;
  //       if (movieList.isNotEmpty) {
  //         for (var i in movieList) {
  //           if (i['backdrop_path'] != null &&
  //               i['poster_path'] != null &&
  //               i['genre_ids'] != null) {
  //             list.add(Movie.fromJson(i, type));
  //           }
  //         }
  //       }
  //     }
  //   } catch (err) {
  //     debugPrint(err.toString());
  //     return <Movie>[];
  //   }

  //   return list.uniqueList(type);
  // }

  /// movies

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
    List<TvShow> list = [];
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
              list.add(TvShow.fromJson(i, type));
            }
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
      return <TvShow>[];
    }
    list = list.toSet().toList();
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
    try {
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
    } on Exception {
      return videoList;
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
    List<Movie> trendingList =
        await getMovieResultsList(MovieType.trending, region: region);
    List<Movie> nowPlayingList = await getMovieResultsList(MovieType.nowPlaying,
        region: region, sortBy: 'title');
    List<Movie> popularList = await getMovieResultsList(MovieType.topRated,
        region: region, sortBy: 'vote');
    List<Movie> upcomingList = await getMovieResultsList(MovieType.upcoming,
        region: region, sortBy: 'release_date');

    for (Movie movie in trendingList) {
      finalList.add(movie);
    }

    for (Movie movie in nowPlayingList) {
      finalList.add(movie);
    }

    for (Movie movie in popularList) {
      finalList.add(movie);
    }

    for (Movie movie in upcomingList) {
      var releaseDate = movie.releaseDate.toString().getDateTime;
      if (releaseDate.isAfter(DateTime.now())) {
        finalList.add(movie);
      }
    }

    return finalList;
  }

  static Future getTvShowsList(String region) async {
    List<TvShow> finalList = [];
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

  static Future<List<Movie>> getActorFilms(int id) async {
    var url = '${kBaseUrl}person/$id/movie_credits?api_key=$apiKey';

    List<Movie> list = [];
    // debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      var movieList = item['cast'] as List;
      if (movieList.isNotEmpty) {
        for (var i in movieList) {
          if (i['backdrop_path'] != null &&
              i['poster_path'] != null &&
              i['genre_ids'] != null) {
            list.add(Movie.fromJson(i, MovieType.filmography));
          }
        }
      }
      movieList = item['crew'] as List;
      if (movieList.isNotEmpty) {
        for (var i in movieList) {
          if (i['backdrop_path'] != null &&
              i['poster_path'] != null &&
              i['genre_ids'] != null) {
            list.add(Movie.fromJson(i, MovieType.filmography));
          }
        }
      }
    }

    return list.uniqueList(MovieType.filmography);
  }

  static Future<MovieWatchProvider?> getWatchProviders(
      int id, String regionCode) async {
    var provider = MovieWatchProvider(flatRate: [], link: "");
    var url = "${kBaseUrl}movie/$id/watch/providers?api_key=$apiKey";

    final jsonResponse = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (jsonResponse.statusCode == 200) {
      Map item = json.decode(jsonResponse.body);
      if (item['results'] != null && item['results'][regionCode] != null) {
        var response = item['results'][regionCode] as Map<String, dynamic>;
        provider = MovieWatchProvider.fromJson(response);
      } else {
        return null;
      }
    }

    return provider;
  }
}
