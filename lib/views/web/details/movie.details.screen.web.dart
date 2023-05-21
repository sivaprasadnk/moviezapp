import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/uri.extensions.dart';
import 'package:moviezapp/views/web/details/large/movie.details.large.new.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.details.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class MovieDetailsScreenWeb extends StatefulWidget {
  static const routeName = "/home/movie/";

  const MovieDetailsScreenWeb({
    Key? key,
  }) : super(key: key);
  @override
  State<MovieDetailsScreenWeb> createState() => _MovieDetailsScreenWebState();
}

class _MovieDetailsScreenWebState extends State<MovieDetailsScreenWeb> {
  bool isLoading = true;
  MovieCompleteDetailsModel? movie;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.moviesProvider
          .getCompleteMovieDetails(Uri.base.id)
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

    return WebScaffold(
      body: !isLoading
          ? SingleChildScrollView(
              child: MovieDetailsLargeNew(
                movieDetails: movie!,
              ),
            )
          : const LoadingMovieDetails(),
    );
  }
}
