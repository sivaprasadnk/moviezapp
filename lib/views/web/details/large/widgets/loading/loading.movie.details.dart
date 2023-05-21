import 'package:flutter/material.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.movie.header.details.dart';

class LoadingMovieDetails extends StatelessWidget {
  const LoadingMovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          LoadingMovieHeaderDetails(),
          LoadingDetails(),
        ],
      ),
    );
  }
}
