// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBhRfcCwsAjqqZeANvj_yhHV-tm7R5pkXY',
    appId: '1:625310114702:web:e12786335e7de5f151badf',
    messagingSenderId: '625310114702',
    projectId: 'moviezapp-spverse',
    authDomain: 'moviezapp-spverse.firebaseapp.com',
    storageBucket: 'moviezapp-spverse.appspot.com',
    measurementId: 'G-CFDVDP1XZN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8LAw4QNnT-lvF2GKMO-grpDsKXc7cj_E',
    appId: '1:625310114702:android:d107d337563acc9751badf',
    messagingSenderId: '625310114702',
    projectId: 'moviezapp-spverse',
    storageBucket: 'moviezapp-spverse.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuRWTjLKJk_KKmXFriai8LF-u6C_xerGY',
    appId: '1:625310114702:ios:9e2a0e2f6216ff4d51badf',
    messagingSenderId: '625310114702',
    projectId: 'moviezapp-spverse',
    storageBucket: 'moviezapp-spverse.appspot.com',
    iosClientId:
        '625310114702-9o6utaofs03l2pgmsvbjd6977316t8p4.apps.googleusercontent.com',
    iosBundleId: 'com.spverse.moviezapp',
  );
}
