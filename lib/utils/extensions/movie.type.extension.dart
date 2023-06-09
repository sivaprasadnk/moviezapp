import 'package:moviezapp/model/movie.dart';

extension MovieTyeExt on MovieType {
  String get functionName {
    switch (this) {
      case MovieType.trending:
        return 'trendingMovies';
      case MovieType.nowPlaying:
        return 'trendingMovies';

      case MovieType.topRated:
        return 'trendingMovies';

      case MovieType.upcoming:
        return 'trendingMovies';

      case MovieType.similar:
        return 'trendingMovies';

      case MovieType.search:
        return 'trendingMovies';

      case MovieType.bookmarks:
        return 'trendingMovies';

      case MovieType.filmography:
        return 'trendingMovies';
    }
  }

  String get typeValue {
    switch (this) {
      case MovieType.trending:
        return 'trending';
      case MovieType.nowPlaying:
        return 'now_playing';

      case MovieType.topRated:
        return 'top_rated';

      case MovieType.upcoming:
        return 'upcoming';

      case MovieType.similar:
        return 'similar';

      case MovieType.search:
        return 'search';

      case MovieType.bookmarks:
        return 'bookmarks';

      case MovieType.filmography:
        return 'filmography';
    }
  }
}
