import 'package:flutter/material.dart';

enum CurrentTheme { DARK, LIGHT }

final ThemeData myTheme = ThemeData(
    primaryColor: Color(0xFF481380),
    brightness: Brightness.dark,
    canvasColor: Color(0xFF7f78d2),
    applyElevationOverlayColor: true,
    buttonColor: Colors.white38,
    unselectedWidgetColor: Colors.white38,
    primaryTextTheme: TextTheme(caption: TextStyle(color: Color(0xFFffe2ff))));
