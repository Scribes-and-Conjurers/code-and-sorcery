import 'package:flutter/material.dart';
import '../login/authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../game_lobby/game_lobby.dart';

class JoinGame extends StatefulWidget {
  JoinGame({this.title, this.someText});
  final Widget title, someText;
  @override
  JoinGameState createState() => new JoinGameState();
}

class JoinGameState extends State<JoinGame> {
  final databaseReference = FirebaseFirestore.instance;
  final gameLinkController = TextEditingController();
  final DocumentReference sfDocRef =
      FirebaseFirestore.instance.collection("cities").doc("SF");

  String gameLink = "";

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: widget.title,
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
              children: <Widget>[
                Padding(padding: EdgeInsets.all(70.0)),
                TextField(
                  controller: gameLinkController,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(), hintText: "ADD LINK"),
                  onChanged: (String text) {
                    setState(() {
                      gameLink = gameLinkController.text;
                    });
                  },
                ),
                Text("\n\n"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lobby');
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setPlayer2() async {
    await databaseReference.collection("games").doc(gameLink).update({
      'player2': username,
    });
  }

  void setPlayer3() async {
    await databaseReference.collection("games").doc(gameLink).update({
      'player3': username,
    });
  }

  void setPlayer4() async {
    await databaseReference.collection("games").doc(gameLink).update({
      'player4': username,
    });
  }
}

/*
FOUR PLAYER LOGIC :

Check if PLAYER2 is empty or not in the game object
  IF PLAYER2 is empty, set CURRENTPLAYER as PLAYER2
  ELSE : IF PLAYER2 is full, check if PLAYER3 is empty or not in the game object
            IF PLAYER3 is empty, set CURRENTPLAYER as PLAYER3
            ELSE : IF PLAYER 3 is full, check if PLAYER4 is empty or not in the game object
                      IF PLAYER4 is empty, set CURRENTPLAYER as PLAYER4
                      ELSE : IF PLAYER4 is full, send alert message in popup box saying the game is already full
*/
class Record {
  final String player2;
  final String player3;
  final String player4;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['player2'] != null),
        assert(map['player3'] != null),
        assert(map['player4'] != null),
        player2 = map['player2'],
        player3 = map['player3'],
        player4 = map['player4'];

  @override
  String toString() => "Record<$player2:$player3:$player4>";
}
