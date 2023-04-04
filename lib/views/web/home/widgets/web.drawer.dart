import 'dart:html' as html;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var name = 'Username';
    if (user!.displayName != null) {
      name = user.displayName!;
    }
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            const SizedBox(height: 8),
            ProfileMenuCard(
              title: 'Get app',
              icon: Icons.android,
              isImplemented: true,
              onTap: () {
                html.window.open(
                  'https://play.google.com/store/apps/details?id=com.spverse.moviezapp',
                  'new tab',
                );
              },
            ),
            const Spacer(),
            CommonButton(
              callback: () {
                context.authProvider
                    .logout(context, context.appProvider.isMobileApp);
              },
              title: 'Sign Out',
            )
          ],
        ),
      ),
    );
  }
}
