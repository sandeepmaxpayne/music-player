import 'dart:io';

import 'package:flutter/material.dart';

Widget avatar(File f, String title, MaterialColor color) {
  return Material(
    borderRadius: BorderRadius.circular(20.0),
    elevation: 4.0,
    child: f != null
        ? CircleAvatar(
            backgroundImage: Image.file(
              f,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ).image,
          )
        : CircleAvatar(
            child: Icon(Icons.play_arrow, color: Colors.white38),
            backgroundColor: color,
          ),
  );
}
