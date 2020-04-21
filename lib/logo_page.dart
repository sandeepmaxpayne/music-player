import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:music_player/musicapp.dart';

class MyMusicLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSplash(
        imagePath: 'assets/headphonenb.png',
        home: MyMusicApp(),
        logoSize: 200,
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        backGroundColor: Color(0xFFf3d1f4),
        animationEffect: 'zoom-in',
      ),
    );
  }
}
