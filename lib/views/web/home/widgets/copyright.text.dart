import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/home/widgets/made.with.flutter.text.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyrightText extends StatelessWidget {
  const CopyrightText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: 'Copyright © 2023 Sivaprasad NK. ',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'https://sivaprasadnk.dev/',
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        var link = 'https://sivaprasadnk.dev/';
                        launchUrl(
                          Uri.parse(link),
                          mode: LaunchMode.externalNonBrowserApplication,
                        );
                      },
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const MadeWithFlutterText(size: 15)
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
