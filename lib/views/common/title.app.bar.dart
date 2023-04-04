import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:moviezapp/views/web/home/widgets/sign.in.button.dart';
import 'package:moviezapp/views/web/home/widgets/user.name.container.dart';

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobileWeb = context.appProvider.isMobileApp;
    var user = FirebaseAuth.instance.currentUser;
    return AppBar(
      elevation: 0,
      backgroundColor: context.primaryColor,
      automaticallyImplyLeading: false,
      title: !isMobileWeb
          ? GestureDetector(
              onTap: () {
                context.moviesProvider.updateCarousalIndex(0);
                context.moviesProvider.updateDataStatus(false);
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreenWeb.routeName, (route) => false);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "MoviezApp",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ).addMousePointer,
            )
          : const SizedBox.shrink(),
      actions: [
        if (user == null)
          const Center(
          child: SigninButton(),
          )
        else
          const Center(
            child: UserNameContainerWeb(),
          ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
