import 'package:flutter/material.dart';

class MovieRatingDetailsMobile extends StatelessWidget {
  const MovieRatingDetailsMobile({
    super.key,
    required this.voteAverage,
    required this.voteCount,
  });

  final double voteAverage;
  final String voteCount;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 10,
      left: 20,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              ((voteAverage * 10).ceilToDouble()).toInt().toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "( $voteCount )",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
