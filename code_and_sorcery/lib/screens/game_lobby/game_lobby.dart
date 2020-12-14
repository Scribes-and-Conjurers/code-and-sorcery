import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../game_session/game_content_short.dart';
import '../game_session/game_session.dart';
import 'dart:async';
import '../../global_variables/global_variables.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

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

//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.all(25),
//                 ),
//                 Container(
//                   padding:
//                       EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 20),
//                   decoration: BoxDecoration(
//                     color: color2,
//                   ),
//                   child: Column(children: [
//                     Text("Game link: ",
//                         style: TextStyle(
//                             fontSize: 25,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                     ),
//                     Text(gameID,
//                         style: TextStyle(
//                             fontSize: 50,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                     ),
//                     startCountdownStream(context),
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                     ),
//                     buildUser(context),
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                     ),
//                   ]),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                 ),
//                 SizedBox(
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.resolveWith(getColor3),
//                     ),
//                     onPressed: () {
//                       checkP1GO();
//                       startTimer();
//                     },
//                     child:
//                         Text('GO TO GAME', style: TextStyle(color: textDark)),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.resolveWith(getColor3),
//                     ),
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/settings');
//                     },
//                     child: Text('SETTINGS', style: TextStyle(color: textDark)),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.resolveWith(getColor3),
//                     ),
//                     onPressed: () {
//                       removePlayer();
//                       Navigator.pop(context);
//                     },
//                     child: Text('HOMEPAGE', style: TextStyle(color: textDark)),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10),

              children: [
                Text("Game link: ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text(gameID,
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 50),
                // startCountdownStream(context),
                leaveCountdownStream(context),
                SizedBox(height: 40),
                buildUser(context),
                SizedBox(height: 40),
                goToGameButton(),
                SizedBox(height: 20),
                goToSettingsButton(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await checkP1Leave();
                    if (player1Leaves == true) {
                      amPlayer1 = false;
                      Navigator.pop(context);
                    } else {
                      removePlayer();
                    }
                  },
                  child: Text('Go back to homepage'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget goToGameButton() {
    return amPlayer1 == true
        ? ElevatedButton(
            onPressed: () {
              checkP1GO();
              startTimer();
            },
            child: Text('Go to game'),
          )
        : Container();
  }

  Widget goToSettingsButton() {
    return amPlayer1 == true
        ? ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            child: Text('Settings'),
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
          return Text(
            "1",
            style: TextStyle(fontSize: 25),
          );
        } else {
          return Text(
            fiveSecondCountdown.toString(),
            style: TextStyle(fontSize: 25),
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
        var pushedLeave = snapshot.data['pushedLeave'];
        if (!snapshot.hasData) {
          return Text("Loading");
        } else if (pushedLeave == true) {
          lobbyClosingTimer = Timer(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
          return Text(
            "Closing lobby...",
            style: TextStyle(fontSize: 25),
          );
        } else {
          return Text("");
        }
      });
}
