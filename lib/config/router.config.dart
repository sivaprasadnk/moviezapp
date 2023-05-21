// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:moviezapp/model/movie.complete.details.model.dart';
// import 'package:moviezapp/views/web/details/movie.details.screen.web.dart';
// import 'package:moviezapp/views/web/home/home.screen.web.dart';

// final routerConfig = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       name: HomeScreenWeb.routeName,
//       builder: (context, state) => const HomeScreenWeb(),
//     ),
//     GoRoute(
//       path: '/movie/:movieId',
//       name: MovieDetailsScreenWeb.routeName,
//       pageBuilder: (context, state) {
//         final movie = state.extra as MovieCompleteDetailsModel;

//         return MaterialPage(
//           child: MovieDetailsScreenWeb(
//             movie: movie,
//           ),
//         );
//       },
//     ),
//   ],
// );
