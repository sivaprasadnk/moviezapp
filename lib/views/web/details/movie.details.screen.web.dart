import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/uri.extensions.dart';
import 'package:moviezapp/views/web/details/large/movie.details.large.new.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.movie.details.web.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';
import 'package:universal_html/html.dart' as html;

class MovieDetailsScreenWeb extends StatefulWidget {
  static const routeName = "/movie/";

  const MovieDetailsScreenWeb({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreenWeb> createState() => _MovieDetailsScreenWebState();
}

class _MovieDetailsScreenWebState extends State<MovieDetailsScreenWeb> {
  bool isLoading = true;
  bool reloaded = false;

  MovieCompleteDetailsModel? movie;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      html.window.onBeforeUnload.listen((event) {
        setState(() {
          reloaded = true;
        });
        // change something in db
      });
      await context.moviesProvider
          .getCompleteMovieDetails(
        Uri.base.id,
        !context.isMobileApp,
        isGuest: context.isGuestUser,
      )
          .then((value) {
        movie = value;
        isLoading = false;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('reloaded : $reloaded');
        return !reloaded;
      },
      child: WebScaffold(
        body: !isLoading
            ? SingleChildScrollView(
                child: MovieDetailsLargeNew(
                  movieDetails: movie!,
                ),
              )
            : const LoadingMovieDetailsWeb(),
      ),
    );
  }
}
