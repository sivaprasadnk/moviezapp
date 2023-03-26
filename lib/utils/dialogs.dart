import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/auth/sign.in/sign.in.screen.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';
import 'package:provider/provider.dart';

class Dialogs {
  static void showLoader({required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return WillPopScope(
          onWillPop: (() async => false),
          child: const Dialog(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      }),
    );
  }

  static Future showGetStartedDialog(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Never miss',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'New movies & series',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Be the first one to watch latest movies and series on movie app',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    showSelectionDialog(context);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  static showSelectionDialog(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (_) {
        return Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Container(
                  height: 5,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Start with',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                  child: Container(
                    height: 75,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              ' Member',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' You can sign up/ sign in with your\n email address',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(width: 10),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    context.authProvider.updateGuestUser(true);
                    Navigator.pushNamed(context, HomeScreenMobile.routeName);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.person,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Guest',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'Use the app without authentication',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                // color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showSortByDialog(
    BuildContext context,
    String currentSettings, {
    bool isMovie = true,
  }) async {
    var primaryColor = context.primaryColor;
    var whiteColor = Colors.white;

    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        var selected = currentSettings;
        return AlertDialog(
          backgroundColor: context.bgColor,
          title: const SectionTitle(title: 'Sort By'),
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              width: context.width * 0.3,
              color: context.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: SortBy.values.map((order) {
                        if (!isMovie &&
                            (order == SortBy.dateAscending ||
                                order == SortBy.dateDescending)) {
                          return const SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = order.displayTitle;
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: selected == order.displayTitle
                                  ? primaryColor
                                  : whiteColor,
                              border: Border.all(
                                color: context.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                order.displayTitle,
                                style: TextStyle(
                                  color: selected == order.displayTitle
                                      ? whiteColor
                                      : primaryColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ).addMousePointer,
            ),
            const SizedBox(width: 10),
            Consumer<MoviesProvider>(builder: (_, provider, __) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                    if (isMovie) {
                      var list = provider.filteredMoviesList;
                      if (selected == SortBy.titleAscending.displayTitle) {
                        list.sort((a, b) => a.title.compareTo(b.title));
                      } else if (selected ==
                          SortBy.titleDescending.displayTitle) {
                        list.sort((a, b) => b.title.compareTo(a.title));
                      } else if (selected ==
                          SortBy.dateAscending.displayTitle) {
                        list.sort(
                            (a, b) => a.releaseDate.compareTo(b.releaseDate));
                      } else if (selected ==
                          SortBy.dateDescending.displayTitle) {
                        list.sort(
                            (a, b) => b.releaseDate.compareTo(a.releaseDate));
                      } else if (selected ==
                          SortBy.ratingAscending.displayTitle) {
                        list.sort(
                            (a, b) => a.voteAverage.compareTo(b.voteAverage));
                      } else if (selected ==
                          SortBy.ratingDescending.displayTitle) {
                        list.sort(
                            (a, b) => b.voteAverage.compareTo(a.voteAverage));
                      }
                      provider.updateSort(selected);
                      provider.updateFilteredMoviesList(list);
                    } else {
                      var list = provider.filteredTvShowsList;
                      if (selected == SortBy.titleAscending.displayTitle) {
                        list.sort((a, b) => a.name.compareTo(b.name));
                      } else if (selected ==
                          SortBy.titleDescending.displayTitle) {
                        list.sort((a, b) => b.name.compareTo(a.name));
                      } else if (selected ==
                          SortBy.ratingAscending.displayTitle) {
                        list.sort(
                            (a, b) => a.voteAverage.compareTo(b.voteAverage));
                      } else if (selected ==
                          SortBy.ratingDescending.displayTitle) {
                        list.sort(
                            (a, b) => b.voteAverage.compareTo(a.voteAverage));
                      }
                      provider.updateSort(selected);
                      provider.updateFilteredTvShowsList(list);
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ).addMousePointer,
              );
            })
          ],
        );
      },
    );
  }
}
