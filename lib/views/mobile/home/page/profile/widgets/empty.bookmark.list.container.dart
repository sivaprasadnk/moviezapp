import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class EmptyBookmarkListContainer extends StatelessWidget {
  const EmptyBookmarkListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: context.height * 0.25,
          ),
          Icon(
            Icons.bookmark_outlined,
            color: context.primaryColor,
            size: 40,
          ),
          const SizedBox(height: 20),
          const Text(
            'Bookmark List is empty',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'After bookmarking movies and series, they are diaplayed here',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
