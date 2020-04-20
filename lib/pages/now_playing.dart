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
  get positionText => position != null ? position.toString().split('.') : '';

  bool isMuted = false;
  bool isdark = false;

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
    print("$positionText $durationText");

    Widget _buildPlayer() => Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(song.title,
                        style: Theme.of(context).textTheme.headline),
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
                        onTap: isPlaying
                            ? () => pause()
                            : () => play(widget.ssong),
                        iconData: isPlaying ? Icons.pause : Icons.play_arrow),
                    ControlButton(
                        onTap: () => next(widget.songData),
                        iconData: Icons.skip_next),
                  ],
                ),
                duration == null
                    ? Container()
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            position != null
                                ? "${positionText[0] ?? ''}"
                                : duration != null ? durationText : '',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w400),
                          ),
                          Expanded(
                            flex: 2,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Color(0xFF8D8E98),
                                overlayColor: Color(0x2FEB1555),
                                thumbColor: Color(0xFFEB1555),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 30.0),
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10.0),
                              ),
                              child: Slider(
                                activeColor: Color(0xff455A64),
                                value:
                                    position?.inMilliseconds?.toDouble() ?? 0,
                                onChanged: (double value) => audioPlayer
                                    .seek((value / 1000).roundToDouble()),
                                min: 0.0,
                                max: duration.inMilliseconds.toDouble(),
                              ),
                            ),
                          ),
                          Text(
                            durationText,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
//
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
