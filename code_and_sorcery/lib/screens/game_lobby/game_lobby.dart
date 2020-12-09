import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../game_session/game_content_short.dart';
import '../game_session/game_session.dart';
import 'dart:async';
import '../../global_variables/global_variables.dart';
import '../join_game/join_game.dart';


String questID;
String gameLinkValue = "";
bool pushedGo;
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
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
         
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
              startCountdownStream(context),
              SizedBox(height: 40),
              buildUser(context),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  checkP1GO();
                  startTimer();
                },
                child: Text('Go to game'),
              ),
              ElevatedButton(
                onPressed: () {
                  removePlayer();
                  Navigator.pop(context);
                },
                child: Text('Go back to homepage'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> goNextPage(int id, int duration) async {
    await Future.delayed(Duration(seconds: duration));
    Navigator.pushNamed(context, '/ingame');
    ;
  }

  Future runTimeout() async {
    await goNextPage(0, 5).timeout(Duration(seconds: 2), onTimeout: () {
      print('test');
    });
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
              'Party Wisdom: ' +
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
            Navigator.pushNamed(context, '/ingame');
            gameSessionTimer.cancel();
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
