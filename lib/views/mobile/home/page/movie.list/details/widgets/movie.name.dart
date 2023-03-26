import 'package:flutter/material.dart';

class MovieName extends StatelessWidget {
  const MovieName({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 50,
      left: 20,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          name,
          maxLines: 3,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
