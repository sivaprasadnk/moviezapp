import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/movie.card.dart';
import 'package:moviezapp/views/common/page.title.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/search/search.textfield.dart';
import 'package:moviezapp/views/web/search/info.text.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(title: 'Search'),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.primaryColor,
                ),
              ),
              width: double.infinity,
              child: const SearchTextField(),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Search Results'),
            const SizedBox(height: 20),
            Consumer<MoviesProvider>(
              builder: (_, provider, __) {
                var query = provider.searchQuery;
                var movies = provider.searchMoviesList;
                if (query.isEmpty) {
                  return const InfoText(
                      message: 'Please type something to search !');
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (movies.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(
                            title: 'Movies',
                            withSeeMore: movies.length > 5,
                            // seeMoreCallBack: () {
                            //   provider.updateMovieGenre(
                            //     Genre(id: 0, name: 'All'),
                            //     MovieType.search,
                            //   );
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) => AllMoviesScreen(
                            //         title: '',
                            //         type: MovieType.search,
                            //         genreList: provider.movieGenreList
                            //             .movieGenres(
                            //                 provider.filteredSearchMoviesList),
                            //       ),
                            //     ),
                            //   );
                            // },
                          ),
                          const SizedBox(height: 20),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: context.gridCrossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.6,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              var movie = movies[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: MovieCard(
                                  isMovie: true,
                                  movie: movie,
                                  name: movie.title,
                                  poster: movie.posterPath,
                                  vote: movie.voteAverage,
                                  id: movie.id,
                                  isWeb: false,
                                  withSize: false,
                                  releaseDate: movie.releaseDate,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    // if (shows.isNotEmpty)
                    //   Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       SectionTitle(
                    //         title: 'TV Shows',
                    //         withSeeMore: shows.length > 5,
                    //         seeMoreCallBack: () {
                    //           provider.updateTvShowGenre(
                    //             Genre(id: 0, name: 'All'),
                    //             TvShowType.search,
                    //           );
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (_) => AllTvShowsScreen(
                    //                 title: '',
                    //                 type: TvShowType.search,
                    //                 genreList: context
                    //                     .moviesProvider.tvGenreList
                    //                     .tvGenres(
                    //                         provider.filteredSearchTvShowList),
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //       const SizedBox(height: 20),
                    //       const TvShowsListMobile(
                    //         showType: TvShowType.search,
                    //       ),
                    //       const SizedBox(height: 20),
                    //     ],
                    //   ),
                    const SizedBox(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
