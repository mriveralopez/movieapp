import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logging/logging.dart';
import 'package:movie/route_generator.dart';
import 'package:movie/src/helpers/custom_trace.dart';
import 'package:movie/src/models/settings.dart';
import 'package:movie/src/service/api_service.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'src/repository/settings_repository.dart' as settingRepo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();

  GlobalConfiguration cfg = GlobalConfiguration();
  await cfg.loadFromAsset('configurations');
  print(CustomTrace(StackTrace.current,
      message: "base_url: ${GlobalConfiguration().getValue('api_url')}"));
  print(CustomTrace(StackTrace.current,
      message: "api_base_url: ${GlobalConfiguration().getValue('api_img')}"));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settingRepo.initSettings();
    setState(() {});

    // settingRepo.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          return Provider(
            create: (context) => ApiService.create(),
            child: MaterialApp(
              navigatorKey: settingRepo.navigatorKey,
              title: _setting.appName ?? "",
              initialRoute: "/Splash",
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              locale: _setting.mobileLanguage.value,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: _setting.brightness.value == Brightness.light
                  ? ThemeData(
                      fontFamily: 'ProductSans',
                      primaryColor: Colors.grey,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        elevation: 0,
                        foregroundColor: Colors.grey,
                      ),
                      brightness: Brightness.light,
                      scaffoldBackgroundColor: Colors.white,
                      accentColor: Colors.black,
                      dividerColor: Colors.red,
                      focusColor: Colors.grey,
                      hintColor: Colors.black,
                      backgroundColor: Colors.red,
                      // indicatorColor: Colors.red,
                      textTheme: TextTheme(
                        bodyText2: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : ThemeData(
                      fontFamily: 'ProductSans',
                      primaryColor: Color(0xFF252525),
                      brightness: Brightness.dark,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        elevation: 0,
                        foregroundColor: Colors.white,
                      ),
                      scaffoldBackgroundColor: Colors.black,
                      accentColor: Colors.white,
                      focusColor: Colors.grey,
                      hintColor: Colors.white,
                      // hintColor: Colors.black,
                      // accentColor: config.Colors().mainDarkColor(1),
                      // dividerColor: config.Colors().accentColor(0.1),
                      // hintColor: config.Colors().secondDarkColor(1),
                      // focusColor: config.Colors().accentDarkColor(1),
                      textTheme: TextTheme(
                        bodyText1: TextStyle(
                          color: Colors.white,
                        ),
                        bodyText2: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}

Future<void> _setupLogging() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
      (rec) => {print("${rec.level.name}: ${rec.time} : ${rec.message}")});
}
