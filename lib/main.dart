import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
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
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: MyMusicApp(),
    );
  }
}
