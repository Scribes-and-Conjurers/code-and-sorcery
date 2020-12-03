import 'package:code_and_sorcery/screens/game_session/game_session.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../login/authenticator.dart';

var gameID = 'testGameSession';
String player1;
String player2;
bool isMultiplayer;
String gameLinkValue = "";
String playerClass = "Warrior";

class GameLobby extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  final gameLinkController = TextEditingController();

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
              TextField(
                  controller: gameLinkController,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(), hintText: ""),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  onChanged: (String text) {
                    gameLinkValue = gameLinkController.text;
                  }),
              ElevatedButton(
                onPressed: () {
                  gameLinkController.text = randomAlphaNumeric(15);

                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                },
                child: Text('GENERATE LINK'),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  getSetPlayers();
                  checkIfSoloGame();
                  if (playerClass == "Warrior") {
                    updateGameHealth();
                  }
                  Navigator.pushNamed(context, '/ingame');
                },
                child: Text('Go to game'),
              ),
              buildUser(context),
            ],
          ),
        ),
      ),
    );
  }
}

void updateGameHealth() async {
  await databaseReference.collection("games").doc('testGameSession').update({
    'partyHealth': FieldValue.increment(1),
  });
}

void createGame() async {
  await databaseReference.collection("games").doc('testGameSession').set({
    'created': FieldValue.serverTimestamp(),
    'finished': false,
    'partyHealth': 3,
    'player1': username,
    'player1Points': 0,
    'player1Class': playerClass,
    'player2': '',
    'player2Class': '',
    'player2Points': 0,
  });
}

void getSetPlayers() async {
  await databaseReference
      .collection('games')
      .doc(gameID)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
      player1 = documentSnapshot.data()['player1'];
      player2 = documentSnapshot.data()['player2'];
      print(player1);
      print(player2);
      // guild = documentSnapshot.data()['guild'];
      // points = documentSnapshot.data()['points'];
    }
  });
}

void checkIfSoloGame() {
  if (player2 == '') {
    isMultiplayer = false;
  } else {
    isMultiplayer = true;
  }
}

Widget buildUser(BuildContext context) {
  // String userId = "skdjfkasjdkfja";
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
          userDocument['player1'] + '\n\n' + userDocument["player2"],
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        );
      });
}
