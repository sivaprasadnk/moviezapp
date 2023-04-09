import 'package:flutter/material.dart';
import 'package:moviezapp/repo/movie/region.list.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:provider/provider.dart';

import '../../../../provider/movies.provider.dart';

class RegionText extends StatelessWidget {
  const RegionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      var selected = provider.selectedRegion;
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Country :',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            selected,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              showListDialog(context, selected).then((value) {
                if (provider.updateData) {
                  provider.getMoviesList();
                  provider.getTvShowsList();
                  provider.updateDataStatus(false);
                }
              });
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 13,
            ),
          ).addMousePointer,
          const SizedBox(width: 10),
        ],
      );
    });
  }

  Future showListDialog(BuildContext context, String currentRegion) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        var selected = currentRegion;
        return AlertDialog(
          title: const SectionTitle(title: 'Select Country'),
          content: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              width: context.width * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: regionList.length,
                    itemBuilder: (context, index) {
                      var region = regionList[index];
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selected = region;
                          });
                        },
                        selected: region == selected,
                        selectedColor: Colors.green,
                        title: Text(region),
                        trailing: region == selected
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
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
                child: const Text('Cancel'),
              ).addMousePointer,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.moviesProvider.updateRegion(selected);
                  context.moviesProvider.updateDataStatus(true);

                  context.pop();
                },
                child: const Text('OK'),
              ).addMousePointer,
            )
          ],
        );
      },
    );
  }
}
