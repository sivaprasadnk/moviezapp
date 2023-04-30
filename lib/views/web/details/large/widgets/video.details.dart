import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/common/video.list.dart';
import 'package:provider/provider.dart';

class VideoDetails extends StatelessWidget {
  const VideoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!provider.videosLoading)
            if (provider.videoList.isNotEmpty)
              const SectionTitle(title: 'Related Videos'),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(
              seconds: 1,
            ),
            child: !provider.videosLoading
                ? const VideoList(
                    isWeb: true,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }
}
