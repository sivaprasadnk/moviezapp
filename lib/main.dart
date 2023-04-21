import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/firebase_options.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/providers.dart';
import 'package:moviezapp/utils/routes.dart';
import 'package:moviezapp/views/mobile/splash.screen/splash.screen.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:provider/provider.dart';

//  flutter run -d chrome --web-renderer html --web-hostname localhost --web-port 5000

//  flutter build web --web-renderer html --release

//  https://moviezapp-spverse.web.app/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'moviezapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    if (kIsWeb) {
      runApp(const WebApp(isMobileWeb: true));
    } else {
      runApp(const MobileApp());
    }
  } else {
    runApp(const WebApp());
  }
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AppProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie App',
            routes: routes,
            theme: ThemeData(
              primaryColor: Colors.red,
              brightness: provider.selectedBrightness,
            ),
            home: const SplashScreenMobile(),
          );
        },
      ),
    );
  }
}

class WebApp extends StatelessWidget {
  const WebApp({
    super.key,
    this.isMobileWeb = false,
  });

  final bool isMobileWeb;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AppProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MoviezApp',
            routes: routes,
            theme: ThemeData(
              primaryColor: Colors.red,
              brightness: provider.selectedBrightness,
            ),
            builder: (context, widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                String message = kDebugMode
                    ? "${errorDetails.summary}"
                    : "Something went wrong !";

                Widget error = Text(message);
                debugPrint('error : ${errorDetails.summary}');
                if (widget is Scaffold) {
                  error = MaterialApp(
                    builder: (context, child) {
                      return Material(
                        child: Scaffold(
                          body: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error_outlined, size: 50),
                                  error,
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return error;
              };
              return widget!;
            },
            home: HomeScreenWeb(isMobileWeb: isMobileWeb),
          );
        },
      ),
    );
  }
}
