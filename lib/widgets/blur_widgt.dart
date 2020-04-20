import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

Widget blurWidget(Song song) {
  var f = song.albumArt == null ? null : File.fromUri(Uri.parse(song.albumArt));

  return Hero(
    tag: song.artist,
    child: Container(
      child: f != null
          ? Image.file(
              f,
              fit: BoxFit.cover,
              color: Colors.transparent,
              colorBlendMode: BlendMode.darken,
            )
          : Image(
              image: AssetImage("assets/headphone.jpeg"),
              color: Colors.transparent,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
            ),
    ),
  );
}
