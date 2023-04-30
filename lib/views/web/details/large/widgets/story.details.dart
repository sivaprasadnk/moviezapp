import 'package:flutter/material.dart';
import 'package:moviezapp/views/common/section.title.dart';

class OverviewDetails extends StatelessWidget {
  const OverviewDetails({super.key, required this.overview});

  final String overview;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (overview.isNotEmpty) const SectionTitle(title: 'Story'),
        if (overview.isNotEmpty) const SizedBox(height: 20),
        if (overview.isNotEmpty) Text(overview),
      ],
    );
  }
}
