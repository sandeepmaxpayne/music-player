import 'dart:ui';

import 'package:flutter/material.dart';

Widget blurFilter() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    child: Opacity(
      opacity: 0.5,
      child: Container(
        decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.2)),
      ),
    ),
  );
}
