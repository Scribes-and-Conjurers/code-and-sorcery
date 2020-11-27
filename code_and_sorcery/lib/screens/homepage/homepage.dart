import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Homepage extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body:
        new Column(children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.pushNamed(context, '/profile');
            },
            child: Text('Profile page'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.pushNamed(context, '/lobby');
              createRecord();
            },
            child: Text('Create a game'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate back to the first screen by popping the current route
              // off the stack.
              Navigator.pushNamed(context, '/join');
            },
            child: Text('Join a game'),
          ),
        ])
    );
  }

  void createRecord() async {
    await databaseReference.collection("games")
        .doc("testGame")
        .set({
      'created': FieldValue.serverTimestamp(),
      'finished': false,
      'player1': ("Clay"),
    });
  }
}




