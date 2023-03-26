import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:provider/provider.dart';

class ContentSelectionWeb extends StatelessWidget {
  const ContentSelectionWeb({
    Key? key,
    this.clearSearch = false,
  }) : super(key: key);

  final bool clearSearch;

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.primaryColor;
    var whiteColor = Colors.white;
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      var selected = provider.selectedContentType;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              provider.updateContentType(Content.movie);
              if (clearSearch) {
                provider.clearSearchList();
              }
            },
            child: Container(
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                color: selected == Content.movie ? whiteColor : primaryColor,
                border: Border.all(
                  color: context.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'Movies',
                  style: TextStyle(
                    color:
                        selected != Content.movie ? whiteColor : primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ).addMousePointer,
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              provider.updateContentType(Content.tvShow);
            },
            child: Container(
              width: 90,
              height: 40,
              decoration: BoxDecoration(
                color: selected == Content.tvShow ? whiteColor : primaryColor,
                border: Border.all(
                  color: context.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'Tv Shows',
                  style: TextStyle(
                    color:
                        selected != Content.tvShow ? whiteColor : primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ).addMousePointer,
        ],
      );
    });
  }
}
