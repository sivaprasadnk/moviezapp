import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/web.drawer.dart';
import 'package:moviezapp/views/web/movie.details/large/movie.details.large.dart';
import 'package:moviezapp/views/web/movie.details/small/movie.details.small.dart';

class MovieDetailsScreenWeb extends StatelessWidget {
  static const routeName = "/movie/";

  const MovieDetailsScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        endDrawer: const WebDrawer(),
        appBar: const TitleAppBar(),
        body: SingleChildScrollView(
          child: context.width > 700
              ? const MovieDetailsLarge()
              : const MovieDetailsSmall(),
        ),
      ),
    );
  }
}
