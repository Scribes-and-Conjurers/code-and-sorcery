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
                    setPlayer2();
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

  // update username and guild for user in database
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

//   await databaseReference.runTransaction((transaction)async{
//    DocumentReference gameRef = _firestore.collection('games')
//                                          .document(gameLinkValue);
//    DocumentSnapshot snapshot = await transaction.get(gameRef);
//    int likesCount = snapshot.data['likes'];
//    await transaction.update(gameRef,{
//      'likes' : likesCount + 1
//    });
// });

}
