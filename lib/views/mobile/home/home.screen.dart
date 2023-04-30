import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/bottom.nav.bar.dart';
import 'package:moviezapp/views/mobile/home/page/bookmarks/bookmarks.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/movie.list.screen.dart';
import 'package:moviezapp/views/mobile/home/page/profile/profile.screen.dart';
import 'package:moviezapp/views/mobile/home/page/search/search.screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});
  static const routeName = '/homeMobile';

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  DateTime? currentBackPressTime;
  var isDeviceConnected = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.appProvider.getVersionFromDb().then((versionFromWeb) {
        context.showSnackbar('versionFromWeb : $versionFromWeb');
      });
      checkNetwork();
    });
    super.initState();
  }

  checkNetwork() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      if (mounted) {
        switch (status) {
          case InternetConnectionStatus.connected:
            updateData();
            break;
          case InternetConnectionStatus.disconnected:
            noNetworkDialog();
            break;
        }
      }
    });
  }

  updateData() {
    if (mounted) {
      if (ModalRoute.of(context)?.isCurrent != true) {
        context.pop();
      }
      if (context.moviesProvider.updateData) {
        Future.wait([
          context.moviesProvider.getMovieGenres(),
          context.moviesProvider.getTVGenres(),
          context.moviesProvider.getMoviesList(),
          context.moviesProvider.getTvShowsList()
        ]);
      }
      setVersion();
      context.appProvider.updatedSelectedIndex(0);
    }
  }

  noNetworkDialog() async {
    if (mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const AlertDialog(
              title: Text('No internet connection !'),
              content: Text(
                "Make sure wifi or cellular data is turned on and then try again!",
              ),
            ),
          );
        },
      );
    }
  }

  setVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    if (context.mounted) {
      context.appProvider.updateVersion('$version.$buildNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: const BottomNavBar(),
          body: Consumer<AppProvider>(
            builder: (_, provider, __) {
              switch (provider.selectedIndex) {
                case 0:
                  return const MovieListScreen();
                case 1:
                  return const SearchScreen();
                case 2:
                  return const BookmarkScreen();
                case 3:
                  return const ProfileScreen();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
