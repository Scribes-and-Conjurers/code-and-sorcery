import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
// import '../login/authenticator.dart';
import '../../global_variables/global_variables.dart';

String player1;
String player2;
String player3;
String player4;
String player1Class;
String player2Class;
String player3Class;
String player4Class;
bool isMultiplayer;
bool gameOn = false;
String gameLinkValue = "";

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
                  gameLinkController.text = randomAlpha(2);
                  gameLinkValue = gameLinkController.text;
                  gameOn = true;
                  createGame();

                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                },
                child: Text('GENERATE LINK'),
              ),
              SizedBox(height: 40),
              // buildUser(context),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the first screen by popping the current route
                  // off the stack.
                  getSetPlayers();
                  // checkIfSoloGame();
                  if (player1Class == "Warrior") {
                    updateGameHealth();
                  }
                  if (player2Class == "Warrior") {
                    updateGameHealth();
                  }
                  if (player3Class == "Warrior") {
                    updateGameHealth();
                  }
                  if (player4Class == "Warrior") {
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
}

void updateGameHealth() async {
  await FirebaseFirestore.instance
      .collection("games")
      .doc(gameLinkValue)
      .update({
    'partyHealth': FieldValue.increment(1),
  });
}

void createGame() async {
  await FirebaseFirestore.instance.collection("games").doc(gameLinkValue).set({
    'created': FieldValue.serverTimestamp(),
    'finished': false,
    'partyHealth': 3,
    'player1': username,
    'player1Points': 0,
    'player1Class': playerClass,
    'player2': '',
    'player2Class': '',
    'player2Points': 0,
    'player3': '',
    'player3Class': '',
    'player3Points': 0,
    'player4': '',
    'player4Class': '',
    'player4Points': 0,
  });
}

void getSetPlayers() async {
  await FirebaseFirestore.instance
      .collection('games')
      .doc(gameLinkValue)
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

// void checkIfSoloGame() {
//   if (player2 == '') {
//     isMultiplayer = false;
//   } else {
//     isMultiplayer = true;
//   }
// }

Widget buildUser(BuildContext context) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameLinkValue)
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
