import 'package:flutter/material.dart';
import 'package:moviezapp/model/movie.dart';
import 'package:moviezapp/model/tv.shows.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/content.selection.dart';
import 'package:moviezapp/views/web/home/widgets/list/movie.list.web.dart';
import 'package:moviezapp/views/web/home/widgets/list/tv.show.list.web.dart';
import 'package:moviezapp/views/web/search/info.text.dart';
import 'package:provider/provider.dart';

class SearchScreenWeb extends StatefulWidget {
  const SearchScreenWeb({super.key});

  @override
  State<SearchScreenWeb> createState() => _SearchScreenWebState();
}

class _SearchScreenWebState extends State<SearchScreenWeb> {
  String query = "";

  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

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
              color: context.primaryColor,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      context.goWebHome();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Consumer<MoviesProvider>(builder: (_, provider, __) {
                    return Form(
                      key: _formKey,
                      child: Container(
                        width: context.width * 0.3,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          focusNode: focusNode,
                          onSaved: (newValue) {
                            provider.clearSearchList();
                            provider.updateQuery(newValue!.trim());
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _formKey.currentState!.save();
                                var query = context.moviesProvider.searchQuery;
                                if (context
                                        .moviesProvider.selectedContentType ==
                                    Content.movie) {
                                  context.moviesProvider.searchMovie(query);
                                } else {
                                  context.moviesProvider.searchTvShow(query);
                                }
                              },
                              child: const Icon(
                                Icons.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 50),
                  const Text(
                    'Search in :',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const ContentSelectionWeb(clearSearch: true),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _formKey.currentState!.save();
                      var query = context.moviesProvider.searchQuery;
                      if (context.moviesProvider.selectedContentType ==
                          Content.movie) {
                        context.moviesProvider.searchMovie(query);
                      } else {
                        context.moviesProvider.searchTvShow(query);
                      }
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 15,
                        )
                      ],
                    ),
                  ).addMousePointer,
                  const Spacer(),
                  const SizedBox(width: 10),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'Search Results'),
                  const SizedBox(height: 20),
                  Consumer<MoviesProvider>(builder: (_, provider, __) {
                    var selected = provider.selectedContentType;
                    var query = provider.searchQuery;
                    return query.isNotEmpty
                        ? selected == Content.movie
                            ? provider.searchMoviesList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${provider.searchMoviesList.length} results found."),
                                      const SizedBox(height: 20),
                                      const MovieListWeb(
                                        isSearch: true,
                                        type: MovieType.search,
                                      ),
                                    ],
                                  )
                                : const InfoText(message: 'No movies found !')
                            : provider.searchTvShowList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${provider.searchTvShowList.length} results found."),
                                      const SizedBox(height: 20),
                                      const TvShowListWeb(
                                        isSearch: true,
                                        type: TvShowType.search,
                                      ),
                                    ],
                                  )
                                : const InfoText(message: 'No Tv shows found !')
                        : const InfoText(
                            message: 'Please type something to search !');
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
