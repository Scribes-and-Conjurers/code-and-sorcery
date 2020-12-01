import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login/authenticator.dart';

var gameID = 'testGameSession';
String player1;
String player2;
bool isSinglePlayer = true;

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
               ElevatedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  getSetPlayers();
                  checkIfSoloGame();
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
    isSinglePlayer = true;
  } else {
    isSinglePlayer = false;
  }
}

Widget buildUser(BuildContext context) {
  // String userId = "skdjfkasjdkfja";
  return StreamBuilder(
      stream:
      FirebaseFirestore.instance.collection('games').doc(gameID).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Text(
          userDocument['player1'] +
              '\n\n' +
              userDocument["player2"],
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        );
      });
}