import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';

String player1;
String player1Class;
String gameLinkValue = "";

class GameLobby extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;

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
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  createGame();
                  getSetPlayers();
                  if (player1Class == "Warrior") {
                    updateGameHealth();
                  }
                  Navigator.pushNamed(context, '/ingame');
                },
                child: Text('Go to game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This creates a single player game in the collection games_sp
  void createGame() async {
    await databaseReference.collection("games").doc(gameLinkValue).set({
      'created': FieldValue.serverTimestamp(),
      'finished': false,
      'partyHealth': 3,
      'player1': username,
      'player1Points': 0,
      'player1Class': playerClass
    });
  }

  // This gets and sets the player in the game object
  void getSetPlayers() async {
    await databaseReference
        .collection('games')
        .doc(gameLinkValue)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        player1 = documentSnapshot.data()['player1'];
        player1Class = documentSnapshot.data()['player1Class'];
        print(player1);
        print(player1Class);
      }
    });
  }

  // Update health if player is warrior
  void updateGameHealth() async {
    await databaseReference.collection("games").doc(gameLinkValue).update({
      'partyHealth': FieldValue.increment(1),
    });
  }

}
