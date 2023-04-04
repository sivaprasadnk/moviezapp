import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/auth/sign.in/sign.in.screen.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/page.title.dart';
import 'package:moviezapp/views/common/webview.screen.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/bookmark.list.menu.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.details.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.section.title.dart';
import 'package:provider/provider.dart';

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
            const SizedBox(height: 25),
            const ProfileSectionTitle(title: 'Theme'),
            const SizedBox(height: 15),
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
            const SizedBox(height: 25),
            // const ProfileSectionTitle(title: 'Account'),
            // const SizedBox(height: 15),
            // const ProfileMenuCard(
            //   title: 'Change Password',
            //   icon: Icons.lock,
            // ),
            // const SizedBox(height: 30),
            const ProfileSectionTitle(title: 'Others'),
            const SizedBox(height: 15),
            ProfileMenuCard(
              title: 'Privacy Policy & Terms',
              icon: Icons.policy,
              isImplemented: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(
                        url:
                            "https://sivaprasadnk.dev/moviez-app/privacy-policy/"),
                  ),
                );
              },
            ),
            // const SizedBox(height: 15),
            // ProfileMenuCard(
            //   title: 'Visit website',
            //   icon: Icons.bookmark,
            //   isImplemented: true,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => const WebViewScreen(
            //             url: "https://moviezapp-spverse.web.app/#/"),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 15),
            ProfileMenuCard(
              title: 'Credits',
              icon: Icons.info,
              isImplemented: true,
              onTap: () {
                Dialogs.showCreditsDialog(context);
              },
            ),
            const SizedBox(height: 15),
            ProfileMenuCard(
              title: 'About',
              icon: Icons.info,
              isImplemented: true,
              onTap: () {
                Dialogs.showVersionDialog(context);
              },
            ),
            const SizedBox(height: 30),
            !isGuest
                ? CommonButton(
                    callback: () {
                      provider.logout(context, context.appProvider.isMobileApp);
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
