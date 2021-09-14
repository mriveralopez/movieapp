import 'package:flutter/material.dart';

import '../helpers/custom_trace.dart';

class Setting {
  String? appName = 'utecapp';

  String? mainColor = '#76082D';
  String? mainDarkColor;
  String? secondColor = '#000000';
  String? secondDarkColor;
  String? accentColor = '#FFFFFF';
  String? accentDarkColor;
  String? scaffoldDarkColor;
  String? scaffoldColor;

  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('es', ''));
  String? appVersion;
  bool enableVersion = true;

  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      mainColor = jsonMap['main_color'] ?? null;
      mainDarkColor = jsonMap['main_dark_color'] ?? '';
      secondColor = jsonMap['second_color'] ?? '';
      secondDarkColor = jsonMap['second_dark_color'] ?? '';
      accentColor = jsonMap['accent_color'] ?? '';
      accentDarkColor = jsonMap['accent_dark_color'] ?? '';
      scaffoldDarkColor = jsonMap['scaffold_dark_color'] ?? '';
      scaffoldColor = jsonMap['scaffold_color'] ?? '';
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "es", '');
      appVersion = jsonMap['app_version'] ?? '';
      enableVersion =
          jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0'
              ? false
              : true;
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

//  ValueNotifier<Locale> initMobileLanguage(String defaultLanguage) {
//    SharedPreferences.getInstance().then((prefs) {
//      return new ValueNotifier(Locale(prefs.get('language') ?? defaultLanguage, ''));
//    });
//    return new ValueNotifier(Locale(defaultLanguage ?? "en", ''));
//  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    return map;
  }
}
