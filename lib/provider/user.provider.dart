import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.details.dart';
import 'package:moviezapp/model/tv.show.details.dart';
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';

import '../views/web/home/home.screen.web.dart';

class UserProvider extends ChangeNotifier {
  final int _userRating = 0;
  int get userRating => _userRating;

  // void updateRating(int value) {
  //   _userRating = value;
  //   notifyListeners();
  // }

  Future<int> getRating() async {
    return await UserRepo.getRating();
  }

  Future<void> updateRating(int value) async {
    await UserRepo.updateRating(value);
  }

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

  Future<bool> checkIfMovieBookmarked(int id) async {
    var savedIds = await UserRepo.getBookmarkMovieIds();
    if (savedIds.contains(id)) {
      debugPrint('movie bookmarked!');
      return true;
    }
    debugPrint('movie not  bookmarked!');

    return false;
  }

  Future<bool> checkIfTvShowBookmarked(int id) async {
    var savedIds = await UserRepo.getBookmarkShowIds();
    if (savedIds.contains(id)) {
      return true;
    }
    return false;
  }

  Future addMovieToBookmarks(MovieDetails movie, BuildContext context) async {
    var savedIds = await UserRepo.getBookmarkMovieIds();
    if (savedIds.contains(movie.id)) {
      if (context.mounted) {
        context.showInfoToast("Already Bookmarked !");
      }
    } else {
      await UserRepo.addMovieToBookmarks(movie);
      if (context.mounted) {
        context.showInfoToast("${movie.title}  added to Bookmarks !");
        Future.delayed(const Duration(seconds: 2)).then((value) {
          if (context.isMobileApp) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreenMobile.routeName, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreenWeb.routeName, (route) => false);
          }
        });
      }
    }
  }

  Future removeMovieFromBookmarks(
      MovieDetails movie, BuildContext context) async {
    await UserRepo.removeMovieFromBookmarks(movie);
    if (context.mounted) {
      context.showInfoToast("${movie.title}  removed from Bookmarks !");
      Future.delayed(const Duration(seconds: 2)).then((value) {
        if (context.isMobileApp) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreenMobile.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreenWeb.routeName, (route) => false);
        }
      });
    }
  }

  Future removeTvShowFromBookmarks(
      TvShowDetails show, BuildContext context) async {
    await UserRepo.removeTvShowFromBookmarks(show);
    if (context.mounted) {
      context.showInfoToast("${show.name} removed from Bookmarks !");
      Future.delayed(const Duration(seconds: 2)).then((value) {
        if (context.isMobileApp) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreenMobile.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreenWeb.routeName, (route) => false);
        }
      });
    }
  }

  Future addTvShowToBookmarks(TvShowDetails show, BuildContext context) async {
    var savedIds = await UserRepo.getBookmarkShowIds();
    if (savedIds.contains(show.id)) {
      if (context.mounted) {
        context.showInfoToast("Already Bookmarked !");
      }
    } else {
      await UserRepo.addShowToBookmarks(show);
      if (context.mounted) {
        context.showInfoToast("${show.name}  added to Bookmarks !");
        Future.delayed(const Duration(milliseconds: 1500)).then((value) {
          if (context.isMobileApp) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreenMobile.routeName, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreenWeb.routeName, (route) => false);
          }
        });
      }
    }
  }

  void clearList() {
    _bookMarkMoviesList.clear();
    _bookMarkShowsList.clear();
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
