import 'package:flutter/material.dart';
import 'package:music_player/logo_page.dart';
import 'package:music_player/utility/themes.dart';

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
      initialRoute: 'logo',
      routes: {'logo': (context) => MyMusicLogo()},
    );
  }
}
