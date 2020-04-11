import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flute_music_player/flute_music_player.dart';

class AlbumUI extends StatefulWidget {
  final Song song;
  final Duration position;
  final Duration duration;
  AlbumUI({this.song, this.duration, this.position});

  @override
  _AlbumUIState createState() => _AlbumUIState();
}

class _AlbumUIState extends State<AlbumUI> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var f = widget.song.albumArt == null
        ? null
        : File.fromUri(Uri.parse(widget.song.albumArt));

    var myHero = Hero(
      tag: widget.song.title,
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.black,
        elevation: 5.0,
        child: f != null
            ? Image.file(
                f,
                fit: BoxFit.cover,
//                height: 250.0,
                gaplessPlayback: true,
              )
            : Image.asset(
                "assets/music_record.jpg",
                fit: BoxFit.scaleDown,
                // height: 250.0,
                gaplessPlayback: false,
              ),
      ),
    );
    return SizedBox.fromSize(
      size: Size(animation.value * 250.0, animation.value * 250.0),
      child: Stack(
        children: <Widget>[
          myHero,
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 0.8),
            child: Material(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(
                children: <Widget>[
                  LinearProgressIndicator(
                    value: 1.0,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).buttonColor),
                  ),
                  LinearProgressIndicator(
                    value: widget.position != null &&
                            widget.position.inMilliseconds > 0
                        ? (widget.position?.inMilliseconds?.toDouble() ?? 0.0) /
                            (widget.duration?.inMilliseconds?.toDouble() ?? 0.0)
                        : 0.0,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).cardColor),
                    backgroundColor: Theme.of(context).buttonColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
