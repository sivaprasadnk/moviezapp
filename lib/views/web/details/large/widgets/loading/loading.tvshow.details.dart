import 'package:flutter/material.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.details.dart';
import 'package:moviezapp/views/web/details/large/widgets/loading/loading.tvshow.header.details.dart';

class LoadingTvShowDetails extends StatelessWidget {
  const LoadingTvShowDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          LoadingTvShowHeaderDetails(),
          LoadingDetails(),
        ],
      ),
    );
  }
}
