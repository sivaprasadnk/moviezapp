import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';
import 'package:moviezapp/views/mobile/splash.screen/splash.screen.scaffold.dart';

class SplashScreenMobile extends StatefulWidget {
  const SplashScreenMobile({super.key});
  static const routeName = "/splash";

  @override
  State<SplashScreenMobile> createState() => _SplashScreenStateMobile();
}

class _SplashScreenStateMobile extends State<SplashScreenMobile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      debugPrint('@@@@ hereeeeeeeeeeeeeeeeeee');
      context.appProvider.updateMobileApp(true);
      context.appProvider.updateMobileWeb(false);
      context.moviesProvider.updateDataStatus(true);
      if (FirebaseAuth.instance.currentUser == null) {
        await Dialogs.showGetStartedDialog(context);
      } else {
        // context.authProvider.updateGuestUser(false);
        context.moviesProvider.updateDataStatus(true);
        context.appProvider.updatedSelectedIndex(0);
        Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: const SplashScreenScaffold(),
    );
  }
}
