import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
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
// bool gameOn = false;

class GameLobby extends StatelessWidget {
  // final databaseReference = FirebaseFirestore.instance;
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

void updateGameHealth() async {
  await FirebaseFirestore.instance.collection("games").doc(gameID).update({
    'partyHealth': FieldValue.increment(1),
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
          .update(playerCheck, {'player2': "", 'player2Class': ""});
    } else if (player4db == username) {
      await transaction
          .update(playerCheck, {'player2': "", 'player2Class': ""});
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
