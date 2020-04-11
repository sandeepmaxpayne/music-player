import 'package:flutter/material.dart';

enum CurrentTheme { DARK, LIGHT }

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    buttonColor: Colors.white38,
    unselectedWidgetColor: Colors.white38,
    primaryTextTheme: TextTheme(caption: TextStyle(color: Colors.white)));

final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.purpleAccent,
    backgroundColor: Colors.white38,
    buttonColor: Colors.black,
    unselectedWidgetColor: Colors.white38,
    primaryTextTheme: TextTheme(caption: TextStyle(color: Colors.white)));
