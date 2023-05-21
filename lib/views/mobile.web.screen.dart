import 'package:flutter/material.dart';
import 'package:moviezapp/repo/app/app.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import 'common/google.playstore.button.dart';

class MobileWebScreen extends StatefulWidget {
  const MobileWebScreen({super.key});

  @override
  State<MobileWebScreen> createState() => _MobileWebScreenState();
}

class _MobileWebScreenState extends State<MobileWebScreen> {
  String error = "";
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      PackageInfo.fromPlatform().then((packageInfo) {
        var currentVersion = int.parse(packageInfo.buildNumber);
        if (context.mounted) {
          AppRepo.getVersionFromDb().then((version) {
            var versionFromWeb = int.parse(version);
            setState(() {});
            if (versionFromWeb > currentVersion) {
              html.window.location.reload();
              context.showSnackbar('new version available !');
            }
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('MoviezApp is best when viewed as app '),
          ),
          const SizedBox(height: 50),
          Center(
            child: GooglePlaystoreButton(
              onTap: () async {
                var link = 'https://spverse.page.link/TG78';

                try {
                  launchUrl(
                    Uri.parse(link),
                    mode: LaunchMode.externalNonBrowserApplication,
                  );
                } catch (err) {
                  if (context.mounted) {
                    context.showSnackbar('Cannot launch url $link');
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
