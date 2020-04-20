import 'package:flutter/material.dart';
import 'package:music_player/utility/themes.dart';
import 'musicapp.dart';

void main() => runApp(MyThemeApp());

class MyThemeApp extends StatefulWidget {
  @override
  _MyThemeAppState createState() => _MyThemeAppState();
}

class _MyThemeAppState extends State<MyThemeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      home: MyMusicApp(),
    );
  }
}
