import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/app/mobile.app.dart';
import 'package:moviezapp/app/web.app.dart';
import 'package:moviezapp/firebase_options_test.dart';
import 'package:moviezapp/utils/notification.service.dart';
// import 'package:moviezapp/firebase_options.dart';
//  flutter run -d chrome --web-renderer html --web-hostname localhost --web-port 5000
//  flutter build web --web-renderer html --csp
//  flutter build web --web-renderer html --release

//  https://moviezapp-spverse.web.app/
// flutter build appbundle --target=lib/app/main.dart --flavor prod
/*
https://api.themoviedb.org/3/person/22226/movie_credits?api_key=8d5a3dfeea83619117402fc317d79d25
*/

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var isChromeExtension = (js.context.hasProperty('chrome') &&
  //     js.context['chrome'].hasProperty('extension'));
  // if (isChromeExtension) {
  //   runApp(const ChromeApp());
  // } else {
  await Firebase.initializeApp(
    name: 'moviezapp',
    options: DefaultFirebaseOptionsTest.currentPlatform,
  );
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    if (kIsWeb) {
      runApp(const WebApp(isMobileWeb: true));
    } else {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      NotificationService.init();
      runApp(const MobileApp());
    }
  }
}
