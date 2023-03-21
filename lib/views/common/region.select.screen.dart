import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/repo/movie/region.list.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:provider/provider.dart';

class RegionSelectScreenMobile extends StatelessWidget {
  const RegionSelectScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SectionTitle(title: 'Select Country'),
                const SizedBox(height: 20),
                Consumer<MoviesProvider>(
                  builder: (_, provider, __) {
                    var selected = provider.selectedRegion;
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: regionList.length,
                      itemBuilder: (context, index) {
                        var region = regionList[index];
                        return ListTile(
                          onTap: () {
                            provider.updateRegion(region);
                          },
                          selected: region == selected,
                          selectedColor: Colors.green,
                          title: Text(region),
                          trailing: region == selected
                              ? const Icon(
                                  Icons.check,
                                )
                              : null,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                // const Spacer(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: CommonButton(
            callback: () {
              context.moviesProvider.updateDataStatus(true);
              context.moviesProvider.getMoviesList();
              context.moviesProvider.getTvShowsList();
              context.moviesProvider.updateDataStatus(false);

              context.goHome();
            },
            title: 'Save and Continue',
          ),
        ),
      ),
    );
  }
}
