import 'package:flutter/material.dart';

class GenreDetails extends StatelessWidget {
  const GenreDetails({
    super.key,
    required this.releaseDate,
    required this.genreList,
    required this.duration,
  });

  final String releaseDate;
  final String genreList;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 30,
      left: 20,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            Text(
              releaseDate,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              genreList,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            if (duration.isNotEmpty)
              Text(
                duration,
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
