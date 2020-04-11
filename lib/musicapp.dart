import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:music_player/data/song_data.dart';
import 'package:music_player/pages/root.dart';
import 'package:music_player/widgets/MPInheritedWidget.dart';

class MyMusicApp extends StatefulWidget {
  @override
  _MyMusicAppState createState() => _MyMusicAppState();
}

class _MyMusicAppState extends State<MyMusicApp> {
  SongData songData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    songData.audioPlayer.stop();
  }

  // Platform messages are asynchronous
  void initPlatformState() async {
    _isLoading = true;

    var songs;
    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print('Failed to get songs: ${e.messege}');
    }

    print(songs);

    //update the nonexistence appearance
    if (!mounted) {
      return;
    }

    setState(() {
      songData = SongData(songs);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FMPInheritedWidget(
        songData: songData, isLoading: _isLoading, child: RootPage());
  }
}
