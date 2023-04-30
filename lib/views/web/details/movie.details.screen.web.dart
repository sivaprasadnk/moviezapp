import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/details/large/movie.details.large.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class MovieDetailsScreenWeb extends StatelessWidget {
  static const routeName = "/movie/";

  const MovieDetailsScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.goWebHome();
        return true;
      },
      child: const WebScaffold(
        body: SingleChildScrollView(
          child: MovieDetailsLarge(),
        ),
      ),
    );
  }
}
