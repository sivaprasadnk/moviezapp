import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/provider/user.provider.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:provider/provider.dart';

import '../../provider/auth.provider.dart';
// import 'package:universal_html/html.dart' as html;

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;

  // int get gridCrossAxisCount => width > 1200
  //     ? 5
  //     : width > 920
  //         ? 4
  //         : width > 685
  //             ? 3
  //             : 2;

  int get gridCrossAxisCount => width > 1200
      ? 5
      : width > 920
          ? 4
          : width > 685
              ? 3
              : 2;

  int get gridLimit => width > 1200
      ? 5
      : width > 920
          ? 4
          : width > 685
              ? 3
              : 2;

  MoviesProvider get moviesProvider =>
      Provider.of<MoviesProvider>(this, listen: false);

  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(this, listen: false);

  UserProvider get userProvider =>
      Provider.of<UserProvider>(this, listen: false);

  AppProvider get appProvider => Provider.of<AppProvider>(this, listen: false);

  // ConnectivityStatus get connectivity =>
  //     Provider.of<ConnectivityStatus>(this, listen: false);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  void showSnackbar(String title) => scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(title),
        ),
      );

  void showInfoToast(String title, {bool autoDismiss = true}) =>
      CherryToast.info(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        animationType: AnimationType.fromRight,
        autoDismiss: autoDismiss,
      ).show(this);

  void showErrorToast(String title, {bool autoDismiss = true}) =>
      CherryToast.error(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        animationType: AnimationType.fromRight,
        autoDismiss: autoDismiss,
      ).show(this);

  bool get isMobileApp => appProvider.isMobileApp;

  bool get isGuestUser => authProvider.isGuestUser;
  bool get isChromeApp => appProvider.isChromeApp;


  int get movieId => moviesProvider.selectedMovieDetails!.id;
  int get tvShowId => moviesProvider.selectedShowDetails!.id;
  List<Movie> get moviesList => moviesProvider.moviesList;

  ThemeData get theme => Theme.of(this);

  Color get primaryColor => theme.primaryColor;
  Color get highlightColor =>
      theme.brightness == Brightness.light ? Colors.black : Colors.white;
  Color get bgColor => theme.scaffoldBackgroundColor;

  void pop() {
    Navigator.pop(this);
  }

  void goHome() {
    Navigator.pushNamedAndRemoveUntil(
        this, HomeScreenMobile.routeName, (route) => false);
  }

  void goWebHome() {
    Navigator.pushNamedAndRemoveUntil(
        this, HomeScreenWeb.routeName, (route) => false);
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  Object? get arguments => ModalRoute.of(this)!.settings.arguments;

  bool get isDialogOpen => ModalRoute.of(this)?.isCurrent != true;
  // bool get isDialogOpen => Navigator.of(this).canPop();

  // void openInNewTab(String url) {
  //   html.window.open(
  //     url,
  //     'new tab',
  //   );
  // }
}
