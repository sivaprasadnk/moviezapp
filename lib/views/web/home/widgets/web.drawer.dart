import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/utils/string.constants.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/bookmark.list.menu.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';
import 'package:provider/provider.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.authProvider;
    var isGuest = provider.isGuestUser;

    var name = 'Username';
    var user = FirebaseAuth.instance.currentUser;
    if (!isGuest) {
      name = user!.displayName!;
    }
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ).addMousePointer,
            const SizedBox(height: 10),
            !isGuest
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user!.email!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (user.photoURL != null && user.photoURL!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            user.photoURL!,
                            height: 45,
                            width: 45,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                    ],
                  )
                : const Text(
                    'Hi, Guest!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            const SizedBox(height: 38),
            BookmarkListMenu(isGuest: isGuest),
            const SizedBox(height: 12),
            Consumer<AppProvider>(builder: (_, provider, __) {
              var isDark = provider.selectedBrightness == Brightness.dark;
              var title = 'Switch to Dark theme';
              var icon = Icons.dark_mode;
              if (isDark) {
                title = "Switch to Light theme";
                icon = Icons.light_mode;
              }
              return ProfileMenuCard(
                title: title,
                icon: icon,
                onTap: () {
                  provider.toggleBrightness();
                },
                showtrailing: false,
                isImplemented: true,
              );
            }),
            const SizedBox(height: 12),
            ProfileMenuCard(
              title: 'Get app',
              icon: Icons.android,
              isImplemented: true,
              onTap: () {
                showAppLink(context);
              },
            ),
            const SizedBox(height: 12),
            ProfileMenuCard(
              title: 'Privacy Policy & Terms',
              icon: Icons.policy,
              isImplemented: true,
              onTap: () {
                var url = 'https://sivaprasadnk.dev/moviez-app/privacy-policy/';
                context.openInNewTab(url);
              },
            ),
            const Spacer(),
            if (!isGuest)
              CommonButton(
                callback: () {
                  context.authProvider
                      .logout(context, context.isMobileApp);
                },
                title: 'Sign Out',
              ).addMousePointer
          ],
        ),
      ),
    );
  }

  showAppLink(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const SectionTitle(
            title: 'Get App',
          ),
          content: SizedBox(
            width: context.width * 0.19,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                const Text('Scan'),
                const SizedBox(height: 12),
                Image.asset(
                  'assets/qrcode.png',
                  height: 160,
                  width: 160,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('OR'),
                    const SizedBox(width: 10),
                    Container(
                      height: 1,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.openInNewTab(kPlayStoreLink);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/google-play.png',
                          height: 40,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "GET IT ON",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "Google Play",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ).addMousePointer
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ).addMousePointer,
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
