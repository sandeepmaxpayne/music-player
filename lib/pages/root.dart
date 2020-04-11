import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/widgets/MPInheritedWidget.dart';
import 'package:music_player/widgets/fmp_listView.dart';

import 'now_playing.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootIW = FMPInheritedWidget.of(context);
    //go to now playing
    void nowPlaying(Song s, {bool nowPlayTap: false}) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NowPlaying(
                    ssong: s,
                    songData: rootIW.songData,
                    nowPlayTap: nowPlayTap,
                  )));
    }

    void shuffleSongs() {
      nowPlaying(rootIW.songData.randomSong);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
        actions: <Widget>[
          Container(
            child: Center(
              child: InkWell(
                child: Text('Now Playing'),
                onTap: () => nowPlaying(
                  rootIW.songData.songs[(rootIW.songData.currentIndex == null ||
                          rootIW.songData.currentIndex < 0)
                      ? 0
                      : rootIW.songData.currentIndex],
                  nowPlayTap: true,
                ),
              ),
            ),
          ),
        ],
      ),
      body: rootIW.isLoading
          //TODO circularProgressIndicator
          ? Center(child: CircularProgressIndicator())
          : Scrollbar(child: FMPListView()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        child: Icon(Icons.shuffle),
        onPressed: () {
          shuffleSongs();
        },
      ),
    );
  }
}
