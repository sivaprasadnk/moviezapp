import 'package:flutter/material.dart';
import 'package:moviezapp/config/error.details.widget.dart';
import 'package:moviezapp/config/generate.route.dart';
import 'package:moviezapp/config/routes.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/providers.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:provider/provider.dart';

class ChromeApp extends StatelessWidget {
  const ChromeApp({
    super.key,
  });

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
            onGenerateTitle: (context) {
              return "MoviezApp";
            },
            onGenerateRoute: generateRoute,
            initialRoute: HomeScreenWeb.routeName,
            onUnknownRoute: (settings) {
              return MaterialPageRoute(builder: (_) {
                return const HomeScreenWeb();
              });
            },
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
            home: const HomeScreenWeb(
              isChromeApp: true,
            ),
          );
        },
      ),
    );
  }
}
