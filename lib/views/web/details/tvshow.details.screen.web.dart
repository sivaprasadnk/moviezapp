import 'package:flutter/material.dart';
import 'package:moviezapp/views/web/details/large/tvshow.details.large.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class TvShowDetailsScreenWeb extends StatelessWidget {
  static const routeName = "/tvshow/";

  const TvShowDetailsScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebScaffold(
      body: SingleChildScrollView(
        child: TvShowDetailsLarge(),
      ),
    );
  }
}
