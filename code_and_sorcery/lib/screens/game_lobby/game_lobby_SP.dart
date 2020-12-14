import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../global_variables/global_variables.dart';
import 'game_settings.dart';
import '../homepage/colors.dart';
import '../homepage/homepage.dart';

String player1 = username;
String player1Class = playerClass;
String gameLinkValue = "";

class GameLobbySP extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Game lobby"),
      // ),
      body: Container(
        decoration: BoxDecoration(
          color: color1,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 0),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor3),
                  ),
                  onPressed: () {
                    // Navigate back to the first screen by popping the current route
                    // off the stack.
                    createGame();
                    getSetPlayers();
                    if (player1Class == "Warrior") {
                      updateGameHealth();
                    }
                    Navigator.pushNamed(context, '/gameLoading');
                  },
                  child: Text('GO TO GAME', style: TextStyle(color: textDark)),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor3),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Text('SETTINGS', style: TextStyle(color: textDark)),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor3),
                  ),
                  onPressed: () {
                    removePlayer();
                    Navigator.pop(context);
                  },
                  child: Text('HOMEPAGE', style: TextStyle(color: textDark)),
                ),
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
}
