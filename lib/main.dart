import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/app/chrome.app.dart';
import 'package:moviezapp/app/mobile.app.dart';
import 'package:moviezapp/app/web.app.dart';
import 'package:moviezapp/firebase_options.dart';
import 'package:universal_html/js.dart' as js;
//  flutter run -d chrome --web-renderer html --web-hostname localhost --web-port 5000
//  flutter build web --web-renderer html --csp
//  flutter build web --web-renderer html --release

//  https://moviezapp-spverse.web.app/

/*
https://api.themoviedb.org/3/person/22226/movie_credits?api_key=8d5a3dfeea83619117402fc317d79d25
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('@@12');

  await Firebase.initializeApp(
    name: 'moviezapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    debugPrint('@@123');

    if (kIsWeb) {
      debugPrint('@@1234');

      runApp(const WebApp(isMobileWeb: true));
    } else {
      debugPrint('@@12345');

      debugPrint('@@');
      runApp(const MobileApp());
    }
  } else {
    var isChromeExtension = (js.context.hasProperty('chrome') &&
        js.context['chrome'].hasProperty('extension'));
    if (isChromeExtension) {
      debugPrint('@@1');

      runApp(const ChromeApp());

      debugPrint('@@123456');
    } else {
      runApp(const WebApp());
    }
  }
}
