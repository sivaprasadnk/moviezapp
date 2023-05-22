import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/string.constants.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/page.title.dart';
import 'package:moviezapp/views/common/region.select.screen.dart';
import 'package:moviezapp/views/common/webview.screen.dart';
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
    var isGuest = context.isGuestUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(title: 'Profile'),
            const SizedBox(height: 25),
            const ProfileDetails(),
            const SizedBox(height: 30),
            // const ProfileSectionTitle(title: 'Your Activities'),
            // const SizedBox(height: 15),
            // const BookmarkListMenu(),
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
                  // var link = await DynamicLinks.generateLink();
                  // debugPrint('link : $link');
                  // if (context.mounted) {
                  //   context.showSnackbar(link);
                  // }
                  provider.toggleBrightness();
                },
                showtrailing: false,
                isImplemented: true,
              );
            }),
            const SizedBox(height: 25),
            const ProfileSectionTitle(title: 'Others'),
            const SizedBox(height: 15),
            ProfileMenuCard(
              title: 'Give Feedback',
              icon: Icons.rate_review,
              isImplemented: true,
              onTap: () {
                if (isGuest) {
                  context.showErrorToast('Login to give Feedback!');
                } else {
                  Dialogs.showLoader(context: context);
                  context.userProvider.getRating().then((value) {
                    context.pop();
                    Dialogs.showFeedbackDialog(context, value);
                  });
                }
              },
            ),
            const SizedBox(height: 15),
            ProfileMenuCard(
              title: 'Privacy Policy & Terms',
              icon: Icons.policy,
              isImplemented: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WebViewScreen(url: kPrivacyPolicyUrl),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            ProfileMenuCard(
              title: 'Settings',
              icon: Icons.settings,
              isImplemented: true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const RegionSelectScreenMobile();
                }));
              },
            ),
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
              title: 'Check for update',
              icon: Icons.update,
              isImplemented: true,
              onTap: () async {
                await InAppUpdate.checkForUpdate().then((value) async {
                  if (value.updateAvailability ==
                      UpdateAvailability.updateAvailable) {
                    context.scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: const Text("Update available !"),
                        action: SnackBarAction(
                          label: 'Update',
                          onPressed: () async {
                            await InAppUpdate.performImmediateUpdate();
                          },
                        ),
                      ),
                    );
                    // await StoreRedirect.redirect();
                  } else {
                    context.scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text("No update available!"),
                      ),
                    );
                  }
                });
                // Dialogs.showVersionDialog(context);
              },
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                "Version : ${context.appProvider.version}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            !isGuest
                ? CommonButton(
                    callback: () {
                      context.authProvider.logout(context);
                    },
                    title: 'Sign Out',
                  )
                : CommonButton(
                    callback: () {
                      Dialogs.showLoader(context: context);

                      context.authProvider.signInWithGoogle(context);
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
