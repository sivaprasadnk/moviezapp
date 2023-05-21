import 'package:flutter/material.dart';
import 'package:moviezapp/config/error.details.widget.dart';
import 'package:moviezapp/config/generate.route.dart';
import 'package:moviezapp/config/routes.dart';
import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/providers.dart';
import 'package:moviezapp/views/mobile.web.screen.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';
import 'package:provider/provider.dart';

class WebApp extends StatelessWidget {
  const WebApp({
    super.key,
    this.isMobileWeb = false,
  });

  final bool isMobileWeb;

  @override
  Widget build(BuildContext context) {
    return !isMobileWeb
        ? MultiProvider(
            providers: providers,
            child: Consumer<AppProvider>(
              builder: (_, provider, __) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'MoviezApp',
                  routes: routes,
                  // routes: ,
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
                  // key: locator<NavigationService>().navigatorKey,

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
                  // routerConfig: routerConfig,
                  home: HomeScreenWeb(isMobileWeb: isMobileWeb),
                );
              },
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MoviezApp',
            routes: routes,
            theme: ThemeData(
              primaryColor: Colors.red,
            ),
            builder: (context, child) {
              return const MobileWebScreen();
            },
            home: const MobileWebScreen(),
          );
  }
}
