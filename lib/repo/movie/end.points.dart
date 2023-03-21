import 'package:moviezapp/repo/movie/api.key.dart';

String kBaseUrl = "https://api.themoviedb.org/3/";
String kImageBaseUrl = "https://image.tmdb.org/t/p/w500/";
String kOriginalImageBaseUrl = "https://image.tmdb.org/t/p/original";

String kTrendingMoviesUrl = "${kBaseUrl}trending/movie/week?api_key=$apiKey";

String kNowPlayingMoviesUrl = "${kBaseUrl}movie/now_playing?api_key=$apiKey";

String kTopRatedMoviesUrl = "${kBaseUrl}movie/top_rated?api_key=$apiKey";
String kUpcomingMoviesUrl = "${kBaseUrl}movie/upcoming?api_key=$apiKey";

String kTrendingTvShowsUrl = "${kBaseUrl}trending/tv/week?api_key=$apiKey";

String kAiringTodayTvShowsUrl = "${kBaseUrl}tv/airing_today?api_key=$apiKey";

String kPopularTvShowsUrl = "${kBaseUrl}tv/popular?api_key=$apiKey";
String kTopRatedTvShowsUrl = "${kBaseUrl}tv/top_rated?api_key=$apiKey";

// String kGenreUrl = "${kBaseUrl}genre/movie/list?api_key=$apiKey";

String kActorsUrl =
    "https://api.themoviedb.org/3/movie/505642/credits?api_key=c5f91272e8db79e3deb27701f18d2894";

var url =
    'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=<current_date>&primary_release_date.lte=<current_date>&with_release_type=3|2&with_watch_monetization_types=flatrate&with_release_type=2|3&with_watch_providers=8|384|125';

String malayalmMovies =
    'https://api.themoviedb.org/3/discover/movie?api_key=c5f91272e8db79e3deb27701f18d2894&language=ml&region=IN&with_original_language={with_original_language}';
