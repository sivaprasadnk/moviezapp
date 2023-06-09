import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/search/search.screen.web.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var label = ' Search movies here ..';
    if (context.width < 935) {
      label = "Search here ...";
    }
    debugPrint('width : ${context.width}');
    return GestureDetector(
      onTap: () {
        context.moviesProvider.clearSearchList();
        Navigator.pushNamed(
          context,
          SearchScreenWeb.routeName,
        );
      },
      child: Container(
        width: context.width * 0.3,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            label: Text(label),
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
