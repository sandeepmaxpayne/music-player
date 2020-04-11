import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_player/data/song_data.dart';
import 'package:music_player/pages/now_playing.dart';
import 'package:music_player/widgets/MPInheritedWidget.dart';

import 'avatar.dart';

class FMPListView extends StatelessWidget {
  final List<MaterialColor> colors = Colors.primaries;

  @override
  Widget build(BuildContext context) {
    final rootIW = FMPInheritedWidget.of(context);
    SongData songData = rootIW.songData;
    return ListView.builder(
      itemBuilder: (context, int index) {
        var s = songData.songs[index];
        final MaterialColor color = colors[index % colors.length];
        var artFile =
            s.albumArt == null ? null : File.fromUri(Uri.parse(s.albumArt));

        return ListTile(
          dense: false,
          leading: Hero(
            child: avatar(artFile, s.title, color),
            tag: s.title,
          ),
          title: Text(s.title),
          subtitle: Text(
            '- ${s.artist}',
            style: Theme.of(context).textTheme.caption,
          ),
          onTap: () {
            songData.setCurrentIndex(index);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NowPlaying(
                          songData: songData,
                          ssong: s,
                        )));
          },
        );
      },
      itemCount: songData.songs.length,
    );
  }
}
