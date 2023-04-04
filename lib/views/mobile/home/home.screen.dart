import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/bottom.nav.bar.dart';
import 'package:moviezapp/views/mobile/home/page/activity.screen.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.moviesProvider.updateData) {
        context.moviesProvider.getMovieGenres();
        context.moviesProvider.getTVGenres();
        context.moviesProvider.getMoviesList();
        context.moviesProvider.getTvShowsList();
      }
      setVersion();
      context.appProvider.updatedSelectedIndex(0);
    });
    super.initState();
  }

  setVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    if (context.mounted) {
      context.appProvider.updateVersion('v$version.$buildNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          context.showSnackbar('Double tap to exit!');
          return Future.value(false);
        }
        SystemNavigator.pop();
        return Future.value(true);
      },
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
                  return const ActivityScreen();
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
