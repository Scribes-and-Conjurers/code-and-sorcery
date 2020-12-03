import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';
import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
import 'assembling_codebits.dart';
import '../game_lobby/game_lobby.dart';
import './game_image_utils.dart';
import './game_summary.dart';
import './quest_short.dart';
import './game_session.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// live updating of player1 points
Widget singlePlayerPointsStream(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          player1 +
              "'s score: " +
              userDocument['player1Points'].toString() +
              '\n\n',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        );
      });
}

Widget partyHealthModifier(BuildContext context) {
  // String userId = "skdjfkasjdkfja";
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          userDocument['partyHealth'].toString(),
          style: TextStyle(fontSize: 25, color: Colors.black),
        );
      });
}

// live updating of player2 points
Widget multiplayerPointsStream(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          player1 +
              "'s score: " +
              userDocument['player1Points'].toString() +
              '\n\n' +
              player2 +
              "'s score: " +
              userDocument['player2Points'].toString() +
              '\n\n' +
              'Multiplayer Bonus! +2',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        );
      });
}
