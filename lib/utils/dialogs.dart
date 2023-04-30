import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:moviezapp/model/actor.details.model.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/string.extensions.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/utils/string.constants.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    Dialogs.showLoader(context: context);
                    context.appProvider.updatedSelectedIndex(0);
                    context.authProvider.signInWithGoogle(context);
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
                              ' Sign in with your Gmail address',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
                    context.appProvider.updatedSelectedIndex(0);

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

  static showCreditsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: context.bgColor,
          title: Column(
            children: const [
              SectionTitle(
                title: 'Credits',
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
            ],
          ),
          content: Container(
            width: context.width * 0.2,
            color: context.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(kTmdbText),
                const SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/tmdb.svg',
                  height: 75,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(1, 180, 228, 1),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: context.highlightColor,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static showVersionDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: context.bgColor,
          title: Column(
            children: const [
              SectionTitle(
                title: 'Version',
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
            ],
          ),
          content: Container(
            width: context.width * 0.2,
            color: context.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.appProvider.version,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    context.pop();
                    await InAppUpdate.checkForUpdate().then((value) async {
                      if (value.updateAvailability ==
                          UpdateAvailability.updateAvailable) {
                        context.scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: const Text("Update available !"),
                            action: SnackBarAction(
                              label: 'Update',
                              onPressed: () async {
                                await InAppUpdate.performImmediateUpdate();
                              },
                            ),
                          ),
                        );
                        // await StoreRedirect.redirect();
                      } else {
                        context.scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text("No update available!"),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text(
                    "Check for update",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: context.highlightColor,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static showFeedbackDialog(BuildContext context, int currentRating) async {
    await showDialog(
      context: context,
      builder: (context) {
        int newRating = currentRating;
        return AlertDialog(
          title: const SectionTitle(
            title: 'Give Feedback !',
          ),
          content: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              width: context.width * 0.19,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  RatingBar.builder(
                    initialRating: currentRating.toDouble(),
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      context.userProvider.updateRating(rating.toInt());
                      if (rating > 3) {
                        if (context.isMobileApp) {
                          // StoreRedirect.redirect(
                          //   androidAppId: kPackageName,
                          // );
                        }
                      }
                      newRating = rating.toInt();
                      setState(() {});
                    },
                  ),

                  // if(newRating>3)
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
                  if (newRating > 3 && context.isMobileApp) {}
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ).addMousePointer,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       context.pop();
            //     },
            //     child: const Text(
            //       'Update',
            //       style: TextStyle(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ).addMousePointer,
            // ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }

  static showActorDetailsDialog(
    BuildContext context,
    ActorDetailsModel actor,
    double size, {
    required String imageTag,
    required String nameTag,
  }) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: false,
        barrierColor: Colors.black54,
        barrierDismissible: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: context.bgColor,
            title: Column(
              children: [
                Hero(
                  tag: nameTag,
                  child: SectionTitle(
                    title: actor.name!,
                  ),
                ),
                const Divider(
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
              ],
            ),
            content: Container(
              width: context.width * 0.75,
              color: context.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: actor.biography!.isNotEmpty
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (actor.profileUrl != null &&
                          actor.profileUrl!.isNotEmpty)
                        Hero(
                          tag: imageTag,
                          child: CustomCacheImage(
                            imageUrl: actor.profilePath!,
                            borderRadius: size - 10,
                            height: size - 10,
                            width: size - 10,
                            cacheKey: 'actor${actor.id}${actor.name}',
                          ),
                        ),
                      const SizedBox(width: 20),
                      if (actor.biography!.isNotEmpty)
                        Container(
                          width: context.width * 0.53,
                          // height: context.height * 0.4,
                          constraints: BoxConstraints(
                            maxHeight: context.height * 0.4,
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              actor.biography!,
                              maxLines: 53,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (actor.bday!.isNotEmpty)
                                RichText(
                                  text: TextSpan(
                                    text: "Birthday : ",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: actor.bday!.formatedDateString,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: context.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (actor.homepage!.isNotEmpty)
                                RichText(
                                  text: TextSpan(
                                    text: "\tWebsite : ",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: actor.homepage!,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrl(
                                                Uri.parse(actor.homepage!));
                                          },
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: context.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).addMousePointer,
                              // if (actor.placeOfBirth!.isNotEmpty)
                              //   RichText(
                              //     text: TextSpan(
                              //       text: "\tResidence : ",
                              //       style: const TextStyle(
                              //         color: Colors.grey,
                              //         fontWeight: FontWeight.normal,
                              //       ),
                              //       children: <TextSpan>[
                              //         TextSpan(
                              //           text: actor.placeOfBirth!,
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             color: context.primaryColor,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ).addMousePointer
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (actor.biography!.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (actor.bday!.isNotEmpty)
                          RichText(
                            text: TextSpan(
                              text: "Birthday : ",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: actor.bday!.formatedDateString,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: context.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (actor.homepage!.isNotEmpty)
                          RichText(
                            text: TextSpan(
                              text: "\tWebsite : ",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: actor.homepage!,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(actor.homepage!));
                                    },
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: context.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ).addMousePointer,
                        // if (actor.placeOfBirth!.isNotEmpty)
                        //   RichText(
                        //     text: TextSpan(
                        //       text: "\tResidence : ",
                        //       style: const TextStyle(
                        //         color: Colors.grey,
                        //         fontWeight: FontWeight.normal,
                        //       ),
                        //       children: <TextSpan>[
                        //         TextSpan(
                        //           text: actor.placeOfBirth!,
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             color: context.primaryColor,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ).addMousePointer
                      ],
                    ),
                ],
              ),
            ),
            actions: [
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: context.highlightColor,
                    ),
                  ),
                ),
              ).addMousePointer
            ],
          );
        },
      ),
    );
  }

  static showActorDetailsDialogForApp(
    BuildContext context,
    ActorDetailsModel actor,
    double size, {
    required String imageTag,
    required String nameTag,
  }) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: false,
        barrierColor: Colors.black54,
        barrierDismissible: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: context.bgColor,
            title: Column(
              children: [
                SectionTitle(
                  title: actor.name!,
                ),
                const Divider(
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
              ],
            ),
            content: Container(
              width: context.width * 0.75,
              color: context.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: imageTag,
                    child: CustomCacheImage(
                      imageUrl: actor.profilePath!,
                      borderRadius: size - 10,
                      height: size - 10,
                      width: size - 10,
                      cacheKey: 'actor${actor.id}${actor.name}',
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (actor.biography!.isNotEmpty)
                    SizedBox(
                      width: context.width * 0.83,
                      height: 200,
                      child: SingleChildScrollView(
                        child: Text(
                          actor.biography!,
                          maxLines: 53,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (actor.bday!.isNotEmpty)
                    RichText(
                      text: TextSpan(
                        text: "Birthday : ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: actor.bday!.formatedDateString,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (actor.homepage!.isNotEmpty)
                    RichText(
                      text: TextSpan(
                        text: "\tWebsite : ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: actor.homepage!,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(actor.homepage!));
                              },
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ).addMousePointer,
                  // if (actor.placeOfBirth!.isNotEmpty)
                  //   RichText(
                  //     text: TextSpan(
                  //       text: "Residence : ",
                  //       style: const TextStyle(
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //       children: <TextSpan>[
                  //         TextSpan(
                  //           text: actor.placeOfBirth!,
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: context.primaryColor,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ).addMousePointer
                ],
              ),
            ),
            actions: [
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: context.highlightColor,
                    ),
                  ),
                ),
              ).addMousePointer
            ],
          );
        },
      ),
    );
  }

  static showUpdateAvailableDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: context.bgColor,
          title: Column(
            children: const [
              SectionTitle(
                title: 'Alert !',
              ),
              Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
            ],
          ),
          content: Container(
            width: context.width * 0.2,
            color: context.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 20),
                Text('New update available !'),
              ],
            ),
          ),
          actions: [
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                  window.location.reload();
                },
                child: Text(
                  'Update Now',
                  style: TextStyle(
                    color: context.highlightColor,
                  ),
                ),
              ).addMousePointer,
            )
          ],
        );
      },
    );
  }
}
