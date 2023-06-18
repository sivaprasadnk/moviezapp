import 'package:flutter/material.dart';
import 'package:moviezapp/model/actor.details.model.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/credits.model.dart';
import 'package:moviezapp/model/crew.model.dart';
import 'package:moviezapp/model/genre.model.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/related.video.model.dart';
import 'package:moviezapp/model/social.media.model.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/model/tvshow.complete.details.model.dart';
import 'package:moviezapp/repo/movie/movie.repo.dart';
import 'package:moviezapp/repo/movie/region.list.dart';
import 'package:moviezapp/repo/user/user.repo.dart';

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
  MovieCompleteDetailsModel? _movieCompleteDetails;
  MovieCompleteDetailsModel get movieCompleteDetails => _movieCompleteDetails!;

  // void updateCompleteDetails(MovieCompleteDetailsModel details) {
  //   _movieCompleteDetails = details;
  //   notifyListeners();
  // }

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

  Future getMoviesList(bool isWeb) async {
    if (updateData) {
      _moviesListLoading = true;
      _moviesList = [];
      _moviesList = await MovieRepo.getMoviesList(
          selectedRegion.regionCode, selectedPage, isWeb);
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

  Future searchMovie(String query, bool isWeb) async {
    _searchMoviesList = await MovieRepo.getMovieResultsList(
      MovieType.search,
      isWeb,
      query: query,
    );
    debugPrint('searchMovies length: ${_searchMoviesList.length}');
    _filteredSearchMoviesList = _searchMoviesList;
    notifyListeners();
  }

  List<Movie> _similarMoviesList = [];
  List<Movie> get similarMoviesList => _similarMoviesList;

  void updateSimilarMoviesList(List<Movie> list) {
    _similarMoviesList = list;
    notifyListeners();
  }

  Movie? _selectedMovie;
  Movie get selectedMovie => _selectedMovie!;

  void updateMovie(Movie movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  MovieDetails? _selectedMovieDetails;
  MovieDetails? get selectedMovieDetails => _selectedMovieDetails;

  void updateSelectedMovie(MovieDetails movie) {
    _selectedMovieDetails = movie;
    notifyListeners();
  }

  List<Movie> _similarMovieList = [];
  List<Movie> get similarMovieList => _similarMovieList;

  Future<List<Movie>> getSimilarMoviesList(int id, bool isWeb) async {
    _similarMovieList = await MovieRepo.getMovieResultsList(
        MovieType.similar, isWeb,
        id: id.toString());
    return _similarMovieList;
  }

  Future<MovieCompleteDetailsModel> getCompleteMovieDetails(
      int id, bool isWeb,
      {bool isGuest = false}) async {
    _selectedMovieDetails = await MovieRepo.getMovieDetails(id);
    var credits = await getActorsList(id, 'movie');
    var videos = await getVideoList(id, "movie");
    // getSocialMediaLinks(id, "movie");
    var similar = await getSimilarMoviesList(id, isWeb);
    var provider =
        await MovieRepo.getWatchProviders(id, selectedRegion.regionCode);
    var isFav = isGuest ? false : await checkIfMovieBookmarked(id);
    return MovieCompleteDetailsModel(
      movie: _selectedMovieDetails!,
      actorsList: credits.actors,
      crewList: credits.crew,
      isFavourite: isFav,
      overview: _selectedMovieDetails!.overview,
      similarMoviesList: similar,
      videoList: videos,
      provider: provider,
    );
  }

  bool _similarMovieListLoading = true;
  bool get similarMovieListLoading => _similarMovieListLoading;

  List<Movie> _filteredMoviesList = [];
  List<Movie> get filteredMoviesList => _filteredMoviesList;

  List<Movie> _filmographyMoviesList = [];
  List<Movie> get filmographyMoviesList => _filmographyMoviesList;

  void updateFilteredMoviesList(List<Movie> list) {
    _filteredMoviesList = list;
    notifyListeners();
  }

  void updateFilmographyMoviesList(List<Movie> list) {
    _filmographyMoviesList = list;
    notifyListeners();
  }

  Genre? _selectedMovieGenre;
  Genre get selectedMovieGenre => _selectedMovieGenre!;

  void updateMovieGenre(Genre genre, MovieType type, {List<Movie>? movies}) {
    _selectedMovieGenre = genre;
    _filteredMoviesList = [];
    _selectedSort = SortBy.titleAscending.displayTitle;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if (genre.id == 0) {
        if (type == MovieType.nowPlaying) {
          _filteredMoviesList = _moviesList.nowPlayingMovies(20);
        } else if (type == MovieType.topRated) {
          _filteredMoviesList = _moviesList.popularMovies(20);
        } else if (type == MovieType.upcoming) {
          _filteredMoviesList = _moviesList.upcomingMovies(20);
        } else if (type == MovieType.filmography) {
          _filteredMoviesList = _filmographyMoviesList;
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
        } else if (type == MovieType.filmography) {
          _filteredMoviesList = genre.getFilteredList(_filmographyMoviesList);
        } else {
          _filteredSearchMoviesList = genre.getFilteredList(_searchMoviesList);
        }
      }
      _filteredMoviesList.sort((a, b) => a.title.compareTo(b.title));
      _filteredSearchMoviesList.sort((a, b) => a.title.compareTo(b.title));

      notifyListeners();
    });
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

  TvShow? _selectedTvShow;
  TvShow get selectedTvShow => _selectedTvShow!;

  void updateSelectedTvShow(TvShow show) {
    _selectedTvShow = show;
    notifyListeners();
  }

  Future getTVGenres() async {
    _tvGenreList = await MovieRepo.getGenreList('tv');
    _selectedTvGenre = _tvGenreList[0];
    notifyListeners();
  }

  List<TvShow> _searchTvShowList = [];
  List<TvShow> get searchTvShowList => _searchTvShowList;

  List<TvShow> _filteredSearchTvShowList = [];
  List<TvShow> get filteredSearchTvShowList => _filteredSearchTvShowList;

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

  Future<TvShowCompleteDetailsModel> getCompleteTvShowDetails(int id) async {
    _selectedShowDetails = await MovieRepo.getTvShowDetails(id);

    var credits = await getActorsList(id, 'tv');

    var videos = await getVideoList(id, "tv");

    // var similar = await getSimilarTvShowsList(id);
    var isFav = false;
    return TvShowCompleteDetailsModel(
      tvShow: _selectedShowDetails!,
      actorsList: credits.actors,
      crewList: credits.crew,
      isFavourite: isFav,
      overview: _selectedShowDetails!.overview,
      similarTvShowsList: [],
      videoList: videos,
    );
  }

  void updateFilteredTvShowsList(List<TvShow> list) {
    _filteredTvShowsList = list;
    notifyListeners();
  }

  TvShowDetails? _selectedShowDetails;
  TvShowDetails? get selectedShowDetails => _selectedShowDetails;

  List<TvShow> _similarTvShowList = [];
  List<TvShow> get similarTvShowList => _similarTvShowList;

  List<TvShow> _filteredTvShowsList = [];
  List<TvShow> get filteredTvShowsList => _filteredTvShowsList;

  List<TvShow> _tvShowsList = [];
  List<TvShow> get tvShowsList => _tvShowsList;

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
    _selectedShowDetails = await MovieRepo.getTvShowDetails(id);
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

  final List<Actor> _actorsList = [];
  List<Actor> get actorsList => _actorsList;

  final List<Crew> _crewList = [];
  List<Crew> get crewList => _crewList;

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
    _crewList.clear();
    _videoList.clear();
    _similarMovieList.clear();
    _actorsListLoading = true;
    _videosLoading = true;
    _similarMovieListLoading = true;
  }

  Future<CreditsModel> getActorsList(int id, String show) async {
    var credits = await MovieRepo.getCreditsList(id, show);
    _crewList.sort((a, b) => a.order.compareTo(b.order));
    return credits;
  }

  getVideoList(int id, String show) async {
    _videosLoading = true;
    _videoList = [];
    _videoList = await MovieRepo.getRelatedVideos(id, show);
    _videosLoading = false;
    notifyListeners();
    return _videoList;
  }

  Future<ActorDetailsModel?> getActorDetails(int id) async {
    return await MovieRepo.getActorDetails(id);
  }

  Future<List<Movie>> getActorFilms(int id) async {
    return await MovieRepo.getActorFilms(id);
  }

  Future<bool> checkIfMovieBookmarked(int id) async {
    var savedIds = await UserRepo.getBookmarkMovieIds();
    return savedIds.contains(id);
  }

  Future<bool> checkIfTvShowBookmarked(int id) async {
    var savedIds = await UserRepo.getBookmarkShowIds();
    if (savedIds.contains(id)) {
      return true;
    }
    return false;
  }
}
