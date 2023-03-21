import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/carousal/carousal.web.dart';
import 'package:moviezapp/views/web/home/widgets/content.selection.dart';
import 'package:moviezapp/views/web/home/widgets/region.text.dart';
import 'package:moviezapp/views/web/home/widgets/section/movie.section.web.dart';
import 'package:moviezapp/views/web/home/widgets/section/tv.show.section.web.dart';
import 'package:provider/provider.dart';

import '../../../provider/movies.provider.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({
    Key? key,
    this.isMobileWeb = false,
  }) : super(key: key);

  final bool isMobileWeb;

  static const routeName = '/home';
  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.appProvider.updateMobileApp(false);

      context.moviesProvider.getMovieGenres();
      context.moviesProvider.getTVGenres();
      context.moviesProvider.getMoviesList();
      context.moviesProvider.getTvShowsList();
      context.appProvider.updatedSelectedIndex(0);
      context.appProvider.updateMobileWeb(widget.isMobileWeb);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: context.width * 0.1),
              width: double.infinity,
              height: 50,
              color: context.theme.primaryColor,
              child: Row(
                children: const [
                  SizedBox(width: 10),
                  ContentSelectionWeb(),
                  Spacer(),
                  RegionText(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CarousalWeb(),
            const SizedBox(height: 20),
            Consumer<MoviesProvider>(builder: (_, provider, __) {
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: provider.selectedContentType == Content.movie
                    ? MovieSectionWeb(isMobileWeb: widget.isMobileWeb)
                    : TvShowSectionWeb(isMobileWeb: widget.isMobileWeb),
              );
            }),
          ],
        ),
      ),
    );
  }
}
