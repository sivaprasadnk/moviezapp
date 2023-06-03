import 'package:flutter/material.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:moviezapp/views/web/home/widgets/app.bar.menu.dart';
import 'package:moviezapp/views/web/home/widgets/sign.in.button.dart';
import 'package:moviezapp/views/web/home/widgets/user.name.container.dart';
import 'package:provider/provider.dart';

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.primaryColor,
      automaticallyImplyLeading: false,
      title: GestureDetector(
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
      ),
      actions: [
        Consumer<AuthProvider>(builder: (_, provider, __) {
          var isGuest = provider.isGuestUser;
          return Center(
            child:
                isGuest ? const SigninButton() : const UserNameContainerWeb(),
          );
        }),
        const SizedBox(width: 20),
        const AppbarMenu(),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
