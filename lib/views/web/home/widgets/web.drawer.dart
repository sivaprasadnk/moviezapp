import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/repo/movie/region.list.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/utils/string.constants.dart';
import 'package:moviezapp/views/common/bookmark.list.menu.dart';
import 'package:moviezapp/views/common/common.button.dart';
import 'package:moviezapp/views/common/google.playstore.button.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:moviezapp/views/mobile/home/page/profile/widgets/profile.menu.card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const IconData globe = IconData(0xe800, fontFamily: 'world');
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AuthProvider>(builder: (_, provider, __) {
          var isGuest = provider.isGuestUser;

          // var name = 'Username';
          // var user = FirebaseAuth.instance.currentUser;
          // if (!isGuest) {
          //   name = user!.displayName!;
          // }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
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
                              FirebaseAuth.instance.currentUser!.displayName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              FirebaseAuth.instance.currentUser!.email!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (FirebaseAuth.instance.currentUser!.photoURL !=
                                null &&
                            FirebaseAuth
                                .instance.currentUser!.photoURL!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              FirebaseAuth.instance.currentUser!.photoURL!,
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
              const BookmarkListMenu(),
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
                title: 'Go to website',
                icon: Icons.launch,
                isImplemented: true,
                onTap: () async {
                  await launchUrl(Uri.parse(kWebsiteLink));
                },
              ),
              const SizedBox(height: 12),
              ProfileMenuCard(
                title: 'Give Feedback',
                icon: Icons.rate_review,
                isImplemented: true,
                onTap: () {
                  if (isGuest) {
                    context.showErrorToast('Login to give Feedback!');
                  } else {
                    context.userProvider.getRating().then((value) {
                      Dialogs.showFeedbackDialog(context, value);
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              ProfileMenuCard(
                title: 'Privacy Policy & Terms',
                icon: Icons.policy,
                isImplemented: true,
                onTap: () {
                  launchUrl(Uri.parse(kPrivacyPolicyUrl));
                },
              ),
              const SizedBox(height: 12),
              ProfileMenuCard(
                title: 'Change Country',
                icon: globe,
                isImplemented: true,
                onTap: () {
                  var provider = context.moviesProvider;
                  showListDialog(context, provider.selectedRegion)
                      .then((value) {
                    if (provider.updateData) {
                      Future.wait([provider.getMoviesList()]);
                      provider.updateDataStatus(false);
                    }
                  });
                },
              ),
              const SizedBox(height: 12),

              ProfileMenuCard(
                title: 'Credits',
                icon: Icons.info,
                isImplemented: true,
                onTap: () {
                  Dialogs.showCreditsDialog(context);
                },
              ),
              const Spacer(),
              if (!isGuest)
                CommonButton(
                  callback: () {
                    context.pop();
                    context.authProvider.logout(context);
                  },
                  title: 'Sign Out',
                ),
              // if (isGuest)
              //   CommonButton(
              //     callback: () {
              //       context.pop();
              //       context.authProvider.signInWithFb(context);
              //     },
              //     title: 'Sign In with Facebook',
              //   ),
              // const SizedBox(height: 12),

              if (isGuest)
                CommonButton(
                  callback: () {
                    if (context.isChromeApp) {
                      context.showErrorToast('Use website / app to continue');
                    } else {
                      context.pop();
                      context.authProvider.signInWithGoogle(context);
                    }
                  },
                  title: 'Sign In with Google',
                ),
              const SizedBox(height: 12),

              // GestureDetector(
              //   onTap: () {
              //     // Dialogs.showLoader(context: context);
              //     context.authProvider
              //         .signInWithGoogle(context)
              //         .then((value) {
              //       // context.pop();
              //     });
              //   },
              //   child: const Text("Sign In"),
              // ).addMousePointer,
            ],
          );
        }),
      ),
    );
  }

  Future showListDialog(BuildContext context, String currentRegion) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        var selected = currentRegion;
        return AlertDialog(
          title: const SectionTitle(title: 'Select Country'),
          content: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              width: context.width * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: regionList.length,
                    itemBuilder: (context, index) {
                      var region = regionList[index];
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selected = region;
                          });
                        },
                        selected: region == selected,
                        selectedColor: Colors.green,
                        title: Text(region),
                        trailing: region == selected
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : null,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Text('Cancel'),
              ).addMousePointer,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.moviesProvider.updateRegion(selected);
                  context.moviesProvider.updateDataStatus(true);

                  context.pop();
                },
                child: const Text('OK'),
              ).addMousePointer,
            )
          ],
        );
      },
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
                GooglePlaystoreButton(
                  onTap: () {
                    launchUrl(Uri.parse(kPlayStoreLink));
                  },
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
