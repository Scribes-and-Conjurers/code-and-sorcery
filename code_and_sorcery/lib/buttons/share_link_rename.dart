import 'package:code_and_sorcery/screens/game_lobby/game_lobby.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import '../screens/homepage/colors.dart';

Widget createShareButton(link) {
  return ElevatedButton(
      child: Text("SHARE"),
      onPressed: () {
        Share.share(link);
      });
}

Widget createShareIcon(link) {
  return IconButton(
      icon: Icon(Icons.copy),
      color: Colors.white,
      onPressed: () {
        Share.share(link);
      });
}
