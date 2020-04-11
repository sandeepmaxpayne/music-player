import 'package:music_player/data/song_data.dart';
import 'package:flutter/material.dart';

class FMPInheritedWidget extends InheritedWidget {
  final SongData songData;
  final bool isLoading;

  const FMPInheritedWidget({this.songData, this.isLoading, child})
      : super(child: child);

  static FMPInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FMPInheritedWidget);
  }

  @override
  bool updateShouldNotify(FMPInheritedWidget oldWidget) =>
      songData != oldWidget.songData || isLoading != oldWidget.isLoading;
}
