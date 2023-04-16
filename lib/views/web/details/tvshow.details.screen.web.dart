import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/tvshow.details.large.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class TvShowDetailsScreenWeb extends StatelessWidget {
  static const routeName = "/tvshow/";

  const TvShowDetailsScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    var show = context.moviesProvider.selectedShow!;
    var isBookmarked = ModalRoute.of(context)!.settings.arguments as bool;

    return WebScaffold(
      body: SingleChildScrollView(
        child: context.width > 700
            ? TvShowDetailsLarge(
                show: show,
                isBookmarked: isBookmarked,
              )
            : TvShowDetailsLarge(
                show: show,
                isBookmarked: isBookmarked,
              ),
      ),
    );
  }
}
