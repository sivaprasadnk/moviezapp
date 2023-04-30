import 'package:flutter/material.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class ActorFilms extends StatelessWidget {
  const ActorFilms({super.key, required this.movies, required this.actor});
  final List<Movie> movies;
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.1,
            right: context.width * 0.1,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SectionTitle(
                title: '${actor.name} Films',
                withSeeMore: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
