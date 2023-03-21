import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Text("Sign In"),
    ).addMousePointer;
  }
}
