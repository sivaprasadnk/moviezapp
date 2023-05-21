import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/views/web/bookmark/bookmark.screen.web.dart';
import 'package:moviezapp/views/web/details/movie.details.screen.web.dart';
import 'package:moviezapp/views/web/details/tvshow.details.screen.web.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:moviezapp/views/web/search/search.screen.web.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name!.getRoutingData;
  switch (routingData.route) {
    case HomeScreenWeb.routeName:
      return _getPageRoute(const HomeScreenWeb(), settings);
    case SearchScreenWeb.routeName:
      return _getPageRoute(const SearchScreenWeb(), settings);
    case BookmarkScreenWeb.routeName:
      return _getPageRoute(const BookmarkScreenWeb(), settings);

    case MovieDetailsScreenWeb.routeName:
      return _getPageRoute(const MovieDetailsScreenWeb(), settings);
    case TvShowDetailsScreenWeb.routeName:
      return _getPageRoute(const TvShowDetailsScreenWeb(), settings);
    default:
      return _getPageRoute(const HomeScreenWeb(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name!);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
