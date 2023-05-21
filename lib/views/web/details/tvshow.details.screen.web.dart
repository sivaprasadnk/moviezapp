import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.complete.details.model.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/uri.extensions.dart';
import 'package:moviezapp/views/web/details/large/movie.details.large.new.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.movie.details.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class TvShowDetailsScreenWeb extends StatefulWidget {
  static const routeName = "/movie/";

  const TvShowDetailsScreenWeb({
    Key? key,
  }) : super(key: key);
  @override
  State<TvShowDetailsScreenWeb> createState() => _TvShowDetailsScreenWebState();
}

class _TvShowDetailsScreenWebState extends State<TvShowDetailsScreenWeb> {
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







// import 'package:flutter/material.dart';
// import 'package:moviezapp/utils/extensions/build.context.extension.dart';
// import 'package:moviezapp/views/web/details/large/tvshow.details.large.dart';
// import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

// class TvShowDetailsScreenWeb extends StatelessWidget {
//   static const routeName = "/tvshow/";

//   const TvShowDetailsScreenWeb({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         context.goWebHome();
//         return true;
//       },
//       child: const WebScaffold(
//         body: SingleChildScrollView(
//           child: TvShowDetailsLarge(),
//         ),
//       ),
//     );
//   }
// }
