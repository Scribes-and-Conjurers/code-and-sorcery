import 'dart:async';
import 'dart:collection';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import '../game_lobby/game_lobby.dart';
import 'package:provider/provider.dart';
import '../game_lobby/game_lobby.dart';
import './game_image_utils.dart';
import './game_general_utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import './game_session.dart';

class Summary extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: game.questionSnapshot,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Builder(builder: (context) {
                          //   return multiplayerPointsStream(context);
                          // }),
                          Padding(padding: EdgeInsets.all(10.0)),
                          MaterialButton(
                              color: Colors.deepPurple,
                              onPressed: () {
                                // if (!isMultiplayer) {
                                //   updateSinglePlayerPoints();
                                //   updateSPGuildPoints();
                                // } else {
                                //   updateMultiplayerPoints();
                                //   updateMPGuildPoints();
                                // }
                                updateGame();
                                questionNumber = 0;
                                finalScore = 0;
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("Leave the game",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  )))
                        ])))));
  }

  // for single player game
  void updateSinglePlayerPoints() async {
    await databaseReference.collection("users").doc(uID).update({
      'points': FieldValue.increment(score),
    });
  }

  // for multplayer game, add 2 bonus points
  void updateMultiplayerPoints() async {
    await databaseReference.collection("users").doc(uID).update({
      'points': FieldValue.increment(score + 2),
    });
  }

  void updateGame() async {
    await databaseReference.collection("games").doc(gameID).update({
      'finished': true,
    });
  }

  // for single player
  void updateSPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(score),
    });
  }

  // for multiplayer
  void updateMPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(score + 2),
    });
  }
}
