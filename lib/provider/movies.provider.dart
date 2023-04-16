import 'package:flutter/material.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/related.video.model.dart';
import 'package:moviezapp/model/social.media.model.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/repo/movie/movie.repo.dart';
import 'package:moviezapp/repo/movie/region.list.dart';

enum Content { movie, tvShow }

enum SortBy {
  titleAscending,
  titleDescending,
  dateAscending,
  dateDescending,
  ratingAscending,
  ratingDescending,
}

extension SortExt on SortBy {
  String get displayTitle {
    switch (this) {
      case SortBy.titleAscending:
        return 'Title - Ascending';
      case SortBy.titleDescending:
        return 'Title - Descending';
      case SortBy.dateAscending:
        return 'Date - Ascending';
      case SortBy.dateDescending:
        return 'Date - Descending';
      case SortBy.ratingAscending:
        return "Rating - Ascending";
      case SortBy.ratingDescending:
        return "Rating - Descending";
    }
  }
}

class MoviesProvider extends ChangeNotifier {
  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  void updateQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  String _selectedSort = SortBy.titleAscending.displayTitle;
  String get selectedSort => _selectedSort;

  void updateSort(String value) {
    _selectedSort = value;
    notifyListeners();
  }

  int _selectedPage = 1;
  int get selectedPage => _selectedPage;

  void incrementPage() {
    _selectedPage = selectedPage + 1;
    notifyListeners();
  }

  void decrementPage() {
    _selectedPage = selectedPage - 1;
    notifyListeners();
  }

  bool _updateData = true;
  bool get updateData => _updateData;

  void updateDataStatus(bool value) {
    _updateData = value;
    notifyListeners();
  }

  ///
  ///  movies
  ///

  List<Genre> _movieGenreList = [];
  List<Genre> get movieGenreList => _movieGenreList;

  bool _moviesListLoading = true;
  bool get moviesListLoading => _moviesListLoading;

  List<Movie> _moviesList = [];
  List<Movie> get moviesList => _moviesList;

  Future getMoviesList() async {
    if (updateData) {
      _moviesListLoading = true;
      _moviesList = [];
      _moviesList = await MovieRepo.getMoviesList(
          selectedRegion.regionCode, selectedPage);
      _moviesListLoading = false;
    }
    notifyListeners();
  }

  bool _isSearchEnabled = false;
  bool get isSearchEnabled => _isSearchEnabled;

  void updateSearchEnabled(bool value) {
    _isSearchEnabled = value;
    notifyListeners();
  }

  List<Movie> _searchMoviesList = [];
  List<Movie> get searchMoviesList => _searchMoviesList;

  List<Movie> _filteredSearchMoviesList = [];
  List<Movie> get filteredSearchMoviesList => _filteredSearchMoviesList;

  void clearSearchList() {
    _searchMoviesList = [];
    _filteredSearchMoviesList = [];
    _searchTvShowList = [];
    _filteredSearchTvShowList = [];
    notifyListeners();
  }

  Future searchMovie(String query) async {
    _searchMoviesList = await MovieRepo.searchMovie(query);
    _filteredSearchMoviesList = _searchMoviesList;
    notifyListeners();
  }

  List<Movie> _similarMoviesList = [];
  List<Movie> get similarMoviesList => _similarMoviesList;

  void updateSimilarMoviesList(List<Movie> list) {
    _similarMoviesList = list;
    notifyListeners();
  }

  MovieDetails? _selectedMovie;
  MovieDetails? get selectedMovie => _selectedMovie;

