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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                            Padding(padding: EdgeInsets.all(10.0)),
                            MaterialButton(
                                color: Colors.deepPurple,
                                onPressed: () {
                                  updateMultiplayerPoints();
                                  updateMPGuildPoints();
                                  updateGame();
                                  questionNumber = 0;
                                  finalScore = 0;
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // removePlayer();
                                },
                                child: Text("Leave the game",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    )))
                          ]),
                    )))));
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

// This summary is for single player
class SummarySP extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final int score;
  SummarySP({Key key, @required this.score}) : super(key: key);

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
                          Builder(builder: (context) {
                            return player1PointsStream(context);
                          }),
                          Padding(padding: EdgeInsets.all(10.0)),
                          MaterialButton(
                              color: Colors.deepPurple,
                              onPressed: () {
                                updateSPGuildPoints();
                                updateGame();
                                finalScore = 0;
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/homepage');
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

  // for single player
  void updateSPGuildPoints() async {
    await databaseReference.collection("guilds").doc(guild).update({
      'totalPoints': FieldValue.increment(score),
    });
  }

  void updateGame() async {
    await databaseReference.collection("games").doc(gameID).update({
      'finished': true,
    });
  }

  void removePlayer() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference playerCheck =
          FirebaseFirestore.instance.collection('games').doc(gameID);
      DocumentSnapshot snapshot = await transaction.get(playerCheck);
      player1db = snapshot.data()['player1'];
      player2db = snapshot.data()['player2'];
      player3db = snapshot.data()['player3'];
      player4db = snapshot.data()['player4'];
      if (playerClass == "Warrior") {
        await transaction
            .update(playerCheck, {'partyHealth': FieldValue.increment(-1)});
      } else if (playerClass == "Wizard") {
        await transaction
            .update(playerCheck, {'partyWisdom': FieldValue.increment(-0.1)});
      }
      if (player1db == username) {
        await transaction.delete(playerCheck);
      } else if (player2db == username) {
        await transaction.update(playerCheck, {
          'player2': "",
          'player2Class': "",
          'nbOfPlayers': FieldValue.increment(-1)
        });
      } else if (player3db == username) {
        await transaction.update(playerCheck, {
          'player3': "",
          'player3Class': "",
          'nbOfPlayers': FieldValue.increment(-1)
        });
      } else if (player4db == username) {
        await transaction.update(playerCheck, {
          'player4': "",
          'player4Class': "",
          'nbOfPlayers': FieldValue.increment(-1)
        });
      }
    });
  }
}
