import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';

class ActorsList extends StatelessWidget {
  const ActorsList({
    Key? key,
    this.size = 180,
    this.height = 260,
  }) : super(key: key);

  final double size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.actorsList.isNotEmpty
            ? SizedBox(
                height: height + 10,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 30);
                  },
                  itemCount: provider.actorsList.length,
                  itemBuilder: (context, index) {
                    var actor = provider.actorsList[index];
                    var imageTag =
                        "actorimage_${actor.name}_${actor.character}";
                    var nameTag = "actorname_${actor.name}_${actor.character}";
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        actor.profileUrl.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Dialogs.showLoader(context: context);
                                  provider
                                      .getActorDetails(actor.id)
                                      .then((actorDetails) {
                                    context.pop();
                                    if (!context.isMobileApp) {
                                      Dialogs.showActorDetailsDialog(
                                        context,
                                        actorDetails!,
                                        size,
                                        imageTag: imageTag,
                                        nameTag: nameTag,
                                      );
                                    } else {
                                      Dialogs.showActorDetailsDialogForApp(
                                        context,
                                        actorDetails!,
                                        size,
                                        imageTag: imageTag,
                                        nameTag: nameTag,
                                      );
                                    }
                                  });
                                },
                                child: Hero(
                                  tag: imageTag,
                                  child: CustomCacheImage(
                                    imageUrl: actor.profilePath,
                                    borderRadius: size - 10,
                                    height: size - 10,
                                    width: size - 10,
                                    cacheKey: 'actor${actor.id}${actor.name}',
                                  ),
                                ),
                              ).increaseSizeOnHover(1.3)
                            : Container(
                                height: size - 10,
                                width: size - 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    size: size - 90,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: size - 20,
                          child: Hero(
                            tag: nameTag,
                            child: Text(
                              actor.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 80,
                          child: Text(
                            actor.character,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
