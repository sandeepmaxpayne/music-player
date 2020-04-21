import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/widgets/MPInheritedWidget.dart';
import 'package:music_player/widgets/button_shape.dart';
import 'package:music_player/widgets/fmp_listView.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'now_playing.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
        title: Text(
          'My Music',
          style: TextStyle(
            fontFamily: 'Dosis',
          ),
        ),
        actions: <Widget>[
          Container(
            child: Center(
              child: InkWell(
                child: Text(
                  'Now Playing',
                  style: TextStyle(
                      fontFamily: 'Dosis', fontWeight: FontWeight.w400),
                ),
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
          ? Center(
              child: SpinKitSquareCircle(
              color: Color(0xFFCE93D8),
              // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
              size: 100.0,
              duration: Duration(seconds: 5),
            ))
          : Scrollbar(child: FMPListView()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFefb1ff),
        child: Icon(
          Icons.shuffle,
          color: Colors.white70,
        ),
        onPressed: () {
          shuffleSongs();
        },
        tooltip: 'Random Songs',
        elevation: 10.0,
        shape: DiamondBorder(),
        heroTag: 'randomAnim',
      ),
    );
  }
}
