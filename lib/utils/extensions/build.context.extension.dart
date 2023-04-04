import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/provider/user.provider.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:provider/provider.dart';

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

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  
  ScaffoldState get scaffold => Scaffold.of(this);

  void showSnackbar(String title) => scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(title),
        ),
      );

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
}
