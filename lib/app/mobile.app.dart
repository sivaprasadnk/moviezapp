import 'package:flutter/material.dart';
import 'package:moviezapp/config/error.details.widget.dart';
import 'package:moviezapp/config/generate.route.dart';
import 'package:moviezapp/config/routes.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/providers.dart';
import 'package:moviezapp/views/mobile/splash.screen/splash.screen.dart';
import 'package:provider/provider.dart';

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
            onGenerateRoute: generateRoute,
            theme: ThemeData(
              primaryColor: Colors.red,
              brightness: provider.selectedBrightness,
            ),
            builder: (context, widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return ErrorDetailsWidget(
                  errorDetails: errorDetails,
                  widget: widget!,
                );
              };
              return widget!;
            },
            home: const SplashScreenMobile(),
          );
        },
      ),
    );
  }
}
