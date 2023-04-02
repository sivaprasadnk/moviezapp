import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';

class UserProvider extends ChangeNotifier {
  //

  List<MovieDetails> _bookMarkMoviesList = [];
  List<MovieDetails> get bookMarkMoviesList => _bookMarkMoviesList;

  List<TvShowDetails> _bookMarkShowsList = [];
  List<TvShowDetails> get bookMarkShowsList => _bookMarkShowsList;

  bool _bookmarkListLoading = true;
  bool get bookmarkListLoading => _bookmarkListLoading;

  bool _bookmarkShowsListLoading = true;
  bool get bookmarkShowsListLoading => _bookmarkShowsListLoading;

  Future<int> getBookmarksCount() async {
    var movieCount = (await UserRepo.getBookmarkMovieIds()).length;
    var showCount = (await UserRepo.getBookmarkShowIds()).length;
    return movieCount + showCount;
  }

  Future addMovieToBookmarks(MovieDetails movie, BuildContext context) async {
    var savedIds = await UserRepo.getBookmarkMovieIds();
    if (savedIds.contains(movie.id)) {
      if (context.mounted) {
        context.showSnackbar("Already Bookmarked !");
      }
    } else {
      await UserRepo.addMovieToBookmarks(movie);
      if (context.mounted) {
        context.showSnackbar("${movie.title}  added to Bookmarks !");

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreenMobile.routeName, (route) => false);
      }
    }
  }

  Future addTvShowToBookmarks(TvShowDetails show, BuildContext context) async {
    var savedIds = await UserRepo.getBookmarkShowIds();
    if (savedIds.contains(show.id)) {
      if (context.mounted) {
        context.showSnackbar("Already Bookmarked !");

      }
    } else {
      await UserRepo.addShowToBookmarks(show);
      if (context.mounted) {
        context.showSnackbar("${show.name}  added to Bookmarks !");
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreenMobile.routeName, (route) => false);
      }
    }
  }

  void clearList() {
    _bookMarkMoviesList.clear();
    notifyListeners();
  }

  Future getBookmarkedMovies(BuildContext context) async {
    _bookmarkListLoading = true;
    _bookMarkMoviesList.clear();
    notifyListeners();
    _bookMarkMoviesList = await UserRepo.getBookmarkedMovies();

    _bookmarkListLoading = false;
    notifyListeners();
  }

  Future getBookmarkedShows(BuildContext context) async {
    _bookmarkShowsListLoading = true;
    _bookMarkShowsList.clear();
    // notifyListeners();
    _bookMarkShowsList = await UserRepo.getBookmarkedShows();

    _bookmarkShowsListLoading = false;
    notifyListeners();
  }
}
