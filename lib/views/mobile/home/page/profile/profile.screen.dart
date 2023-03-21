import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/auth/sign.in/sign.in.screen.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/page.title.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/bookmark.list.menu.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.details.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.section.title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = context.authProvider;
    var isGuest = provider.isGuestUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(title: 'Profile'),
            const SizedBox(height: 25),
            ProfileDetails(isGuest: isGuest),
            const SizedBox(height: 30),
            const ProfileSectionTitle(title: 'Your Activities'),
            const SizedBox(height: 15),
            BookmarkListMenu(isGuest: isGuest),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Reviews',
              icon: Icons.message,
              isCountItem: true,
              count: 15,
            ),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'History',
              icon: Icons.play_arrow_rounded,
            ),
            const SizedBox(height: 25),
            const ProfileSectionTitle(title: 'Theme'),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Switch to Dark theme',
              icon: Icons.dark_mode,
              showtrailing: false,
            ),
            const SizedBox(height: 25),
            const ProfileSectionTitle(title: 'Account'),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Settings',
              icon: Icons.settings,
            ),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'My Subscription Plan',
              icon: Icons.money,
            ),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Change Password',
              icon: Icons.lock,
            ),
            const SizedBox(height: 30),
            !isGuest
                ? CommonButton(
                    callback: () {
                      provider.logout(context);
                    },
                    title: 'Sign Out',
                  )
                : CommonButton(
                    callback: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignInScreen.routeName, (route) => false);
                    },
                    title: 'Sign In',
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
