import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';

class ActorFilms extends StatelessWidget {
  const ActorFilms({
    super.key,
  });

  static const routeName = "/actorfilms";

  @override
  Widget build(BuildContext context) {
    var args = context.arguments as Map;
    List<Movie> moviesList = args['moviesList'];
    String actor = args['actor'];
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
                title: '$actor Films (${moviesList.length})',
                withSeeMore: false,
              ),
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridCrossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 1,
                  childAspectRatio: 0.6,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: moviesList.length,
                itemBuilder: (context, index) {
                  var movie = moviesList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: MovieCard(
                      name: movie.title,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                      id: movie.id,
                      isWeb: true,
                      withSize: false,
                      releaseDate: movie.releaseDate,
                    ),
                  ).addMousePointer;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
