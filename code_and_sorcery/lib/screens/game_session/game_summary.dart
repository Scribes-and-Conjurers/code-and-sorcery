import 'dart:async';
import 'dart:collection';
import 'package:code_and_sorcery/screens/game_lobby/game_lobby.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import 'package:provider/provider.dart';
import './game_image_utils.dart';
import './game_general_utils.dart';
import './game_session.dart';
import '../homepage/colors.dart';

class Summary extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        // value: game.questionSnapshot,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Container(
                    decoration: BoxDecoration(
                      color: color1,
                    ),
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 200),
                            Builder(builder: (context) {
                              return player1PointsStream(context);
                            }),
                            Builder(builder: (context) {
                              return player2PointsStream(context);
                            }),
                            Builder(builder: (context) {
                              return player3PointsStream(context);
                            }),
                            Builder(builder: (context) {
                              return player4PointsStream(context);
                            }),
                            Text('Multiplayer Bonus! +2 points!',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: textBright,
                                )),
                            Padding(padding: EdgeInsets.all(10.0)),

                            SizedBox(
                              width: 200,
                              child: MaterialButton(
                                  padding: EdgeInsets.all(10),
                                  color: color3,
                                  onPressed: () {
                                    updateMultiplayerPoints();
                                    updateMPGuildPoints();
                                    updateGame();
                                    questionNumber = 0;
                                    finalScore = 0;
                                    amPlayer1 = false;
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/homepage');
                                    // removePlayer();
                                  },
                                  child: Text("LEAVE THE GAME",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: textDark,
                                      ))),
                            )

                          ]),
                    )))));
  }

  // for multiplayer game, add 2 bonus points
  void updateMultiplayerPoints() async {
    await databaseReference.collection("users").doc(uID).update({
      'points': FieldValue.increment(finalScore + 2),
    });
  }

  void updateGame() async {
    await databaseReference.collection("games").doc(gameID).update({
      'finished': true,
    });
  }

  void updateMPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(finalScore + 2),
    });
  }
}

// This summary is for single player
class SummarySP extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  SummarySP({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        // value: game.questionSnapshot,
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Container(
                    decoration: BoxDecoration(
                      color: color1,
                    ),
                    alignment: Alignment.topCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Builder(builder: (context) {
                            return player1PointsStream(context);
                          }),
                          Padding(padding: EdgeInsets.all(10.0)),
                          SizedBox(
                            width: 200,
                            child: MaterialButton(
                                padding: EdgeInsets.all(10),
                                color: color3,
                                onPressed: () {
                                  updateSinglePlayerPoints();
                                  updateSPGuildPoints();
                                  updateGame();
                                  finalScore = 0;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Navigator.pushNamed(context, '/homepage');
                                },
                                child: Text("LEAVE THE GAME",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: textDark,
                                    ))),
                          )
                        ])))));
  }

  void updateSinglePlayerPoints() async {
    await databaseReference.collection("users").doc(uID).update({
      'points': FieldValue.increment(finalScore),
    });
  }

  void updateSPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(finalScore),
    });
  }

  void updateGame() async {
    await databaseReference.collection("games").doc(gameID).update({
      'finished': true,
    });
  }
}
