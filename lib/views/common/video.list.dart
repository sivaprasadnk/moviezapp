import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/mobile/home/page/movie.list/video.player.screen.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoList extends StatefulWidget {
  const VideoList({
    super.key,
    this.isWeb = false,
  });
  final bool isWeb;

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    IconData youtube =
        const IconData(0xf167, fontFamily: 'youtube', fontPackage: null);
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.videoList.isNotEmpty
            ? SizedBox(
                height: 250,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 20);
                  },
                  itemCount: provider.videoList.length,
                  itemBuilder: (context, index) {
                    var video = provider.videoList[index];

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (widget.isWeb) {
                              playVideo(video.key, video.name, context);
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return VideoPlayerScreen(videoId: video.key);
                              }));
                            }
                          },
                          child: Stack(
                            children: [
                              CustomCacheImage(
                                imageUrl: video.thumbnail,
                                // 'https://images.unsplash.com/photo-1579353977828-2a4eab540b9a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                                borderRadius: 10,
                                height: 200,
                                width: 250,
                                cacheKey: 'video${video.id}${video.key}',
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    youtube,
                                    color: Colors.red,
                                    size: 75,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ).addMousePointer,
                        const SizedBox(height: 8),
                        Flexible(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              video.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  playVideo(String videoId, String title, BuildContext context) async {
    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: YoutubePlayer(
                  controller: controller,
                  // aspectRatio: 4 / 3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
