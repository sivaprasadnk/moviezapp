import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.3,
      child: Center(
        child: Text(message),
      ),
    );
  }
}
