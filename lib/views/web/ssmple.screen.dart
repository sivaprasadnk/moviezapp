import 'package:flutter/material.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/views/web/home/widgets/web.scaffold.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});
  static const routeName = "/sample/";

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  bool isreloaded = false;

  @override
  void initState() {
    super.initState();
    html.window.onBeforeUnload.listen((event) {
      if (mounted) {
        var provider = Provider.of<AppProvider>(context, listen: false);
        provider.updateIsreloaded(true);
        // setState(() {
        //   isreloaded = true;
        // });
        debugPrint('@ isreloaded : ${provider.isReloaded}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (_, provdier, __) {
      debugPrint('@@ isreloaded : ${provdier.isReloaded}');
      return WillPopScope(
        onWillPop: () async {
          debugPrint('@@@ isreloaded : ${provdier.isReloaded}');
          return !provdier.isReloaded;
        },
        child: const WebScaffold(
          body: Center(
            child: Text("Sample"),
          ),
        ),
      );
    });
  }
}
