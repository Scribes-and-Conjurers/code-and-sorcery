import 'package:code_and_sorcery/screens/game_session/game_content_short.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../game_session/game_content_short.dart';
import '../game_session/game_content_long.dart';
import 'package:code_and_sorcery/global_variables/global_variables.dart';
import '../homepage/colors.dart';

// THIS IS FOR MP!
var game = new GameContentLongNOTF();
var gameShort = new GameContent();

class LoadingBeforeGameMP extends StatefulWidget {
  @override
  _LoadingBeforeGameMPState createState() => _LoadingBeforeGameMPState();
}

class _LoadingBeforeGameMPState extends State<LoadingBeforeGameMP> {
  @override
  void initState() {
    super.initState();
    if (difficulty == 'Easy' && adventureLength == 'Long') {
      updateGameContentLong('long-adv0');
      Timer(
          Duration(seconds: 3),
          () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/ingameLongMP')
              });
    } else if (difficulty == 'Normal' && adventureLength == 'Long') {
      updateGameContentLong('norm-long');
      Timer(
          Duration(seconds: 3),
          () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/ingameLongMP')
              });
    } else if (difficulty == 'Easy' && adventureLength == 'Short') {
      updateGameContentShort('JIfrv2SOOdlxkv5RJP3i');
      Timer(
          Duration(seconds: 3),
          () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/ingame')
              });
    } else if (difficulty == 'Normal' && adventureLength == 'Short') {
      updateGameContentShort('norm-short');
      Timer(
          Duration(seconds: 3),
          () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/ingame')
              });
    } else {
      print('goes nowhere');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: color1,
            child: Center(
                child: Column(children: [
              SizedBox(
                height: 100,
              ),
              Image.asset('assets/new-logo.png'),
              Text(
                "Conjuring game...",
                style: TextStyle(fontSize: 30, color: textBright),
              )
            ]))));
  }

  void updateGameContentLong(String questName) async {
    await FirebaseFirestore.instance
        .collection('ready-quests')
        .doc(questName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // define questions
        game.questions = documentSnapshot.data()['questions'];

        // define choices for each question
        game.choices0 = documentSnapshot.data()['choices0'];
        game.choices1 = documentSnapshot.data()['choices1'];
        game.choices2 = documentSnapshot.data()['choices2'];
        game.choices3 = documentSnapshot.data()['choices3'];
        game.choices4 = documentSnapshot.data()['choices4'];
        game.choices5 = documentSnapshot.data()['choices5'];
        game.choices6 = documentSnapshot.data()['choices6'];
        game.choices7 = documentSnapshot.data()['choices7'];
        game.choices8 = documentSnapshot.data()['choices8'];
        game.choices9 = documentSnapshot.data()['choices9'];

        // put all four choices arrays in one main array
        game.choices = [
          game.choices0,
          game.choices1,
          game.choices2,
          game.choices3,
          game.choices4,
          game.choices5,
          game.choices6,
          game.choices7,
          game.choices8,
          game.choices9
        ];

        // define answers
        game.correctAnswers = documentSnapshot.data()['answers'];
        print('answers: ${game.correctAnswers}');
      }
    });
  }

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
