import 'package:code_and_sorcery/screens/game_session/game_content_short.dart';
import 'package:code_and_sorcery/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import '../game_session/game_content_long.dart';
import '../game_session/game_content_short.dart';

// create game object
// var gameLong = new GameContentLong();
var gameShort = new GameContent();

class LoadingBeforeGameMP extends StatefulWidget {
  @override
  _LoadingBeforeGameMPState createState() => _LoadingBeforeGameMPState();
}

class _LoadingBeforeGameMPState extends State<LoadingBeforeGameMP> {
  @override
  void initState() {
    super.initState();
    // Easy, short MP game
    updateGameContentShort('JIfrv2SOOdlxkv5RJP3i');
    Timer(Duration(seconds: 2),
        () => {
        Navigator.pop(context),
        Navigator.pushNamed(context, '/ingame'),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(children: [
          Image.asset('assets/logo.png'),
          Text(
            "Conjuring game...",
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.6),
          )
        ]));
  }

  //
  void updateGameContentShort(String questName) async {
    await FirebaseFirestore.instance
        .collection('ready-quests')
        .doc(questName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // define questions
        gameShort.questions = documentSnapshot.data()['questions'];

        // define choices for each question
        gameShort.choices0 = documentSnapshot.data()['choices1'];
        gameShort.choices1 = documentSnapshot.data()['choices2'];
        gameShort.choices2 = documentSnapshot.data()['choices3'];
        gameShort.choices3 = documentSnapshot.data()['choices4'];

        // put all four choices arrays in one main array
        gameShort.choices = [
          gameShort.choices0,
          gameShort.choices1,
          gameShort.choices2,
          gameShort.choices3
        ];

        // define answers
        gameShort.correctAnswers = documentSnapshot.data()['answers'];
        print('answers: ${gameShort.correctAnswers}');
      }
    });
  }

  // this updates game content for long adventure
  // void updateGameContentLong(String questName) async {
  //   await FirebaseFirestore.instance
  //       .collection('ready-quests')
  //       .doc(questName)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       // define questions
  //       game.questions = documentSnapshot.data()['questions'];
  //
  //       // define choices for each question
  //       game.choices0 = documentSnapshot.data()['choices0'];
  //       game.choices1 = documentSnapshot.data()['choices1'];
  //       game.choices2 = documentSnapshot.data()['choices2'];
  //       game.choices3 = documentSnapshot.data()['choices3'];
  //       game.choices4 = documentSnapshot.data()['choices4'];
  //       game.choices5 = documentSnapshot.data()['choices5'];
  //       game.choices6 = documentSnapshot.data()['choices6'];
  //       game.choices7 = documentSnapshot.data()['choices7'];
  //       game.choices8 = documentSnapshot.data()['choices8'];
  //       game.choices9 = documentSnapshot.data()['choices9'];
  //
  //       // put all four choices arrays in one main array
  //       game.choices = [
  //         game.choices0,
  //         game.choices1,
  //         game.choices2,
  //         game.choices3,
  //         game.choices4,
  //         game.choices5,
  //         game.choices6,
  //         game.choices7,
  //         game.choices8,
  //         game.choices9
  //       ];
  //
  //       // define answers
  //       game.correctAnswers = documentSnapshot.data()['answers'];
  //       print('answers: ${game.correctAnswers}');
  //     }
  //   });
  // }
}
