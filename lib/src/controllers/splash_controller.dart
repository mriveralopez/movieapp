import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  late GlobalKey<ScaffoldState> scaffoldKey;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() {
    super.initState();

    progress.value["User"] = 100;
    Timer(
      Duration(seconds: 5),
      () {
        // ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
        //   SnackBar(
        //     content: Text(S.of(state!.context).verify_your_internet_connection),
        //   ),
        // );

        progress.notifyListeners();
      },
    );
  }
}
