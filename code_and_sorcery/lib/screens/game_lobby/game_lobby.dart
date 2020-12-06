import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../game_session/game_session.dart';
import 'dart:async';
// import '../login/authenticator.dart';
import '../../global_variables/global_variables.dart';

String player1;
String player2;
String player3;
String player4;
String player1db;
String player2db;
String player3db;
String player4db;
String player1Class;
String player2Class;
String player3Class;
String player4Class;
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
  int counter = 5;
  Timer readyTimer;
  // Timer gameSessionTimer;
  // final databaseReference = FirebaseFirestore.instance;
  final gameLinkController = TextEditingController();
  final String _collection = 'collectionName';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // (counter > 0)
              //     ? Text("")
              //     : Text("Let's go!",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 48)),
              // Text('$counter',
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48)),
              startCountdownStream(context),
              SizedBox(height: 40),
              buildUser(context),
              SizedBox(height: 40),
              TextField(
                  controller: gameLinkController,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(), hintText: ""),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  onChanged: (String text) {
                    gameID = gameLinkController.text;
                  }),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  checkP1GO();
                  getSetPlayers();
                  startTimer();

                  // gameSessionTimer =
                  //     new Timer.periodic(new Duration(seconds: 5), (time) {
                  //   Navigator.pushNamed(context, '/ingame');
                  //   gameSessionTimer.cancel();
                  // });

                  // checkIfSoloGame();
                  // Navigator.pushNamed(context, '/ingame');
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
    if (player1db == username) {
      await transaction.delete(playerCheck);
    } else if (player2db == username) {
      await transaction
          .update(playerCheck, {'player2': "", 'player2Class': ""});
    } else if (player3db == username) {
      await transaction
          .update(playerCheck, {'player3': "", 'player3Class': ""});
    } else if (player4db == username) {
      await transaction
          .update(playerCheck, {'player4': "", 'player4Class': ""});
    }
  });
}

void getSetPlayers() async {
  await FirebaseFirestore.instance
      .collection('games')
      .doc(gameID)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
      player1 = documentSnapshot.data()['player1'];
      player2 = documentSnapshot.data()['player2'];
      player3 = documentSnapshot.data()['player3'];
      player4 = documentSnapshot.data()['player4'];
      player1Class = documentSnapshot.data()['player1Class'];
      player2Class = documentSnapshot.data()['player2Class'];
      player3Class = documentSnapshot.data()['player3Class'];
      player4Class = documentSnapshot.data()['player4Class'];
      print(player2);
      print(player3);
      print(player4);
      print(player2Class);
      print(player3Class);
      print(player4Class);
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
              '\n\n' +
              userDocument["player2"] +
              '\n\n' +
              userDocument["player3"] +
              '\n\n' +
              userDocument["player4"],
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
