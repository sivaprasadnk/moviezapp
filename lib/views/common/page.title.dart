import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.showLeadingIcon = false,
  });

  final String title;
  final bool showLeadingIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        if (!showLeadingIcon)
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
      ],
    );
  }
}
