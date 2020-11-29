import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var profileImg = 'https://i.pinimg.com/originals/f3/be/e8/f3bee827c8aee1048d84bbb02af2e6b6.jpg';
var userName = 'Clay';

class Homepage extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  profileImg,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'WELCOME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                userName,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
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
              )
            ],
          ),
        ),
      ),
    );
  }
  void createRecord() async {
    await databaseReference.collection("games")
        .doc()
        .set({
      'created': FieldValue.serverTimestamp(),
      'finished': false,
      'player1': ("Clay"),
    });
  }
}






