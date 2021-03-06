import 'package:flutter/material.dart';
import '../../global_variables/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinGame extends StatefulWidget {
  JoinGame({this.title, this.someText});
  final Widget title, someText;
  @override
  JoinGameState createState() => new JoinGameState();
}

class JoinGameState extends State<JoinGame> {
  final gameLinkController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // String gameLink = "";

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: widget.title,
        // ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(70.0)),
                TextField(
                  controller: gameLinkController,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "ADD YOUR ROOM CODE"),
                  onChanged: (String text) {
                    setState(() {
                      gameID = gameLinkController.text;
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
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference playerCheck =
          FirebaseFirestore.instance.collection('games').doc(gameID);
      DocumentSnapshot snapshot = await transaction.get(playerCheck);
      player2db = snapshot.data()['player2'];
      player3db = snapshot.data()['player3'];
      player4db = snapshot.data()['player4'];
      // gameFull = snapshot.data()['gameFull'];
      if (playerClass == "Warrior") {
        await transaction
            .update(playerCheck, {'partyHealth': FieldValue.increment(1)});
      } else if (playerClass == "Wizard") {
        await transaction
            .update(playerCheck, {'partyWisdom': FieldValue.increment(0.1)});
      }
      if (player2db == "") {
        await transaction.update(playerCheck, {
          'player2': username,
          'player2Class': playerClass,
          'nbOfPlayers': FieldValue.increment(1)
        });
      } else if (player2db != "") {
        if (player3db == "") {
          await transaction.update(playerCheck, {
            'player3': username,
            'player3Class': playerClass,
            'nbOfPlayers': FieldValue.increment(1)
          });
        } else if (player3db != "") {
          if (player4db == "") {
            await transaction.update(playerCheck, {
              'player4': username,
              'player4Class': playerClass,
              'nbOfPlayers': FieldValue.increment(1)
            });
            // } else {
            //   await transaction.update(playerCheck, {'gameFull': true});
          }
        }
      }
    });
  }

  void getQuestID() async {
    await FirebaseFirestore.instance
        .collection('games')
        .doc(gameID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // define questions
        questID = documentSnapshot.data()['questID'];
        print(questID);
      }
    });
  }
}
