import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/search/search.screen.web.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.moviesProvider.clearSearchList();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const SearchScreenWeb();
            },
          ),
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
              border: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                ),
              )),
        ),
      ),
    );
  }
}
