import 'dart:ui';
import 'package:code_and_sorcery/buttons/share_link_rename.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../game_session/game_content_short.dart';
import '../game_session/game_session.dart';
import 'dart:async';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';
import '../../buttons/share_link_rename.dart';

String gameLinkValue = "";
bool pushedGo;
bool player1Start = false;
bool player1Leaves = false;
int startCountdown;

class GameLobby extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GameLobbySL();
  }
}

// Game widget state
class GameLobbySL extends State<GameLobby> {
  @override
  int counter = 5;
  Timer readyTimer;
  var game = new GameContent();
  final gameLinkController = TextEditingController();

  void startTimer() {
    if (readyTimer != null) {
      readyTimer.cancel();
    }
    readyTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        setState(() {
          if (counter > 0) {
            decreaseCountdown();
          } else {
            readyTimer.cancel();
            stopCountdown();
            player1Start = false;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: color1,
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(padding: EdgeInsets.all(20)),
                Container(
                    padding: EdgeInsets.only(
                        left: 64, right: 64, bottom: 20, top: 20),
                    decoration: BoxDecoration(color: color2),
                    child: Column(children: [
                      Text("Room code: ",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(gameID,
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            createShareIcon(gameID)
                          ]),
                      SizedBox(height: 16),
                      startCountdownStream(context),
                      SizedBox(height: 16),
                      buildUser(context),
                      SizedBox(height: 10),
                    ])),
                SizedBox(height: 14),
                goToGameButton(),
                SizedBox(height: 14),
                goToSettingsButton(),
                SizedBox(height: 14),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getColor3),
                    ),
                    onPressed: () async {
                      await checkP1Leave();
                      if (player1Leaves == true) {
                        amPlayer1 = false;
                        if (amPlayer1 == false) {
                          removePlayer();
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text('GO TO HOMEPAGE'),
                  ),
                ),
                leaveCountdownStream(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget goToGameButton() {
    return amPlayer1 == true
        ? SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor3),
              ),
              onPressed: () {
                checkP1GO();
                startTimer();
              },
              child: Text('GO TO GAME'),
            ),
          )
        : Container();
  }

  Widget goToSettingsButton() {
    return amPlayer1 == true
        ? SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor3),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('SETTINGS'),
            ),
          )
        : Container();
  }
}

void checkP1GO() async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentReference playerCheck =
        FirebaseFirestore.instance.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await transaction.get(playerCheck);
    player1db = snapshot.data()['player1'];
    if (player1db == username) {
      await transaction.update(playerCheck, {'pushedGo': true});
      player1Start = true;
    }
  });
}

Future checkP1Leave() async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentReference playerCheck =
        FirebaseFirestore.instance.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await transaction.get(playerCheck);
    player1db = snapshot.data()['player1'];
    if (player1db == username) {
      await transaction.update(playerCheck, {'pushedLeave': true});
      player1Leaves = true;
    }
  });
}

void decreaseCountdown() async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentReference playerCheck =
        FirebaseFirestore.instance.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await transaction.get(playerCheck);
    startCountdown = snapshot.data()['startCountdown'];
    pushedGo = snapshot.data()['pushedGo'];
    if (pushedGo == true && startCountdown > 0) {
      await transaction.update(playerCheck, {
        'startCountdown': FieldValue.increment(-1),
      });
    }
  });
}

void stopCountdown() async {
  await FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentReference playerCheck =
        FirebaseFirestore.instance.collection('games').doc(gameID);
    DocumentSnapshot snapshot = await transaction.get(playerCheck);
    startCountdown = snapshot.data()['startCountdown'];
    pushedGo = snapshot.data()['pushedGo'];
    if (pushedGo == true && startCountdown == 0) {
      await transaction.update(playerCheck, {
        'startCountdown': 0,
        'startedAt': FieldValue.serverTimestamp(),
      });
    }
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

Widget buildUser(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        difficulty = userDocument["gameDifficulty"];
        adventureLength = userDocument["gameLength"];
        return Text(
          'Party Health: ' +
              userDocument["partyHealth"].toString() +
              '\n\n' +
              'Perception rate: ' +
              ((userDocument["partyWisdom"] * 100).toInt()).toString() +
              '%'
                  '\n\n' +
              userDocument["player1"] +
              '  -  ' +
              userDocument['player1Class'] +
              '\n\n' +
              userDocument["player2"] +
              '  -  ' +
              userDocument['player2Class'] +
              '\n\n' +
              userDocument["player3"] +
              '  -  ' +
              userDocument['player3Class'] +
              '\n\n' +
              userDocument["player4"] +
              '  -  ' +
              userDocument['player4Class'],
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        );
      });
}

Widget startCountdownStream(BuildContext context) {
  Timer gameSessionTimer;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var fiveSecondCountdown = snapshot.data['startCountdown'];
        var gameStarted = snapshot.data['startedAt'];
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        if (fiveSecondCountdown == 1 && gameStarted == null) {
          gameSessionTimer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/gameLoadingMP');
          });
          return Text("Game starting in 1...",
              style: TextStyle(
                  fontSize: 20, color: color3, fontWeight: FontWeight.bold));
        } else if (snapshot.data['startCountdown'] == 5) {
          return Text('Waiting to start...',
              style: TextStyle(
                  fontSize: 20, color: color3, fontWeight: FontWeight.bold));
        } else {
          return Text(
            'Game starting in $fiveSecondCountdown...',
            style: TextStyle(
                fontSize: 20, color: color3, fontWeight: FontWeight.bold),
          );
        }
      });
}

Widget leaveCountdownStream(BuildContext context) {
  Timer lobbyClosingTimer;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameID)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var pushedLeaveCheck = snapshot.data['pushedLeave'];
        if (pushedLeaveCheck == true) {
          lobbyClosingTimer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/homepage');
          });
          return Text(
            "",
            style: TextStyle(fontSize: 1),
          );
        } else {
          return Text(
            "",
            style: TextStyle(fontSize: 1),
          );
        }
      });
}
