import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/app/web.app.dart';
import 'package:moviezapp/firebase_options.dart';
// import 'package:moviezapp/firebase_options.dart';
//  flutter run -d chrome --web-renderer html --web-hostname localhost --web-port 5000
//  flutter build web --web-renderer html --csp
//  flutter build web --web-renderer html --release
//  flutter build web --web-renderer html --release --target=lib/app/web.main.dart
//  https://moviezapp-spverse.web.app/

/*
https://api.themoviedb.org/3/person/22226/movie_credits?api_key=8d5a3dfeea83619117402fc317d79d25
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'moviezapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WebApp());
}
