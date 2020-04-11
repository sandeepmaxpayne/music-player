import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/data/song_data.dart';
import 'package:music_player/widgets/album_ui.dart';
import 'package:music_player/widgets/blur_filter.dart';
import 'package:music_player/widgets/blur_widgt.dart';
import 'package:music_player/widgets/control_button.dart';

enum PlayerState { STOPPED, PLAYING, PAUSED }

class NowPlaying extends StatefulWidget {
  final Song ssong;
  final SongData songData;
  final bool nowPlayTap;
  NowPlaying({this.songData, this.ssong, this.nowPlayTap});

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  MusicFinder audioPlayer;
  Duration duration;
  Duration position;
  PlayerState playerState;
  Song song;

  get isPlaying => playerState == PlayerState.PLAYING;
  get isPaused => playerState == PlayerState.PAUSED;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText => position != null ? duration.toString().split('.') : '';

  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initPlayer() async {
    if (audioPlayer == null) {
      audioPlayer = widget.songData.audioPlayer;
    }
    setState(() {
      song = widget.ssong;
      if (widget.nowPlayTap == null || widget.nowPlayTap == false) {
        if (playerState != PlayerState.STOPPED) {
          stop();
        }
      }
      play(song);
    });
    audioPlayer.setDurationHandler((d) => setState(() {
          duration = d;
        }));
    audioPlayer.setPositionHandler((p) => setState(() {
          position = p;
        }));
    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;
      });
    });
    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.STOPPED;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  Future play(Song s) async {
    if (s != null) {
      final result = await audioPlayer.play(s.uri, isLocal: true);
      if (result == 1) {
        setState(() {
          playerState = PlayerState.PLAYING;
          song = s;
        });
      }
    }
  }

  Future pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) {
      setState(() {
        playerState = PlayerState.PAUSED;
      });
    }
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    if (result == 1) {
      setState(() {
        playerState = PlayerState.STOPPED;
        position = Duration();
      });
    }
  }

  Future next(SongData s) async {
    stop();
    setState(() {
      play(s.nextSong);
    });
  }

  Future prev(SongData s) async {
    stop();
    setState(() {
      play(s.prevSong);
    });
  }

  Future mute(bool muted) async {
    final result = await audioPlayer.mute(muted);
    if (result == 1) {
      setState(() {
        isMuted = muted;
      });
    }
  }

  void onComplete() {
    setState(() {
      playerState = PlayerState.STOPPED;
    });
    play(widget.songData.nextSong);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildPlayer() => Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      song.title,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      song.artist,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ControlButton(
                        onTap: () => prev(widget.songData),
                        iconData: Icons.skip_previous),
                    ControlButton(
                        onTap: () =>
                            isPlaying ? pause() : () => play(widget.ssong),
                        iconData: isPlaying ? Icons.pause : Icons.play_arrow),
                    ControlButton(
                        onTap: () => next(widget.songData),
                        iconData: Icons.skip_next),
                  ],
                ),
                duration == null
                    ? Container()
                    : Slider(
                        value: position?.inMilliseconds?.toDouble() ?? 0,
                        onChanged: (double value) =>
                            audioPlayer.seek((value / 1000).roundToDouble()),
                        min: 0.0,
                        max: duration.inMilliseconds.toDouble(),
                      ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      position != null
                          ? "${positionText ?? ''} / ${durationText ?? ''}"
                          : duration != null ? durationText : '',
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: isMuted
                            ? Icon(
                                Icons.headset_off,
                                color: Theme.of(context).unselectedWidgetColor,
                              )
                            : Icon(
                                Icons.headset,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          mute(!isMuted);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
    var playerUI = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AlbumUI(
          song: song,
          duration: duration,
          position: position,
        ),
        Material(
          child: _buildPlayer(),
          color: Colors.transparent,
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          //TODO check stackfit
          fit: StackFit.expand,
          children: <Widget>[blurWidget(song), blurFilter(), playerUI],
        ),
      ),
    );
  }
}
