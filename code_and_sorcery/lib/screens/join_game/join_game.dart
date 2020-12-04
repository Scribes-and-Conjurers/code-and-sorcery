import 'package:code_and_sorcery/screens/game_lobby/game_lobby.dart';
import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String player2db;
String player3db;
String player4db;

class JoinGame extends StatefulWidget {
  JoinGame({this.title, this.someText});
  final Widget title, someText;
  @override
  JoinGameState createState() => new JoinGameState();
}

class JoinGameState extends State<JoinGame> {
  final gameLinkController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                    setPlayer();
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

  void setPlayer() async {
    await _firestore.runTransaction((transaction) async {
      DocumentReference playerCheck =
          _firestore.collection('games').doc(gameLink);
      DocumentSnapshot snapshot = await transaction.get(playerCheck);
      player2db = snapshot.data()['player2'];
      player3db = snapshot.data()['player3'];
      player4db = snapshot.data()['player4'];
      if (player2db == "") {
        await transaction.update(
            playerCheck, {'player2': username, 'player2Class': playerClass});
      } else if (player2db != "") {
        if (player3db == "") {
          await transaction.update(
              playerCheck, {'player3': username, 'player3Class': playerClass});
        } else if (player3db != "") {
          if (player4db == "") {
            await transaction.update(playerCheck,
                {'player4': username, 'player4Class': playerClass});
          }
        }
      }
    });
  }
}