  void updateSelectedMovie(MovieDetails movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  List<Movie> _similarMovieList = [];
  List<Movie> get similarMovieList => _similarMovieList;

  Future getSimilarMoviesList(int id) async {
    _similarMovieListLoading = true;
    _similarMovieList = [];
    notifyListeners();

    _similarMovieList = await MovieRepo.getSimilarMoviesList(id);

    _similarMovieListLoading = false;
    notifyListeners();
  }

  Future getMovieDetails(int id) async {
    _selectedMovie = await MovieRepo.getMovieDetails(id);
    Future.wait([
      getActorsList(id, 'movie'),
      getVideoList(id, "movie"),
      getSocialMediaLinks(id, "movie"),
      getSimilarMoviesList(id),
    ]);
    // getActorsList(id, 'movie');
    // getVideoList(id, "movie");
    // getSocialMediaLinks(id, "movie");
    // getSimilarMoviesList(id);
    // debugPrint('_videoList length@2 : ${_videoList.length}');
    notifyListeners();
  }

  bool _similarMovieListLoading = true;
  bool get similarMovieListLoading => _similarMovieListLoading;

  List<Movie> _filteredMoviesList = [];
  List<Movie> get filteredMoviesList => _filteredMoviesList;

  void updateFilteredMoviesList(List<Movie> list) {
    _filteredMoviesList = list;
    notifyListeners();
  }

  Genre? _selectedMovieGenre;
  Genre get selectedMovieGenre => _selectedMovieGenre!;

  void updateMovieGenre(Genre genre, MovieType type) {
    _selectedMovieGenre = genre;
    _filteredMoviesList = [];
    if (genre.id == 0) {
      if (type == MovieType.nowPlaying) {
        _filteredMoviesList = _moviesList.nowPlayingMovies(20);
      } else if (type == MovieType.topRated) {
        _filteredMoviesList = _moviesList.popularMovies(20);
      } else if (type == MovieType.upcoming) {
        _filteredMoviesList = _moviesList.upcomingMovies(20);
      } else {
        _filteredSearchMoviesList = _searchMoviesList;
      }
    } else {
      if (type == MovieType.nowPlaying) {
        _filteredMoviesList =
            genre.getFilteredList(_moviesList.nowPlayingMovies(20));
      } else if (type == MovieType.topRated) {
        _filteredMoviesList =
            genre.getFilteredList(_moviesList.popularMovies(20));
      } else if (type == MovieType.upcoming) {
        _filteredMoviesList =
            genre.getFilteredList(_moviesList.upcomingMovies(20));
      } else {
        _filteredSearchMoviesList = genre.getFilteredList(_searchMoviesList);
      }
    }
    notifyListeners();
  }

  Future getMovieGenres() async {
    _movieGenreList = await MovieRepo.getGenreList('movie');
    if (_movieGenreList.isNotEmpty) {
      _selectedMovieGenre = _movieGenreList[0];
    }
    notifyListeners();
  }

  ///
  ///  tvshows
  ///

  Future getTVGenres() async {
    _tvGenreList = await MovieRepo.getGenreList('tv');
    _selectedTvGenre = _tvGenreList[0];
    notifyListeners();
  }

  List<TvShows> _searchTvShowList = [];
  List<TvShows> get searchTvShowList => _searchTvShowList;

  List<TvShows> _filteredSearchTvShowList = [];
  List<TvShows> get filteredSearchTvShowList => _filteredSearchTvShowList;

  Future searchTvShow(String query) async {
    _searchTvShowList = await MovieRepo.searchTvShow(query);
    _filteredSearchTvShowList = _searchTvShowList;
    notifyListeners();
  }

  List<Genre> _tvGenreList = [];
  List<Genre> get tvGenreList => _tvGenreList;

  Genre? _selectedTvGenre;
  Genre get selectedTvGenre => _selectedTvGenre!;

  bool _tvShowListLoading = true;
  bool get tvShowListLoading => _tvShowListLoading;

  Future getTvShowsList() async {
    if (updateData) {
      _tvShowListLoading = true;
      _tvShowsList = [];
      _tvShowsList = await MovieRepo.getTvShowsList(selectedRegion.regionCode);
      _tvShowListLoading = false;
    }
    notifyListeners();
  }

  void updateFilteredTvShowsList(List<TvShows> list) {
    _filteredTvShowsList = list;
    notifyListeners();
  }

  TvShowDetails? _selectedShow;
  TvShowDetails? get selectedShow => _selectedShow;

  List<TvShows> _similarTvShowList = [];
  List<TvShows> get similarTvShowList => _similarTvShowList;

  List<TvShows> _filteredTvShowsList = [];
  List<TvShows> get filteredTvShowsList => _filteredTvShowsList;

  List<TvShows> _tvShowsList = [];
  List<TvShows> get tvShowsList => _tvShowsList;

  void updateTvShowGenre(Genre genre, TvShowType type) {
    _selectedTvGenre = genre;
    _filteredTvShowsList = [];
    if (genre.id == 0) {
      if (type == TvShowType.airingToday) {
        _filteredTvShowsList = _tvShowsList.airingTodayShows(20);
      } else if (type == TvShowType.topRated) {
        _filteredTvShowsList = _tvShowsList.topRatedShows(20);
      } else if (type == TvShowType.popular) {
        _filteredTvShowsList = _tvShowsList.popularShows(20);
      } else {
        _filteredSearchTvShowList = _searchTvShowList;
      }
    } else {
      if (type == TvShowType.airingToday) {
        _filteredTvShowsList =
            genre.getFilteredTvShowsList(_tvShowsList.airingTodayShows(20));
      } else if (type == TvShowType.popular) {
        _filteredTvShowsList =
            genre.getFilteredTvShowsList(_tvShowsList.popularShows(20));
      } else if (type == TvShowType.popular) {
        _filteredTvShowsList =
            genre.getFilteredTvShowsList(_tvShowsList.topRatedShows(20));
      } else {
        _filteredSearchTvShowList =
            genre.getFilteredTvShowsList(_searchTvShowList);
      }
    }
    notifyListeners();
  }

  bool _similarTvShowsLoading = true;
  bool get similarTvShowsLoading => _similarTvShowsLoading;

  Future getSimilarTvShowsList(int id) async {
    _similarTvShowsLoading = true;
    _similarTvShowList = [];
    notifyListeners();
    _similarTvShowList = await MovieRepo.getSimilarTvShowList(id);
    _similarTvShowsLoading = false;
    notifyListeners();
  }

  Future getTvShowDetails(int id) async {
    _selectedShow = await MovieRepo.getTvShowDetails(id);
    getActorsList(id, 'tv');
    getVideoList(id, "tv");
    getSocialMediaLinks(id, "tv");
    getSimilarTvShowsList(id);
    notifyListeners();
  }

  ///
  ///  others
  ///

  String _selectedRegion = "India";
  String get selectedRegion => _selectedRegion;

  void updateRegion(String value) {
    _selectedRegion = value;
    notifyListeners();
  }

  SocialMediaModel _socialMediaModel = SocialMediaModel(
    fbId: "",
    imdbId: "",
    instaId: "",
    twitterId: "",
    wikipediaId: "",
    isLoading: true,
  );

  void updateSocialMedia(SocialMediaModel model) {
    _socialMediaModel = model;
    notifyListeners();
  }

  Future getSocialMediaLinks(int id, String show) async {
    _socialMediaModel = SocialMediaModel(
      fbId: "",
      imdbId: "",
      instaId: "",
      twitterId: "",
      wikipediaId: "",
      isLoading: true,
    );
    notifyListeners();
    _socialMediaModel = await MovieRepo.getSocialMedia(id, show);

    notifyListeners();
  }

  SocialMediaModel get socialMediaModel => _socialMediaModel;

  Content _selectedContentType = Content.movie;
  Content get selectedContentType => _selectedContentType;

  void updateContentType(Content type) {
    _selectedContentType = type;
    _carousalIndex = 0;
    notifyListeners();
  }

  int _carousalIndex = 0;
  int get carousalIndex => _carousalIndex;

  void updateCarousalIndex(int index) {
    _carousalIndex = index;
    notifyListeners();
  }

  List<Actors> _actorsList = [];
  List<Actors> get actorsList => _actorsList;

  List<RelatedVideoModel> _videoList = [];
  List<RelatedVideoModel> get videoList => _videoList;

  bool _actorsListLoading = true;
  bool get actorsListLoading => _actorsListLoading;

  bool _videosLoading = true;
  bool get videosLoading => _videosLoading;

  void updateActorsListLoading(bool value) {
    _actorsListLoading = value;
    notifyListeners();
  }

  void clearDetails() {
    _actorsList.clear();
    _videoList.clear();
    _actorsListLoading = true;
    _similarMovieList.clear();
    _similarMovieListLoading = true;
  }

  Future getActorsList(int id, String show) async {
    _actorsListLoading = true;
    _actorsList = [];
    _actorsList = await MovieRepo.getActorsList(id, show);

    _actorsListLoading = false;
    notifyListeners();
  }

  Future getVideoList(int id, String show) async {
    _videosLoading = true;
    _videoList = [];
    _videoList = await MovieRepo.getRelatedVideos(id, show);
    _videosLoading = false;
    notifyListeners();
  }
}
