import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';

class ActorsList extends StatelessWidget {
  const ActorsList({
    Key? key,
    this.size = 180,
    this.height = 260,
    required this.actorsList,
  }) : super(key: key);

  final double size;
  final double height;
  final List<Actor> actorsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + 10,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 30);
        },
        itemCount: actorsList.length,
        itemBuilder: (context, index) {
          var actor = actorsList[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              actor.profileUrl.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Dialogs.showLoader(context: context);
                        context.moviesProvider
                            .getActorDetails(actor.id)
                            .then((actorDetails) {
                          context.pop();
                          if (!context.isMobileApp) {
                            Dialogs.showActorDetailsDialog(
                              context,
                              actorDetails!,
                              size,
                              imageTag: actor.imageTag,
                              nameTag: actor.nameTag,
                            );
                          } else {
                            Dialogs.showActorDetailsDialogForApp(
                              context,
                              actorDetails!,
                              size,
                              imageTag: actor.imageTag,
                              nameTag: actor.nameTag,
                            );
                          }
                        });
                      },
                      child: Hero(
                        tag: actor.imageTag,
                        child: CustomCacheImage(
                          imageUrl: actor.profilePath,
                          borderRadius: size - 10,
                          height: size - 10,
                          width: size - 10,
                          cacheKey: actor.cacheKey,
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
                  tag: actor.nameTag,
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
    );
  }
}
