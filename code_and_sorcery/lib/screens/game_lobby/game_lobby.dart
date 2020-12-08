import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../game_session/game_content_short.dart';
import '../game_session/game_session.dart';
import 'dart:async';
// import '../login/authenticator.dart';
import '../../global_variables/global_variables.dart';

// String player1;
// String player2;
// String player3;
// String player4;
String player1db;
String player2db;
String player3db;
String player4db;
String player1Class;
String player2Class;
String player3Class;
String player4Class;
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
  // void initState() {
  //   updateGameContent(questID);
  // }

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
      appBar: AppBar(
        title: Text("Game lobby"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          // padding: EdgeInsets.all(15.0),
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
              SizedBox(height: 80),
              startCountdownStream(context),
              SizedBox(height: 40),
              buildUser(context),
              SizedBox(height: 40),
              // TextField(
              //     controller: gameLinkController,
              //     decoration: new InputDecoration(
              //         border: OutlineInputBorder(), hintText: ""),
              //     style: TextStyle(
              //         fontSize: 25,
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold),
              //     onChanged: (String text) {
              //       gameID = gameLinkController.text;
              //     }),
              ElevatedButton(
                onPressed: () {
                  checkP1GO();
                  startTimer();
                  // updateGameContent(questID);
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

  // void updateGameContent(String questName) async {
  //   await FirebaseFirestore.instance
  //       .collection('ready-quests')
  //       .doc(questName)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       // define questions
  //       game.questions = documentSnapshot.data()['questions'];

  //       // define choices for each question
  //       game.choices0 = documentSnapshot.data()['choices1'];
  //       game.choices1 = documentSnapshot.data()['choices2'];
  //       game.choices2 = documentSnapshot.data()['choices3'];
  //       game.choices3 = documentSnapshot.data()['choices4'];

  //       // put all four choices arrays in one main array
  //       game.choices = [
  //         game.choices0,
  //         game.choices1,
  //         game.choices2,
  //         game.choices3
  //       ];

  //       // define answers
  //       game.correctAnswers = documentSnapshot.data()['answers'];
  //       print('answers: ${game.correctAnswers}');
  //     }
  //   });
  // }
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
