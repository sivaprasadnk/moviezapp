import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/web/home/widgets/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/web.drawer.dart';

class WebScaffold extends StatefulWidget {
  const WebScaffold({super.key, required this.body});

  final Widget body;

  @override
  State<WebScaffold> createState() => _WebScaffoldState();
}

class _WebScaffoldState extends State<WebScaffold> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!context.isChromeApp) {
        FirebaseAuth.instance.authStateChanges().listen((user) {
          if (mounted) {
            context.authProvider.updateGuestUser(user == null);
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: const TitleAppBar(),
      endDrawer: const WebDrawer(),
      body: widget.body,
    );
  }
}
