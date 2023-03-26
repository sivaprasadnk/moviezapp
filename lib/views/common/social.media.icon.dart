import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({
    super.key,
    required this.link,
    required this.icon,
    this.isMobile = false,
  });

  final String link;
  final IconData icon;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    var color =
        isMobile ? context.highlightColor.withOpacity(0.6) : Colors.white;
    
    double size = 25;
    return GestureDetector(
      onTap: () async {
        if (kIsWeb) {
          // html.window.open(link, 'new tab');
        } else {
          try {
            if (await canLaunchUrl(Uri.parse(link))) {
              await launchUrl(Uri.parse(link));
            } else {
              if (context.mounted) {
                context.scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("Failed to launch $link")));
              }
            }
          } catch (err) {
            context.scaffoldMessenger.showSnackBar(
                SnackBar(content: Text("Failed to launch $link")));
          }
        }
      },
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    ).addMousePointer;
  }
}
