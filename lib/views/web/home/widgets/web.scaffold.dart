import 'package:flutter/material.dart';
import 'package:moviezapp/views/common/title.app.bar.dart';
import 'package:moviezapp/views/web/home/widgets/web.drawer.dart';

class WebScaffold extends StatelessWidget {
  const WebScaffold({super.key, required this.body});

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: const TitleAppBar(),
      endDrawer: const WebDrawer(),
      body: body,
    );
  }
}
