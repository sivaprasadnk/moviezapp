// import 'package:flutter/material.dart';
// import 'package:moviezapp/model/genre.model.dart';
// import 'package:moviezapp/model/movie.details.dart';
// import 'package:moviezapp/provider/movies.provider.dart';
// import 'package:moviezapp/utils/extensions/build.context.extension.dart';
// import 'package:moviezapp/utils/extensions/int.extensions.dart';
// import 'package:moviezapp/utils/extensions/string.extensions.dart';
// import 'package:moviezapp/views/common/bookmark.button.dart';
// import 'package:moviezapp/views/common/section.title.dart';
// import 'package:moviezapp/views/common/social.media.links.dart';
// import 'package:moviezapp/views/web/details/large/widgets/play.trailer.text.button.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MovieDetailsContainer extends StatelessWidget {
//   const MovieDetailsContainer({
//     super.key,
//     required this.movie,
//     required this.isBookmarked,
//     required this.trailerAvailable,
//   });

//   final MovieDetails movie;
//   final bool isBookmarked;
//   final bool trailerAvailable;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned.fill(
//       left: context.width * 0.1 + 335,
//       // top: 20,
//       bottom: 20,
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               movie.title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   movie.genreList.stringText,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 if (movie.runtime > 0)
//                   Container(
//                     height: 5,
//                     width: 5,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                   ),
//                 if (movie.runtime > 0) const SizedBox(width: 8),
//                 if (movie.runtime > 0)
//                   Text(
//                     movie.runtime.durationInHrs,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                 const SizedBox(width: 8),
//                 if (movie.releaseDate.isNotEmpty)
//                   Container(
//                     height: 5,
//                     width: 5,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                   ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//             const SizedBox(height: 20),

//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.star_rounded,
//                   color: Colors.red.shade500,
//                   size: 40,
//                 ),
//                 const SizedBox(width: 5),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "${((movie.voteAverage) * 10).ceilToDouble()}/ 100",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       "${movie.voteCount} votes",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                         color: Colors.white.withOpacity(0.6),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // const PlayTrailerTextButton(
//             //   isMobile: false,
//             // ),
//             // const SizedBox(height: 50),

//             // const Spacer(),
//             if (trailerAvailable)
//               const PlayTrailerTextButton(
//                 isMobile: false,
//               )
//             else
//               const SizedBox(
//                 height: 45,
//                 width: 242,
//               ),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 BookMarkButton(
//                   movie: movie,
//                   width: context.width * 0.2,
//                   isBookmarked: isBookmarked,
//                 ),
//                 // const SizedBox(width: 15),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     showDetailsDialog(movie, context);
//                 //   },
//                 //   child: const Icon(
//                 //     Icons.info,
//                 //     size: 30,
//                 //     color: Colors.red,
//                 //   ),
//                 // ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             // if (movie.homepage.isNotEmpty)
//             //   GestureDetector(
//             //     onTap: () async {
//             //       try {
//             //         if (await canLaunchUrl(Uri.parse(movie.homepage))) {
//             //           launchUrl(Uri.parse(movie.homepage));
//             //         }
//             //       } catch (err) {
//             //         context.showSnackbar('Cannot launch url!');
//             //       }
//             //     },
//             //     child: Text(
//             //       movie.homepage,
//             //       style: const TextStyle(
//             //         fontWeight: FontWeight.w600,
//             //         fontSize: 15,
//             //         color: Colors.white,
//             //         decoration: TextDecoration.underline,
//             //       ),
//             //     ),
//             //   ).addMousePointer,
//             // if (movie.homepage.isNotEmpty) const SizedBox(height: 20),
//             // Consumer<MoviesProvider>(
//             //   builder: (_, provider, __) {
//             //     var social = provider.socialMediaModel;
//             //     return social.isLoading
//             //         ? const SizedBox.shrink()
//             //         : SocialMediaLinks(model: social);
//             //   },
//             // ),
//             // const SizedBox(height: 20),
//             // const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }

//   showDetailsDialog(MovieDetails movie, BuildContext context) async {
//     await showDialog(
//       context: context,
//       barrierColor: Colors.black87,
//       builder: (_) {
//         return AlertDialog(
//           insetPadding: EdgeInsets.zero,
//           // backgroundColor: context.bgColor,
//           title: Column(
//             children: const [
//               SectionTitle(
//                 title: 'More details',
//               ),
//               Divider(
//                 indent: 0,
//                 endIndent: 0,
//                 color: Colors.black,
//               ),
//             ],
//           ),
//           content: Container(
//             width: context.width * 0.2,
//             color: context.bgColor,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (movie.releaseDate.isNotEmpty)
//                   Text(
//                     "Release Date : ${movie.releaseDate.formatedDateString}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                       color: context.highlightColor.withOpacity(0.6),
//                     ),
//                   ),
//                 if (movie.releaseDate.isNotEmpty) const SizedBox(height: 25),
//                 if (movie.language.isNotEmpty)
//                   Text(
//                     "Language : ${movie.language}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                       color: context.highlightColor.withOpacity(0.6),
//                     ),
//                   ),
//                 if (movie.language.isNotEmpty) const SizedBox(height: 25),
//                 if (movie.homepage.isNotEmpty)
//                   Text(
//                     'Website :',
//                     style: TextStyle(
//                       color: context.highlightColor.withOpacity(0.6),
//                     ),
//                   ),
//                 if (movie.homepage.isNotEmpty) const SizedBox(height: 5),
//                 if (movie.homepage.isNotEmpty)
//                   GestureDetector(
//                     onTap: () async {
//                       try {
//                         if (await canLaunchUrl(Uri.parse(movie.homepage))) {
//                           launchUrl(Uri.parse(movie.homepage));
//                         }
//                       } catch (err) {
//                         context.showSnackbar('Cannot launch Url !');
//                       }
//                     },
//                     child: Text(
//                       movie.homepage,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                         color: context.highlightColor.withOpacity(0.6),
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 if (movie.homepage.isNotEmpty) const SizedBox(height: 25),
//                 Consumer<MoviesProvider>(
//                   builder: (_, provider, __) {
//                     var social = provider.socialMediaModel;
//                     return social.isLoading
//                         ? const SizedBox.shrink()
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Follow on :',
//                                 style: TextStyle(
//                                   color:
//                                       context.highlightColor.withOpacity(0.6),
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               SocialMediaLinks(
//                                 model: social,
//                                 isMobile: true,
//                               ),
//                             ],
//                           );
//                   },
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//           actions: [
//             const SizedBox(width: 10),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: GestureDetector(
//                 onTap: () {
//                   context.pop();
//                 },
//                 child: Text(
//                   'Close',
//                   style: TextStyle(
//                     color: context.highlightColor,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
