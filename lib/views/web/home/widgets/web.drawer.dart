
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/bookmark.list.menu.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';
import 'package:provider/provider.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var name = 'Username';
    var provider = context.authProvider;
    var isGuest = provider.isGuestUser;
    if (user!.displayName != null) {
      name = user.displayName!;
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
            Row(
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
                      user.email!,
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
                var url =
                    'https://play.google.com/store/apps/details?id=com.spverse.moviezapp';
                context.openInNewTab(url);
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
            CommonButton(
              callback: () {
                context.authProvider
                    .logout(context, context.appProvider.isMobileApp);
              },
              title: 'Sign Out',
            ).addMousePointer
          ],
        ),
      ),
    );
  }
}
