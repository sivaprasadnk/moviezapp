import 'package:animate_on_hover/animate_on_hover.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';

class CrewList extends StatelessWidget {
  const CrewList({
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
        return provider.crewList.isNotEmpty
            ? SizedBox(
                height: height + 10,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 30);
                  },
                  itemCount: provider.crewList.length,
                  itemBuilder: (context, index) {
                    var crew = provider.crewList[index];
                    var imageTag = "crewimage_${crew.name}_${crew.job}";
                    var nameTag = "crewname_${crew.name}_${crew.job}";
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        crew.profileUrl.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Dialogs.showLoader(context: context);
                                  provider
                                      .getActorDetails(crew.id)
                                      .then((actor) {
                                    context.pop();
                                    if (!context.isMobileApp) {
                                      Dialogs.showActorDetailsDialog(
                                        context,
                                        actor!,
                                        size,
                                        imageTag: imageTag,
                                        nameTag: nameTag,
                                      );
                                    } else {
                                      Dialogs.showActorDetailsDialogForApp(
                                        context,
                                        actor!,
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
                                    imageUrl: crew.profilePath,
                                    borderRadius: size - 10,
                                    height: size - 10,
                                    width: size - 10,
                                    cacheKey: 'crew_${crew.id}${crew.name}',
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
                              crew.name,
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
                            crew.job,
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
