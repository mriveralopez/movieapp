import 'package:flutter/material.dart';
import 'package:movie/src/pages/movie_screen.dart';
import 'package:movie/src/pages/pages.dart';
import 'package:movie/src/pages/search_screen.dart';
import 'package:movie/src/pages/setting_screen.dart';

import 'src/pages/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      // case '/Debug':
      //   return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      // case '/Home':
      //   return MaterialPageRoute(builder: (_) => HomeScreen(parentScaffoldKey: ,));
      case '/Movie':
        return MaterialPageRoute(
            builder: (_) => MovieScreen(
                  imdbID: args,
                ));
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/Setting':
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
